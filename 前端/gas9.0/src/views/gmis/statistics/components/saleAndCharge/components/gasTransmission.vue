<!-- 输气统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">输气统计</span>
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
          :chart-data="chartData1"
          class="myCharts"
          width="90%"

          :bar-width="30"
        />
      </el-col>
      <el-col :span="12">
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData2"
          :bar-width="20"
          width="90%"
          class="myCharts"
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
        columns: ['日期', '月数据'],
        rows: [
          {'日期': '1月', '月数据': 190},
          {'日期': '2月', '月数据': 240},
          {'日期': '3月', '月数据': 520},
          {'日期': '4月', '月数据': 680},
          {'日期': '5月', '月数据': 750},
          {'日期': '6月', '月数据': 990},
          {'日期': '7月', '月数据': 640}
        ]
      },
      chartData2: {
        columns: ['日期', '本月', '上月', '去年同期'],
        rows: [
          {'日期': '01月', '本月': 240, '上月': 245, '去年同期': 230},
          {'日期': '02月', '本月': 270, '上月': 250, '去年同期': 240},
          {'日期': '03月', '本月': 620, '上月': 480, '去年同期': 420},
          {'日期': '04月', '本月': 700, '上月': 530, '去年同期': 500},
          {'日期': '05月', '本月': 740, '上月': 540, '去年同期': 500},
          {'日期': '06月', '本月': 900, '上月': 800, '去年同期': 780},
          {'日期': '07月', '本月': 490, '上月': 360, '去年同期': 300}
        ]
      },
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
