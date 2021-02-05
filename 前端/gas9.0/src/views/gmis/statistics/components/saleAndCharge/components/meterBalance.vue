<!-- 表端余额统计-->
<template>
  <el-card shadow="never" class="counter">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">表端余额统计</span>
        </div>
        <div slot="right">
          <el-button v-if="false" type="primary" plain>导出数据</el-button>
        </div>
      </search-box>
    </div>
    <el-row :gutter="15">
      <el-col :span="12">
        <chart-bar
          :legend-visible="true"
          :bar-width="30"
          :chart-data="chartData1"
          class="myCharts"
          width="90%"
          :colors="['#73A0FA','#73DEB3']"
        />
      </el-col>
      <el-col :span="12">
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData2"
          :bar-width="20"
          class="myCharts"
          width="90%"
          :colors="color1"
        />
      </el-col>
    </el-row>
  </el-card>
</template>
<script>
import ChartBar from '@/components/Charts/SimpleChartBox'
import tjApi from '@/api/statistics';

export default {
  name: 'Classify',
  components: {
    ChartBar
  },
  props: {
    propsData: {
      type: Object,
      default: function () {
        return {
          orgId: '',
          timeRange: []
        }
      }
    }
  },
  data() {
    return {
      typeValue:'',
      dateRange: '',
      color1: ['#73A0FA', '#73DEB3', '#F6CF31'],
      chartData1: {
        columns: ['日期', '表端余额', '表端平均余额'],
        rows: [
          {'日期': '01月', '表端余额': 800, '表端平均余额': 570},
          {'日期': '02月', '表端余额': 640, '表端平均余额': 250},
          {'日期': '03月', '表端余额': 620, '表端平均余额': 480},
          {'日期': '04月', '表端余额': 720, '表端平均余额': 100},
          {'日期': '05月', '表端余额': 790, '表端平均余额': 500}
        ]
      },
      chartData2: {
        columns: ['日期', '本月', '上月', '去年同期'],
        rows: [
          {'日期': '01月', '本月': 900, '上月': 750, '去年同期': 700},
          {'日期': '02月', '本月': 750, '上月': 600, '去年同期': 520},
          {'日期': '03月', '本月': 200, '上月': 150, '去年同期': 140},
          {'日期': '04月', '本月': 180, '上月': 160, '去年同期': 146},
          {'日期': '05月', '本月': 220, '上月': 180, '去年同期': 163}
        ]
      }
    }
  }
  ,
  watch: {
    propsData() {
      // this.getData()
    }
    ,
  }
  ,
  mounted() {
    // this.getData()
  }
  ,
  methods: {
    getData() {
      let params = {
        orgId: this.propsData.orgId,
        startDay: this.propsData.timeRange[0] || '',
        endDay: this.propsData.timeRange[1] || '',
      }

      tjApi.SCustomerType(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {

          let rows1 = []
          let rows2 = []

          data.nowDate.forEach((item, index) => {
            rows1.push(
              {
                '分类': item.typeName,
                '数据': item.amount
              }
            )

            rows2.push(
              {
                '类型': item.typeName,
                '本月': item.amount,
                '上月': data.lastMonthDate[index].amount,
                '去年同期': data.lastYearDate[index].amount
              },
            )
          })
          this.chartData1.rows = rows1
          this.chartData2.rows = rows2
        }
      })
    },

    selectHandle(){

    }

  }
}
</script>
<style lang="scss" scoped>
</style>
