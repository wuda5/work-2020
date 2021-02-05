<!-- 售气收费看板-->
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
          value-format="yyyy-MM-dd"
        />
        <el-button type="primary" plain @click="sureTime">确认</el-button>
      </div>
    </search-box>

    <!-- 用气类型统计 -->
    <use-gas :props-data="propsData" />

    <!-- 输气统计 -->
    <gas-transmission v-if="false" />

    <!-- 阶梯方案统计 -->
    <stair-plan :props-data="propsData" />

    <!-- 用气阶梯统计 -->
    <stair-use-gas v-if="false" />

    <!-- 收费统计 -->
    <charge :props-data="propsData" />

    <!-- 支付方式统计 -->
    <payment-type :props-data="propsData" />

    <!-- 发票张数统计 -->
    <invoice-count :props-data="propsData" />

    <!-- 发票金额统计 -->
    <invoice-money :props-data="propsData" />

    <!-- 表端余额统计 -->
    <meter-balance v-if="false" />
  </div>
</template>
<script>
import useGas from './components/useGas.vue' // 用气类型统计
import gasTransmission from './components/gasTransmission.vue' // 输气统计
import stairPlan from './components/stairPlan.vue' // 阶梯方案统计
import stairUseGas from './components/stairUseGas' // 用气阶梯统计
import charge from './components/charge' // 收费统计
import paymentType from './components/paymentType' // 支付方式统计
import invoiceCount from './components/invoiceCount' // 发票张数统计
import invoiceMoney from './components/invoiceMoney' // 发票金额统计
import meterBalance from './components/meterBalance' // 表端余额统计

export default {
  name: 'kb2',
  components: {
    useGas,
    gasTransmission,
    stairPlan,
    stairUseGas,
    charge,
    paymentType,
    invoiceCount,
    invoiceMoney,
    meterBalance,
  },
  props: {},
  data() {
    return {
      dateRange: [],
      timeRange: [],
    }
  },
  computed: {
    propsData() {
      return {
        orgId: this.$store.state.statistics.org,
        timeRange: this.timeRange,
      }
    },
  },

  methods: {
    // 点击确认时才请求数据
    sureTime() {
      this.timeRange = this.dateRange
    },
  },
}
</script>
<style lang="scss" scoped>
  .el-card {
    margin-top: 15px;
  }
</style>
