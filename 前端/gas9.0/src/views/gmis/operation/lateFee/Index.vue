<!-- 滞纳金配置 -->
<template>
  <div class="qc-main lateFee-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.lateFee.title') }}</span>
      </div>
      <!-- 搜索区域 -->
      <search-box class="search-box operation-box">
        <div slot="left" class="">
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 滞纳金名称 -->
            <el-form-item label="" prop="executeName">
              <el-input v-model="searchForm.executeName" clearable :placeholder="$t('operation.lateFee.executeName')">
              </el-input>
            </el-form-item>
            <!-- 操作 -->
            <el-form-item label="" prop="dataStatus">
              <el-button type="primary" name="lateFee-search" icon="el-icon-search" class="search-btn lateFee-search" @click.native="handleSearch()">{{ $t('search') }}</el-button>
              <el-button type="warning" name="lateFee-search" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </div>
        <!-- 操作 -->
        <div slot="right" class="operation-btn-box">
          <el-button v-has-permission="['lateFee:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
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
          <!-- 滞纳金名称 -->
          <el-table-column
            prop="executeName"
            :label="$t('operation.lateFee.executeName')"
          >
          </el-table-column>
          <!-- 启用时间 -->
          <el-table-column
            prop="activationTime"
            :label="$t('operation.lateFee.activationTime')"
          >
            <template #default="scope">
              {{ scope.row.activationTime | parseTime('{y}.{m}.{d}') }}
            </template>
          </el-table-column>
          <!-- 用气类型 -->
          <el-table-column
            prop="useGasTypeName"
            :label="$t('operation.lateFee.useGasTypeId')"
          >
          </el-table-column>
          <!-- 滞纳金执行月 -->
          <el-table-column
            prop="executeMonth"
            :label="$t('operation.lateFee.executeMonth')"
          >
            <template #default="scope">
              {{ scope.row.executeMonth }}个月后
            </template>
          </el-table-column>
          <!-- 滞纳金执行日 -->
          <el-table-column
            prop="executeDay"
            :label="$t('operation.lateFee.executeDay')"
          >
            <template #default="scope">
              {{ scope.row.executeDay }}号
            </template>
          </el-table-column>
          <!-- 利率 -->
          <el-table-column
            prop="rate"
            :label="$t('operation.lateFee.rateLabel')"
          >
          </el-table-column>
          <!-- 复利 -->
          <el-table-column
            prop="compoundInterest"
            :label="$t('operation.lateFee.compoundInterest')"
          >
            <template #default="scope">
              {{ scope.row.compoundInterest | compoundInterestFormat }}
            </template>
          </el-table-column>
          <!-- 本金即上线 -->
          <el-table-column
            prop="principalCap"
            :label="$t('operation.lateFee.principalCap')"
          >
            <template #default="scope">
              {{ scope.row.principalCap | principalCapFormat }}
            </template>
          </el-table-column>
          <!-- 固定上限 -->
          <el-table-column
            prop="fixedCap"
            :label="$t('operation.lateFee.fixedCap')"
          >
            <template #default="scope">
              {{ scope.row.fixedCap || '-' }}
            </template>
          </el-table-column>
          <!-- 数据状态 -->
          <el-table-column 
            :label="$t('operation.lateFee.dataStatus')" 
            prop="dataStatus"
            width="140"
            column-key="dataStatus"
            :filter-multiple="false"
            :filters="dataStatusfilters"
          >
            <template #default="scope">
              <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['lateFee:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
              <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['lateFee:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
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
              <el-button v-has-permission="['lateFee:edit']" type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
              <!-- <el-button v-has-permission="['lateFee:delete']" type="danger" name="row-delete" @click.native="handleDelete(row)">{{ $t('delete') }}</el-button> -->
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
          :title="currentRow ? $t('operation.lateFee.edit') : $t('operation.lateFee.add')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <late-fee-form :form-data="currentRow" @success="handleSaveSuccess"></late-fee-form>
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
import { getListData, saveData, deleteData } from '@/api/operation/lateFee'
import LateFeeForm from './Form'

export default {
  name: 'LateFee',
  components: {
    LateFeeForm,
  },
  filters: {
    compoundInterestFormat(value) {
      return +value === 1 ? '是' : '否'
    },
    principalCapFormat(value) {
      return +value === 1 ? '本金' : '固定'
    }
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
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.lateFee.deleteConfirm'), this.$t('common.tips'), {
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
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.lateFee.disableConfirm'), this.$t('common.tips'), {
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
