<!--拆表-->
<template>
  <div v-loading="loading">
    <el-steps :active="curStep" finish-status="success">
      <template v-if="showChargeStep">
        <el-step title="确认信息"></el-step>
        <el-step title="支付"></el-step>
        <el-step title="完成"></el-step>
      </template>
      <template v-else>
        <el-step title="确认信息"></el-step>
        <el-step title="完成"></el-step>
      </template>
    </el-steps>

    <el-divider></el-divider>
    <!-- 确认信息  -->
    <div v-if="isInputInfo">
      <!--表具信息-->
      <span class="subTitle">当前表具信息</span>
      <el-form v-if="curMeter" label-position="top" class="jh-text meterInfo">
        <el-form-item label="缴费编号">
          {{ curMeter.customerChargeNo || emptyStr }}
        </el-form-item>
        <el-form-item label="客户名称">
          <p>{{ curMeter.customerName || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="客户类型">
          {{ curMeter.customerTypeName || emptyStr }}
        </el-form-item>
        <el-form-item label="电话">
          {{ curMeter.telphone || emptyStr }}
        </el-form-item>
        <el-form-item label="表类型">
          {{ dictMap.ORDER_SOURCE_NAME[curMeter.orderSourceName] }}
        </el-form-item>

        <!-- <el-form-item label="气表编号">
          {{ curMeter.gasCode || emptyStr }}
        </el-form-item> -->
        <el-form-item label="表身号">
          {{ curMeter.gasMeterNumber || emptyStr }}
        </el-form-item>

        <el-form-item label="气表厂家">
          {{ curMeter.gasMeterFactoryName || emptyStr }}
        </el-form-item>

        <el-form-item label="气表版号">
          {{ curMeter.gasMeterVersionName || emptyStr }}
        </el-form-item>

        <el-form-item label="气表止数" prop="meterEndGas" style="margin-bottom: 15px">
          <el-input v-model="meterEndGas" clearable type="number"></el-input>
        </el-form-item>
        <el-form-item label="表具余额/多抄金额" prop="meterBalance" style="margin-bottom: 15px">
          <el-input v-model="meterBalance" clearable type="number"></el-input>
        </el-form-item>
      </el-form>
      <br />
      <span class="subTitle">拆表原因</span>
      <el-input v-model="removeReason" type="textarea" rows="3"></el-input>
      <br />
      <br />
      <div class="text-right">
        <el-button
          :disabled="!(curMeter && removeReason) || submitLoading"
          :loading="submitLoading"
          type="primary"
          @click="dismantleMeter"
          >确认</el-button
        >
      </div>
    </div>
    <!-- 支付  -->
    <div v-if="isCharge">
      <!--收费信息-->
      <el-card shadow="never" class="no-border">
        <div slot="header">
          <span class="card-title">收费信息</span>
        </div>
        <el-row :gutter="20">
          <!--收费列表-->
          <qc-charge
            scene="dis_meter"
            :customer-code="curMeter.customerCode"
            :gas-meter-code="curMeter.gasCode"
            :biz-no-or-id="businessId"
            :need-to-pay="needToPay"
            :arrears-detail-ids="arrearsDetailIds"
            :scene-handle="disMeterSuccess"
            :handle-end="handleDisMeterEnd"
          ></qc-charge>
        </el-row>
      </el-card>
      <div class="text-right">
        <!-- 模拟收费成功 执行 -->
        <!-- <el-button type="primary" @click="chargeSuccess">下一步</el-button> -->
      </div>
    </div>
    <div v-if="isFinish">
      <!--确定-->
      <h1 class="success">
        <i class="el-icon-success"></i>
        业务办理成功!
      </h1>
      <p class="success-text">即将返回……</p>
      <div class="text-right">
        <el-button type="primary" @click="finished">完成</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import QcCharge from '@/components/QcCharge/index'
import temporaryApi from '@/api/temporary'
import { chargeSceneFields } from '@/enums/business'

export default {
  name: 'DismantleMeter',
  components: {
    QcCharge,
  },
  props: {
    step: Number,
    curBusinessId: String,
    curMeter: Object,
    settlementReturn: Function,
  },
  data() {
    return {
      // 当前步骤
      curStep: this.step || 1,
      businessId: this.curBusinessId,
      emptyStr: '---',
      removeReason: '', // 拆表原因
      meterEndGas: '', //气表止数
      meterBalance: 0, // 表具余额
      showChargeStep: true, // 是否显示收费步骤
      loading: false, // 全局loading
      submitLoading: false, // 提交按钮loading
      needToPay: false,
      arrearsDetailIds: '', // 缴费信息ID
    }
  },
  computed: {
    // 是否是确认信息步骤
    isInputInfo() {
      return +this.curStep === 1
    },
    // 是否是收费
    isCharge() {
      return this.showChargeStep && +this.curStep === 2
    },
    // 是否到完成的步骤了
    isFinish() {
      return +this.curStep >= 3 || (!this.showChargeStep && +this.curStep >= 2)
    },
  },
  watch: {
    // 监听当前步骤, 如果是完成步骤，则执行操作
    curStep(value) {
      if (this.isFinish) {
        this.$emit('success', true)
        this.$nextTick(() => {
          setTimeout(() => {
            // 关闭弹出并刷新页面
            this.$emit('close', true)
          }, 2000)
        })
      }
    },
  },
  async created() {
    this.loading = true
    // this.showChargeStep = await this.whetherSceneCharge(chargeSceneFields.DIS_METER)
    this.loading = false
  },
  destroyed() {
    if (this.curStep === 2) {
      this.settlementReturn()
    }
  },
  methods: {
    next() {
      this.curStep++
      // if (this.curStep++ > 3) this.curStep = 4;
    },

    // 拆表
    async dismantleMeter() {
      if (this.meterEndGas == '') {
        this.$message.warning('气表止数必填')
        return
      }
      let params = {
        customerCode: this.curMeter.customerCode,
        customerName: this.curMeter.customerName,
        meterCode: this.curMeter.gasCode,
        removeReason: this.removeReason,
        meterEndGas: Number(this.meterEndGas),
        meterBalance: +this.meterBalance,
      }
      const showChargeStep = await this.whetherSceneCharge(chargeSceneFields.CHANGE_METER)
      this.submitLoading = true
      temporaryApi
        .dismantleMeter(params)
        .then(res => {
          const { isSuccess, data } = res.data
          if (isSuccess) {
            console.log(data)
            const { busData, needToPay, arrearsDetailIds } = data
            this.businessId = busData?.id ?? null
            this.needToPay = needToPay
            this.arrearsDetailIds = arrearsDetailIds
            console.log('拆表成功')
            // 如果不需要支付燃气费并且没有可收费场景则跳过一步
            if (!needToPay) {
              this.curStep += 2
            } else {
              this.next()
            }
          }
        })
        .finally(() => (this.submitLoading = false))
    },

    // 收费成功，改变状态
    chargeSuccess() {
      let params = {
        id: this.businessId,
        meterCode: this.curMeter.gasCode,
      }
      temporaryApi.dismantleMeterStatus(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          console.log(res)
          this.next()
        }
      })
    },

    // end
    finished() {
      this.$emit('close')
    },
    disMeterSuccess(callBack) {
      callBack()
    },
    // 收费步骤结束
    handleDisMeterEnd() {
      this.$loading().setText('收费成功，交互中……')
      this.next()
      this.$loading().close()
    },
  },
}
</script>

<style lang="scss" scoped>
.meterInfo {
  .el-form-item {
    width: auto;
    float: left;
    margin-right: 20px;
  }
}
.success {
  color: #13ce66;
  text-align: center;
  padding-top: 50px;
}
.success-text {
  font-size: 16px;
  color: #666;
  text-align: center;
  padding-bottom: 50px;
}
::v-deep .el-card__body {
  overflow: initial;
}
</style>
