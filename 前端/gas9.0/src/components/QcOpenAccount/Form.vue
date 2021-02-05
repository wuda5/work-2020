<!-- 开户表单信息 -->
<template>
  <div v-loading="loading" class="OpenAccountForm-page">
    <!-- 客户信息区域 -->
    <section class="s1">
      <el-card shadow="never no-border">
        <div slot="header">
          <span class="card-title">{{ $t('customerInfo.detailsTitle') }}</span>
        </div>
        <!-- 客户档案表单区域 -->
        <customer-info-form :only-view="true" :form-data="customerData"></customer-info-form>
      </el-card>
    </section>
    <!-- 表具信息区域 -->
    <section class="s1 meter-section">
      <el-card shadow="never">
        <div slot="header">
          <span class="card-title">{{ $t('meterInfo.detailsTitle') }}</span>
        </div>
        <!-- 表具档案表单区域 -->
        <meter-info-form :form-data="meterData" :customer-data="customerData" :type="0" :only-view="false" @success="handleSaveSuccess"></meter-info-form>
      </el-card>
    </section>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import CustomerInfoForm from '@/views/gmis/userInfo/components/editUserInfo.vue'
import MeterInfoForm from './MeterInfoForm.vue'

export default {
  name: 'OpenAccountForm',
  components: {
    CustomerInfoForm,
    MeterInfoForm
  },
  filters: {},
  mixins: [commonMixin],
  props: {
    // 表具表单数据
    meterData: {
      type: Object,
      default: () => ({})
    },
    // 客户表单信息
    customerData: {
      type: Object,
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
    async initData() {},
    
    // 信息编辑成功后的回调
    handleSaveSuccess(data) {
      // 回传父组件
      this.$emit('success', data)
    }
  }
}
</script>

<style scoped lang="scss">
  .OpenAccountForm-page {
    ::v-deep {
      >section {
        margin-bottom: 15px;
      }
      .el-card {
        .el-card__body {
          padding: 15px;
        }
      }
    }
  }
</style>
