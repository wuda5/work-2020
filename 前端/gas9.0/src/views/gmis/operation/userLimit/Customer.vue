<template>
  <div class=" customer-page">
    <div class="customer-table-box">
      <customer-table key="limitCustomerTable" :buy-gas-limit-data="buyGasLimitData" :is-limit="true"></customer-table>
    </div>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import CustomerTable from './components/CustomerTable'

export default {
  name: 'Customer',
  components: {
    CustomerTable
  },
  filters: {},
  mixins: [commonMixin],
  props: {
    // 限购配置信息
    buyGasLimitData: {
      type: [Object],
      required: false,
      default: () => ({})
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
  destroyed() {

  },
  methods: {
    async initData() {
    }
  }
}
</script>

<style scoped lang="scss">

</style>
