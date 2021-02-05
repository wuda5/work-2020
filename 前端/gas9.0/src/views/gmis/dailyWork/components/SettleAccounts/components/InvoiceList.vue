<!-- 开票记录列表 -->
<template>
  <div class="InvoiceList-container">
    <!-- 列表区域 -->
    <el-table
      ref="invoiceListRef"
      v-loading="loading"
      :data="data"
      tooltip-effect="dark"
      style="width: 100%"
      :border="true"
      :highlight-current-row="false"
    >
      <el-table-column fixed prop="invoiceNumber" label="发票编号" width="100" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.invoiceNumber | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="billingDate" label="开票时间" width="150" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.billingDate | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="invoiceType" label="发票类型" width="80">
        <span slot-scope="{row}">
          {{ invoiceTypeMap[row.invoiceType] || emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="invoiceKind" label="发票种类" width="100">
        <span slot-scope="{row}">
          {{ row.invoiceKind | invoiceKind }}
        </span>
      </el-table-column>
      <el-table-column prop="invoiceStatus" label="发票状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.invoiceStatus | invoiceStatusClass">{{ row.invoiceStatus | invoiceStatus }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="totalAmount" label="发票金额" width="150">
        <span slot-scope="{row}">
          {{ row.totalAmount | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerName" label="发票抬头" min-width="200" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerTinNo" label="纳税人识别号" width="140" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerTinNo | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerAddress" label="购买人地址" min-width="200" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerAddress | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerPhone" label="购买人电话" min-width="200" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerPhone | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerBankName" label="开户行名称" width="140" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerBankName | emptyStr }}
        </span>
      </el-table-column>
      <el-table-column prop="buyerBankAccount" label="开户行账号" width="140" show-overflow-tooltip>
        <span slot-scope="{row}">
          {{ row.buyerBankAccount | emptyStr }}
        </span>
      </el-table-column>
    </el-table>
    <!-- 分页插槽 -->
    <slot name="pagination"></slot>
  </div>
</template>

<script>
import { invoiceKindMap, allInvoiceStatusMap, invoiceStatusClassMap } from '@/enums/business'
import { dictionaryCodeMap } from '@/enums/dictionary'
const emptyStr = '--'

export default {
  name: 'InvoiceList',
  components: {

  },
  filters: {
    // 发票种类格式化
    invoiceKind(value) {
      return invoiceKindMap[+value] || emptyStr
    },
    // 开票状态
    invoiceStatus(value) {
      return allInvoiceStatusMap[value] || emptyStr
    },
    // 开票状态
    invoiceStatusClass(value) {
      return invoiceStatusClassMap[value]
    },
    // 发票类型
    filterType(val) {
      switch(val) {
        case '007':
          return '普票';
        case '004':
          return '专票';
        case '026':
          return '电票'
        case '000':
          return '票据'
        default:
          return val
      }
    },
    filterStatusType(val) {
      switch(val) {
        case '0':
          return 'warning'
        case '1':
          return 'success'
        case '2':
          return 'danger'
        default:
          return 'info'
      }
    },
    filterStatus(val) {
      switch(val) {
        case '0':
          return '未开票'
        case '1':
          return '已开票'
        case '2':
          return '作废'
        default:
          return val
      }
    }
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
    // 进气方向map
    invoiceTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.INVOICE_TYPE)
    },
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
