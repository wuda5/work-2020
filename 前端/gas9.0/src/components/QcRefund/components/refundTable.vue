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
      <el-table-column fixed prop="refundNo" label="退费单号" width="200" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.refundNo | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="customerName" label="客户名称" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.customerName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="createTime" label="退费时间" width="140" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.createTime | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column
        prop="customerChargeNo"
        label="客户缴费编号"
        width="180"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.customerChargeNo | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="orderSourceName" label="气表类型" width="180" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ dictMap.ORDER_SOURCE_NAME[row.orderSourceName] | emptyStr }}
        </span>
      </el-table-column>
      <!-- <el-table-column prop="chargeNo" label="缴费单号" width="180" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.chargeNo | emptyStr }}
        </span>
      </el-table-column> -->
      <el-table-column prop="customerName" label="申请人" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.applyUserName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="customerCode" label="退费金额" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.backAmount | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column
        prop="receivableMoney"
        label="退费方式"
        min-width="100"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.backMethodName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column
        prop="actualIncomeMoney"
        label="退费状态"
        min-width="150"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          <!-- curRow
              ? row.refundNo == curRow.refundNo
                ? getRefundStatus(curRow.refundStatus)
                : getRefundStatus(row.refundStatus)
              : getRefundStatus(row.refundStatus) -->
          {{
            curRow && row.refundNo == curRow.refundNo && nowRefundStatus
                ? getRefundStatus(nowRefundStatus)
                : getRefundStatus(row.refundStatus)
          }}
        </span>
      </el-table-column>
      <el-table-column
        prop="actualIncomeMoney"
        label="收费员"
        min-width="100"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.chargeUserName | emptyStr }}
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
    nowRefundStatus: null,
    curRow: {
      type: Object,
      default: () => ({}),
      // default: () => {
      //   return {
      //     refundNo: '',
      //   }
      // },
    },
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
