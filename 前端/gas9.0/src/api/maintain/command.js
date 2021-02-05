/**
 *  指令维护接口
 */

import axiosApi from '@/api/AxiosApi.js'

export default {
  // 分页查询
  page (data) {
    return axiosApi({
      url: '/bizcenter/iot/command/queryCommand',
      method: 'post',
      data
    })
  },

  // 重试
  retry (data) {
    return axiosApi({
      url: '/bizcenter/iot/command/retry',
      method: 'post',
      data
    })
  },

  // 取消
  cancel (data) {
    return axiosApi({
      url: '/bizcenter/iot/command/cancel',
      method: 'post',
      data
    })
  },

  // 阀控指令
  valveControl (data) {
    return axiosApi({
      url: '/bizcenter/iot/business/valvecontrol',
      method: 'post',
      data
    })
  },

  // 调价
  changePricePlan (data) {
    return axiosApi({
      url: '/bizcenter/iot/business/changeprice',
      method: 'post',
      data
    })
  },

  // 移除设备
  removeMeter(data, params) {
    return axiosApi({
      url: '/bizcenter/iot/device/removemeter',
      method: 'post',
      data,
      params
    })
  },
}
