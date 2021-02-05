<!-- 开户按步骤进行 -->
<template>
  <div v-loading="loading" :element-loading-text="submitLoading ? '正在保存开户信息，请稍候...' : ''" class="openAccountStep-page">
    
    <el-steps :active="currentStep" finish-status="success">
      <template v-if="showChargeStep">
        <el-step title="选择开户信息"></el-step>
        <el-step title="支付"></el-step>
        <el-step title="完成"></el-step>
      </template>
      <template v-else>
        <el-step title="选择开户信息"></el-step>
        <el-step title="完成"></el-step>
      </template>
    </el-steps>
    <el-divider></el-divider>
    <div class="step-container">
      <!-- 选择开户信息进行开户操作 -->
      <template v-if="isInputInfo">
        <!-- 开户组件 -->
        <qc-open-account ref="openAccountRef" @success="handleOpenAccountSuccess" />
        <div class="text-right">
          <el-button size="medium" class="next-step-btn" :loading="submitLoading" :disabled="submitLoading" round type="primary" @click="handleSaveOpenAccount">下一步</el-button>
        </div>
      </template>
      <!-- 开户收费操作 -->
      <template v-else-if="isCharge">
        <!--收费信息-->
        <el-card shadow="never" class="no-border">
          <div slot="header">
            <span class="card-title">收费信息</span>
          </div>
          <el-row :gutter="20">
            <!--收费列表-->
            <qc-charge
              scene="open_account"
              :customer-code="currentCustomerCode"
              :gas-meter-code="currentGasMeterCode"
              :biz-no-or-id="currentBizNoOrId"
              :customer-charge-no="customerChargeNo"
              :scene-handle="handleOpenAccountChargeSuccess"
              :handle-end="handleAccountChargeEnd"
            ></qc-charge>
          </el-row>
        </el-card>
      </template>
      <!-- 开户业务流程完成 -->
      <template v-else-if="isFinish">
        <!--确定-->
        <div class="text-center">
          <h1 class="success text-success">
            <i class="el-icon-success"></i>
            业务办理成功!
          </h1>
          <p class="success-text">3s后返回列表页面……</p>
          <div class="text-right">
            <el-button type="primary" @click="finished(false)">完成</el-button>
          </div>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import QcOpenAccount from '@/components/QcOpenAccount/Index.vue'; // 单个开户
import QcCharge from '@/components/QcCharge/index.vue'
import { chargeSceneFields } from '@/enums/business'

export default {
  name: 'OpenAccountStep',
  components: {
    QcOpenAccount,
    QcCharge,
  },
  filters: {},
  mixins: [commonMixin],
  props: {
    // 当前步骤
    step: [String, Number],
    // 客户编号
    customerCode: String,
    // 当前的业务场景
    bizNoOrId: String,
    // 气表编号
    gasMeterCode: String,
  },
  data() {
    return {
      currentStep: null, // 当前步骤
      currentCustomerCode: null, // 当前客户编号
      currentGasMeterCode: null, // 当前气表编号
      customerChargeNo: null, // 当前缴费编号
      currentBizNoOrId: '', // 当前的业务场景id
      timer: null,
      submitLoading: false,
      showChargeStep: false, // 是否显示收费步骤
    }
  },
  computed: {
    // 是否是录入开户信息步骤
    isInputInfo() {
      return +this.currentStep === 1 
    },
    // 是否是收费
    isCharge() {
      return this.showChargeStep && +this.currentStep === 2 
    },
    // 是否到完成的步骤了
    isFinish() {
      return +this.currentStep === 3 || (!this.showChargeStep && +this.currentStep === 2) 
    }
  },
  watch: {
    // 监听当前步骤, 如果是完成步骤，则执行操作
    currentStep(value) {
      if (this.isFinish) {
        this.$emit('save-success')
        this.$nextTick(() => {
          this.timer = setTimeout(() => {
            this.finished(true)
          }, 3000)
        })
      }
    },
    
  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {
    clearTimeout(this.timer)
  },
  methods: {
    async initData() {
      this.loading = true
      this.currentStep = +(this.step || 1)
      this.currentCustomerCode = this.customerCode
      this.currentGasMeterCode = this.gasMeterCode
      this.currentBizNoOrId = this.bizNoOrId
      this.showChargeStep = await this.whetherSceneCharge(chargeSceneFields.OPEN_ACCOUNT)
      // await this.getData()
      this.loading = false
    },

    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },

    // 开户信息填写成功
    handleOpenAccountSuccess(data) {
      // console.log(data)
      this.currentStep++
      this.currentCustomerCode = data.customerCode
      this.currentGasMeterCode = data.gasCode
      // this.$emit('saveSuccess')
    },
    // 开户收费成功
    handleOpenAccountChargeSuccess(callBack) {
      // 收费成功回调
      this.$emit('charge-success')
      callBack()
    },
    // 
    handleAccountChargeEnd() {
      this.currentStep++
    },
    // 所有操作完成
    finished(isRefresh) {
      this.$emit('close', isRefresh)
    },

    // 保存开户信息操作
    async handleSaveOpenAccount() {
      this.submitLoading = true
      this.loading = true
      // await this.$refs?.openAccountRef?.$refs.meterInfoFormRef?.handleSubmit()
      const result = await this.$refs?.openAccountRef?.handleSaveOpenAccountInfo()
      this.submitLoading = false
      this.loading = false
      if (result) {
        const { customer, gasMeter, chargeNo } = result
        this.currentStep++
        this.currentCustomerCode = customer.customerCode
        this.currentGasMeterCode = gasMeter.gasCode
        this.currentBizNoOrId = gasMeter?.bizNoOrId ?? ''
        this.customerChargeNo = chargeNo
        // console.log('result', result)
        // this.$emit('save-success', result)
      }
    }
  }
}
</script>

<style scoped lang="scss">
  .openAccountStep-page {
    ::v-deep {
      .qc-form {
        .save-btn {
          display: none;
        }
      }
      .next-step-btn {
        width: 150px;
      }
    }
  }
</style>
