// 统计（注意：所以统计接口都放在此处）
import axiosApi from '@/api/AxiosApi.js'

export default {
  // 日常综合-------------------------------------

  // 发票统计(包含数量和金额)
  DInvoiceData(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/biz/sts/invoiceDay/invoiceTypeSts`,
      data,
    })
  },

  // 获取收费金额
  DChargeData(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/feiDay/chargeFeiByPayType',
      data,
    })
  },
  // 获取退费金额
  DChargeRefundData(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/feiDay/refundFeiByPayType',
      data,
    })
  },

  // 临时综合-------------------------------------
  //柜台临时综合_柜台统计
  TaccountSts(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/accountNow/accountNowTypeFrom',
      data,
    })
  },

  // 抄表业务-------------------------------------

  // 普表抄表
  RGeneralGasMeter(data) {
    return axiosApi({
      method: 'POST',
      // url: '/bizcenter/sts/meterPlanNow/generalGasMeter',
      url: '/bizcenter/sts/meterPlanNow/generalGasMeterReadSts',
      data,
    })
  },

  // 物联网抄表
  RInternetGasMeter(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/sts/meterPlanNow/internetGasMeter',
      data,
    })
  },

  // 表具档案-------------------------------------
  // 统计表具的信息
  MeterSts(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/meterNow/stsInfo',
      data,
    })
  },

  // 客户档案-------------------------------------
  // 客户信息统计
  UCustomer(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/customerNow/stsCustom',
      data,
    })
  },

  // 统计报表分析-------------------------------------

  // 业绩看板 - 售气数据
  getStsGasDetail(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/gasSell/stsGasDetail',
      data,
    })
  },

  // 业绩看板 - 财务数据
  SFinanceData(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/performancePanel/stsAllFinance',
      data,
    })
  },

  // 业绩看板-柜台人员统计
  SStaffCounter(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/performancePanel/counterStaff',
      data,
    })
  },

  // 业绩看板-柜台人员统计
  SReadMeterCounter(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/performancePanel/stsReadMeter',
      data,
    })
  },

  // ===========

  // 客户信息看板-客户分类统计
  SCustomerType(data) {
    return axiosApi({
      method: 'POST',
      // url: '/bizcenter/biz/sts/customerNow/panel/stsCustomType',
      url: '/bizcenter/biz/sts/customerNow/panel/stsCustomTypeCompare',
      data,
    })
  },

  // 客户信息看板-客户增量统计
  SCustomerAdd(data) {
    return axiosApi({
      method: 'POST',
      // url: '/bizcenter/biz/sts/customerNow/panel/stsCustomAddType',
      url: '/bizcenter/biz/sts/customerNow/panel/stsCustomAddTypeCompare',
      data,
    })
  },

  // 客户信息看板-保险购买分类统计
  SInsureType(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/insureNow/panel/insureNowByTypeCompare',
      data,
    })
  },

  // 客户信息看板-限购统计
  SCustomerLimit(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/customerNow/panel/stsCustomPurchaseLimitCompare',
      data,
    })
  },

  // ===========

  // 售气收费看板-用气类型统计
  SUseGas(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/gasFeiNow/panel/gasFeiTypeCompare',
      data,
    })
  },

  // 售气收费看板-阶梯方案统计
  StairPlan(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/gas/totalStsMonthCompare',
      data,
    })
  },

  // 售气收费看板-发票张数统计 | 发票金额统计
  SinvoiceCount(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/invoiceDay/panel/panelInvoiceKindCompare',
      data,
    })
  },

  // 售气收费看板-收费统计
  Scharge(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/feiDay/panel/chargeFeeByTypeCompare',
      data,
    })
  },
  // 售气收费看板-支付方式统计
  SpaymentType(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/feiDay/panel/chargeFeeByPayTypeCompare',
      data,
    })
  },
  // 查询系统所有的机构
  getOrgList() {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/biz/sts/org/allOnlineOrg'
    })
  },
}
