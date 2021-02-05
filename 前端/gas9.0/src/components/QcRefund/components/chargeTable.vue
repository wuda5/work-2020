<template>
  <div>
    <el-table
      ref="multipleTable"
      :data="chargeList.records"
      tooltip-effect="dark"
      :border="false"
      :highlight-current-row="true"
      @row-click="handleRowClick"
    >
      <el-table-column fixed prop="chargeNo" label="缴费单号" width="180" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.chargeNo | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="customerName" label="客户名称" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.customerName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="createTime" label="缴费时间" width="140" show-overflow-tooltip>
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
      <!-- <el-table-column prop="customerCode" label="表身号" width="180" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.customerCode | emptyStr }}
        </span>
      </el-table-column> -->
      <el-table-column
        prop="receivableMoney"
        label="应收金额"
        min-width="100"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.receivableMoney | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column
        prop="actualIncomeMoney"
        label="实收金额"
        min-width="100"
        show-overflow-tooltip
      >
        <span slot-scope="{ row }">
          {{ row.actualIncomeMoney | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="rechargeMoney" label="充值金额" min-width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.rechargeMoney | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="prechargeMoney" label="预存金额" width="100">
        <span slot-scope="{ row }">
          {{ row.prechargeMoney | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="giveChange" label="找零" width="100" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.giveChange | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="remark" label="备注/理由" width="200" show-overflow-tooltip>
        <span slot-scope="{ row }">
          {{ row.remark | emptyStr }}
        </span>
      </el-table-column>      
    </el-table>
    <Pagination
      v-if="+chargeList.total"
      layout="prev, pager, next"
      :page="+chargeList.current"
      :limit="+chargeList.size"
      :total="+chargeList.total"
      @pagination="handleChange"
    />
  </div>
</template>

<script>
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
    chargeList: {
      required: true,
      type: Object,
      default: () => {
        return {
          records: [],
        }
      },
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
  },
}
</script>

<style lang='scss' scoped>
::v-deep .el-table__body-wrapper {
  height: 182px;
}
</style>
