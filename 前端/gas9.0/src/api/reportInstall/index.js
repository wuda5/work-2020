/*
 * @Description: 报装 API
 * @Author: lingw
 * @Date: 2020-11-11 10:41:49
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 15:07:39
 */
import axiosApi from '../AxiosApi.js'

const apiList = {
  save: {
    method: 'POST',
    url: '/bizcenter/install/record/save',
  },
  aduit: {
    method: 'POST',
    url: '/bizcenter/install/record/dataAudit',
  },
  page: {
    method: 'POST',
    url: '/bizcenter/install/record/page'
  },
  // 分页查询报装工单 记录信息
  orderPage: {
    method: 'POST',
    url: '/bizcenter/operation/job/listOrder'
  },
  // 工单派工
  orderSend: {
    method: 'POST',
    url: '/bizcenter/operation/job/dispatch'
  },
  // 踏勘，施工，验收 接单
  orderReceive: {
    method: 'POST',
    url: '/bizcenter/install/order/receiveOrder'
  },
  updateStatus: {
    method: 'POST',
    url: '/bizcenter/install/record/examin'
  },
  addDesign: {
    method: 'POST',
    url: '/bizcenter/install/design/addDesign'
  },
  saveInstallDetail: {
    method: 'POST',
    url: '/bizcenter/install/record/saveInstallDetail'
  },
  saveInstallAccept: {
    method: 'POST',
    url: '/bizcenter/install/record/saveInstallAccept'
  },
  queryUser: {
    method: 'POST',
    url: '/authority/user/page'
  },
}

export default {
  // 保存报装记录
  save(data) {
    return axiosApi({
      ...apiList.save,
      data
    })
  },
  // 报装-受理资料完成审核
  aduit(data) {
    return axiosApi({
      ...apiList.aduit,
      data
    })
  },
  // 报装-受理资料完成审核
  updateStatus(data) {
    return axiosApi({
      ...apiList.updateStatus,
      data
    })
  },
  // 分页查看报装信息
  page(data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  // 分页查看工单列表
  orderPage(data) {
    return axiosApi({
      ...apiList.orderPage,
      data
    })
  },
  // 工单派工
  orderSend(data) {
    return axiosApi({
      ...apiList.orderSend,
      data
    })
  },
  // 踏勘，施工，验收 接单
  orderReceive(data) {
    return axiosApi({
      ...apiList.orderReceive,
      data
    })
  },
  // 添加设计图
  addDesign(data) {
    return axiosApi({
      ...apiList.addDesign,
      data
    })
  },
  // 查询设计图
  queryDesign(installNumber) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/install/design/queryDesign?installNumber=${installNumber}`
    })
  },
  // 录入安装资料
  saveInstallDetail(data) {
    return axiosApi({
      ...apiList.saveInstallDetail,
      data
    })
  },
  // 查询安装资料
  queryInstallDetail(installNumber) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/install/record/queryInstallDetail?installNumber=${installNumber}`
    })
  },
  // 录入验收资料
  saveInstallAccept(data) {
    return axiosApi({
      ...apiList.saveInstallAccept,
      data
    })
  },
  // 查询验收资料
  queryAccept(installNumber) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/install/record/queryAccept?installNumber=${installNumber}`
    })
  },
  // 报装流程查询
  queryProcess(installNumber) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/install/record/queryProcess?installNumber=${installNumber}`
    })
  },
  // 获取工单材料相关信息
  fetchOrderFiles(jobId) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/operation/jobFile/findFilesByJobId?jobId=${jobId}`
    })
  },
  // 获取安装列表
  fetchInstallFilesList(installNumber) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/install/details/queryInstallDetail?installNumber=${installNumber}`
    })
  },
  // 获取用户列表
  queryUser(data) {
    return axiosApi({
      ...apiList.queryUser,
      data
    })
  },
}