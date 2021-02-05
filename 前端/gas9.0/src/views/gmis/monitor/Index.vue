<!--
 * @Descripttion:
 * @Author: lingw
 * @Date: 2020-10-16 10:18:02
 * @LastEditors: lingw
 * @LastEditTime: 2021-01-27 09:53:35
-->
<template>
  <div class="monitor-container">
    <head-alarm class="monitor-head" :title="activeTitle" :sections="sections" />
    <draggable :x="12" :y="0" :z="variableIndex.areas" :parent="true" :resizable="false" @mousedown.native="currentFirst('areas')">
      <areas :meter-info="meterInfo" @tab-click="handleClick" @search="handleSearch" @meterPagination="getMeterList" @nodePagination="getNodeList" />
    </draggable>
    <draggable :x="468" :y="locationTop" :z="variableIndex.meter" :parent="true" :resizable="false" @mousedown.native="currentFirst('meter')">
      <!-- 单表 -->
      <CardInfo v-if="activeName ==='meter'" :card-info="singleMeter" />
      <!-- 节点输送范围 -->
      <CardInfo v-else :card-info="nodeDeliver" />
    </draggable>
    <!-- 安检统计 -->
    <draggable :x="680" :y="locationTop" :z="variableIndex.security" :parent="true" :resizable="false" @mousedown.native="currentFirst('security')">
      <CardInfo :card-info="security" />
    </draggable>
    <!-- 输差统计 -->
    <draggable :x="892" :y="locationTop" :z="variableIndex.transError" :parent="true" :resizable="false" @mousedown.native="currentFirst('transError')">
      <CardInfo :card-info="transError" />
    </draggable>
    <!-- 异常统计 -->
    <draggable :x="locationLeft" :y="0" :z="variableIndex.except" :parent="true" :resizable="false" @mousedown.native="currentFirst('except')">
      <chart-bar class="monitor-chart-except" title="异常统计" :total-amount="exceptSummary.total" :unit="exceptSummary.unit" :chart-data="exceptSummary.chart" :colors="exceptSummary.colors" />
    </draggable>
    <!-- 抄表统计 -->
    <draggable :x="locationLeft" :y="280" :z="variableIndex.copy" :parent="true" :resizable="false" @mousedown.native="currentFirst('copy')">
      <chart-bar v-if="activeName==='meter'" class="monitor-chart-copy" title="抄表统计" :total-amount="copy.total" :unit="copy.unit" :chart-data="copy.chart" :settings="copySettings" right-header="总数： 7777" />
    </draggable>
    <!-- 指令信息 -->
    <draggable :x="locationLeft" :y="552" :z="variableIndex.order" :parent="true" :resizable="false" @mousedown.native="currentFirst('order')">
      <chart-bar class="monitor-chart-order" title="指令信息" :total-amount="order.total" :unit="order.unit" :chart-data="order.chart" :colors="order.colors" />
    </draggable>
    <!-- 地图组件 -->
    <baidu-map ref="map" />
  </div>
</template>

<script>
import Areas from './components/Area'
import HeadAlarm from './components/HeadAlarm'
import CardInfo from './components/CardInfo'
import BaiduMap from '@/components/CustomMap/Map'
import ChartBar from '@/components/Charts/ChartBar' // 图表
import Draggable from '@/components/Common/Draggable'

export default {
  name: 'Monitor',
  components: {
    Areas,
    BaiduMap,
    HeadAlarm,
    CardInfo,
    ChartBar,
    Draggable
  },
  data () {
    this.copySettings = {
      showLine: ['抄表率'],
      axisSite: { right: ['抄表率'] },
      yAxisType: ['normal', 'percent'],
      yAxisName: ['', '比率']
    }
    return {
      meterInfo: {
        meterNo: 9527,
        meterType: '1',
        meterCompany: 1,
        alarm: 1,
        lineStatus: 1,
        lastDate: '2020-05-10'
      },
      singleMeter: {
        title: '单表',
        subTitleOne: '客户名称',
        subTitleTwo: '最新用气量',
        itemOne: '李晓曦',
        itemTwo: '45,444m³'
      },
      nodeDeliver: {
        title: '节点输送范围',
        subTitleOne: '客户数',
        subTitleTwo: '最新用气量',
        itemOne: 2000,
        itemTwo: '45,444m³'
      },
      security: {
        title: '安检统计',
        subTitleOne: '待安检',
        subTitleTwo: '异常',
        itemOne: 20,
        itemTwo: 2
      },
      transError: {
        title: '输差统计',
        subTitleOne: '节点气量',
        subTitleTwo: '抄表气量',
        itemOne: 20,
        itemTwo: 2
      },
      exceptSummary: {
        chart: {
          columns: ['分类', '异常', '掉线'],
          rows: [
            { '分类': '流量计', '异常': 5000, '掉线': 2000 },
            { '分类': '表具', '异常': 1393, '掉线': 2000 },
            { '分类': '节点', '异常': 1093, '掉线': 2000 }
          ],
        },
        total: 23154,
        unit: '件',
        colors: ['#F6C70E', '#F35385']
      },
      copy: {
        chart: {
          columns: ['分类', '已抄', '待抄', '抄表率'],
          rows: [
            { '分类': '流量计', '已抄': 3000, '待抄': 2000, '抄表率': 0.6 },
            { '分类': '表具', '已抄': 1393, '待抄': 3607, '抄表率': 0.278 },
            { '分类': '节点', '已抄': 1093, '待抄': 4907, '抄表率': 0.218 }
          ],
        },
        unit: '件',
        total: 23154
      },
      order: {
        chart: {
          columns: ['分类', '待执行', '执行失败'],
          rows: [
            { '分类': '流量计', '待执行': 5000, '执行失败': 2000 },
            { '分类': '表具', '待执行': 1393, '执行失败': 2000 },
            { '分类': '节点', '待执行': 1093, '执行失败': 2000 }
          ],
        },
        total: 23154,
        unit: '件',
        colors: ['#5370E8', '#F5CE30']
      },
      // 表具 or 节点
      activeName: 'meter',
      sections: [
        {
          type: 'emergency',
          name: '紧急告警'
        },
        {
          type: 'alarm',
          name: '告警'
        },
        {
          type: 'normal',
          name: '正常'
        }
      ],
      // 各可拖拽区块的 z-index
      variableIndex: {
        areas: 99, // 区域
        meter: 99, // 单表、节点输送范围
        security: 99, // 安检统计
        transError: 99, // 输差统计
        except: 99, // 异常统计
        order: 99, // 指令信息
        copy: 99 // 抄表统计
      }
    }
  },
  computed: {
    activeTitle() {
      return this.activeName === 'meter' ? '表具' : '节点'
    },
    locationTop() {
      return document.body.clientHeight - 80 - 133 - 12
    },
    locationLeft() {
      const width = document.body.clientWidth
      return width > 1330 ? width - 210 - 380 : 1230
    }
  },
  created() {
    this.getLatestData()
  },
  methods: {
    // tab 切换
    handleClick(val) {
      this.activeName = val
      this.getLatestData()
    },
    // 可拖动模块选中
    currentFirst(val) {
      for (const o in this.variableIndex) {
        this.variableIndex[o] = 99
      }
      this.variableIndex[val] = 100
    },
    // 设置 点击设置Maker
    handleSet() {
      const payload = {
        lng: 104.07,
        lat: 30.67
      }
      this.$refs.map.setMarker(payload)
    },
    // 刷新数据
    getLatestData() {
      if (this.activeName === 'meter') {
        this.getMeterList()
      } else {
        this.getNodeList()
      }
    },
    // 搜索 - 触发数据请求
    handleSearch() {
      this.getLatestData()
    },
    // 区域 - 获取表具 list
    async getMeterList({ current = 1, size = 10 } = {}) {
      const payload = {
        current,
        size
      }
    },
    // 区域 - 获取节点 list
    async getNodeList({ current = 1, size = 10 } = {}) {
      const payload = {
        current,
        size
      }
    }
  }
}
</script>

<style lang='scss' scoped>
  .monitor-container {
    width: 100%;
    position: relative;
    .monitor-head {
      position: absolute;
      z-index: 99;
      background: #fff;
      left: 50%;
      top: 18px;
      transform: translateX(-50%);
    }
    .monitor-chart-except, .monitor-chart-copy, .monitor-chart-order {
      min-width: 360px;
      height: 260px;
      box-shadow: 1px 1px 5px 2px #C0C4CC;
    }
  }
</style>
