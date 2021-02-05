<!-- 收费列表下半部分表格 -->
<template>
  <el-card shadow="never" class="no-border chargeForm">
    <el-form
      label-position="top"
      class="jh-text"
      :disabled="gasMeterCode === ''"
      :model="chargeForm"
      label-width="52px"
    >
      <el-form-item
        v-if="showMap.rechargeMoney && orderSourceName === 'IC_RECHARGE'"
        label="充值金额"
      >
        <!-- 表具收费类型不为 (IC_RECHARGE)时，屏蔽掉充值框。 -->
        <!-- :disabled="orderSourceName !== 'IC_RECHARGE'" -->
        <el-input
          v-model="chargeForm.rechargeMoney"
          @input="val => convert(val, 'MONEY', 'rechargeMoney')"
        />
      </el-form-item>
      <el-form-item v-if="isShowCharge" label="充值金额">
        <el-input v-model="chargeForm.rechargeMoney" disabled />
      </el-form-item>
      <el-form-item
        v-if="showMap.rechargeGas && orderSourceName === 'IC_RECHARGE'"
        label="充值气量"
      >
        <!-- 表具收费类型不为 (IC_RECHARGE)时，屏蔽掉充值框。 -->
        <el-input
          v-model="chargeForm.rechargeGas"
          :disabled="amountMark === 'MONEY'"
          @input="val => convert(val, 'GAS', 'rechargeGas')"
        />
      </el-form-item>
      <el-form-item v-if="showMap.deduct" label="账户抵扣">
        <el-switch v-model="chargeForm.deduct" @change="handleDeduct"></el-switch>
      </el-form-item>
      <el-form-item v-if="showMap.deductMoney" label="抵扣金额">
        <!-- <div v-html="handleMoney(chargeForm.deductMoney)"></div> -->
        <el-input
          v-model="chargeForm.deductMoney"
          :disabled="!chargeForm.deduct"
          @input="val => formatter(val, 'deductMoney')"
        />
      </el-form-item>
      <!-- <el-form-item v-if="showMap.insurance" label="保险状态">
        <div class="inline-block" v-html="handleInsurance"></div>
        <el-tooltip effect="dark" :content="handleInsuranceText" placement="top">
          <div class="inline-block"><i class="el-icon-warning-outline grey" /></div>
        </el-tooltip>
      </el-form-item> -->
      <!-- <el-form-item v-if="showMap.insuranceFlag" label="购买保险">
        <el-switch
          v-model="chargeForm.insuranceFlag"
          @change="handleChangeInsuranceFlag"
        ></el-switch>
      </el-form-item> -->
      <el-form-item v-if="showMap.insurancePremium" label="保费金额">
        <!-- :disabled="!chargeForm.insuranceFlag" -->
        <el-input
          v-model="chargeForm.insurancePremium"
          @input="val => formatter(val, 'insurancePremium')"
        />
      </el-form-item>
      <el-form-item v-if="showMap.insuranceData" label="保险时间">
        <!-- :disabled="!chargeForm.insuranceFlag" -->
        <el-date-picker
          v-model="chargeForm.insuranceData"
          type="daterange"
          range-separator="-"
          start-placeholder="开始"
          end-placeholder="结束"
          format="yyyy-MM-dd"
          value-format="yyyy-MM-dd"
          :clearable="false"
          @change="handleDatePicker"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item v-if="showMap.invoiceValue" label="发票类型">
        <el-select v-model="chargeForm.invoiceValue" placeholder="选择发票">
          <el-option
            v-for="item in chargeForm.invoiceType"
            :key="item.value"
            :label="item.label"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item v-if="showMap.invoiceNo" label="票据编号">
        <el-input v-model="chargeForm.invoiceNo" :disabled="!isManualInput" />
      </el-form-item>
      <el-form-item v-if="showMap.chargeType" label="收费方式">
        <el-select
          v-model="chargeForm.chargeType"
          placeholder="选择收费方式"
          @change="handleChargeType"
        >
          <el-option
            v-for="item in chargeMethod"
            :key="item.value"
            :label="item.label"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item v-if="showMap.remark" label="备注">
        <el-input v-model="chargeForm.remark" />
      </el-form-item>
      <!-- <el-form-item v-if="showMap.receivableMoney" label="应收金额">
        <div v-html="handleMoney(receivableMoney)"></div>
      </el-form-item> -->
      <el-form-item v-if="showMap.prechargeMoney" label="预存金额">
        <el-input
          v-model="chargeForm.prechargeMoney"
          :disabled="chargeForm.deduct || scene === 'open_account'"
          @input="val => formatter(val, 'prechargeMoney')"
        >
          <el-button slot="append" :disabled="chargeForm.deduct" @click="handlePrechargeMoney"
            >零存</el-button
          >
        </el-input>
      </el-form-item>
      <el-form-item v-if="showMap.actualIncomeMoney" label="实收金额">
        <el-input
          v-model="chargeForm.actualIncomeMoney"
          :disabled="chargeForm.chargeType.value !== 'CASH'"
          @input="val => formatter(val, 'actualIncomeMoney')"
        />
      </el-form-item>
      <el-form-item v-if="showMap.receivableMoney" label="合计金额">
        <!-- <div>{{ receivableMoney }}</div> -->
        <div v-html="handleMoney(receivableMoney)"></div>
      </el-form-item>
      <el-form-item v-if="showMap.giveChange" label="找零">
        <div v-html="handleMoney(giveChange)"></div>
      </el-form-item>
      <el-form-item v-if="showMap.replacementButton" class="btnBox">
        <!-- <el-button type="primary" size="medium">卡回收</el-button>
        <el-button type="primary" size="medium">补卡</el-button> -->
        <el-button type="danger" size="small" @click="chargeBtn">收费</el-button>
      </el-form-item>
      <el-form-item v-if="showMap.transferButton" class="btnBox">
        <el-button type="primary" size="small" @click="chargeBtn">过户</el-button>
      </el-form-item>
      <el-form-item v-if="showMap.disMeterButton" class="btnBox">
        <el-button type="primary" size="small" @click="chargeBtn">拆表</el-button>
      </el-form-item>
      <el-form-item v-if="showMap.issueButton" class="btnBox">
        <el-button type="primary" size="small" @click="chargeBtn">发卡</el-button>
      </el-form-item>
      <el-form-item v-if="showMap.openAccountButton" class="btnBox">
        <el-button type="primary" size="small" @click="chargeBtn">收费</el-button>
      </el-form-item>
      <el-form-item v-if="showMap.changeMeterButton" class="btnBox">
        <el-button type="primary" size="small" @click="chargeBtn">收费</el-button>
      </el-form-item>
      <!-- <el-form-item class="btnBox">
        <el-button type="danger" @click="chargeBtn">收费</el-button>
      </el-form-item> -->
    </el-form>
    <el-dialog
      title="收费"
      :visible.sync="dialogFormVisible"
      append-to-body
      @open="show"
      @close="closeDialog"
    >
      <ChargeBox
        v-if="dialogFormVisible"
        ref="chargeBox"
        :invoice-no-from-list="chargeForm.invoiceNo"
        :invoice-value-from-list="chargeForm.invoiceValue"
        :invoice-type="filterinvoiceType(chargeForm.invoiceType)"
        :total-money="receivableMoney"
        :close-charge-box="closeChargeBox"
        :handle-end="handleEnd"
      />
    </el-dialog>
  </el-card>
</template>

<script>
import ChargeBox from './ChargeBox'
import BN from '@/utils/bigNumber'
import { chargeSceneFields } from '@/enums/business'

export default {
  name: 'QcChargeList',
  components: {
    ChargeBox,
  },
  props: {
    // totalMoney: Number,
    accountMoney: Number,
    chargeForm: Object,
    receivableMoney: Number,
    giveChange: Number,
    handleCovert: Function,
    gasMeterCode: String,
    handleCharge: Function,
    dicts: Object,
    bizHallBalance: null,
    userBalance: null,
    isLimited: Boolean,
    scene: String,
    chargeItemList: Array,
    chargeType: String,
    settlementType: String,
    // handleReset: Function,
    sceneHandleCallBack: Function,
    amountMark: String,
    orderSourceName: String,
    manualInput: Boolean,
    handleEnd: Function,
    isCharge: Boolean,
    isAccountMeterMoney: Boolean,
    accountMeterMoney: null,
  },
  data() {
    return {
      customerCode: null,
      chargeNo: null,
      // chargeType: null,
      dialogFormVisible: false,
      //全部字段是否显示控制
      showMap: {
        prechargeMoney: false,
        rechargeMoney: false,
        rechargeGas: false,
        insurance: false,
        insuranceFlag: false,
        insurancePremium: false,
        insuranceData: false,
        invoiceValue: false,
        invoiceNo: false,
        chargeType: false,
        remark: false,
        receivableMoney: false,
        actualIncomeMoney: false,
        giveChange: false,
        replacementButton: false,
        transferButton: false,
        issueButton: false,
        disMeterButton: false,
        changeMeterButton: false,
        openAccountButton: false,
      },
      //不同场景需要显示的字段
      sceneMap: {
        //换表
        change_meter: [
          'invoiceValue',
          'invoiceNo',
          'chargeType',
          'accountBalance',
          'disBalance',
          'receivableMoney',
          'changeMeterButton',
          'actualIncomeMoney',
          'giveChange',
          'prechargeMoney',
          'deduct',
          'deductMoney',
        ],
        //开户
        open_account: [
          'invoiceValue',
          'invoiceNo',
          'chargeType',
          'receivableMoney',
          'actualIncomeMoney',
          'giveChange',
          'openAccountButton',
          'prechargeMoney',
        ],
        //过户
        transfer: [
          'invoiceValue',
          'invoiceNo',
          'chargeType',
          'receivableMoney',
          'actualIncomeMoney',
          'giveChange',
          'transferButton',
          'prechargeMoney',
        ],
        //补卡
        card_replacement: [
          'invoiceValue',
          'invoiceNo',
          'chargeType',
          'actualIncomeMoney',
          'receivableMoney',
          'giveChange',
          'replacementButton',
          'prechargeMoney',
          'deduct',
          'deductMoney',
        ],
        //发卡
        issue_card: [
          'rechargeGas',
          'rechargeMoney',
          // 'insurancePremium',
          // 'insuranceData',
          'prechargeMoney',
          'chargeType',
          'invoiceValue',
          'invoiceNo',
          'actualIncomeMoney',
          'receivableMoney',
          'giveChange',
          'issueButton',
          'deduct',
          'deductMoney',
        ],
        //拆表
        dis_meter: [
          'invoiceValue',
          'invoiceNo',
          'chargeType',
          'accountBalance',
          'disBalance',
          'receivableMoney',
          'disMeterButton',
          'actualIncomeMoney',
          'giveChange',
          'prechargeMoney',
          'deduct',
          'deductMoney',
        ],
      },
    }
  },
  computed: {
    //拆表换表时，是否出现充值框
    isShowCharge() {
      const { isAccountMeterMoney, accountMeterMoney } = this
      if (isAccountMeterMoney && BN.lt(accountMeterMoney, 0)) {
        // eslint-disable-next-line vue/no-side-effects-in-computed-properties
        this.chargeForm.rechargeMoney = -accountMeterMoney
        return true
      }
      return false
    },
    //发票编号 开关
    isManualInput() {
      const {
        manualInput,
        chargeForm: { invoiceValue },
      } = this
      if (invoiceValue.value !== 'ELECTRONIC_INVOICE') {
        return true
      }
      return manualInput && invoiceValue.value == 'RECEIPT'
    },
    //收费方式
    chargeMethod() {
      const chargeMethod = []
      if (this.dicts?.CHARGE_METHOD) {
        for (let i of Object.entries(this.dicts.CHARGE_METHOD)) {
          chargeMethod.push({ value: i[0], label: i[1] })
        }
      }
      return chargeMethod
    },
    //处理数字金额，没有时显示“ - ”
    handleMoney() {
      return money => {
        if (money) {
          return `<span class="text-danger font-bold">${money}</span>元`
        }
        return `-`
      }
    },
    //处理保险状态
    handleInsurance() {
      let { insuranceIsExpire, insuranceExpireDate, isBuyInsurance } = this.chargeForm
      if (!isBuyInsurance) {
        return `<span class="text-primary">未购买</span>`
      } else {
        if (insuranceIsExpire) {
          return `<span class="text-danger">已过期</span>`
        } else {
          return `<span class="text-success">未过期</span>`
        }
      }
    },
    //处理保险状态提示信息
    handleInsuranceText() {
      let { insuranceIsExpire, insuranceExpireDate, isBuyInsurance } = this.chargeForm
      if (!isBuyInsurance) {
        return `未购买保险`
      } else {
        if (insuranceIsExpire) {
          return `保险已过期，过期时间${insuranceExpireDate}`
        } else {
          return `保险未过期，到期时间${insuranceExpireDate}`
        }
      }
    },
    // 总金额
    totals: function () {
      let total = 0
      this?.chargeItemList.forEach((item, index, array) => {
        if (!item.isReductionItem) {
          total += item.chargeItemMoney
        } else {
          total -= item.chargeItemMoney
        }
      })
      this.$emit('setTotalMoney', total)
      return total
    },
  },
  created() {
    const { sceneMap, scene, showMap } = this
    sceneMap[scene].forEach(i => {
      showMap[i] = true
    })
  },
  methods: {
    closeDialog() {
      this.$loading().close()
      this.handleEnd()
    },
    //input框必须输入正整数，保留两位小数
    formatter(val, target) {
      this.chargeForm[target] = this.chargeForm[target]
        .replace(/[^\d.]/g, '')
        .replace(/\.{2,}/g, '.')
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3')
        .replace(/^\./g, '')
      //输入抵扣金额时，不得大于个人账户余额，或充值金额非禁用时不能大于充值金额
      if (target === 'deductMoney') {
        const {
          receivableMoney,
          chargeForm: { accountMoney },
        } = this
        if (BN.gte(val, receivableMoney) || BN.gte(val, accountMoney)) {
          this.chargeForm[target] = BN.gte(receivableMoney, accountMoney)
            ? accountMoney
            : receivableMoney
        }
      }
    },
    //处理收费方式
    handleChargeType() {
      const { chargeForm, receivableMoney } = this
      if (chargeForm.chargeType[0] !== 'CASH') {
        chargeForm.actualIncomeMoney = receivableMoney
      }
    },
    //把发票类型过滤掉“票据”
    filterinvoiceType(type) {
      return type.filter(item => {
        return item.value !== 'RECEIPT'
      })
    },
    //收费按钮
    chargeBtn() {
      const { chargeForm, receivableMoney, bizHallBalance, userBalance, chargeItemList } = this
      let flag = false
      chargeItemList.forEach(item => {
        if (BN.lte(item.chargeItemMoney, 0)) {
          flag = true
        }
      })
      if (flag) {
        this.$message({
          message: '收费项金额不能为0',
          type: 'warning',
        })
        return
      }
      if (this.isCharge && this.manualInput && chargeForm.invoiceValue.value == 'RECEIPT') {
        if (chargeForm.invoiceNo == '') {
          this.$message({
            message: '请填写发票编号',
            type: 'warning',
          })
          return
        }
      }
      //当有合计金额时，实收金额必填
      if (receivableMoney !== '' && receivableMoney !== 0) {
        if (chargeForm.actualIncomeMoney === '' || chargeForm.actualIncomeMoney === 0) {
          this.$message({
            message: '请填写实收金额！',
            type: 'warning',
          })
          return
        }
      }
      //发卡时可以不填写实收
      if (this.scene !== 'issue_card') {
        if (chargeForm.actualIncomeMoney === '') {
          this.$message({
            message: '实收金额未填写！',
            type: 'warning',
          })
          return
        }
        // if (chargeForm.actualIncomeMoney < receivableMoney) {
        //   this.$message({
        //     message: '实收金额不能小于应收金额！',
        //     type: 'warning',
        //   })
        //   return
        // }
        if (
          chargeForm.rechargeMoney === '' &&
          chargeForm.insurancePremium === '' &&
          chargeForm.prechargeMoney === '' &&
          !this.chargeItemList.length
        ) {
          this.$message({
            message: '请填写相关必要收费信息！',
            type: 'warning',
          })
          return
        }
      }
      if (this.isLimited) {
        if (receivableMoney > userBalance || receivableMoney > bizHallBalance) {
          this.$message({
            showClose: true,
            message: '应收超额！',
            type: 'warning',
          })
          return
        }
      }
      if (
        (chargeForm.insurancePremium &&
          !chargeForm.insuranceStartDate &&
          !chargeForm.insuranceEndDate) ||
        (!chargeForm.insurancePremium &&
          chargeForm.insuranceStartDate &&
          chargeForm.insuranceEndDate)
      ) {
        this.$message({
          showClose: true,
          message: '保险信息不完整！',
          type: 'warning',
        })
        return
      }
      if (BN.gt(chargeForm.giveChange, 100)) {
        this.$message({
          message: '找零不能大于100元',
          type: 'warning',
        })
        return
      }
      // 实收+抵扣 < 应收 ，提示：实收金额不足
      if (BN.lt(BN.plus([chargeForm.actualIncomeMoney, chargeForm.deductMoney]), receivableMoney)) {
        this.$message({
          message: '实收金额不足！',
          type: 'warning',
        })
        return
      }
      if (chargeForm.invoiceValue.value === 'RECEIPT') {
        //票据时
        this.handleCharge()
      } else {
        //非“票据”时
        this.handleCharge(this.handleInvoiceChargeBox)
      }
    },
    //处理抵扣时
    handleDeduct(val) {
      if (val) {
        this.chargeForm.prechargeMoney = ''
      } else {
        this.chargeForm.deductMoney = ''
      }
    },
    //显示chargeBox发票框
    handleInvoiceChargeBox({ customerCode, chargeId, chargeNo }) {
      this.customerCode = customerCode
      this.chargeId = chargeId
      this.chargeNo = chargeNo
      this.$loading().close()
      this.dialogFormVisible = true
    },
    closeChargeBox() {
      this.dialogFormVisible = false
      // this.handleReset()
      this.$loading().close()
      // this.sceneHandleCallBack()
    },
    //在dialog中拿不到ref，监听dialog打开时才可以拿到
    show() {
      this.$nextTick(() => {
        this.$refs.chargeBox.getBuyerTaxInfo(this.customerCode)
        this.$refs.chargeBox.getIdAndNo(this.chargeId, this.chargeNo)
      })
    },
    //处理零存按钮
    handlePrechargeMoney() {
      // let prechargeMoney = Number(this.chargeForm.prechargeMoney)
      // prechargeMoney = prechargeMoney + this.giveChange
      // if (prechargeMoney) {
      //   this.chargeForm.prechargeMoney = prechargeMoney
      // }
      this.chargeForm.prechargeMoney = BN.plus([this.chargeForm.prechargeMoney, this.giveChange])
    },
    //处理购买保险时
    handleChangeInsuranceFlag(val) {
      if (!val) {
        this.chargeForm.insurancePremium = ''
        this.chargeForm.insuranceStartDate = ''
        this.chargeForm.insuranceEndDate = ''
      }
    },
    // 处理保险日期
    handleDatePicker(val) {
      this.chargeForm.insuranceStartDate = val[0]
      this.chargeForm.insuranceEndDate = val[1]
    },
    //金额气量相互转换
    convert(val, type, target) {
      const vals = val
        .replace(/[^\d.]/g, '')
        .replace(/\.{2,}/g, '.')
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3')
        .replace(/^\./g, '')
      this.chargeForm[target] = vals
      this.handleCovert(vals, type)
    },
  },
}
</script>

<style lang="scss" scoped>
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
}
input[type='number'] {
  -moz-appearance: textfield;
}
.chargeForm {
  flex: 0 0 40%;

  ::v-deep .el-card__body {
    padding: 0;
  }

  .el-form-item {
    width: 49%;
    margin: 0 0 0 1%;
  }

  /* 收费结果 */
  .rechargeResult {
    overflow: hidden;
    clear: both;
    width: 100%;
    .el-form-item {
      width: 24%;
      float: left;
    }
  }

  ::v-deep .btnBox {
    margin-top: 10px;
    width: 100%;
    .el-form-item__content {
      margin-left: 0 !important;
    }
    .el-button {
      float: left;
      width: 47%;
      margin: 0;
      &:nth-child(2) {
        float: right;
        width: 48%;
      }
    }
  }
}
.no-border {
  border: 0 !important;
}
::v-deep .font-bold {
  font-weight: bold;
}
::v-deep .text-danger,
::v-deep .text-success,
::v-deep .text-primary {
  font-size: 12px;
}
::v-deep .grey {
  color: #909399;
}
::v-deep .inline-block {
  display: inline-block;
  margin-right: 5px;
}
.el-button--default {
  ::v-deep span {
    padding: 0 5px;
  }
}
.el-form-item__content {
  span {
    font-size: 12px;
  }
}
.el-date-editor ::v-deep .el-range__close-icon {
  display: none !important;
}
::v-deep .el-input-group__append {
  padding: 0 5px !important;
}
</style>