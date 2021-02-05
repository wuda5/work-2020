<template>
  <div class="counterStatistics">
    <qc-count-card bg-color="#24c4aa">
      <span class="counterTitle">抄表率</span>
      <span class="counterNum">99%</span>
      <span class="counterText">抄表数</span>
      <span class="counterNum1">28712</span>
    </qc-count-card>
    <qc-count-card bg-color="#1fc9d9">
      <span class="counterTitle">遗漏</span>
      <span class="counterNum">824</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#70aef5">
      <span class="counterTitle">结算率</span>
      <span class="counterNum">99%</span>
      <span class="counterText">结算</span>
      <span class="counterNum1">8122</span>
    </qc-count-card>
    <qc-count-card bg-color="#ffc414">
      <span class="counterTitle">审核率</span>
      <span class="counterNum">98%</span>
      <span class="counterText">审核</span>
      <span class="counterNum1">7712</span>
    </qc-count-card>
    <qc-count-card bg-color="#8f9fff">
      <span class="counterTitle">发票</span>
      <span class="counterNum">754</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#55b9ff">
      <span class="counterTitle">收费</span>
      <span class="counterNum">8990</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#8f9fff">
      <span class="counterTitle">发票</span>
      <span class="counterNum">754</span>
      <span class="counterBar"></span>
    </qc-count-card>
    <qc-count-card bg-color="#55b9ff">
      <span class="counterTitle">收费</span>
      <span class="counterNum">8990</span>
      <span class="counterBar"></span>
    </qc-count-card>
  </div>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index.vue'

export default {
  name: 'ReadMeterStatistics',
  components: {
    QcCountCard,
  },
  props: {
    height: {
      type: String,
      default: '100%',
    },
  },
}
</script>

<style lang="scss" scoped>
  .counterStatistics {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    border: 1px solid #e6ebf5;
    border-radius: 4px;
    padding: 10px;
    overflow-y: scroll;
    height: 100%;

    .qc-cont-card {
      width: calc((100% - 15px) / 2);
      height: 230px;
      margin-bottom: 15px;

      .counterText {
        margin-top: 30px;
      }
      .counterNum {
        margin-top: 70px;
      }
      .counterNum1 {
        font-size: 16px;
        margin-top: 5px;
      }
      .counterBar {
        margin-top: 40px;
      }
    }
  }
</style>
