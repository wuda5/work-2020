<!-- 支付方式统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">支付方式统计</span>
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
          :chart-data="chartData1"
          class="myCharts"
          :bar-width="30"
          width="90%"
          :colors="['#73A0FA', '#74DEB3']"
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
  name: 'paymentType',
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
        columns: ['类型', '收费', '退费'],
        rows: [
          /* {'类型': '支付宝', '收费': 800, '退费': 40},
          {'类型': '微信', '收费': 690, '退费': 80},
          {'类型': '银行卡', '收费': 760, '退费': 50},
          {'类型': '现金', '收费': 240, '退费': 60},
          {'类型': '其他', '收费': 485, '退费': 60} */
        ],
      },
      chartData2: {
        columns: ['参数', '本月', '上月', '去年同期'],
        rows: [
          { 参数: '收费', 本月: 520, 上月: 670, 去年同期: 480 },
          { 参数: '退费', 本月: 850, 上月: 790, 去年同期: 660 },
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

      tjApi.SpaymentType(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.apiData = data
          // 设置下拉类型
          this.typeList = data.typeList

          let rows1 = []
          let rows2 = []

          // 数据1
          data.searchDate.forEach((item, index) => {
            rows1.push({
              类型: item.chargeMethodName,
              收费: item.chargeFee,
              退费: item.refundFee,
            })
          })
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
          参数: '收费',
          本月: this.total(this.typeValue, data.nowDate, 'chargeFee'),
          上月: this.total(this.typeValue, data.lastMonthDate, 'chargeFee'),
          去年同期: this.total(this.typeValue, data.lastYearDate, 'chargeFee'),
        },
        {
          参数: '退费',
          本月: this.total(this.typeValue, data.nowDate, 'refundFee'),
          上月: this.total(this.typeValue, data.lastMonthDate, 'refundFee'),
          去年同期: this.total(this.typeValue, data.lastYearDate, 'refundFee'),
        },
      ]
    },

    // 计算数据
    total(typeValue, dataArr,key) {
      let total = 0
      // 筛选
      if (typeValue) {
        dataArr.forEach((item, index) => {
          if (item.chargeMethodCode === this.typeValue) {
            total = parseFloat(item[key])
          }
        })
        return total
      }
      // 未筛选
      else {
        // 遍历改对象
        dataArr.forEach(item => {
          total += parseFloat(item[key])
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
