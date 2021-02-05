<!-- 限购统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">限购统计</span>
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
  name: 'Limit',
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
      color1: ['#73A0FA', '#73DEB3', '#F6CF31'],
      chartData1: {
        columns: ['限购类型', '数据'],
        rows: [
          {'限购类型': '黑名单', '数据': 0},
          {'限购类型': '安检量', '数据': 0}
        ]
      },
      chartData2: {
        columns: ['限购类型', '本月', '上月', '去年同期'],
        rows: [
          {'限购类型': '黑名单', '本月': 0, '上月': 0, '去年同期': 0},
          {'限购类型': '安检量', '本月': 0, '上月': 0, '去年同期': 0}
        ]
      }
    }
  },
  watch: {
    propsData() {
      this.getData()
    }
    ,
  }
  ,
  mounted() {
    this.getData()
  },

  methods: {
    getData() {
      let params = {
        orgId: this.propsData.orgId,
        startDay: this.propsData.timeRange[0] || '',
        endDay: this.propsData.timeRange[1] || '',
      }

      console.log(params)

      tjApi.SCustomerLimit(params).then(res => {
          const {isSuccess, data} = res.data
          if (isSuccess) {

            let rows1 = [
              {'限购类型': '黑名单', '数据': data.searchDate.blackNum},
              {'限购类型': '安检量', '数据': data.searchDate.securityCheckNum}
            ]

            let rows2 = [
              {
                '限购类型': '黑名单',
                '本月': data.nowDate.blackNum,
                '上月': data.lastMonthDate.blackNum,
                '去年同期': data.lastYearDate.blackNum
              },
              {
                '限购类型': '安检量',
                '本月': data.nowDate.securityCheckNum,
                '上月': data.lastMonthDate.securityCheckNum,
                '去年同期': data.lastYearDate.securityCheckNum
              }
            ]
            this.chartData1.rows = rows1
            this.chartData2.rows = rows2
          }
        }
      )
    }

  }
}
</script>
<style lang="scss" scoped>
</style>
