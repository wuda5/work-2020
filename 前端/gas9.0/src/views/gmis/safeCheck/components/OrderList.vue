<!--
 * @Description: 工单列表
 * @Author: lingw
 * @Date: 2020-11-16 10:08:41
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 14:25:18
-->
<template>
 <div>
   <el-table
      :data="orderList.list"
      tooltip-effect="dark"
      style="width: 100%"
      :border="false"
      :highlight-current-row="true"
      :height="242"
      @row-click="handleRowClick"
    >
      <el-table-column
        label="序号"
        type="index"
        width="45"
      />
      <el-table-column
        label="工单编号"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.workOrderNo | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="工单内容"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.workOrderDesc | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="业务类型"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.businessType | filterType }}
        </span>
      </el-table-column>
      <el-table-column
        label="紧急程度"
        width="120"
      >
        <template slot-scope="{row}">
          <span v-if="row.urgency == null">--</span>
          <el-tag v-else :type="row.urgency | filterEmergencyType">{{ row.urgency | filterEmergency }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        label="接单时间"
      >
        <span slot-scope="{row}">
          {{ row.receiveTime | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="结单时间"
        width="80"
      >
        <span slot-scope="{row}">
          {{ row.endJobTime | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="接单人名称"
        width="80"
      >
        <span slot-scope="{row}">
          {{ row.receiveUserName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="结单人名称"
        width="80"
      >
        <span slot-scope="{row}">
          {{ row.endJobUserName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="工单状态"
        width="140"
      >
        <span slot-scope="{row}">
          {{ row.orderStatus | filterStatus }}
        </span>
      </el-table-column>
    </el-table>
    <Pagination
      v-if="+orderList.total"
      style="float: right; margin: 10px 0 5px"
      layout="prev, pager, next"
      :page="+orderList.current"
      :limit="+orderList.size"
      :total="+orderList.total"
      @pagination="handleChange"
    />
 </div>
</template>

<script>
import { defaults } from 'codemirror'
export default {
  name: 'OrderList',
  filters: {
    filterEmpty(val) {
      return val || '--'
    },
    filterEmergency(val) {
      switch(val) {
        case 'NORMAL':
          return '正常'
        case 'VERY_URGENT':
          return '非常紧急'
        case 'URGENT':
          return '紧急'
        default:
          return '--'
      }
    },
    filterEmergencyType(val) {
      switch(val) {
        case 'NORMAL':
          return 'success'
        case 'VERY_URGENT':
          return 'danger'
        case 'URGENT':
          return 'warning'
        default:
          return ''
      }
    },
    filterType(val) {
      switch(val) {
        case 2:
          return '安检工单'
        default:
          return '--'
      }
    },
    filterStatus(val) {
      switch(val) {
        case 0:
          return '待接单'
        case 1:
          return '已接单'
        case 2:
          return '已拒单'
        case 3:
          return '已结单'
        case 4:
          return '已取消'
        default:
          return '--'
      }
    }
  },
  props: {
    orderList: {
      type: Object,
      default: () => {
        return {
          total: 0,
          current: 1,
          size: 5
        }
      }
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    // 行点击
    handleRowClick(row) {
      this.$emit('row-click', row)
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
