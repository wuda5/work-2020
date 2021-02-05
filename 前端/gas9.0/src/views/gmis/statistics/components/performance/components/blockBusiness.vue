<!-- 业务保障数据 -->
<template>
  <div class="tabBox">
    <!-- search -->
    <search-box>
      <div slot="left">
        <span class="card-title">业务保障数据</span>
      </div>
      <div slot="right">
        <el-date-picker
          v-model="dataRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
        <el-button type="primary" plain>确认</el-button>
        <el-button v-if="false" type="primary" plain>导出数据</el-button>
      </div>
    </search-box>

    <!-- 业务保障数据 4 分类 -->
    <div class="StaticsData">
      <st-data-card
        v-for="(item,index) in blockData" :key="index"
        :bg-color="item.bgColor"
        :bg-color1="item.bgColor1"
        :title="item.title"
        :card-data="item.cardData"
        :show-tail="active === index"
        :style="{width: width}"
        @click.native="changeItem(index, item)"
      />
    </div>

    <!--sub-->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <!-- 饼图 -->
        <el-col :span="12" class="chartbox">
          <pie-chart
            :chart-data="chartData"
            class="myCharts"
            width="80%"
          />
        </el-col>

        <!-- chart -->
        <el-col :span="12">
          <chart-bar
            :legend-visible="false"
            :chart-data="chartData1"
            :bar-width="30"
            class="myCharts"
            color="#73A0FA"
            width="80%"
          />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>

import StDataCard from './staticsDataCard' // 方块统计
import PieChart from '@/components/Charts/PieChart' // 饼状图图表
import ChartBar from '@/components/Charts/SimpleChartBox' // 柱状图图表
import LineChart from '@/components/Charts/SimpleLineChart' // 折线图图表

export default {
  name: 'BusinessData',
  components: {
    StDataCard,
    PieChart,
    ChartBar,
    LineChart
  },
  props: {},
  data() {
    return {
      active: 0,
      colors: ['#73A0FA', '#73DEB3', '#F6CF31'],
      dataRange: '',

      // 业务保障数据
      blockData: [
        {
          title: '客服次数',
          bgColor: '#35D2B9',
          bgColor1: '#2FCDB1',
          cardData: {
            todayData: {
              subText: '今日客服(次)',
              detail: 1256
            },
            monthData: {
              subText: '本月次数(万次)',
              detail: 1.33
            },
            yearData: {
              subText: '本年次数(万次)',
              detail: 12.92
            },
            totalData: {
              subText: '累计次数(万次)',
              detail: 131.91
            }
          }
        },
        {
          title: '运维次数',
          bgColor: '#55B9FF',
          bgColor1: '#4CB1FF',
          cardData: {
            todayData: {
              subText: '今日运维(次)',
              detail: 2348
            },
            monthData: {
              subText: '本月次数(万次)',
              detail: 0.41
            },
            yearData: {
              subText: '本年次数(万次)',
              detail: 7.12
            },
            totalData: {
              subText: '累计次数(万次)',
              detail: 1.30
            }
          }
        },
        {
          title: '报装次数',
          bgColor: '#0DC4D4',
          bgColor1: '#0BBDCF',
          cardData: {
            todayData: {
              subText: '今日报装(次)',
              detail: 291
            },
            monthData: {
              subText: '本月次数(万次)',
              detail: 2.31
            },
            yearData: {
              subText: '本年次数(万次)',
              detail: 32.91
            },
            totalData: {
              subText: '累计次数(万次)',
              detail: 156.12
            }
          }
        },
        {
          title: '安检次数',
          bgColor: '#8EA3FA',
          bgColor1: '#8299F9',
          cardData: {
            todayData: {
              subText: '今日次数(次)',
              detail: 2941
            },
            monthData: {
              subText: '本月次数(万次)',
              detail: 4.37
            },
            yearData: {
              subText: '本年次数(万次)',
              detail: 12.91
            },
            totalData: {
              subText: '累计次数(万次)',
              detail: 145.67
            }
          }
        }
      ],

      // 业务保障饼状图数据
      chartData: [
        {value: 100, name: '运维次数(%)', itemStyle: {color: '#55B9FF'}},
        {value: 300, name: '客服次数(%)', itemStyle: {color: '#35D2B9'}},
        {value: 20, name: '报装次数(%)', itemStyle: {color: '#0DC4D4'}},
        {value: 300, name: '安检次数(%)', itemStyle: {color: '#8EA3FA'}}
      ],

      // 业务保障柱状图数据
      chartData1: {
        columns: ['业务保障', '次数'],
        rows: [
          {'业务保障': '客服次数', '次数': 100},
          {'业务保障': '运维次数', '次数': 300},
          {'业务保障': '安检次数', '次数': 50},
          {'业务保障': '报装次数', '次数': 300}
        ]
      },
    }
  },
  computed: {
    width() {
      return (100 / this.blockData.length - 1) + '%'
    },
  },
  mounted() {

  },
  methods: {
    exportData(title) {
      this.exportTitle = `${title}数据导出`
      this.showExportData = true
    },

    changeItem(index, item) {
      this.active = index
      this.chartData[0].value = item.cardData.todayData.detail
      this.chartData1.rows[0]['次数'] = item.cardData.todayData.detail
    }
  }
}
</script>

<style scoped>
.StaticsData {
  margin: 30px 0;
  height: 220px;
  display: flex;
  display: -webkit-flex;
  justify-content: space-between;
}
</style>
