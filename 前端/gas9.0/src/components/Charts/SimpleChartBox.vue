<!--vchart 简单柱状图-->
<template>
  <ve-histogram
    :id="id"
    ref="chart"
    :height="height"
    :extend="extend"
    :legend-visible="legendVisible"
    :judge-width="true"
    :grid="grid"
    :data="chartData"
  />
</template>

<script>
import {option} from 'runjs'
import resize from './mixins/resize'

export default {
  name: 'ChartBar',
  mixins: [resize],
  props: {
    id: {
      type: String,
      default: 'chart'
    },
    title: {
      type: String,
      default: ''
    },
    legendVisible: {
      type: Boolean,
      default: false
    },
    width: {
      type: String,
      default: '600px'
    },
    height: {
      type: String,
      default: '250px'
    },
    showTitle: {
      type: Boolean,
      default: true
    },
    colors: {
      type: Array,
      default: function () {
        return ['#73A0FA']
      }
    },
    barWidth: {
      type: Number,
      default: 20
    },
    chartData: {
      type: Object,
      default: function () {
        return {}
      }
    },
    grid: {
      type: Object,
      default: function () {
        return {top: 60, width: this.width, bottom: 10, left: 0}
      }
    },
    unit: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      chart: null,
      // 扩展
      extend: {
        legend: {
          left: '5%',
          top: '5%',
          icon: 'rect',
          show: this.legendVisible
        },
        title: {
          text: this.title,
          left: '30%',
          top: '5%',
          textStyle: {
            fontStyle: '12px',
            fontWeight: 'normal',
            color: '#bababa'
          }
        },
        color: this.colors,
        series: {
          barWidth: this.barWidth || 'auto' // 柱状图宽度
        },
        yAxis: {
          splitNumber: 4
        }
      }
    }
  },
  computed: {
    curTabName() {
      return this.$store.state.statistics.curTabName
    },
  },
  watch: {
    // 数据变化时更新
    chartData: function (newChartData, oldChartData) {
      this.chartData = newChartData
    },
    // 切换tabs时
    // curTabName() {
    //   this.$refs[`chart`].echarts.resize()
    // }
  },
  mounted() {
    this.$nextTick(() => {
      this.$refs[`chart`].echarts.resize()
    })
  },
  methods: {

  }
}
</script>
