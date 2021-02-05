
/**
 * 调价补差核算 api
 */

// @ts-ignore
import axiosApi from '@/api/AxiosApi.js'

// 获取核算记录列表
export function getListData(data = {}, params = {}) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/adjustPrice/calculationTaskPage',
      params,
      data
    })
  }

//生成核算
export function adjustPriceData(data, id = null,params = {}) {
    let method = 'POST'
    let url = '/bizcenter/adjustPrice/generateAdjustPriceData'
    return axiosApi({
      method,
      url,
      params,
      data
    })
  }
  //重新生成核算
export function retryCaculation(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/adjustPrice/retry'
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 保存手动录入数据
export function saveAdjustPriceData(data, params) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/adjustPrice/manualAccount',
    params,
    data
  })
}

// 获取调价补差气表分页信息
export function getAdjustPriceMeterListData(data, params) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/archive/gasmeterarchive/gasMeter/findAdjustPriceGasMeterPage',
    params,
    data
  })
}
