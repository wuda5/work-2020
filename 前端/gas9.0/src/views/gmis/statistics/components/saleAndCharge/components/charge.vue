<!-- 收费统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">收费统计</span>
        </div>
        <div slot="right">
          <el-button v-if="false" type="primary" plain>导出数据</el-button>
        </div>
      </search-box>
    </div>
    <el-row :gutter="15">
      <el-col :span="24">
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData1"
          class="myCharts"
          :bar-width="30"
          width="100%"
        />
      </el-col>
      <!-- <el-col :span="12">
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData2"
          :bar-width="20"
          class="myCharts"
          :colors="color1"
        /> 
      </el-col>-->
    </el-row>
  </el-card>
</template>
<script>
import ChartBar from '@/components/Charts/SimpleChartBox'
import tjApi from '@/api/statistics'

export default {
  name: 'Classify',
  components: {
    ChartBar,
  },
  props: {
    propsData: {
      type: Object,
      default: function () {
        return {
          orgId: '',
          timeRange: [],
        }
      },
    },
  },
  data() {
    return {
      typeValue: '',
      dateRange: '',
      typeList: [],
      // api 请求的数据
      apiData: null,
      color1: ['#73A0FA', '#73DEB3', '#F6CF31'],
      chartData1: {
        columns: ['收费类型', '金额'],
        rows: [
          // { 收费类型: '燃气收费', 金额: 930 },
          // { 收费类型: '商品收费', 金额: 600 },
          // { 收费类型: '预存', 金额: 520 },
          // { 收费类型: '预存抵扣', 金额: 80 },
          // { 收费类型: '减免', 金额: 70 },
          // { 收费类型: '抄表欠费', 金额: 120 },
          // { 收费类型: '退费', 金额: 280 },
        ],
      },
      /* chartData2: {
        columns: ['收费类型', '本月', '上月', '去年同期'],
        rows: [
          { 收费类型: '燃气收费', 本月: 240, 上月: 245, 去年同期: 230 },
          { 收费类型: '商品收费', 本月: 270, 上月: 250, 去年同期: 240 },
          { 收费类型: '预存', 本月: 620, 上月: 480, 去年同期: 420 },
          { 收费类型: '预存抵扣', 本月: 700, 上月: 530, 去年同期: 500 },
          { 收费类型: '减免', 本月: 740, 上月: 540, 去年同期: 500 },
          { 收费类型: '抄表欠费', 本月: 900, 上月: 800, 去年同期: 780 },
          { 收费类型: '退费', 本月: 490, 上月: 360, 去年同期: 300 },
        ],
      }, */
    }
  },
  watch: {
    propsData() {
      // this.getData()
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

      tjApi.Scharge(params).then(res => {
        const { isSuccess, data } = res.data

        if (isSuccess) {
          this.apiData = data
          // 设置下拉类型
          this.typeList = data.typeList

          let rows1 = []
          let rows2 = []

          data.searchDate.forEach((item, index) => {
            rows1.push({
              收费类型: item.typeName,
              金额: item.amount,
            })
          })
          this.chartData1.rows = rows1
          // this.chartData2.rows = rows2
        }
      })
    },
  },
}
</script>
<style lang="scss" scoped>
</style>
