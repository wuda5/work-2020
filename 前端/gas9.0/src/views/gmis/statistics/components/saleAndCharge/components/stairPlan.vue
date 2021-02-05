<!-- 阶梯方案统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">阶梯方案统计</span>
        </div>
        <div slot="right">
          <el-select v-model="typeValue" clearable placeholder="请选择" @change="selectHandle">
            <el-option
              v-for="item in typeList"
              :key="item.typeId"
              :label="item.typeName"
              :value="item.typeId"
            >
            </el-option>
          </el-select>
          <el-button v-if="false" type="primary" plain>导出数据</el-button>
        </div>
      </search-box>
    </div>

    <el-row :gutter="15">
      <el-col :span="12">
          <!-- :title="'气量总计23811方 金额总计3555元'" -->
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData1"
          class="myCharts"
          :bar-width="30"
          width="90%"
          :colors="['#73A0FA', '#F6CF31']"
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
import tjApi from '@/api/statistics'

export default {
  name: 'stairPlan',
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
        columns: ['类型', '气量', '金额'],
        rows: [
          // { 类型: '方案1', 气量: 280, 金额: 780 },
          // { 类型: '方案2', 气量: 250, 金额: 691 },
          // { 类型: '方案5', 气量: 530, 金额: 800 },
          // { 类型: '方案4', 气量: 260, 金额: 760 },
          // { 类型: '方案6', 气量: 255, 金额: 780 },
        ],
      },
      chartData2: {
        columns: ['参数', '本月', '上月', '去年同期'],
        rows: [
          // { 参数: '气量', 本月: 520, 上月: 670, 去年同期: 480 },
          // { 参数: '金额', 本月: 850, 上月: 790, 去年同期: 660 },
        ],
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

      tjApi.StairPlan(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.apiData = data
          //设置下拉类型
          this.typeList = data.typeList

          let rows1 = []
          let rows2 = []

          // 数据1
          data.searchDate.forEach((item, index) => {
            rows1.push({ 类型: item.gasTypeName, 气量: item.gasAmount, 金额: item.gasMoney })
          })
          this.chartData1.rows = rows1

          // 设置数据2
          this.chartData2.rows = this.getChart2Data()
        }
      })
    },

    // 图表2数据
    getChart2Data() {
      let data = this.apiData
      return [
        {
          参数: '气量',
          本月: this.total(this.typeValue, 'gasAmount', data.nowDate),
          上月: this.total(this.typeValue, 'gasAmount', data.lastMonthDate),
          去年同期: this.total(this.typeValue, 'gasAmount', data.lastYearDate),
        },
        {
          参数: '金额',
          本月: this.total(this.typeValue, 'gasMoney', data.nowDate),
          上月: this.total(this.typeValue, 'gasMoney', data.lastMonthDate),
          去年同期: this.total(this.typeValue, 'gasMoney', data.lastYearDate),
        },
      ]
    },

    // 计算数据
    total(typeValue, key, dataArr) {
      let total = 0
      // 筛选
      if (typeValue) {
        dataArr.forEach((item, index) => {
          if (item.gasLadderId === this.typeValue) {
            total = parseInt(item[key])
          }
        })
        return total
      }
      // 未筛选
      else {
        dataArr.forEach((item, index) => {
          total += parseInt(item[key])
        })
        return total
      }
    },

    // 选择
    selectHandle() {
      this.chartData2.rows = this.getChart2Data()
    },
  },
}
</script>
<style lang="scss" scoped>
</style>
