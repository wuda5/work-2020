<template>
  <div class="counterStatistics" :style="myHeight">
    <qc-count-card bg-color="#31cfb4">
      <span class="counterTitle">受累情况统计</span>
      <span class="counterText">今日受理</span>
      <span class="counterNum">2411</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#0ddcef">
      <span class="counterTitle">客户回访统计</span>
      <span class="counterText">今日回访</span>
      <span class="counterNum">351</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#f6cd0f">
      <span class="counterTitle">投诉统计</span>
      <span class="counterText">今日投诉</span>
      <span class="counterNum">13</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#ff4f84">
      <span class="counterTitle">满意度统计</span>
      <span class="counterText">今日满意度</span>
      <span class="counterNum">99%</span>
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
