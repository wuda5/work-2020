<!-- 缴费记录列表 -->
<template>
  <div class="ChargeList-container">
    <!-- 列表区域 -->
    <el-table
      ref="chargeListRef"
      v-loading="loading"
      :data="data"
      tooltip-effect="dark"
      style="width: 100%"
      :border="true"
      :highlight-current-row="false"
    >
      <el-table-column prop="chargeNo" label="订单号" show-overflow-tooltip />
      <!-- <el-table-column prop="customerChargeNo" label="缴费编号" min-width="150" show-overflow-tooltip /> -->
      <el-table-column prop="createTime" label="收费时间" width="140" show-overflow-tooltip />
      <el-table-column prop="chargeMethodName" label="收费方式" width="80" show-overflow-tooltip />
      <el-table-column prop="receivableMoney" label="合计金额" />
      <el-table-column prop="reductionMoney" label="优惠金额" min-width="100" />
      <el-table-column prop="rechargeGas" label="合计气量" />
      <!-- <el-table-column prop="customerCode" label="客户编号" min-width="200" show-overflow-tooltip /> -->
      <el-table-column prop="customerName" label="客户名称" width="100" show-overflow-tooltip />
      <el-table-column prop="chargeStatus" label="收费状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.chargeStatus | chargeStatusClass">{{ row.chargeStatus | chargeStatus }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="invoiceStatus" label="开票状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.invoiceStatus | invoiceStatusClass">{{ row.invoiceStatus | invoiceStatus }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="remark" label="备注" width="150" show-overflow-tooltip />
    </el-table>
    <!-- 分页插槽 -->
    <slot name="pagination"></slot>
  </div>
</template>

<script>
import { chargeStatusMap, chargeStatusClassMap, allInvoiceStatusMap, invoiceStatusClassMap } from '@/enums/business'

const emptyStr = '--'

export default {
  name: 'ChargeList',
  components: {

  },
  filters: {
    // 收费状态
    chargeStatus(value) {
      return chargeStatusMap[value] || emptyStr
    },
    // 收费状态class
    chargeStatusClass(value) {
      return chargeStatusClassMap[value]
    },
    // 开票状态
    invoiceStatus(value) {
      return allInvoiceStatusMap[value] || emptyStr
    },
    // 开票状态
    invoiceStatusClass(value) {
      return invoiceStatusClassMap[value]
    },
  },
  mixins: [],
  props: {
    //表格数据
    data: {
      type: Array,
      default: () => ([]),
    },
    // 数据加载状态
    loading: {
      type: Boolean,
      default: false
    },
  },
  data() {
    return {

    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  methods: {
    async initData() {

    },

    getData() {

    }
  }
}
</script>

<style scoped lang="scss">

</style>
