// 系统项目右侧兴趣点
import axiosApi from '@/api/AxiosApi.js'

/*
* tips:
* 为方便管理，模块API请写在对应的注释下面
*
* */
export default {
  // 客户信息 ------------------------------------------------------------------------

  // 表具信息 ------------------------------------------------------------------------

  // IC卡信息 ------------------------------------------------------------------------
  cardInfo(data) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/interestConcernsCard/getConcernsCardInfo`,
      data
    })
  },

  // 账户信息------------------------------------------------------------------------
  // 账户信息 （此处获取账户金额）
  accountInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/account/query`,
      data
    })
  },

  // serial 流水查询
  accountSerial(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/account/serial/page`,
      data
    })
  },

  // 气表状态 ------------------------------------------------------------------------

  // 欠费明细 ------------------------------------------------------------------------
  arrearsData(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/arrears/page`,
      data
    })
  },

  // 缴费信息(缴费记录) ------------------------------------------------------------------------
  paymentRecords(data) {
    return axiosApi({
      method: 'POST',
      // url: `/bizcenter/charges/pageChargeItemRecord`,
      url: `/bizcenter/interestConcerns/chargeList`,
      data
    })
  },

  // 充值记录 ------------------------------------------------------------------------
  rechargeRecords(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/getPageByMeterAndCustomerCode`,
      data
    })
  },

  // 保险信息 ------------------------------------------------------------------------

  // 气价方案 ------------------------------------------------------------------------
  priceScheme(data) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/operparam/gasprice/queryByGasMeterCode`,
      data
    })
  },

  // 工单信息 ------------------------------------------------------------------------

  // 限购信息 ------------------------------------------------------------------------
  buyGasLimit(data, params = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/operparam/gaslimit/pageCustomerLimitInfo`,
      params,
      data
    })
  },

  // 统计数据 ------------------------------------------------------------------------
  //获取变更记录
  getChangeRecord(data) {
    return axiosApi({
        method: 'GET',
        url: `/bizcenter/interestConcernsChange/getChangeRecord`,
        data
    })
  },

  // 户表信息 - 查询
  getAccountMeter(data) {
    return axiosApi({
        method: 'POST',
        url: `/bizcenter/iotAccount/query`,
        data
    })
  },
  // serial 流水查询
  getAccountMeterSerial(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iotAccount/serial/page`,
      data
    })
  },
}
