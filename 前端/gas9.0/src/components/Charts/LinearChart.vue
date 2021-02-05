<!-- v-chart 简单条形图-->
<template>
  <ve-bar :id="id" ref="chart" :data="chartData" :judge-width="true" :height="height" :grid="grid" :extend="extend" :legend-visible="legendVisible"></ve-bar>
</template>

<script>
import resize from './mixins/resize'
export default {
  name: 'LinearChart',
  mixins: [resize],
  props: {
    title: {
      type: String,
      default: ''
    },
    height: {
      type: String,
      default: '250px'
    },
    id: {
      type: String,
      default: 'chart'
    },
    legendVisible: {
      type: Boolean,
      default: false
    },
    grid: {
      type: Object,
      default: function() {
        return { top: 60, bottom: 10, width: '80%', left: '5%' }
      }
    },

    chartData: {
      type: Object,
      default: function() {
        return {}
      }
    },
    colors: {
      type: Array,
      default: function() { return ['#73A0FA'] }
    }
  },
  data() {
    return {
      // 扩展
      extend: {
        color: this.colors,
        title: {
          text: this.title,
          left: '30%',
          top: '2%',
          textStyle: {
            fontSize: '12px',
            fontWeight: 'normal',
            color: '#BABABA'
          }
        },
        legend: {
          right: '5%',
          top: '5%',
          orient: 'vertical',
          icon: 'circle',
          textStyle: {
            fontSize: '12px'
          }
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
  mounted() {
    // console.log(this.title)
  }
}
</script>
