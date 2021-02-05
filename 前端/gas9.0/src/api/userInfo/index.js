//用户档案
import axiosApi from '@/api/AxiosApi.js'
import {fileStreamDownload} from '@/api/File'

export {getUseGasTypeList} from '@/api/operation/gasPrice'
const apiList = {
  // 用户档案分页查询
  page: {
    method: 'POST',
    url: `/bizcenter/archive/userarchive/customer/page`
  },
  //查询用户的气表
  queryGasMeter: {
    method: 'GET',
    url: `/bizcenter/archive/userarchive/customer/findGasMeterByCustomerCode`
  },
  //加入黑名单
  addBlacklist: {
    method: 'POST',
    url: `/bizcenter/archive/userarchive/customer/SetBlacklist`
  },
  //移除黑名单
  removeBlacklist: {
    method: 'POST',
    url: `/bizcenter/archive/userarchive/customer/RemoveBlacklist`
  },
  // 新增客户档案信息
  addUserInfo: {
    method: 'POST',
    url: `/bizcenter/archive/userarchive/customer/saveList`
  },
  //修改用户档案信息
  editUserInfo: {
    method: 'PUT',
    url: `/bizcenter/archive/userarchive/customer/update`
  },
  //导出客户档案数据
  exportCustomerInfo: {
    method: 'POST',
    url: `/bizcenter/archive/userarchive/customer/exportCustomer`
  },

}
export default {
  page(data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  queryGasMeter(data) {
    return axiosApi({
      ...apiList.queryGasMeter,
      data
    })
  },
  addBlacklist(data) {
    return axiosApi({
      ...apiList.addBlacklist,
      data
    })
  },
  removeBlacklist(data) {
    return axiosApi({
      ...apiList.removeBlacklist,
      data
    })
  },
  addUserInfo(data) {
    return axiosApi({
      ...apiList.addUserInfo,
      data
    })
  },
  editUserInfo(data) {
    return axiosApi({
      ...apiList.editUserInfo,
      data
    })
  },
  exportCustomerInfo(data) {
    return axiosApi({
      ...apiList.exportCustomerInfo,
      data
    })
  },

  // 下载导入客户档案模板
  downloadCustomerInfoTemplete() {
    return fileStreamDownload('/bizcenter/archive/userarchive/customer/exportCustomer', {size: 0, model: {}}, {}, {
      name: '导入客户信息模板.xls'
    })
  },

  // 导入客户信息
  importCustomerInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/userarchive/customer/import`,
      data,
    })
  },

  // 分页查询客户(连表查询)
  getListData(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/userarchive/customer/list`,
      data,
    })
  },

  // 销户
  cancelAccount(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/cancelAccount/add',
      data
    })
  },
  
  // 批量销户
  batchCancelAccount(data) {
    return axiosApi({
      method: 'POST',
      url: '/bizcenter/cancelAccount/batchAdd',
      data
    })
  }
}

// 下载开户导入模板 选项没有级联的/bizcenter/tempCounter/exportCombobox 选项级联的/bizcenter/tempCounter/exportCascadeTemplate
export function downloadOpenAccountTemplete() {
  return fileStreamDownload('/bizcenter/tempCounter/exportCascadeTemplate', {size: 0, model: {}}, {}, {
    name: '开户导入模板.xls'
  })
}

// 开户
export function OpenAccount(data, customerCode) {
  return axiosApi({
    method: 'POST',
    url: `/bizcenter/tempCounter/establishAccount?customerCode=${customerCode}`,
    data,
  })
}

// 保存信息并开户
export function saveInfoAndOpenAccount(data) {
  return axiosApi({
    method: 'POST',
    url: `/bizcenter/tempCounter/establishAccount`,
    data,
  })
}

// 导入开户
export function importOpenAccount(data) {
  return axiosApi({
    method: 'POST',
    url: `/bizcenter/tempCounter/importBackJson`,
    data,
  })
}

// 获取导入开户数据列表
export function getImportOpenAccountData(data, customerCode) {
  return axiosApi({
    method: 'POST',
    url: `/bizcenter/tempCounter/establishAccount?customerCode=${customerCode}`,
    data,
  })
}

// 通气操作
export function ventilation(data) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/archive/gasmeterarchive/ventilation',
    data,
  })
}

// 获取客户信息根据客户编号
export function getCustomerInfoByCustomerCode(customerCode) {
  return axiosApi({
    method: 'GET',
    url: '/bizcenter/archive/userarchive/customer/customerBycode',
    params: {
      customerCode,
    },
  })
}
