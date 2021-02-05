<!--
 * @Description: 安检列表
 * @Author: lingw
 * @Date: 2020-11-16 10:14:15
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-25 09:45:51
-->
<template>
  <!-- 安检列表 -->
  <div>
    <el-table
      :data="tableDataList.list"
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
        label="客户编号"
        show-overflow-tooltip
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.customerCode | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        width="80"
        label="客户名称"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.customerName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="气表编号"
        width="160"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.gasCode | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="安检计划编号"
        width="160"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.scNo | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="用气类型"
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.useGasTypeId | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="安检人名称"
        width="80"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.customerName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="安检状态"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.dataStatus | filterStatus }}
        </span>
      </el-table-column>
      <el-table-column
        label="备注"
        width="140"
      >
        <span slot-scope="{row}">
          {{ row.remark | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="操作"
        width="220"
      >
      <template slot-scope="{row}">
        <el-button type="primary" @click="() => handleEdit(2, row)">
          编辑
        </el-button>
        <!-- 录入安检结果 -->
        <el-button v-if="row.dataStatus === WAIT_CHECK" type="primary" @click="() => handleInputData(row)">录入安检结果</el-button>
      </template>
      </el-table-column>
    </el-table>
    <Pagination
      v-if="+tableDataList.total"
      style="float: right; margin: 10px 0 5px"
      layout="prev, pager, next"
      :page="+tableDataList.current"
      :limit="+tableDataList.size"
      :total="+tableDataList.total"
      @pagination="handleChange"
    />
  </div>
</template>

<script>
import { constants as STATUS } from '@/plugins/securityCheck'
import { formatNumber2Thousand } from '@/utils/commons'
export default {
  name: 'ReportList',
   filters: {
    filterStatus(val) {
      switch(val) {
        case STATUS.WAIT_ARRAIGNED:
          return '待提审'
        case STATUS.WAIT_AUDIT:
          return '待审核'
        case STATUS.WAIT_ORDER:
          return '待派工'
        case STATUS.WAIT_CHECK:
          return '待安检'
        case STATUS.WAIT_FALLBACK:
          return '待回访'
        case STATUS.EXCEPTION:
          return '异常'
        case STATUS.HAVE_SETTLED:
          return '已结单'
        case STATUS.HAVE_END:
          return '终止'
        default:
          return '--'
      }
    },
    filterMoney(val) {
      return formatNumber2Thousand(val)
    },
    filterEmpty(val) {
      return val || '--'
    }
  },
  props: {
    tableDataList: {
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
  data() {
    return {
      WAIT_CHECK: STATUS.WAIT_CHECK
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    // 编辑按钮
    handleEdit(val, row) {
      this.$emit('edit', val, row)
    },
    // 选中某行
    handleRowClick(row, column, event) {
      this.$emit('row-click', row)
    },
    // 录入安检结果
    handleInputData(record) {
      this.$emit('data-input', record)
    }
  }
}
</script>
