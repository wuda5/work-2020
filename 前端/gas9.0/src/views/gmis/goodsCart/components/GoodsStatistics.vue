<!--
 * @Description: 燃气商店统计
 * @Author: lingw
 * @Date: 2020-10-22 11:01:46
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-22 11:12:16
-->
<template>
  <div class="counterStatistics" :style="myHeight">
    <qc-count-card bg-color="#31cfb4">
      <span class="counterTitle">销售额</span>
      <span class="counterText">今日销售额</span>
      <span class="counterNum">2411</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#0ddcef">
      <span class="counterTitle">销售数量</span>
      <span class="counterText">今日销量</span>
      <span class="counterNum">351</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#f6cd0f">
      <span class="counterTitle">退货</span>
      <span class="counterText">今日退货</span>
      <span class="counterNum">3</span>
      <span class="counterBar"></span>
    </qc-count-card>

  </div>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'

export default {
  name: 'ReadMeterStatistics',
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

<style lang="scss" scoped>

.counterStatistics {
  display: flex;
  display: -webkit-flex;
  justify-content: space-between;

  .qc-cont-card {
    width: 100%;
    margin-right: 10px;
    float: left;

    &:last-child {
      margin: 0;
    }

    .counterText {
      margin-top: 30px;
    }
    .counterBar {
      margin-top: 40px;
    }
  }
}

</style>
