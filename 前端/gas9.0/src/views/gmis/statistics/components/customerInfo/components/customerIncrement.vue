<!-- 客户增量统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">客户增量统计</span>
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
          :colors="['#73A0FA','#74DEB3']"
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
  name: 'Increment',
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
      typeList: [],
      typeValue: '',
      chartData1: {
        columns: ['类型', '开户', '销户'],
        rows: [
          {'类型': '居民', '开户': 0, '销户': 0},
          {'类型': '低保', '开户': 0, '销户': 0},
          {'类型': '工业', '开户': 0, '销户': 0},
          {'类型': '公共福利', '开户': 0, '销户': 0},
          {'类型': '采暖', '开户': 0, '销户': 0}
        ]
      },
      chartData2: {
        columns: ['类型', '本月', '上月', '去年同期'],
        rows: [
          {'类型': '开户', '本月': 0, '上月': 0, '去年同期': 0},
          {'类型': '销户', '本月': 0, '上月': 0, '去年同期': 0}
        ]
      },

      // api 请求的数据
      apiData: null
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

      tjApi.SCustomerAdd(params).then(res => {
        const {isSuccess, data} = res.data

        if (isSuccess) {
          this.apiData = data

          //设置下拉类型
          this.typeList = data.typeList

          let rows1 = []

          // 设置数据1
          data.searchDate.openAccountSts.forEach((item, index) => {
            rows1.push(
              {
                '类型': item.typeName,
                '开户': item.amount,
                '销户': data.searchDate.closeAccountSts[index].amount
              },
            )
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
          '类型': '开户',
          '本月': this.total(this.typeValue, data.nowDate.openAccountSts),
          '上月': this.total(this.typeValue, data.lastMonthDate.openAccountSts),
          '去年同期': this.total(this.typeValue, data.lastYearDate.openAccountSts)
        },
        {
          '类型': '销户',
          '本月': this.total(this.typeValue, data.nowDate.closeAccountSts),
          '上月': this.total(this.typeValue, data.lastMonthDate.closeAccountSts),
          '去年同期': this.total(this.typeValue, data.lastYearDate.closeAccountSts)
        }
      ]
    },

    // 计算数据
    total(typeValue, dataArr) {
      let total = 0
      // 筛选
      if (typeValue) {
        dataArr.forEach((item, index) => {
          if (item.type === this.typeValue) {
            total = parseInt(item.amount)
          }
        })
        return total

      }
      // 未筛选
      else {
        dataArr.forEach((item, index) => {
          total += parseInt(item.amount)
        })
        return total
      }
    },

    // 选择
    selectHandle() {
      this.chartData2.rows = this.getChart2Data()
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
