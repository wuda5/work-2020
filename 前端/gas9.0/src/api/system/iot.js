/**
 *  厂家网关配置接口
 */

import axiosApi from '@/api/AxiosApi.js'

export default {
  // 分页查询
  page (data) {
    return axiosApi({
      url: '/bizcenter/operparam/iotubscribe/iotubscribeconfig/page',
      method: 'post',
      data
    })
  },

  // 保存
  save (data, params = {}) {
    let url = '/bizcenter/operparam/iotubscribe/iotubscribeconfig/add'
    let method = 'post'
    if (data.id) {
      url = '/bizcenter/operparam/iotubscribe/iotubscribeconfig/update'
      method = 'post'
    }
    return axiosApi({
      url,
      method,
      params,
      data
    })
  }
}
