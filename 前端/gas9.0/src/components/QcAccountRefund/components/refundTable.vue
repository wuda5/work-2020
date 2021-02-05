<template>
  <div>
    <el-table
      ref="multipleTable"
      :data="refundList.records"
      tooltip-effect="dark"
      :border="false"
      :highlight-current-row="true"
      @row-click="handleRowClick"
    >
      <!-- <el-table-column fixed prop="id" label="退费单号" width="200" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.id | emptyStr }}
        </span>
      </el-table-column> -->
      <el-table-column fixed prop="customerName" label="客户名称" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.customerName | emptyStr }}
        </span>
      </el-table-column>            
      <el-table-column prop="accountMoney" label="账户金额" width="80" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.accountMoney | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="applyUserName" label="申请人" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.applyUserName | emptyStr }}
        </span>
      </el-table-column> 
      <el-table-column prop="applyTime" label="申请时间" width="140" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.applyTime | emptyStr }}
        </span>
      </el-table-column>           
      <el-table-column
        prop="applyReason"
        label="退费原因"
        width="180"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.applyReason | emptyStr }}
        </span>
      </el-table-column>  
      <el-table-column
        prop="auditRemark"
        label="审核备注"
        width="180"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.auditRemark | emptyStr }}
        </span>
      </el-table-column>    
      <el-table-column
        prop="methodName"
        label="退费方式"
        min-width="50"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.methodName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column
        prop="refundStatus"
        label="退费状态"
        min-width="50"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ getRefundStatus(row.refundStatus) | emptyStr }}
        </span>
      </el-table-column>
      <!-- <el-table-column prop="createTime" label="退费时间" width="140" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.createTime | emptyStr }}
        </span>
      </el-table-column> -->
      <el-table-column prop="finishTime" label="完成时间" width="140" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.finishTime | emptyStr }}
        </span>
      </el-table-column> 
    </el-table>
    <Pagination
      v-if="+refundList.total"
      layout="prev, pager, next"
      :page="+refundList.current"
      :limit="+refundList.size"
      :total="+refundList.total"
      @pagination="handleChange"
    />
  </div>
</template>

<script>
import ChargeApi from '@/api/charges'
import { dictionaryCodeMap } from '@/enums/dictionary'

export default {
  name: 'QcRefundChargeTable',
  filters: {
    filterStatus(val) {
      switch (val) {
        case 'NOT_OPEN':
          return '未开票'
        case 'OPENED':
          return '已开票'
        default:
          return val
      }
    },
  },
  props: {
    refundList: {
      required: true,
      type: Object,
      default: () => {
        return {
          records: [],
        }
      },
    },
    search: Function,
  },
  data() {
    return {
      dicts: {
        ORDER_SOURCE_NAME: {},
      },
    }
  },
  mounted() {
    this.dicts = {
      ORDER_SOURCE_NAME: this.dictMap[dictionaryCodeMap.ORDER_SOURCE_NAME],
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    handleRowClick(row, column, event) {
      this.$emit('row-click', row, column, event)
    },
    getRefundStatus(refundStatus) {
      let refundText = ''
      switch (refundStatus) {
        case 'WAITE_AUDIT':
          refundText = '审核中'
          break
        case 'NONREFUND': // 不能撤销
          refundText = '不予退费'
          break
        case 'REFUNDABLE':
          refundText = '可退费'
          break
        case 'REFUND_ERR':
          refundText = '退费失败'
          break
        case 'THIRDPAY_REFUND':
          refundText = '三方支付退费中'
          break
        case 'REFUNDED': // 不能撤销
          refundText = '退费完成'
          break
        case 'CANCEL':
          refundText = '已取消'
          break
        default:
          refundText = '未知状态'
      }
      return refundText
    },
    refund(id) {
      ChargeApi.refundExcute(id).then(res => {
        console.log(res)
        this.search()
      })
    },
  },
}
</script>

<style lang='scss' scoped>
::v-deep .el-table__body-wrapper {
  height: 182px;
}
</style>
