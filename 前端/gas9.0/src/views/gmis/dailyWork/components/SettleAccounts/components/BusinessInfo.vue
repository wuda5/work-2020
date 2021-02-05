<!-- 扎帐信息 -->
<template>
  <div v-loading="loading" class="BusinessInfo-container">
    <el-form label-position="top" class="jh-text">
      <el-form-item label="合计金额">
        <p>{{ data.totalAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="现金">
        <p>{{ data.cashAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="银行转账">
        <p>{{ data.bankTransferAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="支付宝">
        <p>{{ data.alipayAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="微信">
        <p>{{ data.wechatAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="退费金额">
        <p>{{ data.refundAmount | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="合计发票">
        <p>{{ data.receiptInvoiceTotalNum | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="票据">
        <p>{{ data.receiptTotalNum | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="蓝票">
        <p>{{ data.blueInvoiceTotalNum | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="废票">
        <p>{{ data.invalidInvoiceTotalNum | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="红票">
        <p>{{ data.redInvoiceTotalNum | emptyStr }}</p>
      </el-form-item>
      <el-form-item label="合计发票金额">
        <p>{{ data.receiptInvoiceTotalAmount | emptyStr }}</p>
      </el-form-item>

      <div class="clearfix"></div>
    </el-form>
    <div class="btnBox">
      <slot name="operation"></slot>
    </div>
  </div>
</template>

<script>

export default {
  name: 'BusinessInfo',
  components: {

  },
  filters: {},
  mixins: [],
  props: {
    //表格数据
    data: {
      type: Object,
      default: () => ({}),
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

    },
  }
}
</script>

<style scoped lang="scss">
  .BusinessInfo-container {
    ::v-deep {
      .el-form-item {
        width: calc(100% / 6);
        float: left;
      }
      .btnBox {
        margin-top: 15px;
        text-align: right;

        .el-button {
          width: calc(100% / 6);
        }
      }
    }
  }
</style>
