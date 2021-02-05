<!--
 * @Description: 报装统计
 * @Author: lingw
 * @Date: 2020-11-11 16:48:45
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-18 09:13:46
-->
<template>
  <div class="counterStatistics" :style="myHeight">
    <qc-count-card bg-color="#35d2b9">
      <span class="counterTitle">任务统计</span>
      <span class="counterText"></span>
      <span class="counterNum">824</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#0fdbed">
      <span class="counterTitle">结单统计</span>
      <span class="counterText">当月结单</span>
      <span class="counterNum">824</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#ffc414">
      <span class="counterTitle">收费金额统计</span>
      <span class="counterText">当月收费</span>
      <span class="counterNum">824</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#ff6696">
      <span class="counterTitle">待收金额统计</span>
      <span class="counterText"></span>
      <span class="counterNum">126</span>
      <span class="counterBar"></span>
    </qc-count-card>
  </div>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'

export default {
  name: 'CounterStatistics',
  components: {
    QcCountCard
  },
  props: {
    height: {
      type: String,
      default: '100%'
    }
  },
  computed: {
    myHeight() {
      return {
        height: this.height
      }
    }
  }
}
</script>

<style lang="scss">
  .counterStatistics {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    overflow-y: scroll;
    height: 100%;
    .qc-cont-card {
      width: calc((100% - 15px) / 2);
      height: 230px;
      margin-bottom: 15px;
    }
  }
</style>
