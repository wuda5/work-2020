<!-- 地址配置 -->
<template>
  <div class="qc-main community-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.community.config') }}</span>
      </div>
      <el-row :gutter="15">
        <el-col :span="10" class="street-col" style="min-height: calc(100vh - 230px);">
          <div class="table-title">{{ $t('operation.community.streetList') }}</div>
          <!-- 搜索区域 -->
          <search-box class="search-box operation-box">
            <div slot="left">
              <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
                <!-- 街道(乡镇)名称 -->
                <el-form-item label="">
                  <el-input v-model="searchForm.streetName" style="width: auto" clearable :placeholder="$t('operation.community.streetName')">
                  </el-input>
                </el-form-item>
                <!-- 操作 -->
                <el-form-item label="">
                  <el-button type="primary" name="street-search" class="search-btn street-search" @click.native="handleSearch(false)">{{ $t('search') }}</el-button>
                </el-form-item>
              </el-form>
            </div>
            <!-- 操作 -->
            <div slot="right" class="fr operation-btn-box">
              <el-button v-has-permission="['community:streetAdd']" class="add-btn" name="add-btn" type="success" @click="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
            </div>
          </search-box>
          <div class="operation-box">
          </div>
          <!--数据-->
          <el-table
            :ref="listRef"
            v-loading="listLoading"
            stripe
            border
            highlight-current-row
            :data="list"
            tooltip-effect="dark"
            @row-click="handleRowClick"
            @filter-change="filterChange"
          >
            <!-- 索引 -->
            <el-table-column
              type="index"
              :label="$t('table.index')"
            >
            </el-table-column>
            <!-- 省市区 -->
            <el-table-column
              prop=""
              :label="$t('operation.community.region')"
            >
              <template #default="{ row }">
                {{ row.provinceName }}  {{ row.cityName }} {{ row.areaName }}
              </template>
            </el-table-column>
            <!-- 街道(乡镇)名称 -->
            <el-table-column
              prop="streetName"
              :label="$t('operation.community.streetName')"
            >
            </el-table-column>
            <!-- 状态 -->
            <!-- <el-table-column 
              :label="$t('status')" 
              prop="dataStatus"
              width="70"
              column-key="dataStatus"
              :filter-multiple="false"
              :filters="dataStatusfilters"
            >
              <template #default="scope">
                <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['community:streetEdit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" />
              </template>
            </el-table-column> -->
            <!-- 操作 -->
            <el-table-column
              fixed="right"
              :label="$t('table.operation')"
              width="80"
            >
              <template #default="{ row }">
                <el-button v-has-permission="['community:streetEdit']" type="primary" name="row-edit" @click="showFormDialog(formStatusField.EDIT)">{{ $t('edit') }}</el-button>
                <!-- <el-button v-has-permission="['community:streetDelete']" type="danger" name="row-delete" @click.stop="handleDelete(row)">{{ $t('delete') }}</el-button> -->
              </template>
            </el-table-column>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            layout="total, sizes, prev, next, jumper"
            @pagination="handleGetList"
          />
        </el-col>
        <!-- 小区(村、xx路)列表 -->
        <el-col :span="14">
          <community-page v-if="currentRow" :street-data="currentRow"></community-page>
          <no-select v-else :tips="$t('operation.community.selectStreetHint')" :top="0" />
        </el-col>
      </el-row>

      <!-- 街道(乡镇)表单弹窗 -->
      <qc-dialog
        :width="600"
        :title="currentRow ? $t('operation.community.editStreet') : $t('operation.community.addStreet')"
        :visible="formDialogVisible"
        data-key="formDialogVisible"
        @close="dialogClose"
      >
        <street-form :form-data="currentRow" @success="handleSaveSuccess"></street-form>
      </qc-dialog>
    </el-card>
  </div>
</template>

<script>
import { isEmpty, merge, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import CommunityPage from './components/Community'
import StreetForm from './components/StreetForm'
import NoSelect from '@/components/QcNoSelect'
import { getStreetList, deleteStreet, getCommunityList, saveStreet } from '@/api/operation/community'
import { formStatusField } from '@/enums/form'
import { deleteStatusField } from '@/enums/common'
import { awaitToJs } from '@/utils/index'

export default {
  name: 'Street',
  components: {
    CommunityPage,
    StreetForm,
    NoSelect,
  },
  mixins: [commonMixin, listMixin],
  props: {
  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        streetName: null,
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
    }
  },
  created() {
    this.initData()
  },
  methods: {
    // 初始化数据
    async initData() {
      await this.getList()
    },

    // 获取街道(乡镇)列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getStreetList(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
          // console.log('data', data)
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            this.$nextTick(() => {
              this.loadData()
            })
            resolve(records)
          } else {
            resolve(false)
          }
          this.listLoading = false
        }).catch(() => {
          resolve(false)
          this.listLoading = false
        })
      })
    },

    // 获取街道列表之后加载其它数据
    loadData() {
      const street = this.list.find((item) => item.id === this.currentRow?.id)
      if (street) {
        // 设置选中行高亮
        this.$refs[this.listRef]?.setCurrentRow(street)
        this.currentRow = cloneDeep(street)
      } else {
        this.currentRow = null
      }
    },

    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        deleteStreet({ ids }).then((result) => {
          this.btnLoading = true
          const { isSuccess, data } = result.data
          if (isSuccess) {
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          this.btnLoading = true
          resolve(false)
        })
      })
    },

    //删除街道(乡镇)信息
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.deleteStreetConfirm'), this.$t('common.tips'), {
        type: 'warning'
      }))
      if (!confirmResult?.error) {
        const deleteResult = await this.deleteData([row.id])
        if (deleteResult) {
          this.$message.success(this.$t('tips.deleteSuccess'))
          await this.getList()
          const currentRowId = this.currentRow?.id || ''
          if (currentRowId === row.id) {
            this.currentRow = null
            this.isRowClick = false
          } else {
            this.$refs[this.listRef].setCurrentRow(this.list.find((item) => item.id === currentRowId))
          }
        }
      }
    },

    // 表单信息保存成功
    async handleSaveSuccess(data, isAdd) {
      // console.log(data);
      // console.log('isAdd', isAdd);
      await this.getList()
      this.formDialogVisible = false
    },
    
    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.disableStreetConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveStreet(row, id).then((result) => {
        this.listLoading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.dataStatus = Number(!+val)
        }
      }).catch(() => {
        this.listLoading = false
        row.dataStatus = Number(!+val)
      })
    },
  }
}
</script>

<style lang="scss" scoped>
.community-page {
  position: relative;
}
</style>
