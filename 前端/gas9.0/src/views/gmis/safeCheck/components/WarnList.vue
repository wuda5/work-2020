<!--
 * @Description: 隐患列表
 * @Author: lingw
 * @Date: 2020-11-24 11:38:41
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 10:25:52
-->
<template>
 <div>
   <el-table
      :data="warnList.list"
      tooltip-effect="dark"
      style="width: 100%"
      :border="false"
      :highlight-current-row="true"
      :height="242"
    >
      <el-table-column
        label="序号"
        type="index"
        width="45"
      />
      <el-table-column
        label="隐患名称"
        width="120"
      >
        <span slot-scope="{row}">
          {{ row.scTermItemsName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="隐患等级"
        show-overflow-tooltip
        width="120"
      >
        <span slot-scope="{row}">
          <span v-if="!row.dangerLeve">--</span>
          <el-tag
            v-else
            :type="row.dangerLeve | filterLevelType"
            effect="dark"
>
            {{ row.dangerLeve | filterLevel }}
          </el-tag>
        </span>
      </el-table-column>
      <el-table-column
        label="整改信息"
        width="80"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.handleInfo | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="	隐患处理状态"
        show-overflow-tooltip
        width="120"
      >
        <span slot-scope="{row}">

          {{ row.handleStatus | filterStatus }}
        </span>
      </el-table-column>
      <el-table-column
        label="安检隐患描述"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.hiddenDanger | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="备注"
      >
        <span slot-scope="{row}">
          {{ row.remark | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="{row}">
          <el-button v-if="row.handleStatus !== 1" type="primary" @click="() => handleInputWarn(row)">录入整改隐患</el-button>
        </template>
      </el-table-column>
    </el-table>
    <Pagination
      v-if="+warnList.total"
      style="float: right; margin: 10px 0 5px"
      layout="prev, pager, next"
      :page="+warnList.current"
      :limit="+warnList.size"
      :total="+warnList.total"
      @pagination="handleChange"
    />
 </div>
</template>

<script>
export default {
  name: 'WarnList',
  filters: {
    filterEmpty(val) {
      return val || '--'
    },
    filterStatus(val) {
      return val === 1 ? '已整改' : '未整改'
    },
    filterLevelType(val) {
      switch(val) {
        case '0':
          return 'danger'
        case '1':
          return 'info'
        case '2':
          return 'warning'
        default:
          return ''
      }
    },
    filterLevel(val) {
      switch(val) {
        case '0':
          return '重度'
        case '1':
          return '轻度'
        case '2':
          return '中度'
        default:
          return '--'
      }
    },
    filterName(val) {
      const [record] = this.warnLevel.filter(item => item.code === val)
      return record.name
    }
  },
  props: {
    warnList: {
      type: Object,
      default: () => {
        return {
          total: 0,
          current: 1,
          size: 5
        }
      }
    },
    warnLevel: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    // 录入整改信息
    handleInputWarn(row) {
      this.$emit('handleWarnEdit', row)
    }
  }
}
</script>
