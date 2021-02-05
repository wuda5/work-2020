<!-- 开户组件 -->
<template>
  <div v-loading="loading" class="OpenAccount-page">
    <!-- 客户信息区域 -->
    <section class="s1">
      <el-card shadow="never no-border">
        <div slot="header">
          <span class="card-title">{{ $t('customerInfo.detailsTitle') }}</span>
          <el-button type="primary" class="fr" @click="selectCustomerDialogVisible = true">{{ $t('选择已有客户') }}</el-button>
        </div>
        <!-- 客户档案表单区域 -->
        <customer-info-form ref="customerInfoFormRef" :only-view="false" :form-data.sync="customerData" show-reset-btn></customer-info-form>

        <!-- 客户列表选择弹框 -->
        <el-dialog
          width="1200px"
          title="选择需要开户的客户"
          :visible.sync="selectCustomerDialogVisible"
          :append-to-body="true"
        >
          <customer-list v-if="selectCustomerDialogVisible" @select-success="handleCustomerSelectSuccess"></customer-list>
        </el-dialog>
      </el-card>
    </section>
    <!-- 表具信息区域 -->
    <section class="s1 meter-section">
      <el-card shadow="never">
        <div slot="header">
          <span class="card-title">{{ $t('meterInfo.detailsTitle') }}</span>
          <el-button type="primary" class="fr" @click="selectMeterDialogVisible = true">{{ $t('选择已有表具') }}</el-button>
        </div>
        <!-- 表具档案表单区域 -->
        <meter-info-form ref="meterInfoFormRef" :form-data.sync="meterData" :customer-data="customerData" show-reset-btn ::only-view="true" @success="handleOpenAccountSuccess"></meter-info-form>
        <!-- 表具列表选择弹框 -->
        <el-dialog
          width="1200px"
          title="选择需要开户的表具"
          :visible.sync="selectMeterDialogVisible"
          :append-to-body="true"
        >
          <meter-list v-if="selectMeterDialogVisible" @select-success="handleMeterSelectSuccess"></meter-list>
        </el-dialog>
      </el-card>
    </section>
  </div>
</template>

<script>
import { isObject, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import { saveInfoAndOpenAccount } from '@/api/userInfo/index'
import CustomerInfoForm from '@/views/gmis/userInfo/components/editUserInfo.vue' // 客户表单
import CustomerList from './CustomerList.vue' // 客户档案列表
import MeterInfoForm from './MeterInfoForm.vue' // 表具表单
import MeterList from './MeterList.vue' // 表具档案列表

export default {
  name: 'QcOpenAccount',
  components: {
    CustomerInfoForm,
    MeterInfoForm,
    CustomerList,
    MeterList,
  },
  filters: {},
  mixins: [commonMixin],
  props: {

  },
  data() {
    return {
      // 客户信息相关的
      customerData: {},
      selectCustomerDialogVisible: false, // 选择客户列表弹框标志
      // 表具信息相关的
      meterData: {},
      selectMeterDialogVisible: false, // 选择表具列表弹框标志

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
      this.loading = true
      this.loading = false
      //  await this.getList()

    },
    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },

    // 开户成功回调
    handleOpenAccountSuccess(data) {
      // 成功给父组件回调事件
      this.$emit('success', data)
    },

    // 验证开户信息是否全部正确, 返回气表信息和客户信息
    async validateOpenAccount() {
      // 验证客户信息
      const customerValidateResult = await this.$refs.customerInfoFormRef?.validateForm()
      // console.log('customerValidateResult', customerValidateResult)
      if (!customerValidateResult) {
        return Promise.resolve(false)
      }
      // 验证表具信息
      const meterValidateResult = await this.$refs.meterInfoFormRef?.validateForm()
      // console.log('meterValidateResult', meterValidateResult)
      if (!meterValidateResult) {
        return Promise.resolve(false)
      }
      
      return Promise.resolve( {
        customer: customerValidateResult,
        gasMeter: meterValidateResult
      })
    },
    // 验证信息并开户保存
    async handleSaveOpenAccountInfo() {
      const result = await this.validateOpenAccount()
      // console.log(result)
      return new Promise((resolve) => {
        if (result) {
          result.chargeNo = result.gasMeter?.customerChargeNo
          saveInfoAndOpenAccount(result)
          .then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              this.$message.success('开户信息保存成功')
            }
            resolve(isSuccess ? isObject(data) ? data : result : false)
          })
          .catch(() => (resolve(false)))
        } else {
          resolve(false)
        }
      })
    },

    // 开户客户选择成功
    handleCustomerSelectSuccess(data) {
      this.customerData = cloneDeep(data || {})
      this.selectCustomerDialogVisible = false
    },

    // 开户表具选择成功
    handleMeterSelectSuccess(data) {
      this.meterData = cloneDeep(data || {})
      this.selectMeterDialogVisible = false
    },
  }
}
</script>

<style scoped lang="scss">
  .OpenAccount-page {
    ::v-deep {
      >section {
        margin-bottom: 15px;
      }
      .el-card {
        .el-card__body {
          padding: 15px;
        }
      }
      .qc-form {
        padding: 0;
        .el-form-item {
          margin-bottom: 10px !important;
        }
      }
      .userinfo-form {
        .el-form-item {
          // width: calc(100% / 6) !important;
          // &.idCard-form-item {
          // width: calc(100% / 6 * 2) !important;
          // }
          // &.contactAddress-form-item {
          // width: calc(100% / 6 * 2) !important;
          // }
          &.save-btn-box {
            display: none;
          }
        }
      }
      .customerCode-form-item {
        display: none;
      }
      .meterinfo-form {
        
      }
      .gasCode-form-item {
        display: none;
      }
    }
  }
</style>
