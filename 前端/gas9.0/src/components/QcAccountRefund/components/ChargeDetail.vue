<template>
  <div>
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">详情</span>
      </div>
      <el-row :gutter="24">
        <el-col :span="24">
          <el-form ref="deitailForm" label-position="top" :model="chargeDetailForm" class="jh-text">
            <el-row :gutter="24" class="w100">
              <el-col :span="6">
                <el-form-item label="客户名称" class="w100">
                  <div class="label">
                    {{ chargeDetailForm.customerName }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="身份证号" class="w100">
                  <div class="lebal">
                    {{ chargeDetailForm.identityCardNo }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="账号余额" class="w100">
                  <div class="lebal">
                    {{ chargeDetailForm.accountMoney }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="家庭住址" class="w100">
                  <div class="label">
                    {{ chargeDetailForm.address }}
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="24" class="w100">
              <div v-if="apply">
                <el-col :span="6">
                  <el-form-item label="实退金额" class="w100">
                    <el-input
                      v-model="applyRefundForm.actualRefundMoney"
                      @input="val => tofix(val,'actualRefundMoney')"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="退费方式" class="w100">
                    <el-select v-model="applyRefundForm.refundMethod">
                      <el-option
                        v-for="{ label, value } in refundType"
                        :key="value"
                        :value="value"
                        :label="label"
                      />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="退费原因" class="w100">
                    <el-input v-model="applyRefundForm.refundReason"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label=" " class="w100">
                    <el-button
                      :loading="loading"
                      :disabled="refundButton"
                      type="primary"
                      @click="handleApplyRefund"
                    >
                      退费申请
                    </el-button>
                  </el-form-item>
                </el-col>
              </div>
              <div v-else>
                <el-alert
                  v-if="curRow"
                  :title="'不可申请退费说明：' + refundApplyForm.nonRefund"
                  type="error"
                  :closable="false"
                  style="margin-top: 10px"
                >
                </el-alert>
              </div>
            </el-row>
          </el-form>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import { toFix2 } from '@/utils/index'

export default {
  name: 'QcRefundChargeDetail',
  props: {
    chargeDetailList: Array,
    chargeDetailForm: Object,
    isRefundMoney: Number,
    refundApplyForm: Object,
    refund: Boolean,
    apply: Boolean,
    curRow: null,
    handleRefund: Function,
    handleSumbit: Function,
    refundType: null,
    noCardText: String,
    applyRefundForm: Object,
  },
  data() {
    return {
      loading: false,
    }
  },
  computed: {
    refundButton() {
      let ready = true
      const {
        applyRefundForm: { actualRefundMoney, refundMethod, refundReason },
      } = this
      if (actualRefundMoney != '' && refundMethod != '' && refundReason != '') {
        ready = false
      }
      return ready
    },
  },
  methods: {
    tofix(val,target) {
      this.applyRefundForm[target] = toFix2(val)
    },
    async handleApplyRefund() {
      this.loading = true
      await this.handleRefund()
      this.loading = false
    },
  },
}
</script>

<style lang="scss" scoped>
.btnBox {
  margin-top: 20px;
  width: 100%;
}
.w100 {
  width: 100%;
}
::v-deep .el-table--mini td {
  padding: 0 !important;
}
.label {
  font-size: 12px;
  color: #333;
}
</style>
