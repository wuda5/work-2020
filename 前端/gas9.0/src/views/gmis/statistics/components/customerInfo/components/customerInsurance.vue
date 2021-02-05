<!-- 保险购买分类统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">保险购买分类统计</span>
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
  name: 'Insurance',
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
        columns: ['类型', '数据'],
        rows: [
          {'类型': '新增', '数据': 0},
          {'类型': '续保', '数据': 0},
          {'类型': '未购买', '数据': 0}
        ]
      },
      chartData2: {
        columns: ['类型', '本月', '上月', '去年同期'],
        rows: [
          {'类型': '新增', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '续保', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '未购买', '本月': 0, '上月': 0, '去年同期': 0}
        ]
      },
    }
  },
  watch: {
    propsData() {
      this.getData()
    },
  },
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

      tjApi.SInsureType(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {

          let rows1 = [
            {'类型': '新增', '数据': data.searchDate.newBuy},
            {'类型': '续保', '数据': data.searchDate.reBuy},
            {'类型': '未购买', '数据': data.searchDate.noBuy}
          ]

          let rows2 = [
            {'类型': '新增', '本月': data.nowDate.newBuy, '上月': data.lastMonthDate.newBuy, '去年同期': data.lastYearDate.newBuy},
            {'类型': '续保', '本月': data.nowDate.reBuy, '上月': data.lastMonthDate.reBuy, '去年同期': data.lastYearDate.reBuy},
            {'类型': '未购买', '本月': data.nowDate.noBuy, '上月': data.lastMonthDate.noBuy, '去年同期': data.lastYearDate.noBuy}
          ]
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
