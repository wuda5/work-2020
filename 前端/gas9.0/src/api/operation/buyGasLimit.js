
/**
 * 购气限制配配置api
 */
import axiosApi from '@/api/AxiosApi.js'

// 获取列表
export function getListData(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/gaslimit/purchaseLimit/page',
    params,
    data
  })
}

// 保存信息
export function saveData(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/gaslimit/purchaseLimit/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/gaslimit/purchaseLimit/update'
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
    url: '/bizcenter/operparam/gaslimit/purchaseLimit/delete',
    params,
    data
  })
}