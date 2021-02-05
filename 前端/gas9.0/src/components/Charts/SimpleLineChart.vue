<!-- vchart 简单折线图-->
<template>
  <ve-line ref="chart" :loading="loading" :data="chartData" :height="height" :judge-width="true" :grid="grid" :extend="extend" :legend-visible="legendVisible"></ve-line>
</template>
<script>
// import { compile } from 'path-to-regexp'
import resize from './mixins/resize'
import 'v-charts/lib/style.css'
export default {
  name: 'SimpleLineChart',
  mixins: [resize],
  props: {
    height: {
      type: String,
      default: '250px'
    },
    legendVisible: {
      type: Boolean,
      default: false
    },
    chartData: {
      type: Object,
      default: function() {
        return {}
      }
    },
    grid: {
      type: Object,
      default: function () {
        return { top: 60, width: '80%', bottom: 10, left: '5%' }
      }
    },
    colors: {
      type: Array,
      default: function() { return ['#73A0FA'] }
    }
  },
  data() {
    return {
      loading: true,
      // 扩展
      extend: {
        yAxis: {
          // min: 0,
          // max: 1000,
          // interval: 250
          // splitNumber:4 //y轴坐标刻度分段
        },
        legend: {
          left: '5%',
          top: '5%'
          // icon:'pin'
        },
        color: this.colors,
        series: {
          smooth: false
        }
      }
    }
  },
  watch: {
    chartData: function(newChartData, oldChartData) {
      // console.log(newChartData)
      this.chartData = newChartData
    },
    tabId(oldTabId, newTabId) {
    //   console.log(newTabId)
      this.$nextTick(() => {
        this.$refs[`chart`].echarts.resize()
      })
    }
  },
  created() {
    const _this = this
    setTimeout(() => {
      this.loading = false
    }, 1000)
  },
  mounted() {

  }
}
</script>
