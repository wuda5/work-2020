<!-- 发票金额统计-->
<template>
  <el-card shadow="never" class="counter">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">发票金额统计(合计票数 {{ totalMoney }} 元)</span>
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
        <chart-bar
          :legend-visible="true"
          :bar-width="30"
          width="90%"
          :chart-data="chartData1"
          class="myCharts"
          :colors="['#73A0FA', '#F55D8D', '#7585A2']"
        />
      </el-col>
      <el-col :span="12">
        <chart-bar
          :legend-visible="true"
          :bar-width="20"
          :chart-data="chartData2"
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
      totalMoney: 0,
      color1: ['#73A0FA', '#73DEB3', '#F6CF31'],
      chartData1: {
        columns: ['发票', '蓝票', '红票', '废票'],
        rows: [
          // { 发票: '普票', 蓝票: 800, 红票: 350, 废票: 100 },
          // { 发票: '专票', 蓝票: 730, 红票: 790, 废票: 80 },
          // { 发票: '电子票', 蓝票: 760, 红票: 490, 废票: 110 },
        ],
      },
      chartData2: {
        columns: ['发票', '本月', '上月', '去年同期'],
        rows: [
          // { 发票: '蓝票', 本月: 520, 上月: 470, 去年同期: 480 },
          // { 发票: '红票', 本月: 520, 上月: 320, 去年同期: 440 },
          // { 发票: '废票', 本月: 480, 上月: 300, 去年同期: 350 },
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

      tjApi.SinvoiceCount(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.apiData = data
          // 设置下拉类型
          this.typeList = data.typeList
          this.totalMoney = data.searchDate.totalMoney

          let rows1 = []
          let rows2 = []

          // 数据1
          for (let key in data.searchDate) {
            if (typeof data.searchDate[key] === 'object') {
              let itemList = data.searchDate[key]
              // { 发票: '普票', 蓝票: 800, 红票: 350, 废票: 100 },
              let itemObj = { 发票: itemList.ktName }
              itemList.kindList.forEach(item => {
                itemObj[item.ktName] = item.totalAmount
              })
              rows1.push(itemObj)
            }
          }
          this.chartData1.rows = rows1

          // 数据2
          this.chartData2.rows = this.getChart2Data()
        }
      })
    },

    // 图表2数据
    getChart2Data() {
      let data = this.apiData
      return [
        {
          发票: '红票',
          本月: this.total(this.typeValue, data.nowDate, 0, 'totalAmount'),
          上月: this.total(this.typeValue, data.lastMonthDate, 0, 'totalAmount'),
          去年同期: this.total(this.typeValue, data.lastYearDate, 0, 'totalAmount'),
        },
        {
          发票: '蓝票',
          本月: this.total(this.typeValue, data.nowDate, 1, 'totalAmount'),
          上月: this.total(this.typeValue, data.lastMonthDate, 1, 'totalAmount'),
          去年同期: this.total(this.typeValue, data.lastYearDate, 1, 'totalAmount'),
        },
        {
          发票: '废票',
          本月: this.total(this.typeValue, data.nowDate, 2, 'totalAmount'),
          上月: this.total(this.typeValue, data.lastMonthDate, 2, 'totalAmount'),
          去年同期: this.total(this.typeValue, data.lastYearDate, 2, 'totalAmount'),
        },
      ]
    },
    // '本月': this.total(this.typeValue, 'gasAmount', data.nowDate),

    // 计算数据
    total(typeValue, data, index, fileKey) {
      // index 更具数据返回定义 0 ：红票 1：蓝票 2：废票
      // key 需要统计的字段

      let total = 0
      // 筛选
      if (typeValue) {
        // 遍历改对象
        for (let key in data) {
          if (typeof data[key] === 'object' && data[key].kt === typeValue) {
            let kindList = data[key].kindList
            total = kindList[index][fileKey]
          }
        }
        return total
      }
      // 未筛选
      else {
        // 遍历改对象
        for (let key in data) {
          if (typeof data[key] === 'object') {
            let kindList = data[key].kindList
            total += parseFloat(kindList[index][fileKey])
          }
        }
        return total
      }
    },

    // 选择
    selectHandle() {
      let rows2 = this.getChart2Data()
      console.log(rows2)
      this.chartData2.rows = rows2
    },
  },
}
</script>
<style lang="scss" scoped>
</style>
