/**
 * 限购客户型配置
 */
import axiosApi from '@/api/AxiosApi.js'
export { getCommunityList, getStreetList } from './community'

// 获取限购配置列表
export function getBuyGasLimitData(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/customerlimit/purchaseLimit/page',
    params,
    data
  })
}

/**
 * 获取客户设备信息
 * @param {*} params
 * @param {*} isLimit 是否获取限制客户列表 
 */
export function getCustomerList(params, isLimit = false) {
  let url = '/bizcenter/operparam/customerlimit/customerList'
  if (isLimit) {
    url = '/bizcenter/operparam/customerlimit/limitList'
  }
  return axiosApi({
    method: 'POST',
    url,
    params,
    data: params
  })
}

// 增加限购客户
export function addCustomerLimit(data, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/customerlimit/saveList',
    params,
    data
  })
}

// 移出限购客户
export function removeCustomerLimit(params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/customerlimit/community/delete',
    params,
    data: params
  })
}