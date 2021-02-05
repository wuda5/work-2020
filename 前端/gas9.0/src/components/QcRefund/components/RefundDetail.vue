<template>
  <div>
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">退费明细</span>
      </div>
      <el-row :gutter="24" class="w100">
        <el-col :span="12">
          <el-table :data="refundDetailList" :border="true" height="300px" style="width: 100%">
            <el-table-column prop="chargeItemName" label="商品名称" show-overflow-tooltip>
              <template slot-scope="{ row }">
                <p>
                  {{ row.chargeItemName | emptyStr }}
                </p>
              </template>
            </el-table-column>
            <el-table-column prop="totalCount" label="数量">
              <template slot-scope="{ row }">
                <p>
                  {{ row.totalCount | emptyStr }}
                </p>
              </template>
            </el-table-column>

            <el-table-column prop="price" label="单价">
              <span slot-scope="{ row }">
                {{ row.price | emptyStr }}
              </span>
            </el-table-column>
            <el-table-column prop="chargeItemGas" label="气量">
              <template slot-scope="{ row }">
                <p>
                  {{ row.chargeItemGas | emptyStr }}
                </p>
              </template>
            </el-table-column>
            <el-table-column prop="chargeItemMoney" label="金额">
              <template slot-scope="{ row }">
                <p>
                  {{ row.chargeItemMoney | emptyStr }}
                </p>
              </template>
            </el-table-column>
          </el-table>
        </el-col>
        <el-col :span="12">
          <el-form ref="deitailForm" label-position="top" :model="refundDetailForm" class="jh-text">
            <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="客户名称" style="width: 100%">
                  <el-input v-model="refundDetailForm.customerName" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="退费单号" style="width: 100%">
                  <el-input v-model="refundDetailForm.refundNo" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="24" class="w100">
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
            </el-row>
            <el-row :gutter="24" class="w100">
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
            </el-row>
            <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item
                  v-if="curRow && curRow.isCardMeter"
                  v-show="false"
                  label="有无卡退费"
                  style="width: 100%"
                >
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
              <el-col v-if="isBackCardLoad" :span="12">
                <el-form-item label="卡退气" style="width: 100%">
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
            </el-row>
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
                    v-if="refundStatus !== 'THIRDPAY_REFUND'"
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
                <el-col :span="12">
                  <el-form-item label="是否通过" style="width: 100%">
                    <el-radio v-model="startRefundForm.status" :label="true">可退费</el-radio>
                    <el-radio v-model="startRefundForm.status" :label="false">不予退费</el-radio>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="审核备注" style="width: 100%">
                    <el-input v-model="startRefundForm.auditOpinion"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24" class="w100">
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
                <el-col :span="12">
                  <el-form-item label="退费状态" style="width: 100%">
                    <el-link type="danger">不予退费</el-link>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="备注" style="width: 100%">
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
    loadRefundAllInfoData: Object,
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
      const { curRow, loadRefundAllInfoData } = this
      //       case 'THIRDPAY_REFUND':
      //   refundText = '三方支付退费中'
      //   break
      // case 'REFUNDED': // 不能撤销
      //   refundText = '退费完成'
      //   break
      if (curRow) {
        return (
          (curRow.refundStatus === 'THIRDPAY_REFUND' || curRow.refundStatus === 'REFUNDED') &&
          loadRefundAllInfoData.isCardRefund
        )
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
    async refund(id) {
      this.tfLoading = true
      // let flag = true
      // if (this.refundStatus == 'REFUND_ERR') {
      //   this.$confirm('是否继续退费?', '提示', {
      //     confirmButtonText: '确定',
      //     cancelButtonText: '取消',
      //     type: 'warning',
      //   })
      //     .then(() => {
      //       flag = true
      //     })
      //     .catch(() => {
      //       flag = false
      //     })
      // }
      // if (flag) {
      const { loadRefundAllInfoData } = this
      let next = false
      const params = {
        refundId: id,
        isCardRefund: loadRefundAllInfoData.isCardRefund,
        isMoneyMeter: loadRefundAllInfoData.isMoneyMeter,
        isCardMeter: loadRefundAllInfoData.isCardMeter,
      }
      if (loadRefundAllInfoData.isCardRefund) {
        //是否要读卡
        const res = await CardApi.readCar(
          (code, readData) => {
            params.readData = readData
          },
          () => {
            next = true
            this.tfLoading = false
          }
        )
      }
      if (next) {
        return
      }
      ChargeApi.refundExcute(params)
        .then(res => {
          if (res.data.isSuccess) {
            //非按原路返回
            if (this.curRow.refundMethod !== 'PAY_METHOD_REFUND') {
              if (res.data.data.isCardRefund) {
                this.$confirm('是否卡退气?', '提示', {
                  confirmButtonText: '确定',
                  cancelButtonText: '取消',
                  type: 'warning',
                })
                  .then(() => {
                    this.handleCard(this.curRow.gasMeterCode)
                  })
                  .catch(() => {
                    this.search()
                  })
              } else {
                this.search()
              }
            } else {
              //
              this.$message('待第三方退费完成后，请进行卡退气')
              this.search()
            }
          }
        })
        .finally(() => {
          this.tfLoading = false
        })
      // }
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
</style>
