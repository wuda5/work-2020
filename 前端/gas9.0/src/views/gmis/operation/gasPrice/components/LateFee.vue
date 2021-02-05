<!--滞纳金列表（备份）-->
<template>
  <div class=" late-fee-page">
    <div class="operation-box">
      <div class="fl">
        <div class="table-title">{{ $t('operation.gasPrice.lateFeeTitle') }}</div>
      </div>
      <div v-if="isOperation" class="fr operation-btn-box">
        <el-button v-has-permission="['gasPrice:lateFeeAdd']" class="add-btn" name="add-btn add-late-fee-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
      </div>
    </div>
    <!--数据-->
    <el-table
      :ref="listRef"
      v-loading="listLoading"
      stripe
      border
      :data="list"
      tooltip-effect="dark"
      @row-click="handleRowClick"
    >
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <el-table-column
        prop="activationTime"
        :label="$t('operation.gasPrice.activationTime')"
      >
        <template #default="scope">
          {{ scope.row.activationTime | parseTime('{y}.{m}.{d}') }}
        </template>
      </el-table-column>
      <el-table-column
        prop="executeMonth"
        :label="$t('operation.gasPrice.executeMonth')"
      >
        <template #default="scope">
          {{ scope.row.executeMonth }}个月后
        </template>
      </el-table-column>
      <el-table-column
        prop="executeDay"
        :label="$t('operation.gasPrice.executeDay')"
      >
        <template #default="scope">
          {{ scope.row.executeDay }}号
        </template>
      </el-table-column>
      <el-table-column
        prop="rate"
        :label="$t('operation.gasPrice.rateLabel')"
      >
      </el-table-column>
      <el-table-column
        prop="compoundInterest"
        :label="$t('operation.gasPrice.compoundInterest')"
      >
        <template #default="scope">
          {{ scope.row.compoundInterest | compoundInterestFormat }}
        </template>
      </el-table-column>
      <el-table-column
        prop="principalCap"
        :label="$t('operation.gasPrice.principalCap')"
      >
        <template #default="scope">
          {{ scope.row.principalCap | principalCapFormat }}
        </template>
      </el-table-column>
      <el-table-column
        prop="fixedCap"
        :label="$t('operation.gasPrice.fixedCap')"
      >
        <template #default="scope">
          {{ scope.row.fixedCap || '-' }}
        </template>
      </el-table-column>
      <el-table-column
        prop="dataStatus"
        :label="$t('operation.gasPrice.dataStatus')"
        width="120"
      >
        <template #default="scope">
          {{ dataStatusMap[scope.row.dataStatus] }}
        </template>
      </el-table-column>
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="100"
      >
        <template #default="{ row }">
          <el-button type="primary" name="row-edit" @click.native.stop="showFormDialog(formStatusField.EDIT, row)">{{ $t('view') }}</el-button>
          <!-- <el-button type="danger" name="row-delete" @click.native.stop="handleDelete(row)">{{ $t('delete') }}</el-button> -->
        </template>
      </el-table-column>
      <template v-if="!isOperation" #empty>
        <b class="text-danger">{{ $t('operation.gasPrice.selectUseGasTypeHint') }}</b>
      </template>
    </el-table>
    <!--分页-->
    <pagination
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      :total="+total"
      @pagination="handleGetList"
    />

    <!-- 街道(乡镇)表单弹窗 -->
    <qc-dialog
      :width="600"
      :title="currentRow ? $t('operation.gasPrice.viewLateFee') : $t('operation.gasPrice.addLateFee')"
      :visible="formDialogVisible"
      data-key="formDialogVisible"
      @close="dialogClose"
    >
      <late-fee-form :form-data="currentRow ? currentRow : { useGasTypeId }" :only-view="!!currentRow" @success="handleSaveSuccess"></late-fee-form>
    </qc-dialog>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { deleteStatusField, dataStatusMap } from '@/enums/common'
import { getLateFeeList } from '@/api/operation/gasPrice'
import LateFeeForm from './LateFeeForm'

export default {
  name: 'LateFeeIndex',
  components: {
    LateFeeForm
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
    // 用气类型id
    useGasTypeId: {
      type: [String, Number],
      default: ''
    }
  },
  data() {
    this.formStatusField = formStatusField
    this.dataStatusMap = dataStatusMap
    return {
      searchForm: {
        useGasTypeId: null,
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
    }
  },
  computed: {
    // 判断是否可以操作
    isOperation() {
      return this.useGasTypeId
    }
  },
  watch: {
    useGasTypeId: {
      handler(value) {
        this.initData()
      },
      immediate: true
    }
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
      const { useGasTypeId } = this
      if (!useGasTypeId) {
        this.list = []
      } else {
        this.searchForm.useGasTypeId = this.useGasTypeId
        await this.getList()
      }
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getLateFeeList(this.generateQueryParams(params)).then((result) => {
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
        // deleteStreet({ ids }).then((result) => {
        //   this.btnLoading = true
        //   const { isSuccess, data } = result.data
        //   if (isSuccess) {
        //     resolve(true)
        //   } else {
        //     resolve(false)
        //   }
        // }).catch(() => {
        //   this.btnLoading = true
        //   resolve(false)
        // })
      })
    },

    //删除街道(乡镇)信息
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.deleteConfirm'), this.$t('common.tips'), {
        type: 'warning'
      }))
      if (!confirmResult?.error) {
        const deleteResult = await this.deleteData([row.id])
        if (deleteResult) {
          this.$message.success(this.$t('tips.deleteSuccess'))
          this.getList()
        }
      }
    },

    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    }
  }
}
</script>

<style scoped lang="scss">

</style>
