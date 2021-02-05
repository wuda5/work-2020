/*
 * @Description: 安检 API
 * @Author: lingw
 * @Date: 2020-11-19 10:41:49
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-24 18:37:37
 */
import axiosApi from '../AxiosApi.js'

const apiList = {
  save: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/saveSecurityCheckRecord',
  },
  update: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/updateSecurityCheckRecord',
  },
  page: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/pageSecurityCheckRecord'
  },
  approval: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/approval'
  },
  approvaled: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/approvaled'
  },
  completeOrder: {
    method: 'POST',
    url: '/bizcenter/operation/job/completeOrder'
  },
  end: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/end'
  },
  leaflet: {
    method: 'POST',
    url: '/bizcenter/operation/job/leaflet'
  },
  recall: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/recall'
  },
  refuseOrder: {
    method: 'POST',
    url: '/bizcenter/operation/job/refuseOrder'
  },
  reject: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/reject'
  },
  transferOrder: {
    method: 'POST',
    url: '/bizcenter/operation/job/transferOrder'
  },
  orderPage: {
    method: 'POST',
    url: '/bizcenter/operation/job/listOrder'
  },
  queryUser: {
    method: 'POST',
    url: '/authority/user/page'
  },
  queryProcess: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/queryProcess'
  },
  queryCheckItems: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/pageSecurityCheckItems'
  },
  queryCheckRecord: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/pageSecurityCheckRecord'
  },
  saveCheckResult: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/saveCheckResult'
  },
  updateCheckWarn: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/update'
  },
  getCheckResult: {
    method: 'POST',
    url: '/bizcenter/securityCheckRecord/getCheckResult'
  }
}

export default {
  // 保存安检记录
  save(data) {
    return axiosApi({
      ...apiList.save,
      data
    })
  },
  // 编辑安检记录
  update(data) {
    return axiosApi({
      ...apiList.update,
      data
    })
  },
  // 分页查看安检信息
  page(data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  // 提审
  approval(data) {
    return axiosApi({
      ...apiList.approval,
      data
    })
  },
  // 审核
  approvaled(data) {
    return axiosApi({
      ...apiList.approvaled,
      data
    })
  },
  // 结单
  completeOrder(data) {
    return axiosApi({
      ...apiList.completeOrder,
      data
    })
  },
  // 终止
  end(data) {
    return axiosApi({
      ...apiList.end,
      data
    })
  },
  // 派工
  leaflet(data) {
    return axiosApi({
      ...apiList.leaflet,
      data
    })
  },
  // 撤回
  recall(data) {
    return axiosApi({
      ...apiList.recall,
      data
    })
  },
  // 拒单
  refuseOrder(data) {
    return axiosApi({
      ...apiList.refuseOrder,
      data
    })
  },
  // 驳回
  reject(data) {
    return axiosApi({
      ...apiList.reject,
      data
    })
  },
  // 转单
  transferOrder(data) {
    return axiosApi({
      ...apiList.transferOrder,
      data
    })
  },
  // 获取工单列表
  orderPage(data) {
    return axiosApi({
      ...apiList.orderPage,
      data
    })
  },
  // 获取用户列表
  queryUser(data) {
    return axiosApi({
      ...apiList.queryUser,
      data
    })
  },
  // 根据安检编号查询流程信息
  queryProcess(data) {
    return axiosApi({
      ...apiList.queryProcess,
      data
    })
  },
  // 查询所有安检项及对应的子项信息
  getAllCheckInfos() {
    return axiosApi({
      method: 'GET',
      url: '/bizcenter/securityCheckChildItem/getAllCheckInfos'
    })
  },
  // 分页查询隐患信息
  queryCheckItems(data) {
    return axiosApi({
      ...apiList.queryCheckItems,
      data
    })
  },
  // 分页查询安检计划信息
  queryCheckRecord(data) {
    return axiosApi({
      ...apiList.queryCheckRecord,
      data
    })
  },
  // 上传安检结果
  saveCheckResult(data) {
    return axiosApi({
      ...apiList.saveCheckResult,
      data
    })
  },
  // 上传安检隐患整改信息
  updateCheckWarn(data) {
    return axiosApi({
      ...apiList.updateCheckWarn,
      data
    })
  },
  // 获取安检信息
  getCheckResult(data) {
    return axiosApi({
      ...apiList.getCheckResult,
      data
    })
  },
}