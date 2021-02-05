<!--
 * @Description: 工单材料相关信息详情
 * @Author: lingw
 * @Date: 2020-11-18 17:06:20
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 14:31:47
-->
<template>
<div>
  <div v-if="orderFilesInfo.length">
    <el-card>
      <div slot="header">
        <span class="card-title">工单ID： {{ orderInfo.id }}</span>
      </div>
      <el-row :gutter="12">
        <el-col :span="12">
          <p>工单类型: 安检工单</p>
        </el-col>
        <el-col :span="12">
          <p>紧急程度: 
             <span v-if="orderInfo.urgency == null">--</span>
              <el-tag v-else :type="orderInfo.urgency | filterEmergencyType">{{ orderInfo.urgency | filterEmergency }}</el-tag>
          </p>
        </el-col>
      </el-row>
      <el-row :gutter="12">
        <el-col :span="12">
          <p>工单状态: {{ orderInfo.orderStatus | filterStatus }}</p>
        </el-col>
      </el-row>
      <el-row :gutter="12">
        <el-col :span="24">
          <p>工单内容: 
            {{ orderInfo.dataStatus | filterEmpty }}
          </p>
        </el-col>
      </el-row>
      <div>
        <el-image
          v-for="info in orderFilesInfo" :key="info.id" 
          style="width: 100px; height: 100px"
          :src="info.materialUrl" 
          :preview-src-list="[info.materialUrl]"
        >
        </el-image>
      </div>
      </el-card>
  </div>
  <div v-else class="info-empty">
    <p>暂时没有数据</p>
  </div>
 </div>
</template>

<script>
export default {
  name: 'OrderFilesInfo',
  filters: {
    filterEmpty(val) {
      return val || '--'
    },
    filterName(val) {
      switch(val) {
      case 'SURVEY':
        return '踏勘'
      case 'INSTALL':
        return '报装'
      case 'ACCEPT':
        return '验收'
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
  },
  props: {
    orderFilesInfo: {
      type: Array,
      default: () => {
        return []
      }
    },
    orderInfo: {
      type: Object,
      default: () => {
        return {}
      }
    }
  }
}
</script>

<style lang='scss' scoped>
  .jh-text {
    .el-card__body {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      overflow: hidden;
      .info-item {
        width: 100%;
        display: flex;
        justify-content: space-between;
      }
    }
  }
  .info-empty {
    width: 100%;
    height: 240px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
