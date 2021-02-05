<!-- 安检统计 -->
<template>
  <div class="counterStatistics" :style="myHeight">
    <qc-count-card bg-color="#6e85e5">
      <span class="counterTitle">在线统计</span>
      <span class="counterNum">2411</span>
    </qc-count-card>
    <qc-count-card bg-color="#55b9ff">
      <span class="counterTitle">故障维修</span>
      <span class="counterNum">125</span>
    </qc-count-card>

    <qc-count-card bg-color="#35d2b9">
      <span class="counterTitle">工单处理</span>
      <span class="counterNum">12364</span>
    </qc-count-card>
    <qc-count-card bg-color="#f7cc0d">
      <span class="counterTitle">异常统计</span>
      <span class="counterNum">2387</span>
    </qc-count-card>
  </div>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'

export default {
  name: 'UserRecordStatistics',
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

  .innerBox {
    width: 150px;
  }

  .qc-cont-card {
    width: 100%;
    float: left;

    .counterTitle {
      margin-top: 20px;
    }

    &:last-child {
      margin: 0;
    }

    .counterNum {
      margin-top: 60px;
      font-size: 24px;
    }
  }
}

</style>
