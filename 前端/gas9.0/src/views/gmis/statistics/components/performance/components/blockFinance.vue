<!-- 财务数据 -->
<template>
  <div class="tabBox">
    <!--search-->
    <search-box>
      <div slot="left">
        <span class="card-title">财务数据</span>
      </div>
    </search-box>

    <!--财务数据 5分类 -->
    <div class="StaticsData">
      <st-data-card
        v-for="(item, key, index) in finaText" :key="index"
        :bg-color="colors[index]"
        :title="finaText[key].title"
        :card-data="finaText[key]"
        :show-tail="active === index"
        :style="{width: width}"
        @click.native="changeItem(index,item)"
      />
    </div>

    <!--search-->
    <search-box>
      <div slot="right">
        <el-date-picker
          v-model="dataRange"
          type="monthrange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :picker-options="pickerOptions"
          value-format="yyyy-MM"
        />
        <el-button type="primary" plain @click="getData">确认</el-button>
      </div>
    </search-box>

    <!-- 同比环比 波动趋势 -->
    <el-card shadow="never">
      <el-row :gutter="15">
        <el-col :span="12">
          <div class="card-title">同比环比</div>
          <chart-bar
            :legend-visible="true"
            :chart-data="barData"
            :bar-width="10"
            width="80%"
            class="myCharts"
            :colors="colors"
          />
        </el-col>
        <el-col :span="12">
          <div class="card-title">波动趋势</div>
          <line-chart
            :legend-visible="true"
            :chart-data="lineData"
            width="80%"
            class="myCharts"
          />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import StDataCard from './staticsDataCard'
import ChartBar from '@/components/Charts/SimpleChartBox' // 柱状图图表
import LineChart from '@/components/Charts/SimpleLineChart' // 折线图图表
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'FinanceData',
  components: {
    ChartBar,
    LineChart,
    StDataCard
  },
  props: {
    propsData: {
      type: Object,
      default: function () {
        return {
          orgId: ''
        }
      }
    }
  },
  data() {
    return {
      active: 0,  // 当前选中
      colors: [
        '#8EA3FA',
        '#55B9FF',
        '#35D2B9',
        '#F5C60D',
        '#0FDBED'
      ],
      dataRange: '', // 时间

      // 快捷选择时间
      pickerOptions: {
        shortcuts: [
          {
            text: '本月',
            onClick(picker) {
              picker.$emit('pick', [new Date(), new Date()]);
            }
          },
          {
            text: '今年至今',
            onClick(picker) {
              const end = new Date();
              const start = new Date(new Date().getFullYear(), 0);
              picker.$emit('pick', [start, end]);
            }
          },
          {
            text: '最近三个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setMonth(start.getMonth() - 3);
              picker.$emit('pick', [start, end]);
            }
          },
          {
            text: '最近六个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setMonth(start.getMonth() - 6);
              picker.$emit('pick', [start, end]);
            }
          },
          {
            text: '最近十二个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setMonth(start.getMonth() - 12);
              picker.$emit('pick', [start, end]);
            }
          },

        ]
      },

      finaText: {
        customer: {
          title: '客户量',
          todayData: '今日新增(户)',
          monthData: '本月新增(户)',
          yearData: '本年新增(户)',
          totalData: '累计客户量(户)',
          data: {}
        },
        /* gasAmount: {
          title: '售气量',
          todayData: '今日售气(方)',
          monthData: '本月售气(方)',
          yearData: '本年售气(方)',
          totalData: '累计售气量(方)',
          data: {}
        }, */
        gasFei: {
          title: '收费量',
          todayData: '今日收费(元)',
          monthData: '本月收费(元)',
          yearData: '本年收费(元)',
          totalData: '累计收费(元)',
          data: {}
        },
        overdraftFei: {
          title: '燃气欠费',
          todayData: '今日欠费(元)',
          monthData: '本月欠费(元)',
          yearData: '本年欠费(元)',
          totalData: '累计欠费(元)',
          data: {}
        },
        /*sale: {
          title: '销货量',
          todayData: '今日销量(件)',
          monthData: '本月销量(万件)',
          yearData: '本年销量(万件)',
          totalData: '累计销货量(万件)',
          data: {}
        }*/
      },

      // 同比环比柱状图数据
      barData: {
        columns: ['时间', '本期', '上期'],
        rows: []
      },

      // 同比环比折线图数据
      lineData: {
        columns: ['日期', '月数据'],
        rows: []
      },
    }
  },
  computed: {
    width() {
      // return (100 / this.finaData.length - 1) + '%'
      return (100 / Object.keys(this.finaText).length - 1) + '%'
    },
  },
  watch:{
    propsData() {
      this.getData()
    },
  },
  
  mounted() {
    this.getData()
  },
  methods: {
    changeItem(index, item) {
      this.active = index
      this.formatChartData(item.data.compareData)
    },

    getData() {
      let params = {
        orgId:this.propsData.orgId,
        endDay: '',
        startDay: '',
      }

      if (this.dataRange) {
        
        params.startDay = this.dataRange[0] + '-01'
        params.endDay = this.dataRange[1] + '-01'
      }

      tjApi.SFinanceData(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          for (let key in data) {
            if (this.finaText[key]) {
              this.finaText[key].data = data[key]
            }
          }

          // 设置第一组数据
          this.formatChartData(this.finaText.customer.data.compareData)

        }
      })
    },

    // 转换 同比环比柱状图数据 同比环比折线图数据
    formatChartData(arr) {
      let barRows = []
      let lineRows = []

      arr.forEach(item => {
        let barDataItem = {
          '时间': item.monStr,
          '上期': item.lastYearNum,
          '本期': item.thisYearNum
        }
        let lineDataItem = {
          '日期': item.monStr,
          '月数据': item.thisYearNum
        }

        /* 模拟数据*/
        /*let barDataItem = {
          '时间': item.monStr,
          '本期': this.randomNum(10,90),
          '上期': this.randomNum(10,40)
        }

        let lineDataItem = {
          '日期': item.monStr,
          '月数据': this.randomNum(10,40)
        }*/
        barRows.push(barDataItem)
        lineRows.push(lineDataItem)

      })
      this.barData.rows = barRows
      this.lineData.rows = lineRows
    },
  }
}
</script>

<style scoped>
.StaticsData {
  margin: 30px 0 15px;
  height: 220px;
  display: flex;
  display: -webkit-flex;
  justify-content: space-between;
}
</style>
