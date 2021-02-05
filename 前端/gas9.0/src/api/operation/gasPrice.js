/**
 * 气价配置
 */

import axiosApi from '@/api/AxiosApi.js'

// 获取用气类型列表
export function getUseGasTypeList(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/gasprice/useGasType/page',
    params,
    data
  })
}

// 保存用气类型信息
export function saveUseGasType(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/useGasType/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/useGasType/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 删除街道(乡镇)数据
export function deleteUseGasType(data, params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/gasprice/useGasType/delete',
    params,
    data
  })
}

// 获取价格信息列表
export function getPriceList(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/gasprice/priceScheme/page',
    params,
    data
  })
}

// 保存价格信息
export function savePrice(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/priceScheme/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/priceScheme/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 保存阶梯价格
export function saveLadderPrice(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/priceScheme/addLadder'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/priceScheme/updateLadder'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 保存固定价格
export function saveFixedPrice(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/priceScheme/addFixed'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/priceScheme/updateFixed'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 保存采暖价格
export function saveHeatingPrice(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/priceScheme/addHeating'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/priceScheme/updateHeating'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 获取滞纳金信息列表
export function getLateFeeList(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/gasprice/penalty/page',
    params,
    data
  })
}

// 保存滞纳金信息
export function saveLateFee(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gasprice/penalty/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gasprice/penalty/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 远程批量调价
export function adjustmentPrice(data) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/iot/business/changebatprice',
    data
  })
}
