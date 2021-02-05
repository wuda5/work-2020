<!--
 * @Description: 流程信息
 * @Author: lingw
 * @Date: 2020-11-16 11:09:31
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 14:43:38
-->
<template>
  <div>
    <el-timeline v-if="processList.length">
      <el-timeline-item v-for="process in processList" :key="process.id" :timestamp=" process.createTime" placement="top">
        <el-card>
          <p>操作人: {{ process.processUserName | filterEmpty }}</p>
          <p>操作时间: {{ process.createTime | filterEmpty }}</p>
          <p>当前状态: {{ process.processState | statusFilter }}</p>
        </el-card>
      </el-timeline-item>
    </el-timeline>
    <div v-else class="empty">
      <span>暂时没有流程信息</span>
    </div>
  </div>
</template>

<script>
import { constants as STATUS } from '@/plugins/reportInstall'
export default {
  name: 'ProcessInfo',
  filters: {
    statusFilter(val) {
      switch(val) {
        case STATUS.WAIT_RESOLVE:
          return '受理'
        case STATUS.HAVE_RESOLVED:
          return '已受理'
        case STATUS.WAIT_SURVEY:
          return '踏勘'
        case STATUS.WAIT_DESIGN:
          return '设计'
        case STATUS.WAIT_CHARGE:
          return '收费'
        case STATUS.WAIT_BUILD:
          return '施工'
        case STATUS.WAIT_CHECK:
          return '待验收'
        case STATUS.WAIT_SETTLE:
          return '结单'
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
  },
  data () {
    return {

    }
  },
  mounted () {

  },
  methods: {

  }
}
</script>

<style lang='scss' scoped>
  .empty {
    min-height: 240px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
