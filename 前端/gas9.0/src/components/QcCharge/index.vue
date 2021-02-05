<template>
  <div class="pr">
    <div class="header">
      <el-button v-if="isAccountMeterMoney" class="balance">
        气表余额：
        <span class="redFont">
          {{ (accountMeterMoney ? accountMeterMoney : '0.00') | moneyFormat(2) }}
        </span>
      </el-button>
      <el-button class="balance">
        个人账户余额：
        <span class="redFont">
          {{ chargeForm.accountMoney | moneyFormat(2) }}
        </span>
      </el-button>
    </div>
    <!-- 微信支付扫码框 -->
    <input
      v-if="isPayCode"
      ref="payInput"
      v-model="payCode"
      class="payInput"
      placeholder="请点击输入框扫码"
      type="text"
      @keyup.enter="postWeChartPay"
    />
    <button v-if="isPayCode" ref="payButton" type="primary" class="payCancer" @click="cancerPay">
      取消
    </button>
    <div v-loading="loading" style="display: flex">
      <ChargeTable
        :v-for="showTable"
        :waite-append-item-list="waiteAppendItemList"
        :charge-item-list="chargeItemList"
        :order-source-name="orderSourceName"
        :scene="scene"
        :is-charge="isCharge"
      />
      <ChargeList
        ref="chargelist"
        :scene="scene"
        :charge-item-list="chargeItemList"
        :charge-form.sync="chargeForm"
        :receivable-money="receivableMoney"
        :give-change="giveChange"
        :handle-covert="handleCovert"
        :handle-charge="handleCharge"
        :dicts="dicts"
        :biz-hall-balance="bizHallBalance"
        :user-balance="userBalance"
        :is-limited="isLimited"
        :scene-handle-call-back="sceneHandleCallBack"
        :amount-mark="amountMark"
        :order-source-name="orderSourceName"
        :manual-input="manualInput"
        :handle-end="handleEnd"
        :is-charge="isCharge"
        :is-account-meter-money="isAccountMeterMoney"
        :account-meter-money="accountMeterMoney"
      />
      <!-- :charge-type="chargeType"
      :settlement-type="settlementType" -->
    </div>
  </div>
</template>

<script>
import ChargeTable from './components/ChargeTable'
import ChargeList from './components/ChargeList'
import Api from '@/api/charges/index'
import { debounce } from 'lodash'
import { dictionaryCodeMap } from '@/enums/dictionary'
import print from '@/utils/print/print.js'
import BN from '@/utils/bigNumber'
import { chargeSceneFields } from '@/enums/business'
import { parseTime } from '@/utils/index'
import { omit } from 'lodash'

export default {
  name: 'QcCharge',
  components: {
    ChargeTable,
    ChargeList,
  },
  props: {
    scene: {
      type: String,
      default: 'card_replacement',
    },
    customerCode: String,
    gasMeterCode: String,
    chargeType: String,
    settlementType: {
      type: String,
      default: 'MONEY',
    },
    useGasTypeId: String,
    sceneHandle: Function,
    handleEnd: Function,
    bizNoOrId: String,
    needToPay: {
      default: null,
      type: Boolean,
    },
    customerChargeNo: null,
    arrearsDetailIds: {
      type: Array,
      default: null,
    },
  },
  data() {
    return {
      loading: true,
      //是否限额
      isLimited: false,
      //营业余额
      bizHallBalance: 40000,
      //操作员余额
      userBalance: 2500,
      //列表显示收费项
      chargeItemList: [],
      // 待添加收费项
      waiteAppendItemList: [],
      // 收费列表表单
      chargeForm: {
        prechargeMoney: '', //预存金额
        rechargeMoney: '', //充值金额
        rechargeGas: '', //充值气量
        isBuyInsurance: false, //是否购买保险 true购买 false未购买
        insuranceIsExpire: false, //保险是否已过期 true已过期 false未过期
        insuranceExpireDate: '', //保险到期日期
        insuranceEndDate: '', //保险到期日期
        insurancePremium: '', //保费金额
        insuranceStartDate: '', //保险开始日期
        insuranceFlag: false, //开启购买保险开关
        insuranceData: '', //保险日期绑定元素
        receivableMoney: '', //应收金额
        actualIncomeMoney: '', //实收金额
        invoiceType: [], //发票类型
        invoiceValue: { label: '票据', value: 'RECEIPT' }, //当前选中的发票
        invoiceNo: '', //发票编号
        remark: '', //备注
        chargeType: { value: 'CASH', label: '现金' }, //收费方式
        giveChange: '', //找零
        accountMoney: 0, //个人账户余额
      },
      //数据字典
      dicts: {
        CHARGE_METHOD: {},
        INVOICE_TYPE: {},
      },
      //结算类型
      // settlementType: 'MONEY',
      chargeRes: null,
      orderSourceName: null,
      amountMark: null,
      manualInput: null,
      isCharge: null,
      showTable: false,

      payCode: null, //客户付款码
      isPayCode: true, //是否加载客户付款码
      weChatParam: null, //微信收费参数
      timer: null, //轮询器
      timeout: 1000, //轮询时间
      chargeParams: null, //发起收费参数保存
      accountMeterMoney: null,
      covertMark: 'MONEY',
    }
  },
  computed: {
    //是否显示户表余额
    isAccountMeterMoney() {
      const { orderSourceName, scene } = this
      return (
        orderSourceName === 'CENTER_RECHARGE' && (scene === 'dis_meter' || scene === 'change_meter')
      )
    },
    //应收金额
    receivableMoney() {
      const { prechargeMoney, rechargeMoney, insurancePremium } = this.chargeForm
      let isReductionList = [],
        reductionList = []
      this.chargeItemList.forEach((item, index, array) => {
        if (!item.isReductionItem) {
          isReductionList.push(item.chargeItemMoney)
        } else {
          reductionList.push(item.chargeItemMoney)
        }
      })
      const total = BN.plusAndMinus(isReductionList, reductionList)
      return BN.plus([total, prechargeMoney, rechargeMoney, insurancePremium])
    },
    //找零
    giveChange() {
      let actualIncomeMoney = Number(this.chargeForm.actualIncomeMoney)
      const mns = BN.minus(this.receivableMoney, this.chargeForm.deductMoney)
      if (BN.gt(actualIncomeMoney, mns)) {
        return BN.plusAndMinus(
          [this.chargeForm.actualIncomeMoney],
          [mns]
        )
      }
      // let actualIncomeMoney = Number(this.chargeForm.actualIncomeMoney)
      // if (BN.gt(actualIncomeMoney, this.receivableMoney)) {
      //   return BN.plusAndMinus([this.chargeForm.actualIncomeMoney], [this.receivableMoney])
      //   // return +(Number(this.chargeForm.actualIncomeMoney) - this.receivableMoney).toFixed(2)
      // }
      return 0
    },
  },
  watch: {
    //监听微信支付码输入框显示时，添加到body下，dialog组件里必须这样
    isPayCode(n) {
      if (n) {
        this.$nextTick(() => {
          const body = document.querySelector('body')
          if (body.append) {
            body.append(this.$refs.payInput)
            body.append(this.$refs.payButton)
          } else {
            body.appendChild(this.$refs.payInput)
            body.appendChild(this.$refs.payButton)
          }
          this.$refs.payInput.focus()
        })
      }
    },
  },
  async mounted() {
    //初始化数据字典
    this.dicts = {
      CHARGE_METHOD: this.dictMap[dictionaryCodeMap.CHARGE_METHOD],
      INVOICE_TYPE: this.dictMap[dictionaryCodeMap.INVOICE_TYPE],
    }
    //初始化发票类型
    const invoiceType = []
    for (var i in this.dicts.INVOICE_TYPE) {
      invoiceType.push({
        value: i,
        label: this.dicts.INVOICE_TYPE[i],
      })
    }
    this.chargeForm.invoiceType = invoiceType
  },
  async created() {
    // this.$nextTick(() => {
    //   console.log(this.$refs.payInput)
    // })
    this.isPayCode = false
    Api.findGasMeterConfInfoByCode(this.gasMeterCode).then(res => {
      this.orderSourceName = res.data.data.orderSourceName
      this.amountMark = res.data.data.amountMark
    })
    this.getChargeList()
    //根据场景收费传入scene来控制的，没有使用 chargeSceneFields
    this.isCharge = this.needToPay
      ? this.needToPay
      : await this.whetherSceneCharge(this.scene?.toUpperCase())
    this.showTable = true
  },
  methods: {
    getChargeList() {
      const sceneType = this.scene?.toUpperCase()
      Api.loadByScene({
        customerCode: this.customerCode,
        gasMeterCode: this.gasMeterCode,
        sceneType,
        bizNoOrId: this.bizNoOrId,
        arrearsDetailIds: this.arrearsDetailIds,
      })
        .then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            const data = res.data.data
            this.manualInput = data.manualInput
            //设置收费列表表单数据
            this.accountMeterMoney = data.accountMeterMoney
            this.chargeForm = {
              ...this.chargeForm,
              ...{
                accountMoney: Number(data.accountMoney ? data.accountMoney : 0),
              },
            }
            //设置列表显示收费项数据
            const chargeItemList = []
            data.itemList.forEach(item => {
              chargeItemList.push({
                ...item,
                chargeItemName: item.chargeItemName,
                chargeItemMoney: Number(item.chargeItemMoney),
                moneyMethod: item.moneyMethod,
                isReductionItem: item.isReductionItem,
                chargeItemGas: Number(item.chargeItemGas),
                isInput: false,
              })
            })
            this.chargeItemList = chargeItemList
            //设置待添加收费项数据
            const waiteAppendItemList = []
            data.waiteAppendItemList.forEach(item => {
              waiteAppendItemList.push({
                ...item,
                chargeItemName: item.chargeItemName,
                chargeItemMoney: Number(item.chargeItemMoney),
                moneyMethod: item.moneyMethod,
                isReductionItem: item.isReductionItem,
                isInput: item.moneyMethod === 'fixed' ? false : true,
              })
            })
            this.waiteAppendItemList = waiteAppendItemList
            this.loading = false
          }
        })
        .catch(err => {
          this.loading = false
        })
    },
    //打印模板
    printTemplate(data) {
      print['GAS_BILL'](data)
    },
    //发起收费
    handleCharge(isReceipt) {
      const loading = this.$loading({
        lock: true,
        text: '收费中……',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.4);',
      })
      const { chargeForm, chargeItemList } = this
      let payableMoneyList = [],
        reductionMoneyList = []
      chargeItemList.forEach(i => {
        if (!i.isReductionItem) {
          //应缴金额：所有非减免收费项之和
          // payableMoney += i.chargeItemMoney
          payableMoneyList.push(i.chargeItemMoney)
        } else {
          //减免金额：所有减免收费项之和
          // reductionMoney += i.chargeItemMoney
          reductionMoneyList.push(i.chargeItemMoney)
        }
      })
      let params = {}
      params.customerCode = this.customerCode
      params.gasMeterCode = this.gasMeterCode
      params.itemList = chargeItemList
      params.chargeRecord = {
        actualIncomeMoney: chargeForm.actualIncomeMoney, //实收金额
        chargeMethodCode: chargeForm.chargeType.value ?? null, //	收费方式编码
        chargeMethodName: chargeForm.chargeType.label ?? null, //	收费方式名称
        giveChange: this.giveChange ?? null, //	找零
        remark: chargeForm.remark ?? null, //备注理由
        prechargeDeductionMoney: chargeForm.deductMoney,//预存抵扣
        chargeMoney: BN.minus(BN.plus(payableMoneyList), BN.plus(reductionMoneyList)), //收费金额
        customerCode: this.customerCode, //客户编号
        invoiceNo: chargeForm.invoiceNo, //发票编号
        prechargeMoney: chargeForm.prechargeMoney, //预存金额
        receivableMoney: this.receivableMoney, //	应收金额
        rechargeGas: chargeForm.rechargeGas === '' ? null : chargeForm.rechargeGas, //充值气量
        rechargeMoney: chargeForm.rechargeMoney === '' ? null : chargeForm.rechargeMoney, //充值金额
        invoiceType: chargeForm.invoiceValue.value, //开票类型
        insurancePremium: chargeForm.insurancePremium === '' ? null : chargeForm.insurancePremium, //	保险费
        insuranceStartDate: chargeForm.insuranceData[0] ?? null, //	保险开始日期
        insuranceEndDate: chargeForm.insuranceData[1] ?? null, //	保险到期日期
        payableMoney: BN.plus(payableMoneyList), //应缴金额	+
        reductionMoney: BN.plus(reductionMoneyList), //	减免金额	-
      }
      //发卡单独处理:单独传参，没有实收金额时，直接读写卡
      if (this.scene == 'issue_card') {
        params.isSendCard = true
        params.bizNoOrId = this.bizNoOrId
        if (chargeForm.actualIncomeMoney == '') {
          this.sceneHandle()
          return
        }
      }
      params.bizNoOrId = this.bizNoOrId
      //开户，过户场景收费需要传入 customerChargeNo
      if (this.scene == 'open_account' || this.scene == 'transfer') {
        params.chargeRecord.customerChargeNo = this.customerChargeNo
      }
      params.scene = this.scene?.toUpperCase()
      // console.log(params)
      this.chargeParams = params //保存支付参数，以备微信支付超时时使用
      params.ctype = this.covertMark
      params.arrearsDetailIds = this.arrearsDetailIds
      //如果是微信支付时
      if (params.chargeRecord.chargeMethodCode === 'WECHATPAY') {
        loading.text = '请出示付款码'
        this.weChatCharge({ isReceipt, loading })
        this.isPayCode = true
      } else {
        //非微信支付时
        Api.charge(params)
          .then(res => {
            this.chargeRes = res
            if (res.data.isSuccess) {
              //场景处理函数必须要回调
              this.sceneHandleCallBack(res, isReceipt)
            } else {
              loading.close()
            }
          })
          .catch(error => {
            console.log(error)
            loading.close()
          })
      }
    },
    //微信支付取消按钮
    cancerPay() {
      this.$loading().close()
      this.isPayCode = false
      this.payCode = null
    },
    //微信收费参数封装
    weChatCharge(chargeData) {
      // const { res, retry } = chargeData
      // if (retry) {
      //   //支付超时重试时重新获取chargeNo，及res结果
      //   this.weChatParam.productId = res.data.data.chargeRecord.chargeNo
      //   this.weChatParam.orderNumber = res.data.data.chargeRecord.chargeNo
      //   this.weChatParam.chargeData.res = res
      //   return
      // }
      // const { chargeItemList } = this
      // let detailStr = '',
      //   bodyText = `${this.scene}场景收费`
      // chargeItemList.forEach(item => {
      //   detailStr += `${item.chargeItemName ? item.chargeItemName : ``}; `
      // })
      const weChatParam = {
        //   productId: res.data.data.chargeRecord.chargeNo,
        //   orderNumber: res.data.data.chargeRecord.chargeNo,
        //   detail: detailStr,
        //   body: bodyText,
        chargeData,
      }
      this.weChatParam = weChatParam
    },
    //微信收费支付参数，时间方法，1分钟订单失效
    timeSection(section) {
      let date = new Date(),
        min = date.getMinutes(),
        timeSection = {}
      const rule = '{y}{m}{d}{h}{i}{s}'
      timeSection.timeStart = parseTime(date, rule)
      date.setMinutes(min + Number(section) / 60)
      timeSection.timeExpire = parseTime(date, rule)
      if (section) {
        this.weChatParam.timeSection = timeSection
      } else {
        return timeSection
      }
    },
    //发起微信支付请求
    postWeChartPay() {
      this.$loading().text = '扫码成功'
      this.isPayCode = false
      this.chargeParams.authCode = this.payCode
      this.chargeParams.testExpireSecend = 60
      Api.charge(this.chargeParams)
        .then(res => {
          this.chargeRes = res
          //收费成功
          if (res.data.isSuccess) {
            this.weChatParam.orderNumber = res.data.data.chargeRecord.chargeNo
            this.weChatParam.chargeData.res = res
            this.$loading().setText('查询支付结果中……')
            this.timeSection(res.data.data.expireSecend)
            this.orderquery()
          } else {
            this.$loading().close()
            this.cancerPay()
          }
        })
        .catch(error => {
          console.log(error)
          this.$loading().close()
        })
      // this.weChatParam.authCode = this.payCode
      // this.weChatParam = { ...this.weChatParam, ...this.timeSection() }
      // Api.wechatMicropay(omit(this.weChatParam, ['chargeData']))
      //   .then(res => {
      //     if (res.data.isSuccess) {
      //       this.orderquery()
      //     }
      //   })
      //   .catch(err => {
      //     console.log(err)
      //     this.$loading().close()
      //     this.isPayCode = false
      //   })
      //   .finally(() => {
      //     this.payCode = null
      //   })
    },
    //微信支付订单超时处理
    weChartTimeout() {
      this.$loading().setText('订单超时或扫码错误，请重试……')
      this.isPayCode = true
      this.payCode = null
      // this.$loading().setText('订单超时，重新生成订单中……')
      // Api.charge(this.chargeParams).then(res => {
      //   this.weChatCharge({ res, retry: true })
      //   this.$loading().setText('订单重新生产，请重新扫码')
      //   this.isPayCode = true
      // })
    },
    //轮询是否微信收费成功
    async orderquery(end) {
      this.isPayCode = false
      clearTimeout(this.timer)
      const endTime = Number(this.weChatParam.timeSection.timeExpire)
      const nowTime = Number(this.timeSection().timeStart)
      // console.log(this.weChatParam.timeExpire, this.timeSection().timeStart)
      // if (nowTime > endTime) {
      //   //超过订单有效时间处理
      //   this.weChartTimeout()
      //   return
      // }
      //如果最后一次查询，且超时，直接判定超时
      if (end && nowTime >= endTime) {
        this.weChartTimeout()
        return
      }
      //如果超时，再去查询一次
      if (nowTime >= endTime) {
        this.orderquery(true)
        return
      }
      //轮询请求 1s 3s 5s 5s 5s…… 直到超时
      Api.orderquery({ orderNumber: this.weChatParam.orderNumber })
        .then(res => {
          // console.log(this.timeSection.timeStart)
          const data = res.data.data
          if (res.data.isSuccess) {
            this.$loading().setText(data.trade_state_desc)
            if (data.trade_state === 'SUCCESS') {
              //支付成功，后续操作
              this.timeout = 1000
              clearTimeout(this.timer)
              // this.readCardAndInvoice({ ...this.weChatParam.chargeData })
              this.sceneHandleCallBack(
                this.weChatParam.chargeData.res,
                this.weChatParam.chargeData.isReceipt
              )
            } else {
              if (data.trade_state === 'PAYERROR') {
                //查询返回超时状态时
                clearTimeout(this.timer)
                this.weChartTimeout()
              } else {
                //非超时状态 支付不成功，继续查询
                this.timer = setTimeout(() => {
                  this.timeout = this.timeout > 3000 ? this.timeout : this.timeout + 2000
                  this.orderquery()
                }, this.timeout)
              }
            }
          }
        })
        .catch(err => {
          console.log(err)
          this.$loading().close()
        })
    },
    //场景处理函数必须要回调
    sceneHandleCallBack(res, isReceipt) {
      res = res ? this.chargeRes : res
      let that = this
      this.sceneHandle(() => {
        //非票据时，弹出发票弹窗
        if (isReceipt) {
          that.$loading().close()
          isReceipt({
            customerCode: that.customerCode,
            chargeId: res.data.data.chargeRecord.id,
            chargeNo: res.data.data.chargeRecord.chargeNo,
          })
        }
        //票据时直接打印
        else {
          Api.printReceiptLoad(res.data.data.chargeRecord.chargeNo).then(response => {
            const { isSuccess } = response.data
            if (isSuccess) {
              // console.log(response.data.data)
              this.$loading.text = '开始打印……'
              this.$loading.spinner = 'el-icon-loading'
              print['GAS_BILL'](response.data.data)
                .then(result => {
                  this.$loading().close()
                })
                .finally(() => {
                  this.$loading().close()
                  this.handleEnd()
                })
              // this.printTemplate(response.data.data)
            }
          })
        }
      })
    },
    //处理气量金额换算
    handleCovert(val, type) {
      if (this.gasMeterCode === '' || this.useGasTypeId === '') {
        return
      }
      if (!(this.orderSourceName == 'IC_RECHARGE' && this.amountMark == 'GAS')) {
        return
      }
      const typeMap = {
        MONEY: '金额换算成气量',
        GAS: '气量换算成金额',
      }
      const data = {
        conversionType: {
          code: type,
          desc: typeMap[type],
        },
        conversionValue: Number(val),
        gasMeterCode: this.gasMeterCode,
        useGasTypeId: this.useGasTypeId,
      }
      this.covertMark = type
      this.debounces(data, type)
    },
    //防抖 0.8s 查询一次
    debounces: debounce(function (data, type) {
      Api.convert(data).then(res => {
        const { isSuccess } = res.data
        if (isSuccess) {
          if (type === 'GAS') {
            this.chargeForm.rechargeMoney = (+res.data.data).toFixed(2)
          } else {
            this.chargeForm.rechargeGas = (+res.data.data).toFixed(2)
          }
        }
      })
    }, 800),
  },
}
</script>

<style lang="scss" scoped>
.payInput {
  width: 300px;
  position: fixed;
  top: 50%;
  left: 50%;
  z-index: 9999;
  transform: translate(-180px, -50%);
  margin-top: 80px;
  font-size: 26px;
  height: 50px;
  line-height: 50px;
  border-radius: 5px;
  border: 1px solid #409eff;
}
.payCancer {
  width: 80px;
  position: fixed;
  top: 50%;
  left: 50%;
  z-index: 9999;
  transform: translate(130px, -50%);
  margin-top: 80px;
  height: 50px;
  font-size: 18px;
  border:0;
  background: #409eff;
  color: #fff;
  border-radius: 5px;
}
.pr {
  position: relative;
}
.header {
  position: absolute;
  top: -53px;
  right: 10px;
  z-index: 3000;
}
.balance {
  background: #ebeef5;
  border: none;
}
</style>