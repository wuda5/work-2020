<!-- 安检子项配置 -->
<template>
  <div class="qc-main securitySubItem-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.securitySubItem.title') }}</span>
      </div>
      <!-- 搜索区域 -->
      <search-box class="search-box operation-box">
        <div slot="left" class="">
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 安检子项名称 -->
            <el-form-item label="" prop="name">
              <el-input v-model="searchForm.name" clearable :placeholder="$t('operation.securitySubItem.name')">
              </el-input>
            </el-form-item>
            <!-- 操作 -->
            <el-form-item label="" prop="dataStatus">
              <el-button type="primary" name="securitySubItem-search" icon="el-icon-search" class="search-btn securitySubItem-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
              <el-button class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
            </el-form-item>
          </el-form>
        </div>
      </search-box>
      <div>
        <!--数据-->
        <el-table
          :ref="listRef"
          v-loading="listLoading"
          stripe
          border
          :highlight-current-row="false"
          :data="list"
          tooltip-effect="dark"
          @filter-change="filterChange"
        >
          <!-- 索引 -->
          <el-table-column
            type="index"
            :label="$t('table.index')"
          >
          </el-table-column>
          <!-- 子项名称 -->
          <el-table-column
            prop="name"
            :label="$t('operation.securitySubItem.name')"
          >
          </el-table-column>
          <!-- 安检项名称 -->
          <el-table-column
            prop="securityName"
            :label="$t('operation.securitySubItem.securityName')"
          >
          </el-table-column>
          <!-- 安检项编码 -->
          <el-table-column
            prop="securityCode"
            :label="$t('operation.securitySubItem.securityCode')"
          >
          </el-table-column>
          <!-- 隐患级别 -->
          <el-table-column
            prop="dangerLevel"
            :label="$t('operation.securitySubItem.dangerLevel')"
          >
            <template #default="scope">
              {{ scope.row.dangerLevel | dangerLevelFormat }}
            </template>
          </el-table-column>
          <!-- 数据状态 -->
          <el-table-column 
            :label="$t('operation.securitySubItem.dataStatus')" 
            prop="dataStatus"
            width="140"
            column-key="dataStatus"
            :filter-multiple="false"
            :filters="dataStatusfilters"
          >
            <template #default="scope">
              <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['securitySubItem:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
              <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['securitySubItem:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
                <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
                <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
              </el-radio-group>
            </template>
          </el-table-column>
          <!-- 操作 -->
          <el-table-column
            fixed="right"
            :label="$t('table.operation')"
            width="120"
          >
            <template #default="{ row }">
              <el-button type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
            </template>
          </el-table-column>
        </el-table>
        <!--分页-->
        <pagination
          :page.sync="queryParams.current"
          :limit.sync="queryParams.size"
          :total="+total"
          @pagination="handleGetList"
        />

        <!-- 安检子项表单弹窗 -->
        <qc-dialog
          :width="800"
          :title="currentRow ? $t('operation.securitySubItem.edit') : $t('operation.securitySubItem.add')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <security-subItem-form :form-data="currentRow" @success="handleSaveSuccess"></security-subItem-form>
        </qc-dialog>
      </div>
    </el-card>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { getListData, saveData } from '@/api/operation/securitySubItem'
import SecuritySubItemForm from './Form'

export default {
  name: 'SecuritySubItem',
  components: {
    SecuritySubItemForm,
  },
  filters: {
    dangerLevelFormat(value) {
      if(value != null){
        return +value === 0 ? '重度事故隐患' : +value === 1?'一般事故隐患':'中度事故隐患'
      }
      
    },
   
  },
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField  
    return {
      searchForm: {
        executeName: null,
        useGasTypeId: null,
        dataStatus: null,
      }
    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    //初始化数据
    async initData() {
      await this.getList()
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getListData(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
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

    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.securitySubItem.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveData(row, id).then((result) => {
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

    // 数据状态搜索发生变化
    handleDataStatusChange(value) {
      this.handleSearch()
    },
  }
}
</script>

<style scoped lang="scss">
  .buy-gas-limit-page {
    ::v-deep .operation-box {
      margin-bottom: 10px;
    }
  }
</style>
