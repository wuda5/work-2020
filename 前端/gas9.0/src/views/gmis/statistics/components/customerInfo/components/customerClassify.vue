<!-- 客户分类统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">客户分类统计</span>
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
          :bar-width="30"
          width="90%"
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
      dateRange: '',
      color1: ['#73A0FA', '#73DEB3', '#F6CF31'],
      chartData1: {
        columns: ['分类', '数据'],
        rows: [
          {'分类': '居民', '数据': 0},
          {'分类': '低保', '数据': 0},
          {'分类': '工业', '数据': 0},
          {'分类': '公共福利', '数据': 0},
          {'分类': '采暖', '数据': 0}
        ]
      },
      chartData2: {
        columns: ['类型', '本月', '上月', '去年同期'],
        rows: [
          {'类型': '居民', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '低保', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '工业', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '公共福利', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '采暖', '本月': 0, '上月': 0, '去年同期': 0}
        ]
      },
    }
  }
  ,
  watch: {
    propsData() {
      this.getData()
    }
    ,
  }
  ,
  mounted() {
    this.getData()
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

          data.searchDate.forEach((item, index) => {
            rows1.push(
              {
                '分类': item.typeName,
                '数据': item.amount
              }
            )
          })

          data.nowDate.forEach((item, index) => {
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
    }

  }
}
</script>
<style lang="scss" scoped>
</style>
