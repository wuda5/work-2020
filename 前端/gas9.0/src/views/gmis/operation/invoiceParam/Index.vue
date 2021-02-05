<!-- 开票参数配置 -->
<template>
  <div class="qc-main invoiceParam--page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.invoiceParam.title') }}</span>
      </div>
      <!-- 搜索区域 -->
      <search-box class="search-box operation-box">
        <div slot="left" class="">
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 销方名称 -->
            <el-form-item label="" prop="name">
              <el-input v-model="searchForm.name" clearable :placeholder="$t('operation.invoiceParam.name')">
              </el-input>
            </el-form-item>
            <!-- 操作 -->
            <el-form-item label="" prop="dataStatus">
              <el-button type="primary" name="invoiceParam-search" icon="el-icon-search" class="search-btn invoiceParam-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
              <el-button type="warning" name="invoiceParam-search" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </div>
        <!-- 操作 -->
        <div slot="right" class="operation-btn-box">
          <el-button v-has-permission="['invoiceParam:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
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
          <!-- 销方名称 -->
          <el-table-column
            prop="name"
            show-overflow-tooltip
            :label="$t('operation.invoiceParam.name')"
          >
          </el-table-column>
          <!-- 账号等级 -->
          <el-table-column
            prop="accountLevel"
            :label="$t('operation.invoiceParam.accountLevel')"
          >
            <template #default="scope">
              {{ scope.row.accountLevel | accountLevelFormat }}
            </template>
          </el-table-column>
          <!-- 销方地址 -->
          <el-table-column
            prop="address"
            show-overflow-tooltip
            :label="$t('operation.invoiceParam.address')"
          >
          </el-table-column>
          <!-- 销方银行账户 -->
          <el-table-column
            prop="bankAccount"
            :label="$t('operation.invoiceParam.bankAccount')"
          >
          </el-table-column>
          <!-- 银行开户行名称 -->
          <el-table-column
            prop="bankName"
            :label="$t('operation.invoiceParam.bankName')"
          >
          </el-table-column>
          <!-- 销方纳税人编号 -->
          <el-table-column
            prop="taxpayerNo"
            :label="$t('operation.invoiceParam.taxpayerNo')"
          >
          </el-table-column>
          <!-- 销方电话 -->
          <el-table-column
            prop="telephone"
            :label="$t('operation.invoiceParam.telephone')"
          >
          </el-table-column>
          <!-- 备注 -->
          <el-table-column
            prop="remark"
            :label="$t('operation.invoiceParam.remark')"
          >
          </el-table-column>
          <!-- 数据状态 -->
          <el-table-column 
            :label="$t('operation.invoiceParam.invoiceStatus')" 
            prop="invoiceStatus"
            width="140"
            column-key="invoiceStatus"
            :filter-multiple="false"
            :filters="dataStatusfilters"
          >
            <template #default="scope">
              <!-- <qc-switch v-model="scope.row.invoiceStatus" :disabled="!checkPermission(['invoiceParam:edit'])" @change="handleSwitchChange(scope.row.invoiceStatus, scope.row)" /> -->
              <el-radio-group v-model="scope.row.invoiceStatus" :disabled="!checkPermission(['invoiceParam:edit'])" @change="handleSwitchChange(scope.row.invoiceStatus, scope.row)">
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
              <el-button v-has-permission="['invoiceParam:edit']" type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
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

        <!-- 开票参数配置弹窗 -->
        <qc-dialog
          :width="800"
          :title="currentRow ? $t('operation.invoiceParam.edit') : $t('operation.invoiceParam.add')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <invoice-param-edit :form-data="currentRow" @success="handleSaveSuccess"></invoice-param-edit>
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
import { getInvoiceParamList, saveInvoiceParam } from '@/api/operation/invoiceParam'
import invoiceParamEdit from './components/Edit'

export default {
  name: 'InvoiceParam',
  components: {
    invoiceParamEdit,
  },
  filters: {
    accountLevelFormat(value) {
      if(value != null){
        return +value === 0 ? '总公司' : '分公司'
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
        name: null,
        invoiceStatus: null,
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
        getInvoiceParamList(this.generateQueryParams(params)).then((result) => {
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
      await this.getList()
      this.formDialogVisible = false
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, invoiceStatus } = row
      if (!invoiceStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.invoiceParam.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.invoiceStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveInvoiceParam(row, id).then((result) => {
        this.listLoading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.invoiceStatus = Number(!+val)
        }
      }).catch(() => {
        this.listLoading = false
        row.invoiceStatus = Number(!+val)
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
