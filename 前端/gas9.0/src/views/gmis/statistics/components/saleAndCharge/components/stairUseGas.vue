<!-- 阶梯方案统计-->
<template>
  <el-card shadow="never">
    <div slot="header" class="clearfix">
      <search-box>
        <div slot="left">
          <span class="card-title">用气阶梯统计</span>
          <el-select v-model="typeValue" clearable placeholder="请选择" @change="selectHandle">
            <el-option
              v-for="item in this.dict.USER_TYPE"
              :key="item.id"
              :label="item.name"
              :value="item.code"
            >
            </el-option>
          </el-select>
        </div>
        <div slot="right">
          <el-select v-model="typeValue" clearable placeholder="请选择" @change="selectHandle">
            <el-option
              v-for="item in this.dict.USER_TYPE"
              :key="item.id"
              :label="item.name"
              :value="item.code"
            >
            </el-option>
          </el-select>
          <el-button type="primary" plain>导出数据</el-button>
        </div>
      </search-box>
    </div>

    <el-row :gutter="15">
      <el-col :span="12">
        <div>合计户数 454558户 合计气量 23811方  合计金额 3555451.110元</div>
        <chart-bar
          :legend-visible="true"
          :chart-data="chartData1"
          class="myCharts"
          width="90%"
          :colors="color1"
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
        columns: ['阶段', '户数', '用量', '金额'],
        rows: [
          {'阶段': '1阶', '户数': 1393, '用量': 1093, '金额': 3230},
          {'阶段': '2阶', '户数': 3530, '用量': 3230, '金额': 4293},
          {'阶段': '3阶', '户数': 2923, '用量': 2623, '金额': 1423},
          {'阶段': '4阶', '户数': 1723, '用量': 1423, '金额': 1093},
          {'阶段': '5阶', '户数': 3792, '用量': 3492, '金额': 3492},
          {'阶段': '6阶', '户数': 4593, '用量': 4293, '金额': 2623}
        ]
      },
      chartData2: {
        columns: ['参数', '本月', '上月', '去年同期'],
        rows: [
          {'参数': '户数', '本月': 520, '上月': 670, '去年同期': 480},
          {'参数': '用量', '本月': 850, '上月': 790, '去年同期': 660},
          {'参数': '金额', '本月': 850, '上月': 790, '去年同期': 660}
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
