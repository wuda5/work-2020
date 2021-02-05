/**
 * 临时综合页面
 */

import cardApi from '@/api/card/index.js';
import dailyWorkApi from '@/api/dailyWork/index';
import { checkOpenAccountIsCharge, getCustomerByMeter } from '@/api/meterInfo/index';
import { default as Api, default as temporaryApi } from '@/api/temporary/index.js';
import { downloadOpenAccountTemplete } from '@/api/userInfo';
import ImportOpenAccount from '@/components/QcOpenAccount/Import.vue'; // 导入开户
// import QcOpenAccount from '@/components/QcOpenAccount/Index.vue'; // 单个开户
import QcOpenAccount from '@/components/QcOpenAccount/Step.vue'; // 单个开户(按步骤)
import ChangeGasType from '@/components/QcPopUpWindow/ChangeGasType'; // 用气类型变更
import ChangeMeter from '@/components/QcPopUpWindow/changeMeter'; // 换表
import DismantleMeter from '@/components/QcPopUpWindow/DismantleMeter'; // 拆表
import MeterTransfer from '@/components/QcPopUpWindow/MeterTransfer'; // 过户
import OpenGas from '@/components/QcPopUpWindow/OpenGas.vue'; // 通气
import RemoteControl from '@/components/QcPopUpWindow/RemoteControl'; // 远程控制
import AccountInfo from '@/components/QcTabsInfo/AccountInfo'; // 账户信息
import AccountMeter from '@/components/QcTabsInfo/AccountMeter'; // 账户信息
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo'; // 欠费明细
import BuyLimit from '@/components/QcTabsInfo/BuyLimit.vue'; // 购气限制信息
import CardInfo from '@/components/QcTabsInfo/CardInfo'; // IC卡信息,
import ChangeRecords from '@/components/QcTabsInfo/ChangeRecords.vue'; // 变更记录
// tabs
import CustomerDetails from '@/components/QcTabsInfo/CustomerDetails.vue'; // 客户信息
import InsuranceInfo from '@/components/QcTabsInfo/InsuranceInfo.vue'; // 保险信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails'; // 表具信息
import MeterStatusDetails from '@/components/QcTabsInfo/MeterStatusDetails.vue'; // 气表状态
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords'; // 缴费记录
import PricePlan from '@/components/QcTabsInfo/PricePlan'; // 气价方案
import RechargeRecords from '@/components/QcTabsInfo/RechargeRecords.vue'; // 充值记录
import SafeCheckInfo from '@/components/QcTabsInfo/SafeCheckInfo'; // 安检信息
import WorkOrder from '@/components/QcTabsInfo/WorkOrder'; // 工单信息
// add
// import OneMeterMultiFamily from './components/OneMeterMultiFamily' // 一表多户
import QcUpload from '@/components/QcUpload/index'; // 上传
import { dataStatusField } from '@/enums/common';
import { dictionaryCodeMap } from '@/enums/dictionary';
import hobbyMixin from '@/mixins/hobby.js';
import meterMixin from '@/mixins/meter';
import { initQueryParams } from '@/utils/commons';
import CardToZero from './components/CardToZero.vue'; // 卡清零
import Counter from './components/count/Index.vue'; // 统计模块
import GetCard from './components/GetCard'; // 发卡
// import InfoEdit from './components/InfoEdit' // 编辑
import InvoiceManage from './components/InvoiceManage'; // 发票管理
import OpenAnAccount from './components/openAccount/OpenAnAccount.vue'; // 开户
import OpenMoreAccount from './components/OpenMoreAccount'; // 批量开户
import PriceChange from './components/priceChange/Index.vue'; // 调价补差
import Reconciliation from './components/Reconciliation'; // 对账
import ReturnPremium from './components/ReturnPremium'; // 退费
// pop window
import TopSearchBox from './components/topSearch/SearchBox'; // 顶部搜索框

export default {
  name: 'Temporary',
  components: {
    TopSearchBox, // 顶部搜索框
    QcOpenAccount, // 单个开户
    ImportOpenAccount, // 导入开户
    ReturnPremium, // 退费
    InvoiceManage, // 发票管理
    CardToZero, // 卡清零
    QcUpload, // 上传
    // 本页面添加
    // OneMeterMultiFamily, // 一表多户
    // InfoEdit, // 编辑
    DismantleMeter, // 拆表
    ChangeMeter, // 换表
    GetCard, // 发卡
    MeterTransfer, // 过户
    OpenAnAccount, // 开户
    OpenMoreAccount, // 批量开户
    Reconciliation, // 对账
    PriceChange,//调价补差
    OpenGas, // 通气
    RemoteControl, // 远程控制
    ChangeGasType, // 用气类型变更

    // tabs
    CustomerDetails,
    MeterDetails,
    ChangeRecords, // 变更记录
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
    SafeCheckInfo,
    Counter, // 统计

  },
  mixins: [meterMixin, hobbyMixin],
  filters: {
  },
  data() {
    return {
      showCard: false, // 显示补卡
      showGas: false, // 显示补气
      cardReplaceData: null,
      gasReplaceData: null,
      // 燃气类型
      useGasType: [],
      //搜索条件
      searchCondition: this.initSearchCondition(),
      searchLoading: false,
      readCarLoading: false,
      // userList
      userList: [],
      userListTotal: 0,

      // 开户---------------------------
      openAccountDialogVisible: false,

      // 导入开户---------------------------
      importOpenAccountDialogVisible: false,
      openGasDialogVisible: false, // 通气弹出框标识
      remoteControlDialogVisible: false, // 远程控制弹出框标识
      showChangeGasType: false, // 用气类型变更
      showGetCard: false,  //开卡弹窗标识
      showCardReplacement: false,  //补卡弹窗标识
      showGasReplacement: false,   //补气弹窗标识

      // 当前选择的表具
      curMeter: null,
      customerInfoData: null, // 客户信息

      showUpload: false, // 上传

      // 场景收费
      step: 1, // 场景收费步骤，默认1 ，根据预检取得
      curBusinessId: '', // 当前业务ID

      // 过户---------------------------
      showMeterTransfer: false, // 过户
      transferCustomerCode: '', // 过户新用户的 code
      isCharge: false, // 是否收费
      openChargeFlag: false, // 开启输入缴费编号

      // 拆表
      showDismantleMeter: false, // 拆表

      // 换表
      showChangeMeter: false,

      // 卡回收
      showCardRecycle: false,

      // 调价补差
      showPriceChange: false, //调价补差弹窗
      showCheckPrice: true, // 显示调价补差核算记录
      openAccountProps: {}, // 开户收费组件传递props属性
      openAccountChargeLoading: false, // 开户收费loading
      // ==================================
      curTabsLabel: '客户信息', // 右侧当前点击标签名
      isShowCardFlag: false,

    }
  },
  computed: {
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
    //发卡按钮是否显示
    // isShowGetCard() {
    //   const { curMeter } = this
    //   let flag
    //   if (curMeter?.chargeType !== 'IC_RECHARGE') {
    //     flag = !curMeter || curMeter.sendCardStauts != 'WAITE_SEND'
    //   } else {
    //     flag = !curMeter || curMeter.dataStatus != 4 || curMeter.sendCardStauts != 'WAITE_SEND'
    //   }
    //   return flag
    // }
  },
  mounted() {
    this.getUseGasType()
  },
  methods: {
    getCardClose() {
      this.showGetCard = false
    },
    cardReplacementClose() {
      this.showCardReplacement = false
    },
    gasReplacementClose() {
      this.showGasReplacement = false
    },
    // 关闭弹出框
    dialogCloses(key) {
      this[key] = false
    },
    //卡回收点击
    recoverCard() {
      cardApi.recoverCard()
    },
    // 初始化搜索条件
    initSearchCondition() {
      return {
        customerChargeNo: '', // 缴费编号
        gasMeterNumber: '', // 表身号
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        gasMeterAddress: '', // 安装地址
        pageSize: 10, // 一页显示几条数据
        pageNo: 1, // 当前第几页
      }
    },

    // 获取客户类型
    getUseGasType() {
      Api.getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then(res => {
        const { isSuccess, data } = res.data

        if (isSuccess) {
          this.useGasType = data.records
        }
      })
    },

    handleClick(key) {
      (this.curMeter.gasCode && this.curMeter.customerCode) ? this.dialogOpen(key) : this.$message({
        message: '请先选择一个表具',
        type: 'warning'
      });
    },

    //设置按钮loading
    setLoading(load, bool) {
      this[load] = bool
    },
    // 搜索客户
    search(gasMeterCode) {
      this.curMeter = null
      gasMeterCode ? this.searchCondition.gasCode = gasMeterCode : this.searchCondition.gasCode = ''
      Api.list(this.searchCondition).then(res => {
        gasMeterCode ? this.readCarLoading = false : this.searchLoading = false
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.userList = data.records
          this.userListTotal = parseInt(data.total)
          this.$nextTick(() => {
            this.loadData()
          })
        }
      }).catch(err => {
        this.searchLoading = false
      }).finally(() => {
        this.readCarLoading = false
        this.searchLoading = false
      })
    },

    // 获取列表之后加载其它数据
    loadData() {
      const meter = this.userList.length === 1 ? this.userList[0] : null
      if (meter) {
        // 设置选中行高亮
        this.$refs.tableRef?.setCurrentRow(meter)
        this.rowClick(meter)
      } else {
        this.meterInfoData = null
      }
    },

    // 默认搜索
    searchDefault(gasMeterCode) {
      this.searchCondition.pageNo = 1
      this.searchCondition.pageSize = 10
      this.search(gasMeterCode)
    },

    //获取气表版号
    getMeterVersion(id) {
      return dailyWorkApi.getMeterVersionById(id)
    },

    // 客户列表表格行点击
    async rowClick(row) {
      this.curMeter = row

      // 处理户表显示
      this.handleHb(row.orderSourceName)
      // 处理欠费显示
      this.handleQf(row.orderSourceName)

      const res = await this.getMeterVersion(row.gasMeterVersionId)
      this.curMeter.chargeType = res.data.data.orderSourceName
      this.getCustomerInfoData()
      const { gasCode, customerCode } = this.curMeter
      await cardApi.watherIssueCard({ gasMeterCode: gasCode, customerCode: customerCode })
        .then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            const { data } = res.data
            this.isShowCardFlag = data
          }
        })
        .catch(err => {
          console.log(err)
        })
        .finally(() => {
          this.loading = false
        })
    },

    //补卡预检
    cardReplaceCheck() {
      const { gasCode, customerCode } = this.curMeter
      cardApi.repCard({ gasMeterCode: gasCode, customerCode }).then(res => {
        const { isSuccess } = res.data
        if (isSuccess) {
          this.cardReplaceData = res.data.data
          this.showCardReplacement = true
        }
      })
    },

    //补气预检
    gasReplaceCheck() {
      cardApi.repGascheck({ gasMeterCode: this.curMeter.gasCode, customerCode: this.curMeter.customerCode }).then(res => {
        const { isSuccess } = res.data
        if (isSuccess) {
          this.gasReplaceData = res.data.data
          this.showGasReplacement = true
        }
      })
    },

    // 过户预检
    meterTransfer() {
      let params = {
        customerCode: this.curMeter.customerCode,
        gasMeterCode: this.curMeter.gasCode
      }
      temporaryApi.transferAccountCheck(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.step = data.step || 1
          this.transferCustomerCode = data.busData ? data.busData.customerCode : ''
          this.showMeterTransfer = true
          this.isCharge = data.flag
          this.openChargeFlag = data.openChargeFlag
          // this.dialogOpen('showMeterTransfer')
        }
      })
    },

    // 拆表预检
    dismantleMeterCheck() {
      let params = {
        customerCode: this.curMeter.customerCode,
        gasMeterCode: this.curMeter.gasCode
      }

      temporaryApi.dismantleMeterCheck(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.step = data.step || 1
          this.curBusinessId = data.busData ? data.busData.id : ''
          this.showDismantleMeter = true
        }
      })

    },

    // 换表预检
    changeMeterCheck() {
      let params = {
        customerCode: this.curMeter.customerCode,
        oldMeterCode: this.curMeter.gasCode
      }
      temporaryApi.changeMeter(params).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.step = data.step || 1
          this.showChangeMeter = true
        }
      })
    },

    //  开户----------------------------------------
    // 开户成功后的回调
    handleOpenAccountSuccess(data) {
      console.log('开户成功后的回调', data)
      const customerCode = data?.customerCode ?? null
      // 如果是当前用户正在开户，则刷新表具信息
      if (customerCode && customerCode === this?.currentItem?.customerCode) {
        this.queryGasMeterFunc(this.currentItem)
      }
      // 关闭弹框
      this.openAccountDialogVisible = false
    },

    // 开户信息保存成功
    handleOpenAccountSaveSuccess(isRefresh = true) {
      if (isRefresh) {
        this.search()
      }
    },

    // 开户信息保存成功
    handleOpenAccountDialogClose(isRefresh) {
      // console.log('data', data)
      this.openAccountDialogVisible = false
    },

    // 导入开户信息成功
    handleImportOpenAccountSuccess() {
      this.currentItem = null
      this.multipleSelection = []
      this.gasMeterData = []
      this.resetSearch('searchFormRef')
      this.$nextTick(() => {
        this.importOpenAccountDialogVisible = false
      })
    },

    // 下载导入开户信息模板
    handleDownloadOpenAccountTemplateFile() {
      downloadOpenAccountTemplete().then((result) => {
        console.log('result', result)
      }).catch(() => {
      })
    },

    // 通气信息保存成功,更新数据
    handleOpenGasSuccess(data) {
      this.openGasDialogVisible = false
      this.search()
    },

    // 获取客户信息
    getCustomerInfoData() {
      return new Promise((resolve) => {
        getCustomerByMeter({ gasMeterCode: this.curMeter?.gasCode ?? null }).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.customerInfoData = data
            resolve(data)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    //关闭弹窗
    dialogClosePrice() {
      this.showPriceChange = false;
    },

    // 用气类型保存成功
    handleSaveUseGasTypeChangeSuccess() {
      this.showChangeGasType = false
      this.search()
    },

    // 打开开户收费弹窗
    async handleOpenAccountDialog(flag) {
      if (flag) {
        const result = await this.checkOpenAccountCharge()
        if (result) {
          this.openAccountProps = {
            step: 2,
            customerCode: this.customerInfoData?.customerCode,
            gasMeterCode: this.curMeter?.gasCode,
          }
          this.openAccountDialogVisible = true
        }
      } else {
        this.openAccountProps = {
          step: 1,
          customerCode: null,
          gasMeterCode: null,
        }
        this.openAccountDialogVisible = true
      }
    },

    // 是否开户收费了
    checkOpenAccountCharge() {
      this.openAccountChargeLoading = true
      return new Promise((resolve) => {
        checkOpenAccountIsCharge({}, { customerCode: this.customerInfoData?.customerCode, gasCode: this.curMeter?.gasCode }).then((response) => {
          const { isSuccess } = response.data
          // if (isSuccess) {

          // }
          resolve(isSuccess)
        })
          .catch(() => {
            resolve(false)
          })
          .finally(() => {
            this.openAccountChargeLoading = false
          })
      })
    },

    // 换表弹窗关闭回调
    handleChangeMeterDialogClose(isRefresh) {
      debugger
      this.showChangeMeter = false
      if (isRefresh) {
        this.search()
      }
    },

    // 换表成功回调
    handleChangeMeterSuccess(isRefresh) {
      if (isRefresh) {
        this.search()
      }
    },

    // 拆表弹窗关闭回调
    handleDismantleMeterSuccess(isRefresh = true) {
      if (isRefresh) {
        this.search()
      }
    },

    //中心计费物联网表预结算回退
    settlementReturn() {
      const srParmas = {
        customerCode: this.curMeter.customerCode,
        gasMeterCode: this.curMeter.gasCode,
        gasMeterNumber: this.curMeter.gasMeterNumber
      }
      temporaryApi.settlementReturn(srParmas).then(
        res => {
          console.log(res)
        }
      )
    },

    // 过户弹窗关闭回调
    handleMeterTransferSuccess(isRefresh = true) {
      if (isRefresh) {
        this.search()
      }
    },
    //清空搜索框
    resetSearchCondition() {
      this.searchCondition = {
        customerChargeNo: '', // 缴费编号
        gasMeterNumber: '', // 表身号
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        gasMeterAddress: '', // 安装地址
        pageSize: 10, // 一页显示几条数据
        pageNo: 1, // 当前第几页
      }
    },
  }
}
