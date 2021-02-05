/**
 * 日常综合页面
 */
import CardApi from '@/api/card/index';
import ChargeApi from '@/api/charges/index';
import Api from '@/api/dailyWork/index';
import { getUseGasTypeList } from '@/api/operation/gasPrice';
import AccountInfo from '@/components/QcTabsInfo/AccountInfo'; // 账户信息
import AccountMeter from '@/components/QcTabsInfo/AccountMeter'; // 账户信息
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo'; // 欠费明细
import BuyLimit from '@/components/QcTabsInfo/BuyLimit.vue'; // 购气限制信息
import CardInfo from '@/components/QcTabsInfo/CardInfo'; // IC卡信息,
import ChangeRecords from '@/components/QcTabsInfo/ChangeRecords.vue'; // 变更记录
// import { Card } from 'node_modules/element-ui/types/index';
// tabs
import CustomerDetails from '@/components/QcTabsInfo/CustomerDetails.vue'; // 客户信息
import InsuranceInfo from '@/components/QcTabsInfo/InsuranceInfo.vue'; // 保险信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails'; // 表具信息
import MeterStatusDetails from '@/components/QcTabsInfo/MeterStatusDetails.vue'; // 气表状态
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords'; // 缴费记录
import PricePlan from '@/components/QcTabsInfo/PricePlan'; // 气价方案
import RechargeRecords from '@/components/QcTabsInfo/RechargeRecords.vue'; // 充值记录
import WorkOrder from '@/components/QcTabsInfo/WorkOrder'; // 工单信息
import { dataStatusField } from '@/enums/common';
import { dictionaryCodeMap } from '@/enums/dictionary';
import hobbyMixin from '@/mixins/hobby.js';
import BN from '@/utils/bigNumber';
import { initQueryParams } from '@/utils/commons';
import { parseTime } from '@/utils/index';
import print from '@/utils/print/print.js';
import OneMeterMultiFamily from '@/views/gmis/temporary/components/OneMeterMultiFamily';
import TopSearchBox from '@/views/gmis/temporary/components/topSearch/SearchBox'; // 顶部搜索框
import { debounce } from 'lodash';
import ChargeBox from './components/ChargeBox'; // 收费
import ChargeList from './components/ChargeList'; // 收费下半部分
import ChargeTable from './components/ChargeTable'; // 收费上半部分表格
import DailyWorkStatistics from './components/DailyWorkStatistics'; // 图表134582123714885875
import InvoiceManage from './components/InvoiceManage/Index.vue'; // 发票管理
import ReturnPremium from './components/ReturnPremium'; // 退费
import SearchBox from './components/SearchBox'; // 顶部搜索框
import SettleAccounts from './components/SettleAccounts/Index.vue'; // 扎帐
import UserList from './components/UserList'; // 客户列表

export default {
  name: 'DailyWorkPage',
  directives: {
    focusInput: {
      inserted: function (el) {
        el.querySelector('input').focus()
      },
    },
  },
  mixins: [hobbyMixin],
  components: {
    ReturnPremium, // 退费
    InvoiceManage, // 发票管理
    ChangeRecords, // 变更记录
    SettleAccounts, // 扎帐
    ChargeBox, // 收费
    OneMeterMultiFamily, // 一表多户
    ChargeTable, // 收费上半部分表格
    ChargeList,  // 收费下半部分
    SearchBox,  //顶部搜索框
    UserList, //客户列表
    TopSearchBox,

    // tabs
    CustomerDetails,
    MeterDetails,
    MeterStatusDetails,
    InsuranceInfo, // 保险信息
    CardInfo,
    AccountInfo,
    AccountMeter,
    ArrearageInfo,
    PaymentRecords,
    RechargeRecords, // 充值记录
    PricePlan,
    WorkOrder,
    BuyLimit,
    DailyWorkStatistics, // 统计

  },
  data() {
    return {
      //营业余额
      bizHallBalance: '',
      //操作员余额
      userBalance: '',
      //页面高度
      clientHeight: this.initClientHeight(),
      //搜索框数据
      searchCondition: {
        customerChargeNo: '', // 缴费编号
        gasMeterNumber: '', // 表身号
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        // gasMeterAddress: '', // 安装地址
        moreGasMeterAddress: '',//
        pageSize: 2, //一页显示几条数据
        pageNo: 1, //当前第几页
      },
      paginations: {
        currentPage: 1,
        pageSize: 2,
        total: 2,
      },
      searchLoading: false,
      readCarLoading: false,
      // 客户列表
      tableData: [],
      // 收费列表表单
      chargeForm: {
        deduct: false, //是否使用账户抵扣
        deductMoney: '', // 抵扣金额
        prechargeMoney: '', //预存金额
        rechargeMoney: '', //充值金额
        rechargeGas: '', //充值气量
        rechargeActivityList: [], //充值活动
        rechargeActivityValueList: [], //选中的充值活动
        gives: 0, //活动赠送
        isBuyInsurance: false, //是否购买保险 true购买 false未购买
        insuranceIsExpire: false, //保险是否已过期 true已过期 false未过期
        insuranceExpireDate: '', //保险到期日期
        insuranceEndDate: '',	//保险到期日期
        insurancePremium: '',	//保费金额
        insuranceStartDate: '',	//保险开始日期
        insuranceFlag: false,//开启购买保险开关
        insuranceData: '', //保险日期绑定元素
        receivableMoney: '', //应收金额
        actualIncomeMoney: '', //实收金额
        invoiceType: [],//发票类型
        invoiceValue: { label: '票据', value: 'RECEIPT' },//当前选中的发票
        invoiceNo: '', //发票编号
        remark: '', //备注
        chargeType: { value: 'CASH', label: '现金' }, //收费方式
        giveChange: '',//找零
        accountMoney: 0, //个人账户余额
      },
      //总收费金额
      totalMoney: 0,
      // 待添加收费项
      waiteAppendItemList: [],
      //列表显示收费项
      chargeItemList: [],
      //用气类型
      useGasTypeId: '',
      //气表编号
      gasMeterCode: '',
      //用户编码
      customerCode: '',
      //结算类型
      orderSourceName: '',
      //数据字典
      dicts: {
        MONEY_METHOD: {},
        USER_TYPE: {},
        SETTLEMENT_TYPE: {},
        INVOICE_TYPE: {},
        CHARGE_METHOD: {},
        CHARGE_ITEM_TYPE: {},
      },
      //收费列表是否加载
      chargeLoading: false,
      //是否限额
      isLimited: true,
      // 金额标志
      amountMark: null,
      //发票编号是否可输入
      manualInput: null,
      useGasType: [], // 用气类型数组
      showInvoiceManage: false, // 发票管理
      showSettleAccounts: false, // 显示扎帐弹框标志
      curTabsLabel: '客户信息', // 右侧当前点击标签名
      currentRow: null, // 当前点击行数据
      accountMeterMoney: null,

      payCode: null, //客户付款码
      isPayCode: false,//是否加载客户付款码
      weChatParam: null,//微信收费参数
      timer: null, //轮询器
      timeout: 1000, //轮询时间
      chargeParams: null, //发起收费参数保存
      covertMark: 'MONEY',
      isOpenInsurance: null,
      userListloading: false,
      readData: null,
    };
  },
  mounted() {
    //初始化数据字典
    this.dicts = {
      MONEY_METHOD: this.dictMap[dictionaryCodeMap.MONEY_METHOD],
      USER_TYPE: this.dictMap[dictionaryCodeMap.USER_TYPE],
      SETTLEMENT_TYPE: this.dictMap[dictionaryCodeMap.SETTLEMENT_TYPE],
      INVOICE_TYPE: this.dictMap[dictionaryCodeMap.INVOICE_TYPE],
      CHARGE_METHOD: this.dictMap[dictionaryCodeMap.CHARGE_METHOD],
      CHARGE_ITEM_TYPE: this.dictMap[dictionaryCodeMap.CHARGE_ITEM_TYPE],
    }
    //初始化发票类型
    const invoiceType = []
    for (var i in this.dicts.INVOICE_TYPE) {
      invoiceType.push({
        value: i,
        label: this.dicts.INVOICE_TYPE[i]
      })
    }
    this.chargeForm.invoiceType = invoiceType
  },
  created() {
    this.isLimitedLoad()
    this.getUseGasType()
  },
  activated() {
    this.search()
  },
  computed: {
    //应收金额
    receivableMoney() {
      const { prechargeMoney, rechargeMoney, deductMoney, insurancePremium } = this.chargeForm
      return BN.plus(
        [this.totalMoney, prechargeMoney, rechargeMoney, insurancePremium]
      )
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
    },
    //收费金额+充值金额+保险金额
    deductKey() {
      const {
        chargeForm: { insurancePremium, rechargeMoney }, totalMoney
      } = this
      return BN.plus([insurancePremium, rechargeMoney, totalMoney])
    }
  },
  watch: {
    receivableMoney(newV) {
      // const { deductMoney } = this.chargeForm
      // this.chargeForm.actualIncomeMoney = deductMoney != '' ? BN.minus(newV, deductMoney) : newV
      if (this.chargeForm.chargeType.value != 'CASH') {
        this.chargeForm.actualIncomeMoney = newV
      }
    },
    'deductKey'(newV) {
      if (this.chargeForm.deduct && (newV <= this.chargeForm.accountMoney)) {
        this.chargeForm.deductMoney = newV
        return
      }
      if (this.chargeForm.deduct) {
        this.chargeForm.deductMoney = this.chargeForm.accountMoney
      }
    },
  },
  methods: {
    //卡清零点击
    recoverCard() {
      CardApi.recoverCard()
    },
    //获取操作员/营业额  是否限额
    isLimitedLoad() {
      Api.limitLoad().then(res => {
        const { isSuccess } = res.data
        if (isSuccess) {
          const { userBalance, bizHallBalance } = res.data.data
          if (userBalance == -1 || bizHallBalance == -1) {
            this.isLimited = false
          }
          this.userBalance = userBalance == -1 ? ' 未限额 ' : userBalance
          this.bizHallBalance = bizHallBalance == -1 ? ' 未限额 ' : bizHallBalance
        }
      }).catch(err => {
        console.log(err)
      })
    },
    //初始化高度
    initClientHeight() {
      return document.documentElement.clientHeight - 144
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
      let payableMoneyList = [], reductionMoneyList = []
      chargeItemList.forEach(i => {
        if (!i.isReductionItem) { //应缴金额：所有非减免收费项之和
          payableMoneyList.push(i.chargeItemMoney)
        } else {  //减免金额：所有减免收费项之和
          reductionMoneyList.push(i.chargeItemMoney)
        }
      })
      let params = {}
      params.customerCode = this.customerCode
      params.gasMeterCode = this.gasMeterCode
      params.itemList = chargeItemList
      params.activityList = chargeForm.rechargeActivityValueList
      params.chargeRecord = {
        actualIncomeMoney: chargeForm.actualIncomeMoney,//实收金额
        chargeMethodCode: chargeForm.chargeType.value ?? null,//	收费方式编码
        chargeMethodName: chargeForm.chargeType.label ?? null,//	收费方式名称
        giveChange: this.giveChange ?? null,//	找零
        remark: chargeForm.remark,//备注理由
        chargeMoney: this.totalMoney,//收费金额
        customerCode: this.customerCode,//客户编号
        invoiceNo: chargeForm.invoiceNo,//发票编号
        prechargeDeductionMoney: chargeForm.deductMoney,//预存抵扣
        prechargeMoney: chargeForm.prechargeMoney,//预存金额
        receivableMoney: this.receivableMoney,//	应收金额
        rechargeGas: chargeForm.rechargeGas === '' ? null : chargeForm.rechargeGas,//充值气量
        rechargeMoney: chargeForm.rechargeMoney === '' ? null : chargeForm.rechargeMoney,//充值金额
        invoiceType: chargeForm.invoiceValue.value,//开票类型
        insurancePremium: chargeForm.insurancePremium === '' ? null : chargeForm.insurancePremium,//	保险费
        insuranceStartDate: chargeForm.insuranceData[0] ?? null,//	保险开始日期
        insuranceEndDate: chargeForm.insuranceData[1] ?? null,//	保险到期日期
        payableMoney: BN.plus(payableMoneyList),//应缴金额	+
        reductionMoney: BN.plus(reductionMoneyList),//	减免金额	-
      }
      let eGives = this.$refs.chargelist.existGives.toString()
      let existGives = eGives === '-'
        ? null
        : eGives.substring(0, eGives.length - 1)
      if (this.orderSourceName !== 'IC_RECHARGE') { //充值赠送气量
        params.chargeRecord.rechargeGiveMoney = existGives
      } else {
        if (this.amountMark === 'MONEY') { //充值赠送金额
          params.chargeRecord.rechargeGiveMoney = existGives
        } else {
          params.chargeRecord.rechargeGiveGas = existGives
        }
      }
      params.useAccountDec = chargeForm.deduct  //是否抵扣
      this.chargeParams = params //保存支付参数，以备微信支付超时时使用
      params.ctype = this.covertMark
      //如果是微信支付时
      if (params.chargeRecord.chargeMethodCode === 'WECHATPAY') {
        loading.text = '请出示付款码'
        this.weChatCharge({ isReceipt, loading })
        // this.weChatParam = params
        this.isPayCode = true
      } else {
        //非 微信支付
        Api.charge(params).then(res => {
          //收费成功
          if (res.data.isSuccess) {
            loading.text = '收费成功……'
            this.readCardAndInvoice({ isReceipt, res, loading })
          } else {
            loading.close()
          }
        }).catch(error => {
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
    //卡表并且充值时才读写卡  微信支付成功后，后续流程
    readCardAndInvoice({ isReceipt, res, loading }) {
      const { chargeForm } = this
      if (this.orderSourceName === 'IC_RECHARGE' && Number(chargeForm.rechargeMoney) > 0) {
        this.handleGasCard(() => {
          this.openInvoiceBox(isReceipt, res) ? null : this.printReceiptLoad(res, loading)
        })
      } else {
        this.openInvoiceBox(isReceipt, res) ? null : this.printReceiptLoad(res, loading)
      }
      this.isLimitedLoad()
    },
    //微信收费参数封装
    weChatCharge(chargeData) {
      // const { res, retry } = chargeData
      //   if (retry) {   //支付超时重试时重新获取chargeNo，及res结果
      //     this.weChatParam.productId = res.data.data.chargeRecord.chargeNo
      //     this.weChatParam.orderNumber = res.data.data.chargeRecord.chargeNo
      //     this.weChatParam.chargeData.res = res
      //     return
      //   }
      //   const { chargeItemList } = this
      //   let detailStr = '', bodyText = '柜台收费'
      //   chargeItemList.forEach(item => {
      //     detailStr += `${item.chargeItemName ? item.chargeItemName : ``}; `
      //   })
      const weChatParam = {
        // productId: res.data.data.chargeRecord.chargeNo,
        // orderNumber: res.data.data.chargeRecord.chargeNo,
        // detail: detailStr,
        // body: bodyText,
        chargeData
      }
      this.weChatParam = weChatParam
    },
    //微信收费支付参数，时间方法，1分钟订单失效
    timeSection(section) {
      let date = new Date(), min = date.getMinutes(), timeSection = {}
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
      Api.charge(this.chargeParams).then(res => {
        //收费成功
        if (res.data.isSuccess) {
          this.weChatParam.orderNumber = res.data.data.chargeRecord.chargeNo
          this.weChatParam.chargeData.res = res
          this.$loading().setText('查询支付结果中……')
          this.timeSection(res.data.data.expireSecend)
          // debugger
          this.orderquery()
        } else {
          this.$loading().close()
          this.cancerPay()
        }
      }).catch(error => {
        console.log(error)
        this.$loading().close()
      })
      // this.weChatParam.authCode = this.payCode
      // this.weChatParam = { ...this.weChatParam, ...this.timeSection() }
      // ChargeApi.wechatMicropay(omit(this.weChatParam, ['chargeData'])).then(res => {
      //   if (res.data.isSuccess) {
      //     this.orderquery()
      //   }
      // }).catch(err => {
      //   console.log(err)
      //   this.$loading().close()
      //   this.isPayCode = false
      // }).finally(() => {
      //   this.payCode = null
      // })
    },
    //微信支付订单超时处理
    weChartTimeout() {
      this.$loading().setText('订单超时或扫码错误，请重试……')
      this.isPayCode = true
      this.payCode = null
      // Api.charge(this.chargeParams).then(res => {
      //   this.weChatCharge({ res, retry: true })
      //   this.$loading().setText('订单重新生成，请重新扫码')
      //   this.isPayCode = true
      // })
    },
    //轮询是否微信收费成功
    async orderquery(end) {
      this.isPayCode = false
      clearTimeout(this.timer)
      const endTime = Number(this.weChatParam.timeSection.timeExpire)
      const nowTime = Number(this.timeSection().timeStart)
      // console.log(nowTime)
      //如果最后一次查询，且超时，直接判定超时
      if (end && nowTime >= endTime) {
        this.weChartTimeout()
        return
      }
      //如果超时，再去查询一次
      if (nowTime >= endTime) {
        this.orderquery(true)
        // debugger
        return
      }
      //轮询请求 1s 3s 5s 5s 5s…… 直到超时
      ChargeApi.orderquery({ orderNumber: this.weChatParam.orderNumber }).then(res => {
        // console.log(this.timeSection.timeStart)
        const data = res.data.data
        if (res.data.isSuccess) {
          this.$loading().setText(data.trade_state_desc)
          if (data.trade_state === 'SUCCESS') {
            //支付成功，后续操作
            this.timeout = 1000
            clearTimeout(this.timer)
            this.payCode = null
            // debugger
            this.readCardAndInvoice({ ...this.weChatParam.chargeData })
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
        } else {
          this.$loading().setText('查询错误，请重试')
          this.weChartTimeout()
        }
      }).catch(err => {
        console.log(err)
        this.$loading().close()
      })
    },
    //发票类型非票据时，收费成功后弹窗发票弹窗
    openInvoiceBox(isReceipt, res) {
      if (isReceipt) {
        isReceipt({
          customerCode: this.customerCode,
          chargeId: res.data.data.chargeRecord.id,
          chargeNo: res.data.data.chargeRecord.chargeNo
        })
        return true
      }
      return false
    },
    //打印发票
    printReceiptLoad(res, loading) {
      Api.printReceiptLoad(res.data.data.chargeRecord.chargeNo).then(
        response => {
          const { isSuccess } = response.data
          if (isSuccess) {
            loading.text = '开始打印……'
            loading.spinner = 'el-icon-loading'
            try {
              this.printTemplate(response.data.data)
            } catch (error) {
              loading.close()
              this.$message.error('未安装打印插件')
            }
            this.handleReset()
            setTimeout(() => {
              loading.close()
              this.$message({
                message: '收费完成！',
                type: 'success',
              })
            }, 1200);
          }
        }
      )
    },
    //购气写卡操作
    async handleGasCard(callBack) {
      const result = await CardApi.shakeHandsSocket({
        shakeOne: CardApi.buyGasLoad,
        shakeTwo: CardApi.buyGasCallBack,
        code: this.gasMeterCode,
        customerCode: this.customerCode,
        callBack: () => {
          console.log('购气写卡成功！')
          callBack()
        },
      }).finally(() => {
        this.handleReset()
      })
    },
    //重置按钮
    handleReset() {
      this.chargeForm = {
        ...this.chargeForm, ...{
          deduct: false,
          deductMoney: '',
          prechargeMoney: '',
          rechargeMoney: '',
          rechargeGas: '',
          rechargeActivityList: [],
          rechargeActivityValueList: [],
          gives: 0,
          isBuyInsurance: false,
          insuranceIsExpire: false,
          insuranceExpireDate: '',
          insuranceEndDate: '',
          insurancePremium: '',
          insuranceStartDate: '',
          insuranceFlag: false,
          insuranceData: '',
          receivableMoney: '',
          actualIncomeMoney: '',
          invoiceValue: { label: '票据', value: 'RECEIPT' },
          invoiceNo: '',
          remark: '',
          chargeType: { value: 'CASH', label: '现金' },
          giveChange: '',
          accountMoney: 0,
        }
      }
      this.totalMoney = 0
      this.waiteAppendItemList = []
      this.chargeItemList = []
      this.useGasTypeId = ''
      this.gasMeterCode = ''
      this.orderSourceName = ''
    },
    //设置总收费金额
    setTotalMoney(money) {
      this.totalMoney = money
    },
    //设置按钮loading
    setLoading(load, bool) {
      this[load] = bool
    },
    //搜索客户（表具）
    search(gasMeterCode, readData) {
      this.readData = readData
      this.handleReset()
      gasMeterCode ? this.searchCondition.gasCode = gasMeterCode : this.searchCondition.gasCode = ''
      const params = JSON.parse(JSON.stringify(this.searchCondition))
      for (let i in params) { //将空字符串过滤为null
        if (params[i] === '') {
          params[i] = null
        }
      }
      Api.list(params).then(res => {
        const { isSuccess } = res.data
        if (isSuccess) {
          gasMeterCode ? this.readCarLoading = false : this.searchLoading = false

          this.currentRow = null
          this.tableData = res.data.data.records
          this.paginations.currentPage = Number(res.data.data.current)
          this.paginations.pageSize = Number(res.data.data.size)
          this.paginations.total = Number(res.data.data.total)
        }
      }).finally(() => {
        this.readCarLoading = false
        this.searchLoading = false
      })
    },
    //清空搜索框
    resetSearchCondition() {
      this.searchCondition = {
        customerChargeNo: '', // 缴费编号
        gasMeterNumber: '', // 表身号
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        moreGasMeterAddress: '',//
        pageSize: 2, //一页显示几条数据
        pageNo: 1, //当前第几页
      }
    },
    // 默认搜索
    searchDefault(gasMeterCode, readData) {
      this.searchCondition.pageNo = 1
      this.searchCondition.pageSize = 2
      this.search(gasMeterCode, readData)
    },
    //根据当前页码搜索
    searchByCurrentPage(page) {
      this.searchCondition.pageNo = page
      this.search()
    },
    //获取收费列表数据
    async handleChargeList(row) {
      let loadParmas = { customerCode: row.customerCode, gasMeterCode: row.gasCode }
      let next = false
      if (row.orderSourceName === 'IC_RECHARGE') {
        if (!this.readData) {
          this.userListloading = true
          //如果是IC卡时，要读卡
          const res = await CardApi.readCar((code, readData) => {
            loadParmas.readData = readData
            this.userListloading = false
          }, () => {
            this.handleReset()
            this.userListloading = false
            next = true
          })
          this.userListloading = false
        } else {
          loadParmas.readData = this.readData
        }
      }
      if (next) { return }
      //  else if (row.orderSourceName === 'IC_RECHARGE' && this.isReadCardSearch){
      //   loadParmas.readData = readData
      // }
      // debugger
      // console.log(loadParmas)
      this.handleReset()
      this.currentRow = row
      // console.log(this.currentRow)
      this.chargeLoading = true
      this.gasMeterCode = row.gasCode
      this.useGasTypeId = row.useGasTypeId
      this.customerCode = row.customerCode
      Api.getMeterVersionById(row.gasMeterVersionId).then(res => {
        const { amountMark, orderSourceName } = res.data.data
        this.orderSourceName = orderSourceName
        this.amountMark = amountMark
      })
      Api.load(loadParmas).then(res => {
        const { isSuccess } = res.data
        // console.log('-----------')
        if (isSuccess) {
          //如果是haveNoWriteCardRecord 为true，代表上次读写卡失败，立即在读写卡即可
          if (res.data.data.haveNoWriteCardRecord) {
            // console.log(this.gasMeterCode, this.customerCode)
            this.$confirm('是否重新写卡？', '提示', {
              confirmButtonText: '确定',
              showCancelButton: false,
              type: 'warning',
            }).then(() => {
              //读写卡
              CardApi.shakeHandsSocket({
                shakeOne: CardApi.buyGasLoad,
                shakeTwo: CardApi.buyGasCallBack,
                code: this.gasMeterCode,
                customerCode: this.customerCode,
                callBack: () => {
                  console.log('购气写卡成功！')
                  this.chargeLoading = false
                  this.$loading().close()
                  this.$message.success('写卡成功！')
                  // callBack()
                },
              }).finally(() => {
                this.handleReset()
                this.chargeLoading = false
                this.$loading().close()
              })
            })
          }
          const data = res.data.data
          this.isOpenInsurance = data.isOpenInsurance
          // this.customerCode = row.customerCode
          this.manualInput = data.manualInput
          this.accountMeterMoney = data.accountMeterMoney
          //设置收费列表表单数据
          this.chargeForm = {
            ...this.chargeForm, ...{
              accountMoney: Number(data.accountMoney ? data.accountMoney : 0),
              insuranceExpireDate: data.insuranceExpireDate,
              insuranceIsExpire: data.insuranceIsExpire,
              isBuyInsurance: data.isBuyInsurance,
              totalMoney: data.totalMoney,
            }
          }
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
              isInput: item.moneyMethod === 'fixed' ? false : true,
            })
          })
          this.chargeItemList = chargeItemList
          //设置活动列表
          if (data.rechargeActivityList.length !== 0) {
            const rechargeActivityList = []
            data.rechargeActivityList.forEach(item => {
              rechargeActivityList.push({
                ...item,
                activityId: item.activityId,
                activityName: item.activityName,
                activityMoneyType: item.activityMoneyType,
                activityPercent: item.activityPercent,
                activityMoney: item.activityMoney,
                giveGas: item.giveGas
              })
            })
            this.chargeForm.rechargeActivityList = rechargeActivityList
          }
          this.chargeLoading = false
        } else {
          this.handleReset()
        }
      }).catch(error => {
        this.chargeLoading = false
      }).finally(() => {
        this.chargeLoading = false
        this.readData = null
      })

      // 处理户表显示
      this.handleHb(row.orderSourceName)
      // 处理欠费显示
      this.handleQf(row.orderSourceName)
    },
    //处理气量金额换算
    handleCovert(val, type) {
      if (this.gasMeterCode === '' || this.useGasTypeId === '') {
        return
      }
      if (!(this.orderSourceName == 'IC_RECHARGE' && this.amountMark == 'GAS')) {
        return
      }
      //orderSourceName !== 'IC_RECHARGE' && amountMark !== 'GAS'
      const typeMap = {
        MONEY: '金额换算成气量',
        GAS: '气量换算成金额'
      }
      const data = {
        conversionType: {
          code: type,
          desc: typeMap[type]
        },
        conversionValue: Number(val),
        gasMeterCode: this.gasMeterCode,
        useGasTypeId: this.useGasTypeId
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
    // 获取客户类型
    getUseGasType() {
      getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then(res => {
        const { isSuccess, data } = res.data

        if (isSuccess) {
          this.useGasType = data.records
        }
      })
    },
  },
};
