<!-- v-chart 饼状图 -->
<template>
  <div :id="id" :class="className" :style="{height:height,width:width}"/>
</template>

<script>
import echarts from 'echarts'
import resize from './mixins/resize'

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    id: {
      type: String,
      default: 'piechart'
    },
    width: {
      type: String,
      default: '400px'
    },
    height: {
      type: String,
      default: '250px'
    },
    myChartData: {
      type: Array,
      default: function () {
        return ['客服次数(%)', '运维次数(%)', '安检次数(%)', '报装次数(%)']
      }
    },
    chartData: {
      type: Array,
      default: function () {
        return []
      }
    }
  },
  data() {
    return {
      chart: null
    }
  },
  watch: {
    // 必须深度监听次数据，不然不会改变数据
    chartData: {
      handler(newName, oldName) {
        this.initChart()
      },
      deep: true //为true，表示深度监听，这时候就能监测到a值变化
    }
  },
  mounted() {
    this.initChart()
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      const _this = this
      _this.$nextTick(() => {
        this.chart = echarts.init(document.getElementById(this.id))
        this.chart.setOption({
          backgroundColor: '#fff',
          tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {d}%'
          },
          legend: {
            orient: 'vertical',
            x: '60%',
            y: '30%',
            icon: 'circle',
            textStyle: {
              color: '#BABABA',
              fontSize: '14px'
            },
            itemStyle: {
              borderRadius: '100%'
            },
            data: _this.myChartData
          },
          calculable: false,
          series: [{
            name: '业务保障数据',
            type: 'pie',
            radius: ['50%', '75%'],
            center: ['40%', '50%'],
            avoidLabelOverlap: false,
            label: {
              show: false,
              position: 'center',
              normal: {
                position: 'inner',
                formatter: '{d}%',
                fontSize: '12px'
              }
            },
            //   itemStyle:{
            //       width:'60px'
            //   },
            emphasis: {
              label: {
                show: true,
                fontSize: '14px',
                fontWeight: 'bold'
              }
            },
            labelLine: {
              show: true
            },
            data: _this.chartData
          }
          ]
        })
      })
    }
  }
}
</script>
