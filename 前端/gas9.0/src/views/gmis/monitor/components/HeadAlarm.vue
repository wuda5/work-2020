<!--
 * @Description: 实时告警 - 顶部提示框
 * @Author: lingw
 * @Date: 2020-10-19 14:38:36
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 14:15:53
-->
<template>
  <div class="header-container">
    <p>{{ title }}状态专栏</p>
    <div v-for="section in sections" :key="section.id">
      <i :class="['el-icon-location-information', section.type]"></i>
      <span>{{ section.name }}</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MonitorHeader',
  props: {
    sections: {
      type: Array,
      default: () => {
        return []
      }
    },
    title: {
      required: true,
      type: String
    }
  }
}
</script>

<style lang='scss' scoped>
  .header-container {
    display: flex;
    padding: 6px;
    width: 360px;
    height: 40px;
    border-radius: 6px;
    box-shadow: 1px 1px 5px 2px #C0C4CC;
    justify-content: space-around;
    align-items: center;
    background: #fff;
    font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif;
    p {
      font-size: 16px;
      font-weight: 600;
    }
    div {
      border-left: 1px solid #cfd3db;
      padding-left: 6px;
      span {
        font-size: 14px;
        font-weight: 400;
      }
    }
    .emergency {
      color: #F56C6C;
    }
    .alarm {
      color: #E6A23C;
    }
    .normal {
      color: #67C23A;
    }
  }
</style>
