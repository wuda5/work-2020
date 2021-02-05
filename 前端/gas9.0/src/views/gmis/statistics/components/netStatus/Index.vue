<!--网表状态看板 -->
<template>
  <div class="tabBox">
    <!-- search -->
    <search-box>
      <div slot="right">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
        <el-button type="primary" plain>确认</el-button>
      </div>
    </search-box>

    <!-- 燃气表 -->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <el-col :span="12">
          <span class="card-title">燃气表</span>
          <line-chart
            :legend-visible="true"
            :chart-data="chartData1"
            :tab-id="tabId"
            class="myCharts"
            width="800px"
            :colors="colors"
          />
        </el-col>
        <el-col :span="12">
          <div align="right">
            <el-button type="primary" plain>导出数据</el-button>
          </div>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData2"
            :bar-width="20"
            class="myCharts"
            width="800px"
            :tab-id="tabId"
            :colors="colors1"
          />
        </el-col>
      </el-row>
    </el-card>

    <!-- 流量计 -->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <el-col :span="12">
          <span class="card-title"></span>
          <line-chart
            :legend-visible="true"
            :chart-data="chartData1"
            class="myCharts"
            width="800px"
            :tab-id="tabId"
            :colors="colors"
          />
        </el-col>
        <el-col :span="12">
          <div align="right">
            <el-button type="primary" plain>导出数据</el-button>
          </div>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData2"
            :bar-width="20"
            class="myCharts"
            :tab-id="tabId"
            width="800px"
            :colors="colors1"
          />
        </el-col>
      </el-row>
    </el-card>

    <!-- 节点 -->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <el-col :span="12">
          <span class="card-title"></span>
          <line-chart
            :legend-visible="true"
            :chart-data="chartData1"
            class="myCharts"
            width="800px"
            :tab-id="tabId"
            :colors="colors"
          />
        </el-col>
        <el-col :span="12">
          <div align="right">
            <el-button type="primary" plain>导出数据</el-button>
          </div>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData2"
            :bar-width="20"
            :tab-id="tabId"
            width="800px"
            class="myCharts"
            :colors="colors1"
          />
        </el-col>
      </el-row>
    </el-card>

    <!-- 厂家分析 -->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <el-col :span="12">
          <span class="card-title">厂家分析</span>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData3"
            class="myCharts"
            :tab-id="tabId"
            width="800px"
            :colors="['#73A0FA','#73DEB3','#F55D8D','#F7C739']"
          />
        </el-col>
        <el-col :span="12">
          <div align="right">
            <el-button type="primary" plain>导出数据</el-button>
          </div>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData2"
            :bar-width="20"
            width="800px"
            :tab-id="tabId"
            class="myCharts"
            :colors="colors1"
          />
        </el-col>
      </el-row>
    </el-card>

    <!-- 异常 -->
    <el-card shadow="never" class="counter">
      <el-row :gutter="15">
        <el-col :span="12">
          <span class="card-title">异常</span>
          <line-chart
            :legend-visible="true"
            :chart-data="chartData4"
            class="myCharts"
            width="800px"
            :tab-id="tabId"
            :colors="['#5FD9A9','#F3477D','#F6BF1D']"
          />
        </el-col>
        <el-col :span="12">
          <div align="right">
            <el-button type="primary" plain>导出数据</el-button>
          </div>
          <chart-bar
            :legend-visible="true"
            :chart-data="chartData5"
            :bar-width="20"
            width="800px"
            :tab-id="tabId"
            class="myCharts"
            :colors="colors1"
          />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>
<script>
import LineChart from '@/components/Charts/SimpleLineChart'
import ChartBar from '@/components/Charts/SimpleChartBox'
import {run} from 'runjs'

export default {
  components: {
    LineChart,
    ChartBar
  },
  props: {
    tabId: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {
      dateRange: '',
      chartData1: {}, // 燃气表折线图数据
      chartData2: {}, // 燃气表柱状图数据
      chartData3: {}, // 厂家分析第一个柱状图数据
      chartData4: {}, // 异常折线图数据
      chartData5: {}, // 异常柱状图数据
      colors: ['#7FA7F7', '#5FD9A9', '#F3477D', '#F6BF1D'],
      colors1: ['#73A0FA', '#73DEB3', '#F6CF31'],

    }
  },
  created() {
    this.chartData1 = (function () {
      return {
        columns: ['日期', '正常', '掉线', '告警', '故障'],
        rows: [
          {'日期': '1', '正常': 670, '掉线': 50, '告警': 0, '故障': 150},
          {'日期': '2', '正常': 750, '掉线': 80, '告警': 60, '故障': 200},
          {'日期': '3', '正常': 660, '掉线': 30, '告警': 150, '故障': 80},
          {'日期': '4', '正常': 630, '掉线': 100, '告警': 120, '故障': 60},
          {'日期': '5', '正常': 615, '掉线': 150, '告警': 180, '故障': 0},
          {'日期': '6', '正常': 645, '掉线': 130, '告警': 250, '故障': 90},
          {'日期': '7', '正常': 860, '掉线': 180, '告警': 190, '故障': 110},
          {'日期': '8', '正常': 755, '掉线': 120, '告警': 270, '故障': 90},
          {'日期': '9', '正常': 930, '掉线': 200, '告警': 175, '故障': 30}
        ]
      }
    })()
    this.chartData2 = (function () {
      return {
        columns: ['状态', '本月', '上月', '去年同期'],
        rows: [
          {'状态': '正常', '本月': 520, '上月': 650, '去年同期': 480},
          {'状态': '掉线', '本月': 520, '上月': 720, '去年同期': 450},
          {'状态': '告警', '本月': 650, '上月': 400, '去年同期': 420},
          {'状态': '故障', '本月': 700, '上月': 660, '去年同期': 480}
        ]
      }
    })()
    this.chartData3 = (function () {
      return {
        columns: ['厂家', '正常', '掉线', '告警', '故障'],
        rows: [
          {'厂家': '金卡', '正常': 760, '掉线': 10, '告警': 100, '故障': 160},
          {'厂家': '秦川', '正常': 800, '掉线': 80, '告警': 90, '故障': 240},
          {'厂家': '先锋', '正常': 600, '掉线': 50, '告警': 70, '故障': 50},
          {'厂家': '德星', '正常': 920, '掉线': 40, '告警': 90, '故障': 20},
          {'厂家': '航天', '正常': 800, '掉线': 150, '告警': 110, '故障': 60}
        ]
      }
    })()
    this.chartData4 = (function () {
      return {
        columns: ['日期', '掉线', '告警', '故障'],
        rows: [
          {'日期': '1', '掉线': 50, '告警': 0, '故障': 150},
          {'日期': '2', '掉线': 80, '告警': 60, '故障': 200},
          {'日期': '3', '掉线': 30, '告警': 150, '故障': 80},
          {'日期': '4', '掉线': 100, '告警': 120, '故障': 60},
          {'日期': '5', '掉线': 150, '告警': 180, '故障': 0},
          {'日期': '6', '掉线': 130, '告警': 250, '故障': 90},
          {'日期': '7', '掉线': 180, '告警': 190, '故障': 110}
        ]
      }
    })()
    this.chartData5 = (function () {
      return {
        columns: ['状态', '本月', '上月', '去年同期'],
        rows: [
          {'状态': '掉线', '本月': 520, '上月': 720, '去年同期': 450},
          {'状态': '告警', '本月': 650, '上月': 400, '去年同期': 420},
          {'状态': '故障', '本月': 700, '上月': 660, '去年同期': 480}
        ]
      }
    })()
    // console.log(this.tabId);
  }
}
</script>>
<style lang="scss" scoped>
.spanBox {
  font-size: 14px;
  color: #A0A0A0;
}

.el-input {
  width: 120px;
}

.el-input--suffix .el-input__inner {
  padding-right: 0;
}

.counter {
  margin-top: 15px;
}

.queryList {
  display: flex;
  justify-content: space-around;
  align-items: center;
}
</style>
