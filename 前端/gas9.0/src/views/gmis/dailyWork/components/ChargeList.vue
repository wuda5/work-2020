<!-- 收费列表下半部分表格 -->
<template>
  <el-card
    shadow="never"
    class="no-border chargeForm"
    :class="orderSourceName === 'READMETER_PAY' ? 'mb23' : ''"
  >
    <el-form
      label-position="left"
      class="jh-text"
      :disabled="gasMeterCode === ''"
      :model="chargeForm"
      label-width="52px"
      :rules="rules"
    >
      <!-- <el-form-item label="账户抵扣">
        <el-switch v-model="chargeForm.deduct" @change="handleDeduct"></el-switch>
      </el-form-item>
      <el-form-item label="抵扣金额">
        <div v-html="handleMoney(chargeForm.deductMoney)"></div>
      </el-form-item>
      <el-form-item label="收费金额">
        <div v-html="handleMoney(totalMoney)"></div>
      </el-form-item>
      <el-form-item label="预存金额">
        <el-input
          v-model="chargeForm.prechargeMoney"
          :disabled="chargeForm.deduct"
          @input="val => formatter(val, 'prechargeMoney')"
        >
          <el-button slot="append" @click="handlePrechargeMoney">零存</el-button>
        </el-input>
      </el-form-item> -->
      <el-form-item :label="`收费金额`" style="display: none">
        <div v-html="handleMoney(totalMoney)"></div>
      </el-form-item>
      <div v-if="orderSourceName !== 'READMETER_PAY'" class="isReadBox">
        <el-form-item label="充值金额">
          <el-input
            v-model="chargeForm.rechargeMoney"
            :disabled="orderSourceName === 'READMETER_PAY'"
            @input="val => convert(val, 'MONEY', 'rechargeMoney')"
          />
        </el-form-item>
        <el-form-item label="充值气量">
          <el-input
            v-model="chargeForm.rechargeGas"
            :disabled="!(orderSourceName == 'IC_RECHARGE' && amountMark == 'GAS')"
            @input="val => convert(val, 'GAS', 'rechargeGas')"
          />
        </el-form-item>
        <el-form-item label="充值活动">
          <el-select
            v-model="chargeForm.rechargeActivityValueList"
            multiple
            collapse-tags
            clearable
            placeholder="无"
            value-key="activityId"
            :disabled="amountMark === 'READMETER_PAY'"
          >
            <el-option
              v-for="item in chargeForm.rechargeActivityList"
              :key="item.activityId"
              :label="item.activityName"
              :value="item"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="活动赠送">
          <div>{{ existGives }}</div>
        </el-form-item>
      </div>
      <el-form-item v-if="isOpenInsurance" label="保险状态">
        <div class="inline-block" v-html="handleInsurance"></div>
        <el-tooltip effect="dark" :content="handleInsuranceText" placement="top">
          <div class="inline-block"><i class="el-icon-warning-outline grey" /></div>
        </el-tooltip>
      </el-form-item>
      <el-form-item v-if="isOpenInsurance" label="购买保险">
        <el-switch
          v-model="chargeForm.insuranceFlag"
          @change="handleChangeInsuranceFlag"
        ></el-switch>
      </el-form-item>
      <el-form-item v-if="isOpenInsurance" label="保费金额" prop="insurancePremium">
        <el-input
          v-model="chargeForm.insurancePremium"
          :disabled="!chargeForm.insuranceFlag"
          @input="val => formatter(val, 'insurancePremium')"
        />
      </el-form-item>
      <el-form-item v-if="isOpenInsurance" label="保险时间">
        <el-date-picker
          v-model="chargeForm.insuranceData"
          type="daterange"
          range-separator="-"
          start-placeholder="开始"
          end-placeholder="结束"
          format="yyyy-MM-dd"
          value-format="yyyy-MM-dd"
          :disabled="!chargeForm.insuranceFlag"
          :clearable="false"
          @change="handleDatePicker"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item label="发票类型">
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
      <el-form-item label="票据编号">
        <el-input v-model="chargeForm.invoiceNo" :disabled="!isManualInput" />
      </el-form-item>
      <el-form-item label="收费方式">
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
      <el-form-item label="备注">
        <el-input v-model="chargeForm.remark" />
      </el-form-item>
      <el-form-item label="预存金额">
        <el-input
          v-model="chargeForm.prechargeMoney"
          :disabled="chargeForm.deduct"
          @input="val => formatter(val, 'prechargeMoney')"
        >
          <el-button slot="append" :disabled="chargeForm.deduct" @click="handlePrechargeMoney">零存</el-button>
        </el-input>
      </el-form-item>
      <el-form-item label="应收金额">
        <div v-html="handleMoney(receivableMoney)"></div>
      </el-form-item>
      <el-form-item label="账户抵扣">
        <el-switch v-model="chargeForm.deduct" @change="handleDeduct"></el-switch>
      </el-form-item>
      <el-form-item label="抵扣金额">
        <!-- <div v-html="handleMoney(chargeForm.deductMoney)"></div> -->
        <el-input
          v-model="chargeForm.deductMoney"
          :disabled="!chargeForm.deduct"
          @input="val => formatter(val, 'deductMoney')"
        />
      </el-form-item>
      <el-form-item label="实收金额">
        <el-input
          v-model="chargeForm.actualIncomeMoney"
          :disabled="chargeForm.chargeType.value !== 'CASH'"
          @input="val => formatter(val, 'actualIncomeMoney')"
        />
      </el-form-item>
      <el-form-item label="找零">
        <div v-html="handleMoney(giveChange)"></div>
      </el-form-item>
      <el-form-item label=" " class="btns">
        <el-button type="primary" @click="reset">重置</el-button>
      </el-form-item>
      <el-form-item label=" " class="btns">
        <el-button type="danger" @click="chargeBtn">收费</el-button>
      </el-form-item>
      <!-- <el-form-item class="btnBox">
        <el-button type="primary" @click="reset">重置</el-button>
        <el-button type="danger" @click="chargeBtn">收费</el-button>
      </el-form-item> -->
    </el-form>
    <el-dialog title="收费" :visible.sync="dialogFormVisible" @open="show" @close="closeDialog">
      <ChargeBox
        v-if="dialogFormVisible"
        ref="chargeBox"
        :invoice-no-from-list="chargeForm.invoiceNo"
        :invoice-value-from-list="chargeForm.invoiceValue"
        :invoice-type="filterinvoiceType(chargeForm.invoiceType)"
        :total-money="receivableMoney"
        :close-charge-box="closeChargeBox"
      />
    </el-dialog>
  </el-card>
</template>

<script>
import ChargeBox from './ChargeBox'
import BN from '@/utils/bigNumber'
import ChargeListVue from '@/components/QcCharge/components/ChargeList.vue'

export default {
  name: 'DailyWorkChargeList',
  components: {
    ChargeBox,
  },
  props: {
    totalMoney: Number,
    accountMoney: Number,
    chargeForm: Object,
    receivableMoney: Number,
    giveChange: Number,
    handleCovert: Function,
    handleReset: Function,
    gasMeterCode: String,
    handleCharge: Function,
    dicts: Object,
    orderSourceName: String,
    deductKey: Number,
    bizHallBalance: null,
    userBalance: null,
    isLimited: Boolean,
    chargeItemList: Array,
    amountMark: String,
    manualInput: Boolean,
    waiteAppendItemList: Array,
    accountMeterMoney: null,
    isOpenInsurance: null,
  },
  data() {
    const reg = /^[1-9]+\d*(\.\d{0,2})?$|^0?\.\d{0,2}$/
    const moneyCheck = (rule, value, callback) => {
      if (!reg.test(value)) {
        callback(new Error('金额格式错误'))
      } else {
        callback()
      }
    }
    return {
      customerCode: null,
      chargeNo: null,
      chargeType: null,
      dialogFormVisible: false,
      rules: {
        prechargeMoney: [{ validator: moneyCheck, trigger: 'blur' }],
        actualIncomeMoney: [{ validator: moneyCheck, trigger: 'blur' }],
        insurancePremium: [{ validator: moneyCheck, trigger: 'blur' }],
      },
    }
  },
  computed: {
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
    //活动赠送
    existGives() {
      const { rechargeActivityValueList } = this.chargeForm
      let gives = 0,
        txt = `元`
      const temp = []
      if (this.orderSourceName == 'IC_RECHARGE' && this.amountMark == 'GAS') {
        txt = `方`
        //气表时
        for (let i of rechargeActivityValueList) {
          switch (i.activityMoneyType) {
            case 'unfixed':
              gives += 0
              break
            case 'fixed':
              // gives += Number(i.giveGas)
              temp.push(i.giveGas)
              break
            case 'percent':
              // gives += (+Number(i.activityPercent).toFixed(2) / 100) * this.chargeForm.rechargeGas
              temp.push(BN.times(BN.percent(i.activityPercent), this.chargeForm.rechargeGas))
              break
          }
        }
        gives = temp.length ? BN.plus(temp) : gives
        if (gives == 0) {
          return `-`
        } else {
          let result = BN.toFixed(gives, 3).toString()
          return Number(result.substring(0, result.length - 1)) + '方'
        }
      } else {
        //金额表时  非固定金额时未处理
        for (let i of rechargeActivityValueList) {
          switch (i.activityMoneyType) {
            case 'unfixed':
              gives += 0
              break
            case 'fixed':
              // gives += Number(i.activityMoney)
              temp.push(i.activityMoney)
              break
            case 'percent':
              // gives += (+Number(i.activityPercent).toFixed(2) / 100) * this.chargeForm.rechargeMoney
              temp.push(BN.times(BN.percent(i.activityPercent), this.chargeForm.rechargeMoney))
              break
          }
        }
      }
      gives = temp.length ? BN.plus(temp) : gives
      if (gives == 0) {
        return `-`
      } else {
        let result = BN.toFixed(gives, 3).toString()
        return Number(result.substring(0, result.length - 1)) + txt
      }
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
  },
  updated() {
    if (this.chargeForm.actualIncomeMoney === 0) {
      this.chargeForm.actualIncomeMoney = ''
    }
  },
  methods: {
    closeDialog() {
      this.$loading().close()
      this.handleReset()
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
    //重置按钮
    reset() {
      this.handleReset()
    },
    //收费按钮
    chargeBtn() {
      const {
        chargeForm,
        receivableMoney,
        bizHallBalance,
        userBalance,
        chargeItemList,
        waiteAppendItemList,
        orderSourceName,
        accountMeterMoney,
      } = this
      let flag = false
      // return
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
      if (this.manualInput && chargeForm.invoiceValue.value == 'RECEIPT') {
        if (chargeForm.invoiceNo == '') {
          this.$message({
            message: '请填写发票编号',
            type: 'warning',
          })
          return
        }
      }
      if (chargeForm.actualIncomeMoney === '') {
        this.$message({
          message: '实收金额未填写！',
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
      if (this.isLimited) {
        const lok = BN.minus(chargeForm.actualIncomeMoney, this.existGives)
        if (BN.gt(lok, userBalance) || BN.gt(lok, bizHallBalance)) {
          this.$message({
            showClose: true,
            message: '应收超额！',
            type: 'warning',
          })
          return
        }
      }
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
      if (BN.gt(chargeForm.giveChange, 100)) {
        this.$message({
          message: '找零不能大于100元',
          type: 'warning',
        })
        return
      }
      //待收费列表中有燃气费（code==gasfee）时，不能预存金额
      const ispre = waiteAppendItemList.filter(item => {
        return item.chargeItemSourceCode === 'GASFEE'
      })
      if (ispre.length && BN.gt(chargeForm.prechargeMoney, 0)) {
        this.$message({
          message: '有未缴纳的燃气费不能预存',
          type: 'warning',
        })
        return
      }
      //当中心计费表欠费
      if (orderSourceName === 'CENTER_RECHARGE' && BN.lt(accountMeterMoney, 0)) {
        //充值金额有且大于0时
        if (chargeForm.rechargeMoney !== '' && BN.gt(chargeForm.rechargeMoney, 0)) {
          //欠费大于等于充值金额时,不够冲正时
          if (BN.agt(accountMeterMoney, chargeForm.rechargeMoney)) {
            let warnText = BN.gt(chargeForm.prechargeMoney, 0)
              ? '未充值或者充值金额不能冲正欠费，不能预存'
              : '未充值或者充值金额不能冲正欠费，请完成所有欠费缴纳'
            this.$message({
              message: warnText,
              type: 'warning',
            })
            return
          }
        } else {
          //无充值金额时
          this.$message({
            message: '存在欠费，请充值',
            type: 'warning',
          })
          return
        }
        // if (chargeForm.rechargeMoney === '' && BN.lte(chargeForm.rechargeMoney, 0)) {
        //   this.$message({
        //     message: '有欠费金额，不能预存，请充值',
        //     type: 'warning',
        //   })
        //   return
        // } else {
        //   if(BN.agte(accountMeterMoney, chargeForm.rechargeMoney)){
        //     this.$message({
        //       message: '充值金额不够冲正户表欠费金额，不能预存',
        //       type: 'warning',
        //     })
        //     return
        //   }
        // }
      }
      if (chargeForm.invoiceValue.value === 'RECEIPT') {
        //票据时
        this.handleCharge()
      } else {
        //非“票据”时
        this.handleCharge(this.handleInvoiceChargeBox)
      }
    },
    //显示chargeBox发票框
    handleInvoiceChargeBox({ customerCode, chargeId, chargeNo }) {
      this.customerCode = customerCode
      this.chargeId = chargeId
      this.chargeNo = chargeNo
      this.dialogFormVisible = true
    },
    closeChargeBox() {
      this.dialogFormVisible = false
      this.$loading().close()
      this.handleReset()
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
      this.chargeForm.prechargeMoney = BN.plus([this.chargeForm.prechargeMoney, this.giveChange])
    },
    //处理抵扣时
    handleDeduct(val) {
      if (val) {
        this.chargeForm.prechargeMoney = ''
      } else {
        this.chargeForm.deductMoney = ''
      }
      // const { chargeForm, receivableMoney, totalMoney, deductKey } = this
      // chargeForm.deductMoney = val ? chargeForm.accountMoney : 0
      // //抵扣超过应收时
      // if (deductKey < chargeForm.deductMoney) {
      //   // chargeForm.deduct = false
      //   chargeForm.deductMoney = deductKey
      // }
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
.isReadBox {
  width: 100%;
  display: flex;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
}
input[type='number'] {
  -moz-appearance: textfield;
}
.mb23 {
  .el-form-item {
    margin-bottom: 23px !important;
  }
}
.chargeForm {
  margin-top: 10px;

  ::v-deep .el-card__body {
    padding: 0;
  }

  .el-form-item {
    width: 24.4%;
    margin: 3px 0.3% 13px 0.3%;
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
::v-deep .btns {
  .el-form-item__label {
    display: none;
  }
  .el-form-item__content {
    margin-left: 0 !important;
  }
  .el-button {
    width: 100%;
  }
}
::v-deep .el-select__tags {
  .el-tag {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    &:first-child {
      width: 80%;
    }
  }
}
</style>