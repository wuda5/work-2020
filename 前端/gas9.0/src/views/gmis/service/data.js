/**
 * 客服业务页面
 */

import QcFootMenu from '@/components/QcFootMenu/index'
// morInfo
import QcMeterInfo from '@/components/QcMeterInfo/index'
import QcMeterLocation from '@/components/QcMeterLocation' // 表地址信息
import AccountInfo from '@/components/QcTabsInfo/AccountInfo'
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo'
import BuyLimit from '@/components/QcTabsInfo/BuyLimit'
import CardInfo from '@/components/QcTabsInfo/CardInfo'
import ChangeRecords from '@/components/QcTabsInfo/ChangeRecords.vue' // 变更记录
import MeterState from '@/components/QcTabsInfo/MeterState'
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords'
import PricePlan from '@/components/QcTabsInfo/PricePlan'
import SecurityInfo from '@/components/QcTabsInfo/SafeCheckInfo'
import WorkOrder from '@/components/QcTabsInfo/WorkOrder'
import QcUserInfo from '@/components/QcUserInfo/index'
// pop window---------
import QcWorkOrder from '@/components/QcWorkOrder' // 创建工单
import ReturnVisit from './components/ReturnVisit' // 回访登记
import ServiceStatistics from './components/ServiceStatistics' // 统计模块

export default {
  name: 'Service',
  components: {
    QcFootMenu, // footMenu

    QcUserInfo, // 客户信息
    QcMeterInfo, // 表具信息
    // moreInfo
    PaymentRecords, // 缴费记录
    CardInfo, // IC卡信息
    SecurityInfo, // 安检信息
    AccountInfo, // 账户信息
    ArrearageInfo, // 欠费明细
    ChangeRecords, // 变更记录
    MeterState, // 气表状态
    PricePlan, // 气价方案
    WorkOrder, // 工单信息
    BuyLimit, // 限购信息
    //
    ServiceStatistics, // 统计
    QcWorkOrder, // 工单
    QcMeterLocation, // 表地址信息
    ReturnVisit // 回访登记

  },
  data() {
    return {
      // 用户信息
      userInfoData: {
        userNum: '2587425',
        userName: '徐有容',
        phone: '13978951257',
        userTpye: '居民',
        gasType: '民用',
        time: '2016-03-21',
        restMoney: '100.00',
        addr: '龙泉驿区3栋1单元25号'
      },
      // 表具信息
      meterInfoData: {
        meterNo: 124545,
        meterType: '卡表',
        meterCompany: '秦川',
        model: 'v1.5',
        version: '5A',
        gasDerection: '左近',
        regulatorBox: 'QC1.1',
        accountOpeningTime: '2011-11-17',
        gasUseTotal: 300,
        circleUse: 55,
        expiryDateInsurance: '2020-08-08',
        addr: '龙泉驿区3栋1单元25号'
      },

      // 收费表单
      chargeForm: {
        topUpValue: '',
        money: '',
        prestore: '',
        expiryDateInsurance: '',
        delivery: false,
        premium: '',
        invoiceNo: '',
        invoiceType: '',
        chargeWay: ''
        // amount:NaN

      },
      // 应收金额
      amountReceivable: 360,
      // 实收金额
      theSumReceived: '',
      // 找零
      changeMoney: 0,

      // 收费列表
      tableData: [
        {
          userID: '224545',
          name: '王小虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        },
        {
          userID: '65944',
          name: '王小虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        }
      ],
      // 收费列表
      chargeList: [
        {
          userID: '224545',
          name: '王虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        },
        {
          userID: '224545',
          name: '王小',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        },
        {
          userID: '224545',
          name: '王小',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        },
        {
          userID: '224545',
          name: '王小',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        },
        {
          userID: '65944',
          name: '王小虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        }
      ],
      total: 360,

      // 弹出相关
      showWorkOrder: false, // 创建工单
      showReturnVisit: false // 登记回访
    }
  },
  methods: {
    exportMsg(msg) {
      this.$message({
        message: msg,
        type: 'success'
      })
    },

    search(dd) {
      console.log(dd)
    },


    // 零存
    zeroStore() {
      console.log('零存')
    },

    // 实收金额
    receivedChange(val) {
      const receivedMoney = parseFloat(val)
      this.changeMoney = receivedMoney - this.amountReceivable
      console.log(val)
    },

    // 客户列表表格行点击
    rowClick(row, column, event) {
      console.log(row.userID)
      console.log(row, column, event)
    },

    // 表格赛选
    tableSelect(selection) {
      console.log(selection)
    },

    // 补卡
    dialogOpen(key) {
      this[key] = true
    },

    dialogClose(key) {
      // console.log(key)
      this[key] = false
    }
  }
}
