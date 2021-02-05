<template>
  <div>
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">详情</span>
      </div>
      <el-row :gutter="24" class="w100">
        <el-col :span="24">
          <el-form ref="deitailForm" label-position="top" :model="refundDetailForm" class="jh-text">
            <el-row :gutter="24" class="w100">
              <el-col :span="5">
                <el-form-item label="客户名称" style="width: 100%">
                  <div class="label">
                    {{ refundDetailForm.customerName }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="5">
                <el-form-item label="退费金额" style="width: 100%">
                  <div class="label">
                    {{ refundDetailForm.refundMoney }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="5">
                <el-form-item label="申请人" style="width: 100%">
                  <div class="label">
                    {{ refundDetailForm.applyUserName }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="5">
                <el-form-item label="退费方式" style="width: 100%">
                  <div class="label">
                    {{ refundDetailForm.methodName }}
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="4">
                <el-form-item label="退费原因" style="width: 100%">
                  <div class="label">
                    {{ refundDetailForm.applyReason }}
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <!-- <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="退费金额" style="width: 100%">
                  <el-input v-model="refundDetailForm.backAmount" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="退费方式" style="width: 100%">
                  <el-input v-model="refundDetailForm.backMethodName" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row> -->
            <!-- <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="申请人" style="width: 100%">
                  <el-input v-model="refundDetailForm.applyUserName" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="申请原因" style="width: 100%">
                  <el-input v-model="refundDetailForm.backReason" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row> -->
            <!-- <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item v-if="curRow" label="有无卡退费" style="width: 100%">
                  <el-input
                    v-if="curRow && curRow.whetherNoCard === 0"
                    value="有卡退费"
                    disabled
                  ></el-input>
                  <el-input
                    v-if="curRow && curRow.whetherNoCard === 1"
                    value="无卡退费"
                    disabled
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col v-if="!isBackCardLoad" :span="12">
                <el-form-item v-if="isBackGas" label="卡退气" style="width: 100%">
                  <el-button
                    :loading="tqLoading"
                    :disabled="!curRow"
                    type="primary"
                    @click="() => handleCard(curRow.gasMeterCode)"
                  >
                    卡退气
                  </el-button>
                </el-form-item>
              </el-col>
            </el-row> -->
            <el-row v-if="curRow && curRow.whetherNoCard === 1" :gutter="24" class="w100">
              <el-alert :title="noCardText" type="error"> </el-alert>
            </el-row>
            <el-row
              v-if="
                refundStatus !== 'NONREFUND' &&
                refundStatus !== 'REFUNDED' &&
                refundStatus !== 'WAITE_AUDIT'
              "
              :gutter="24"
            >
              <el-col :span="12">
                <el-form-item
                  v-if="
                    refundStatus !== 'CANCEL' &&
                    refundStatus !== 'NONREFUND' &&
                    refundStatus !== 'REFUNDED'
                  "
                  label=" "
                  style="width: 100%"
                >
                  <el-button
                    :loading="cancelLoading"
                    :disabled="!curRow"
                    type="primary"
                    @click="() => cancelRefund(curRow.id)"
                  >
                    撤销退费
                  </el-button>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label=" " style="width: 100%">
                  <el-button
                    v-if="refundStatus === 'REFUNDABLE'"
                    :disabled="!curRow"
                    :loading="tfLoading"
                    size="mini"
                    type="primary"
                    @click="() => refund(curRow.id)"
                  >
                    退费
                  </el-button>
                  <el-button
                    v-if="refundStatus === 'REFUND_ERR'"
                    :loading="tfLoading"
                    :disabled="!curRow"
                    size="mini"
                    type="primary"
                    @click="() => refund(curRow.id)"
                  >
                    重试
                  </el-button>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="24">
              <el-alert
                v-if="refundStatus === 'REFUND_ERR'"
                :title="curRow ? curRow.refundFailedReason : ''"
                type="error"
                :closable="false"
              >
              </el-alert>
            </el-row>
            <div v-if="refundStatus === 'WAITE_AUDIT'" style="width: 100%">
              <el-row :gutter="24" class="w100">
                <el-col :span="6">
                  <el-form-item label="是否通过" style="width: 100%">
                    <el-radio v-model="startRefundForm.status" :label="true">可退费</el-radio>
                    <el-radio v-model="startRefundForm.status" :label="false">不予退费</el-radio>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="审核备注" style="width: 100%">
                    <el-input v-model="startRefundForm.auditOpinion"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label=" " style="width: 100%">
                    <el-button
                      :loading="refundLoading"
                      :disabled="!curRow"
                      type="primary"
                      @click="refundSumbit"
                    >
                      确认审核
                    </el-button>
                  </el-form-item>
                </el-col>
              </el-row>
            </div>
            <div v-if="refundStatus === 'NONREFUND'" style="width: 100%">
              <el-row :gutter="24" class="w100">
                <el-col :span="5">
                  <el-form-item label="退费状态" style="width: 100%">
                    <el-link type="danger">不予退费</el-link>
                  </el-form-item>
                </el-col>
                <el-col :span="19">
                  <el-form-item label="审核备注" style="width: 100%">
                    <el-input v-model="refundDetailForm.auditRemark" disabled></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </div>
          </el-form>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import ChargeApi from '@/api/charges'
import CardApi from '@/api/card'

export default {
  name: 'QcRefundRefundDetail',
  props: {
    refundDetailList: Array,
    refundDetailForm: Object,
    refundStatus: String,
    cancelRefund: Function,
    startRefundForm: Object,
    refundSumbit: Function,
    curRow: Object,
    search: Function,
    noCardText: String,
    isBackGas: null,
  },
  data() {
    return {
      cancelLoading: false,
      refundLoading: false,
      tfLoading: false,
      tqLoading: false,
      rebackGasEnd: false,
    }
  },
  computed: {
    isBackCardLoad() {
      const { curRow } = this
      if (curRow) {
        return curRow.whetherNoCard == 0 && curRow.isViewIC && curRow.refundStatus === 'REFUNDABLE'
      } else {
        return false
      }
    },
  },
  methods: {
    // async chargeSumbit() {
    //   this.loading = true
    //   await this.handleSumbit()
    // },
    closeCancelLoading() {
      this.cancelLoading = false
    },
    closeRefundLoading() {
      this.refundLoading = false
    },
    refund(id) {
      this.tfLoading = true
      ChargeApi.accountRefund(id)
        .then(res => {
          if (res.data.isSuccess) {
            this.search()
          }
        })
        .finally(() => {
          this.tfLoading = false
        })
    },
    async handleCard(gasMeterCode) {
      this.tqLoading = true
      CardApi.shakeHandsSocket({
        shakeOne: CardApi.backGasLoad,
        shakeTwo: CardApi.backGasCallBack,
        code: gasMeterCode,
        customerCode: this.curRow.customerCode,
        bizIdOrNo: this.curRow.chargeNo,
        callBack: () => {
          this.tqLoading = false
          this.$loading().close()
          this.$message({
            message: '退气成功',
            type: 'success',
          })
          //退气成功隐藏退气按钮
          this.rebackGasEnd = true
          this.search()
        },
        error: () => {
          this.tqLoading = false
        },
      })
    },
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  .el-row {
    width: 100%;
  }
  .el-form-item {
    width: 16%;
  }
}
.jh-text .el-form-item {
  width: 20%;
}
::v-deep .el-table--mini td {
  padding: 0 !important;
}
.label {
  font-size: 12px;
  color: #333;
}
</style>
