
/**
 * 调价补差审核 api
 */

// @ts-ignore
import axiosApi from '@/api/AxiosApi.js'

// 分页查询调价补差记录列表
export function getListData(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/page',
      params,
      data
    })
  }

// 分页查询调价补差记录列表
export function page(data, params) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/adjustPrice/pageAdjustPrice',
    params,
    data
  })
}

//审核
export function examine(data, id = null,params = {}) {
    let method = 'POST'
    let url = '/bizcenter/adjustPrice/examine'
    return axiosApi({
      method,
      url,
      params,
      data
    })
  }

  // 核算
export function caculate(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/caculate',
      params,
      data
    })
  }

// 驳回
export function reject(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/reject',
      params,
      data
    })
  }

// 撤回
export function withdraw(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/withdraw',
      params,
      data
    })
  }

// 撤销收费
export function withdrawCharge(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/withdrawCharge',
      params,
      data
    })
  }