<!-- 购气配额限制列表 -->
<template>
  <div class="qc-main buy-gas-limit-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.buyGasLimit.title') }}</span>
      </div>
      <!-- 列表搜索区域 -->
      <search-box class="search-box operation-box">
        <div slot="left" class="">
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 限购名称 -->
            <el-form-item label="" prop="limitName">
              <el-input v-model="searchForm.limitName" clearable :placeholder="$t('operation.buyGasLimit.limitName')">
              </el-input>
            </el-form-item>
            <!-- 搜索操作 -->
            <el-form-item label="">
              <el-button type="primary" name="buyGasLimit-search" icon="el-icon-search" class="search-btn buyGasLimit-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
              <el-button type="warning" name="buyGasLimit-search" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div slot="right" class="operation-btn-box">
          <el-button v-has-permission="['buyGasLimit:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
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
          @row-click="handleRowClick"
          @filter-change="filterChange"
        >
          <!-- 索引 -->
          <el-table-column
            type="index"
            :label="$t('table.index')"
          >
          </el-table-column>
          <!-- 限购名称 -->
          <el-table-column
            prop="limitName"
            :label="$t('operation.buyGasLimit.limitName')"
          >
          </el-table-column>
          <!-- 用气类型 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.useGasTypeLabel')" 
            prop="useGasTypeName"
          >
            <template #default="scope">
              <!-- {{ JSON.parse(scope.row.useGasTypeName).join('、') }} -->
              {{ scope.row.useGasTypeName | useGasTypeNameFormat }}
            </template>
          </el-table-column>
          <!-- 限制类型 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.limitType')" 
            prop="limitType"
          >
            <template #default="scope">
              {{ scope.row.limitType | limitTypeFormat }}
            </template>
          </el-table-column>
          <!-- 启用时间 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.startTime')" 
            prop="startTime"
          >
            <template #default="scope">
              {{ scope.row.startTime | parseTime('{y}.{m}.{d}') }}
            </template>
          </el-table-column>
          <!-- 结束时间 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.endTime')" 
            prop="endTime"
          >
            <template #default="scope">
              {{ scope.row.endTime | parseTime('{y}.{m}.{d}') }}
            </template>
          </el-table-column>
          <!-- 最大充值气量 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.maxChargeGas')" 
            prop="maxChargeGas"
          >
          </el-table-column>
          <!-- 最大充值金额 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.maxChargeMoney')" 
            prop="maxChargeMoney"
          >
          </el-table-column>
          <!-- 状态 -->
          <el-table-column 
            :label="$t('operation.buyGasLimit.dataStatus')" 
            prop="dataStatus"
            width="140"
            column-key="dataStatus"
            :filter-multiple="false"
            :filters="dataStatusfilters"
          >
            <template #default="scope">
              <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['buyGasLimit:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
              <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['buyGasLimit:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
                <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
                <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
              </el-radio-group>
            </template>
          </el-table-column>
          <!-- 操作 -->
          <el-table-column
            fixed="right"
            :label="$t('table.operation')"
            width="100"
          >
            <template #default="{ row }">
              <el-button v-has-permission="['buyGasLimit:edit']" type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
              <!-- <el-button v-has-permission="['buyGasLimit:delete']" type="danger" name="row-delete" @click.native="handleDelete(row)">{{ $t('delete') }}</el-button> -->
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

        <!-- 用气类型表单弹窗 -->
        <qc-dialog
          :width="800"
          :title="currentRow ? $t('operation.buyGasLimit.edit') : $t('operation.buyGasLimit.add')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <buy-gas-limit-form :form-data="currentRow" @success="handleSaveSuccess"></buy-gas-limit-form>
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
import { limitTypeMap } from '@/enums/buyGasLimit'
import { getListData, saveData, deleteData } from '@/api/operation/buyGasLimit'
import BuyGasLimitForm from './Form'

export default {
  name: 'BuyGasLimit',
  components: {
    BuyGasLimitForm,
  },
  filters: {
    // 限制类型格式化
    limitTypeFormat(value) {
      return limitTypeMap[+value] ?? ''
    },
    // 用气类型格式化
    useGasTypeNameFormat(value) {
      return JSON.parse(value)?.join?.('、')
    },
  },
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        limitName: null,
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
    // 初始化数据
    async initData() {
      await this.getList()
    },
    // 获取列表数据
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

    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        deleteData({ ids }).then((result) => {
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

    //删除操作
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.buyGasLimit.deleteConfirm'), this.$t('common.tips'), {
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
          }
        }
      }
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
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.buyGasLimit.disableConfirm'), this.$t('common.tips'), {
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
