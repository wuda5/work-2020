<template>
  <div>
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">收费列表</span>
      </div>
      <el-row :gutter="24">
        <el-col :span="12">
          <el-table :data="chargeDetailList" :stripe="true" height="300px" class="padding0 w100">
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
              <span slot-scope="{ row }">
                {{ row.chargeItemGas | emptyStr }}
              </span>
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
          <el-form ref="deitailForm" label-position="top" :model="chargeDetailForm" class="jh-text">
            <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="客户名称" class="w100">
                  <el-input v-model="chargeDetailForm.customerName" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="应收" class="w100">
                  <el-input v-model="chargeDetailForm.receivableMoney" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="抵扣金额" class="w100">
                  <el-input v-model="chargeDetailForm.prechargeDeductionMoney" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="实收" class="w100">
                  <el-input v-model="chargeDetailForm.actualIncomeMoney" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="找零" class="w100">
                  <el-input v-model="chargeDetailForm.giveChange" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item v-if="apply" label="可退金额" class="w100">
                  <el-input v-model="isRefundMoney" disabled></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row v-if="curRow && curRow.isCardMeter" v-show="false" :gutter="24" class="w100">
              <el-col :span="24">
                <el-form-item label="有无卡退费" style="width: 100%">
                  <el-radio v-model="refundApplyForm.whetherNoCard" :label="0">有卡退费</el-radio>
                  <el-radio v-model="refundApplyForm.whetherNoCard" :label="1"> 无卡退费 </el-radio>
                </el-form-item>
                <el-alert
                  v-if="refundApplyForm.whetherNoCard === 1"
                  :title="noCardText"
                  type="error"
                >
                </el-alert>
              </el-col>
            </el-row>
            <el-row v-if="refund" :gutter="24" class="w100">
              <el-col :span="12">
                <el-form-item label="退费方式" class="w100">
                  <el-select v-model="refundApplyForm.refundType">
                    <el-option
                      v-for="{ label, value } in refundType"
                      :key="value"
                      :value="value"
                      :label="label"
                    />
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="退费原因" class="w100">
                  <el-input v-model="refundApplyForm.refundReason"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="clearfix"></div>
            <div class="btnBox">
              <el-button
                v-if="apply && !refund"
                :disabled="!curRow"
                type="primary"
                @click="handleRefund"
              >
                退费申请
              </el-button>
              <el-alert
                v-if="apply === false && curRow"
                :title="'不可申请退费说明：' + refundApplyForm.nonRefund"
                type="error"
                :closable="false"
              >
              </el-alert>
              <el-button
                v-if="refund"
                :loading="loading"
                :disabled="!curRow"
                type="primary"
                @click="chargeSumbit"
              >
                提审
              </el-button>
            </div>
          </el-form>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
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
  },
  data() {
    return {
      loading: false,
    }
  },
  methods: {
    async chargeSumbit() {
      this.loading = true
      await this.handleSumbit()
    },
    closeLoading() {
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
</style>
