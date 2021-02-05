
/**
 * 表具档案api
 */
import axiosApi from '@/api/AxiosApi.js'
import { fileStreamDownload } from '@/api/File'
import factoryApi from '@/api/system/gasMeterFactory'
import versionApi from '@/api/system/gasMeterVersion'
import modelApi from '@/api/system/gasModel'
import axios from 'axios'
export { getCommunityList, getStreetList, getRegionList } from '@/api/operation/community'

// 获取列表
export function getListData(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/archive/gasmeterarchive/gasMeter/findGasMeterPage',
    params,
    data
  })
}
//获取统计数据
export function getStaticsData(data = {}, params = {}) {
  return axiosApi({
    method: 'GET',
    url: '/bizcenter/biz/sts/meterNow/stsAllInfo',
    data
  })
}
// 保存信息
export function saveData(data, id = null, params = {}) {
  let method = 'POST'
  let url = '/bizcenter/archive/gasmeterarchive/gasMeter/add'
  if (id) {
    method = 'PUT'
    url = '/bizcenter/archive/gasmeterarchive/gasMeter/update'
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
    url: '/bizcenter/archive/gasmeterarchive/gasMeter/delete',
    params,
    data
  })
}

// 获取气表厂家
export function getFactoryListData(data) {
  return factoryApi.query(data)
}

// 获取气表版号
export function getVersionListData(data) {
  return versionApi.query(data)
}

// 获取气表型号
export function getModelListData(data) {
  return modelApi.query(data)
}

// 同时获取气表厂家，气表版号，气表型号
export function getFactoryAndVersionAndModelListData(factoryData, versionData, modelData) {
  return new Promise((resolve, reject) => {
    axios.all([getFactoryListData(factoryData), getVersionListData(versionData), getModelListData(modelData)]).then(axios.spread(function () {
      // 组装数据
      // console.log(arguments)
      const result = [...arguments]
      const newResult = []
      for (const index in result) {
        const { isSuccess, data } = result[index].data
        if (isSuccess) {
          newResult.push(data.records)
        } else {
          newResult.push([])
        }
      }
      resolve(newResult)
    })).catch((err) => {
      console.log('err', err)
      reject(err)
    })
  })
}

// 下载表具导入模板
export function downloadMeterInfoTemplete() {
  return fileStreamDownload('/bizcenter/archive/gasmeterarchive/gasMeter/exportCustomer', { size: 0, model: {} }, {}, {
    name: '导入表具信息模板.xls'
  })
}

// 导入表具信息
export function importMeterInfo(data) {
  return axiosApi({
    method: 'POST',
    url: `/bizcenter/archive/gasmeterarchive/gasMeter/import`,
    data,
  })
}

// 根据气表编号查询客户详情信息
export function getCustomerByMeter(data) {
  return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/gasmeterarchive/gasMeter/customer`,
      data,
  })
}

// 根据气表编号查询气表详细信息
export function getGasMeterDetails(data) {
  return axiosApi({
    method: 'get',
    // url: `/bizcenter/archive/gasmeterarchive/gasMeter/getByGasMeterCode`,
    url: `/bizcenter/interestConcerns/getMeterInfo`,
    data,
  })
}

// 获取用气类型变更记录
export function getUseGasTypeChangeList(data) {
  return axiosApi({
    method: 'get',
    url: `/bizcenter/tempCounter/useGasTypeChange`,
    data,
  })
}

// 保存变更用气类型信息
export function saveUseGasTypeChange(data) {
  return axiosApi({
      method: 'POST',
      url: `/bizcenter/tempCounter/useGasTypeChange`,
      data,
  })
}

// 判断开户是否收费
export function checkOpenAccountIsCharge(data, params = {}) {
  return axiosApi({
      method: 'POST',
      url: `/bizcenter/openAccount/whetherCharged`,
      params,
      data,
  })
}

// 根据气表编号获取气表信息
export function getMeterInfoByGasMeterCode(gasMeterCode) {
  return axiosApi({
      method: 'get',
      url: `/bizcenter/archive/gasmeterarchive/findgsaMeterByCode`,
      params: {
        gasMeterCode: gasMeterCode
      },
  })
}

// 根据气表编号获取客户信息
export function getCustomerInfoByGasMeterCode(gasMeterCode, data = {}, params = {}) {
  data = { gasMeterCode, ...data }
  return axiosApi({
      method: 'post',
      url: `/bizcenter/archive/gasmeterarchive/gasMeter/customer`,
      params,
      data,
  })
}

// 批量重新注册
export function batchRegisterAgain(data = {}, params = {}) {
  return axiosApi({
      method: 'post',
      url: `/bizcenter/archive/gasmeterarchive/addDeviceAgain`,
      params,
      data,
  })
}
