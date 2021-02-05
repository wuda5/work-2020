// 临时综合
import axiosApi from '@/api/AxiosApi.js'
// 引入日常综合 以便获取list 接口
import dailyWork from '@/api/dailyWork/index.js'
// 引入业务运营配置下 燃气类型接口
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  list(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/userarchive/customerGas/pagelistTwo`,
      data,
    })
  },
  getUseGasTypeList,

  // 过户===============================================================
  // 过户验证:如存在业务单则返回当前业务单，否则只返回表具编号
  transferAccountCheck(data) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/tempCounter/transferAccount/check`,
      data
    })
  },
  // 过户
  transferAccount(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/tempCounter/transferAccount`,
      data
    })
  },

  // 拆表===============================================================
  // 拆表记录检查(预检)
  dismantleMeterCheck(data) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/removeMeter/check`,
      data
    })
  },

  // 拆表
  dismantleMeter(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/removeMeter/add`,
      data
    })
  },

  // 拆表 支付完成后更新状态  不用了，支付成功后台后台修改
  dismantleMeterStatus(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/removeMeter/updateAfterPaid`,
      data
    })
  },

  // 换表 ===============================================================
  // 换表预检
  changeMeter(data) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/changeMeter/check`,
      data
    })
  },

  // 换表 查询气表状态 旧燃气表
  gasMeterStatus(data) {
    return axiosApi({
      method: 'GET',
      // url: `/bizcenter/archive/gasmeterarchive/gasMeter/getByGasMeterCode`,
      url: `/bizcenter/interestConcerns/getMeterInfo`,
      data
    })
  },

  // 换表 根据输入的表身号查询新表数据（主要用于显示厂家，版号和进气型号）
  // 如果无相关信息 数据库无此表，需要录入数据

  getNewMeterInfoByMeterCode(data) {
    return axiosApi({
      method: 'GET',
      // url: `/bizcenter/archive/gasmeterarchive/findgsaMeterByCode`,
      url: `/bizcenter/archive/gasmeterarchive/gasMeter/getEffectiveMeterByNumber`,
      data
    })
  },

  // 换表 新增换表记录
  changeMeterAdd(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/changeMeter/add`,
      data
    })
  },

  // 换表 气量金额换算
  changeMoneyConvert(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/calculate/convert`,
      data
    })
  },

  // 换表 中心计费物联网表结算抄表数据,返回户表余额
  costCenterRechargeMeter(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/changeMeter/costCenterRechargeMeter`,
      data
    })
  },

  // 场景是否收费
  whetherSceneCharge(sceneCode) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/charges/whetherSceneCharge`,
      params: {
        sceneCode
      }
    })
  },

  // 获取微信对账列表
  queryWeixinBill(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/pay/onlinepay/queryWeixinBill`,
      data
    })
  },
  // 导出微信对账列表
  exportWeixinBill(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/pay/onlinepay/wxBill/export',
      data
    })
  },

  //中心计费物联网表预结算回退 
  settlementReturn(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/changeMeter/settlementReturn',
      data
    })
  },

  // XX ===============================================================
  // XX ===============================================================

}
