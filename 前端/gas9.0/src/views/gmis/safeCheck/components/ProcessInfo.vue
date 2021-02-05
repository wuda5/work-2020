<!--
 * @Description: 流程信息
 * @Author: lingw
 * @Date: 2020-11-16 11:09:31
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 10:12:14
-->
<template>
 <el-timeline>
  <el-timeline-item v-for="process in processList" :key="process.id" :timestamp=" process.createTime" placement="top">
    <el-card>
      <p>操作人: {{ process.processUserName | filterEmpty }}</p>
      <p>操作时间: {{ process.createTime | filterEmpty }}</p>
      <p>当前状态: {{ process.processState | statusFilter }}</p>
    </el-card>
  </el-timeline-item>
</el-timeline>
</template>

<script>
import { constants as STATUS } from '@/plugins/securityCheck'
export default {
  name: 'ProcessInfo',
  filters: {
    statusFilter(val) {
      switch(val) {
        case STATUS.WAIT_ARRAIGNED:
          return '提审'
        case STATUS.WAIT_AUDIT:
          return '审核'
        case STATUS.WAIT_ORDER:
          return '派工'
        case STATUS.WAIT_CHECK:
          return '安检'
        case STATUS.WAIT_FALLBACK:
          return '回访'
        case STATUS.EXCEPTION:
          return '异常'
        case STATUS.HAVE_SETTLED:
          return '已结单'
        case STATUS.HAVE_END:
          return '终止'
      }
    },
    filterEmpty(val) {
      return val ?? '--'
    }
  },
  props: {
    processList: {
      type: Array,
      default: () => {
        return []
      }
    }
  }
}
</script>
<style lang="scss" scoped>
  .el-timeline-item {
    padding-bottom: 10px;
    .el-card__body {
      padding: 10px !important;
    }
  }
</style>