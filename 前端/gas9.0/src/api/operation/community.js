
/**
 * 地址配置api
 */
import axiosApi from '@/api/AxiosApi.js'
import areaApi from '../Area'

// 获取街道(乡镇)列表
export function getStreetList(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/address/street/page',
    params,
    data
  })
}

// 获取地区列表
export function getRegionList(data = {}, params = {}) {
  return areaApi.query(data)
}

// 获取有效街道的地区列表
export function getValidRegionList(params = {}) {
  return axiosApi({
    method: 'GET',
    url: '/authority/area/queryEx',
    params,
  })
}

// 保存街道(乡镇)信息
export function saveStreet(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/address/street/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/address/street/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 删除街道(乡镇)数据
export function deleteStreet(data, params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/address/street/delete',
    params,
    data
  })
}

// 获取小区(村、xx路)列表根据街道(乡镇)id
export function getCommunityList(data, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/address/community/page',
    params,
    data
  })
}

// 保存小区(村、xx路)信息
export function saveCommunity(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/address/community/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/address/community/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 删除街道(乡镇)数据
export function deleteCommunity(data, params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/address/community/delete',
    params,
    data
  })
}

// 获取详细地址列表根据小区(村、xx路)id
export function getDetailsAddressList(data, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/address/batchdetailedAddress/page',
    params,
    data
  })
}

// 保存详细地址信息
export function saveDetailsAddress(data, id = null,params = {}) {
  let method = 'POST'
  let url = '/bizcenter/operparam/address/batchdetailedAddress/saveDetailAddresss'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/operparam/address/batchdetailedAddress/update'
  }
  return axiosApi({
    method,
    url,
    params,
    data
  })
}

// 删除详细地址数据
export function deleteDetailsAddress(data, params = {}) {
  return axiosApi({
    method: 'DELETE',
    url: '/bizcenter/operparam/address/batchdetailedAddress/delete',
    params,
    data
  })
}

// 批量建址
export function batchAddAddress(data) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/operparam/address/batchdetailedAddress/batchAddresss',
    data
  })
}
