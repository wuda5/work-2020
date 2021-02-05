
/**
 * 表具档案api
 */
import axiosApi from '@/api/AxiosApi.js'

export default {
  // 通过表身号获取参数设置记录
  getIotDeviceParams(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iot/iotDeviceParams/queryByNumbers`,
      params,
      data,
    })
  },

  // 保存参数设置通过气表表身号
  saveData(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iot/iotDeviceParams/inputParamsBatch`,
      params,
      data,
    })
  },

  // 保存参数设置通过气表版号
  saveDataByVersion(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iot/iotDeviceParams/inputParamsByVersion`,
      params,
      data,
    })
  },
}
