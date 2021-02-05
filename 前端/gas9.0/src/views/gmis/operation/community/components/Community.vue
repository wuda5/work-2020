<!-- 小区(村、xx路)列表 -->
<template>
  <div class="community-index-page">
    <el-row :gutter="15">
      <el-col :span="12" class="community-col" style="min-height: calc(100vh - 230px);">
        <div class="table-title">
          {{ $t('operation.community.list') }}
          <!-- <b v-if="streetName" class="text-danger">({{ $t('operation.community.currentStreet') }}{{ streetName }})</b> -->
        </div>
        <!-- 搜索区域 -->
        <search-box class="search-box operation-box">
          <div slot="left">
            <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
              <!-- 小区(村、xx路)名称 -->
              <el-form-item label="">
                <el-input v-model="searchForm.communityName" clearable :placeholder="$t('operation.community.communityName')">
                </el-input>
              </el-form-item>
              <!-- 搜索操作 -->
              <el-form-item label="">
                <el-button type="primary" name="community-search" :disabled="!isOperation" class="search-btn community-search" @click.native="handleSearch(false)">{{ $t('search') }}</el-button>
              </el-form-item>
            </el-form>
          </div>
          <!-- 列表操作区域 -->
          <div v-if="isOperation" slot="right" class="operation-btn-box">
            <el-button v-has-permission="['community:add']" class="add-btn" name="add-btn" type="success" @click="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
            <el-button v-has-permission="['community:batchAddAddress']" class="add-btn" name="add-btn" type="success" @click="batchAddAddressFormDialogVisible = true">{{ $t('operation.community.batchAddAddressText') }}</el-button>
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
          :data="list"
          tooltip-effect="dark"
          highlight-current-row
          @row-click="handleRowClick"
          @filter-change="filterChange"
        >
          <!-- 索引 -->
          <el-table-column
            type="index"
            :label="$t('table.index')"
          >
          </el-table-column>
          <!-- 小区(村、xx路)名称 -->
          <el-table-column
            prop="communityName"
            show-overflow-tooltip
            :label="$t('operation.community.communityName')"
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
              <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['community:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" />
            </template>
          </el-table-column> -->
          <!-- 操作 -->
          <el-table-column
            fixed="right"
            :label="$t('table.operation')"
            width="80"
          >
            <template>
              <el-button v-has-permission="['community:edit']" type="primary" name="row-edit" @click="showFormDialog(formStatusField.EDIT)">{{ $t('edit') }}</el-button>
              <!-- <el-button v-has-permission="['community:delete']" type="danger" name="row-delete" @click.stop="handleDelete(row)">{{ $t('delete') }}</el-button> -->
            </template>
          </el-table-column>
          <template v-if="!isOperation" #empty>
            <b class="text-danger">{{ $t('operation.community.selectStreetHint') }}</b>
          </template>
        </el-table>
        <!--分页-->
        <pagination
          :page.sync="queryParams.current"
          :limit.sync="queryParams.size"
          :total="+total"
          layout="total, sizes, prev, next, jumper"
          @pagination="handleGetList"
        />

        <!-- 小区(村、xx路)表单弹窗 -->
        <qc-dialog
          :width="600"
          :title="currentRow ? $t('operation.community.editCommunity') : $t('operation.community.addCommunity')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <community-form v-if="formDialogVisible" :form-data="communityFormData" @success="handleSaveSuccess"></community-form>
        </qc-dialog>

        <!-- 批量建址表单弹窗 -->
        <qc-dialog
          :width="800"
          :title="$t('operation.community.batchAddAddressText')"
          :visible="batchAddAddressFormDialogVisible"
          data-key="batchAddAddressFormDialogVisible"
          @close="dialogClose"
        >
          <batch-add-address-form v-if="batchAddAddressFormDialogVisible" :form-data="batchAddAddressFormData" @success="handleBatchAddAddressSaveSuccess"></batch-add-address-form>
        </qc-dialog>
      </el-col>
      <el-col :span="12">
        <!--  -->
        <details-address v-if="currentRow" :community-data="currentRow"></details-address>
        <no-select v-else :tips="$t('operation.community.selectCommunityHint')" :top="0" />
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, merge } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { getCommunityList, deleteCommunity, saveCommunity } from '@/api/operation/community'
import { awaitToJs } from '@/utils/index'
import CommunityForm from './CommunityForm'
import BatchAddAddressForm from './BatchAddAddressForm'
import DetailsAddress from './DetailsAddress'
import NoSelect from '@/components/QcNoSelect'
import { formStatusField } from '@/enums/form'
import { deleteStatusField } from '@/enums/common'

export default {
  name: 'CommunityIndex',
  components: {
    CommunityForm,
    DetailsAddress,
    NoSelect,
    BatchAddAddressForm
  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {
    // 街道数据
    streetData: {
      type: Object,
      default: () => ({})
    },
  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        streetId: null,
        communityName: null,
        communityAddress: null,
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      },
      batchAddAddressFormDialogVisible: false, // 批量建址弹出框标识
    }
  },
  computed: {
    // 判断是否可以操作
    isOperation() {
      return this.streetData.id
    },

    // 传入的小区表单数据
    communityFormData() {
      const cloneData = cloneDeep(this.currentRow || {})
      cloneData.communityId = cloneData.id ?? null
      const { id, areaCode, areaName, cityCode, cityName, provinceCode, provinceName, streetName } = this.streetData
      return merge({ streetId: id, streetName, areaCode, areaName, cityCode, cityName, provinceCode, provinceName  }, cloneData)
    },

    // 传入批量建址表单组件的数据
    batchAddAddressFormData() {
      const cloneData = cloneDeep(this.currentRow || {})
      cloneData.communityId = cloneData.id ?? null
      const { id, areaCode, areaName, cityCode, cityName, provinceCode, provinceName, streetName } = this.streetData
      return merge({ streetId: id, streetName, areaCode, areaName, cityCode, cityName, provinceCode, provinceName  }, { communityId: cloneData.id ?? null, communityName: cloneData?.communityName ?? null })
    }
  },
  watch: {
    streetData: {
      handler(value) {
        this.initData()
      },
      immediate: true
    }
  },
  created() {
    // this.initData()
  },
  mounted() {

  },
  destroyed() {
  }, 
  methods: {
    // 初始化数据
    async initData() {
      // 清空选中行和单击标识
      this.currentRow = null
      this.isRowClick = false
      if (isEmpty(this.streetData)) {
        this.list = []
      } else {
        this.searchForm.streetId = this.streetData.id
        await this.getList()
      }
    },

    // 获取小区(村、xx路)列表根据街道(乡镇)Id
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getCommunityList(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
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

    // 获取小区列表之后加载其它数据
    loadData() {
      const community = this.list.find((item) => item.id === this.currentRow?.id)
      if (community) {
        // 设置选中行高亮
        this.$refs[this.listRef]?.setCurrentRow(community)
        this.currentRow = cloneDeep(community)
      } else {
        this.currentRow = null
      }
    },
  
    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        deleteCommunity({ ids }).then((result) => {
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
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.deleteCommunityConfirm'), this.$t('common.tips'), {
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
      this.formDialogVisible = false
      this.getList()
    },

    // 批量建档保存成功
    handleBatchAddAddressSaveSuccess() {
      this.batchAddAddressFormDialogVisible = false
      this.getList()
    },
    
    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.disableCommunityConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveCommunity(row, id).then((result) => {
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

<style scoped lang="scss">

</style>
