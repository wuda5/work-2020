
/**
 * 优惠活动api
 */
import axiosApi from '@/api/AxiosApi.js'

// 获取列表
export function getListData(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/giveReduction/page',
    params,
    data
  })
}

// 保存信息
export function saveData(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/giveReduction/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/giveReduction/update'
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
    url: '/bizcenter/operparam/giveReduction/delete',
    params,
    data
  })
}