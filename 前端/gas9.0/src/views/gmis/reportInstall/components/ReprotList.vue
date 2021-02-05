<!--
 * @Description: 报装列表
 * @Author: lingw
 * @Date: 2020-11-16 10:14:15
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 14:47:40
-->
<template>
  <!-- 报装列表 -->
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
        label="编号"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.installNumber | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="报装人名称"
        width="80"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.customerName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="报装地址"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.addressRemark | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="联系电话"
        width="120"
      >
        <span slot-scope="{row}">
          {{ row.telphone | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="户数"
        width="80"
      >
        <span slot-scope="{row}">
          {{ row.population | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="状态"
        width="80"
      >
        <span slot-scope="{row}">
          {{ row.dataStatus | filterStatus }}
        </span>
      </el-table-column>
      <el-table-column
        label="收费金额"
        width="140"
      >
        <span slot-scope="{row}">
          {{ row.money | filterMoney }}
        </span>
      </el-table-column>
      <!-- <el-table-column
        prop="pressBoxNo"
        label="调压箱号"
      /> -->
      <el-table-column
        label="操作"
        width="240"
      >
      <template slot-scope="{row}">
        <el-button type="primary" @click="() => handleReport(2, row)">
          编辑
        </el-button>
        <el-button v-if="design_scheme_visible === row.dataStatus" type="primary" @click="() => handleDesign(row)">设计方案</el-button>
        <el-button v-if="input_check_visible === row.dataStatus" type="primary" @click="() => handleAccept(row)">录入验收资料</el-button>
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
import { constants as STATUS } from '@/plugins/reportInstall'
import { formatNumber2Thousand } from '@/utils/commons'
export default {
  name: 'ReportList',
   filters: {
    filterStatus(val) {
      switch(val) {
        case STATUS.WAIT_RESOLVE:
          return '待受理'
        case STATUS.HAVE_RESOLVED:
          return '已受理'
        case STATUS.WAIT_SURVEY:
          return '待踏勘'
        case STATUS.WAIT_DESIGN:
          return '待设计'
        case STATUS.WAIT_CHARGE:
          return '待收费'
        case STATUS.WAIT_BUILD:
          return '待施工'
        case STATUS.WAIT_CHECK:
          return '待验收'
        case STATUS.WAIT_SETTLE:
          return '待结单'
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
      input_check_visible: STATUS.WAIT_CHECK,
      design_scheme_visible: STATUS.WAIT_DESIGN || STATUS.WAIT_BUILD || STATUS.WAIT_CHECK
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    // 编辑按钮
    handleReport(val, row) {
      this.$emit('edit', val, row)
    },
    // 选中某行
    handleRowClick(row, column, event) {
      this.$emit('row-click', row)
    },
    handleAccept(record) {
      this.$emit('accept', record)
    },
    handleDesign(record) {
      this.$emit('design', record)
    }
  }
}
</script>
