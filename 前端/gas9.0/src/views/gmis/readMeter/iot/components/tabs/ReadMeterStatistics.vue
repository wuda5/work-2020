<!-- 物联网抄表统计 -->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">物联网 抄表统计</div>
    </div>
    <div slot="default" class="frameBody counterStatistics">
      <template v-if="sts">
        <qc-count-card bg-color="#24c4aa">
          <span class="counterTitle">抄表率</span>
          <span class="counterNum">{{ percentage(sts.readMeterCount, sts.totalMeter) }}</span>
          <span class="counterText">抄表数</span>
          <span class="counterNum1">{{ sts.readMeterCount | formatStatisticsNum }}</span>
        </qc-count-card>
        <qc-count-card bg-color="#1fc9d9">
          <span class="counterTitle">遗漏</span>
          <span class="counterNum">{{ sts.missMeterCount | formatStatisticsNum }}</span>
          <span class="counterBar"></span>
        </qc-count-card>
        <qc-count-card bg-color="#70aef5">
          <span class="counterTitle">结算率</span>
          <span class="counterNum">{{ percentage(sts.settlementCount, sts.totalMeter) }}</span>
          <span class="counterText">结算</span>
          <span class="counterNum1">{{ sts.settlementCount | formatStatisticsNum }}</span>
        </qc-count-card>
        <qc-count-card bg-color="#ffc414">
          <span class="counterTitle">审核率</span>
          <span class="counterNum">98%</span>
          <span class="counterText">{{ percentage(sts.reviewCount, sts.totalMeter) }}</span>
          <span class="counterNum1">{{ sts.reviewCount | formatStatisticsNum }}</span>
        </qc-count-card>
        <qc-count-card v-if="false" bg-color="#8f9fff">
          <span class="counterTitle">发票</span>
          <span class="counterNum">754</span>
          <span class="counterBar"></span>
        </qc-count-card>
        <qc-count-card v-if="false" bg-color="#55b9ff">
          <span class="counterTitle">收费</span>
          <span class="counterNum">8990</span>
          <span class="counterBar"></span>
        </qc-count-card>
      </template>
    </div>
  </info-frame>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index.vue'
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'ReadMeterStatistics',
  components: {
    QcCountCard,
  },
  data() {
    return {
      sts: null
    }
  },
  created() {
    this.getData()
  },
  methods: {
    // 获取统计数据
    getData() {
      tjApi.RInternetGasMeter({}).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.sts = data[0]
        }
      })
    },

    // 计算百分比
    percentage(num, total) {
      return (num / total * 100).toFixed(0) + '%'
    }
  },
}
</script>

<style lang="scss" scoped>
.counterStatistics {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  align-content: flex-start;

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
