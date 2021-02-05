<!--
 * @Descripttion: 票据列表
 * @Author: lingw
 * @Date: 2020-10-12 11:40:40
 * @LastEditors: lingw
 * @LastEditTime: 2020-12-03 15:15:32
-->
<template>
 <div>
    <!-- 发票列表 -->
      <el-table
        ref="multipleTable"
        :data="billList.records"
        tooltip-effect="dark"
        :border="true"
        :highlight-current-row="true"
        @row-click="handleRowClick"
      >
        <el-table-column
          fixed
          prop="chargeNo"
          label="缴费单号"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.chargeNo | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="customerName"
          label="客户名称"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.customerName | emptyStr }}
          </span>
        </el-table-column>
      <el-table-column
          prop="customerCode"
          label="客户编号"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.customerCode | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="createTime"
          label="创建时间"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.createTime | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="businessHallName"
          label="营业厅名称"
          width="100"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.businessHallName | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="receivableMoney"
          label="应收金额"
          min-width="200"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.receivableMoney | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="actualIncomeMoney"
          label="实收金额"
          min-width="200"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.actualIncomeMoney | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="rechargeMoney"
          label="充值金额"
          min-width="200"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.rechargeMoney | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="prechargeMoney"
          label="预存金额"
          width="130"
        >
          <span slot-scope="{row}">
            {{ row.prechargeMoney | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="giveChange"
          label="找零"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.giveChange | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="invoiceStatus"
          label="开票状态"
          width="80"
        >
          <span slot-scope="{row}">
            {{ row.invoiceStatus | emptyStr | filterStatus }}
          </span>
        </el-table-column>
        <el-table-column
          prop="gasMeterCode"
          label="表具编号"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.gasMeterCode | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="remark"
          label="备注/理由"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.remark | emptyStr }}
          </span>
        </el-table-column>
      </el-table>
      <Pagination
        v-if="+billList.total"
        layout="prev, pager, next"
        :page="+billList.current"
        :limit="+billList.size"
        :total="+billList.total"
        @pagination="handleChange"
      />
 </div>
</template>

<script>
export default {
  name: 'Bill',
  filters: {
    filterStatus(val) {
      switch(val) {
        case 'NOT_OPEN':
          return '未开票'
        case 'OPENED':
          return '已开票'
        default:
          return val
      }
    }
  },
  props: {
    billList: {
      required: true,
      type: Object,
      default: () => {
        return {
          records: []
        }
      }
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    handleRowClick(row, column, event) {
      this.$emit('row-click', row, column, event)
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
