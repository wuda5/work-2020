<!-- 业绩看板 -->
<template>
  <div>
    <!-- 售气数据 -->
    <block-gas :props-data="propsData" />

    <!-- 财务数据 -->
    <block-finance :props-data="propsData" />

    <!-- 业务保障数据 -->
    <block-business v-if="false" />

    <!-- 柜台人员统计 -->
    <table-counter-staff :props-data="propsData" />

    <!-- 抄表人员统计 -->
    <table-read-meter :props-data="propsData" />

    <!-- 报装工单数统计 -->
    <table-work-order v-if="false" />

    <!--  安检工单数统计 -->
    <table-safe-check v-if="false" />

    <!-- 燃具销售人员 -->
    <table-sale-count v-if="false" />
  </div>
</template>

<script>
import blockGas from './components/blockGas.vue' // 用气量
import blockFinance from './components/blockFinance.vue' // 财务数据
import blockBusiness from './components/blockBusiness.vue' // 业务保障数据

import tableCounterStaff from './components/tableCounterStaff.vue' // 柜台人员统计
import tableReadMeter from './components/tableReadMeter.vue' // 抄表人员统计
import tableWorkOrder from './components/tableWorkOrder.vue' // 报装工单数统计
import tableSafeCheck from './components/tableSafeCheck.vue' // 安检工单数统计
import tableSaleCount from './components/tableSaleCount.vue' // 燃具销售人员

import commonMixin from '@/mixins/common'
import ExportData from '../exportData' //导出数据

export default {
  name: 'Result',
  components: {
    blockGas,
    blockFinance,
    blockBusiness,
    tableCounterStaff,
    tableReadMeter,
    tableWorkOrder,
    tableSafeCheck,
    tableSaleCount,
  },
  mixins: [commonMixin],
  computed: {
    propsData() {
      return {
        orgId: this.$store.state.statistics.org,
      }
    },
  },
  watch: {},
  created() {},
  mounted() {},
  destroyed() {},
  methods: {
    exportData(title) {
      this.exportTitle = `${title}数据导出`
      this.showExportData = true
    },
  },
}
</script>

<style scoped lang="scss">
  .tabBox {
    margin-top: 10px;
    margin-bottom: 40px;
  }
</style>
