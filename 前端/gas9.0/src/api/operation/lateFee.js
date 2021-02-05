/**
 * 滞纳金配置
 */
import axiosApi from '@/api/AxiosApi.js'
export { getUseGasTypeList } from './gasPrice'

// 获取列表
export function getListData(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/gasprice/penalty/page',
    params,
    data
  })
}

// 保存信息
export function saveData(data, id = null,params = {}) {
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

// 删除数据
export function deleteData(data, params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/gasprice/penalty/delete',
    params,
    data
  })
}