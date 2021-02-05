/*
 * @Descripttion: 
 * @Author: lingw
 * @Date: 2020-10-08 13:16:38
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-09 17:35:36
 */
import axiosApi from '../AxiosApi.js'
import { fileStreamDownload } from '@/api/File'

const apiList = {
  getChargeBill: {
    method: 'POST',
    url: `/bizcenter/summaryBill/queryChargeRecordList`
  },
  getInvoiceList: {
    method: 'POST',
    url: `/bizcenter/summaryBill/queryInvoiceList`
  },
}

export default {
  // 获取扎帐信息
  queryAccount({ startTime, endTime }) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/query?startTime=${startTime}&endTime=${endTime}`
    })
  },
  // 保存扎帐信息
  saveSettleAccount(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/summaryBill`,
      data,
    })
  },
  // 获取缴费明细
  getChargeBill(data) {
    return axiosApi({
      ...apiList.getChargeBill,
      data
    })
  },
  // 获取发票明细
  getInvoiceList(data) {
    return axiosApi({
      ...apiList.getInvoiceList,
      data
    })
  },
  // 获取扎帐记录
  getRecordsList(data = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/querySummaryBillRecord`,
      data,
    })
  },
  // 获取扎帐记录中的收费明细
  getRecordsChargeBill(data = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/querySummaryedCharges`,
      data,
    })
  },
  // 获取扎帐记录中的发票明细
  getRecordsInvoiceList(data = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/querySummaryedInvoices`,
      data,
    })
  },
  
  // 反扎帐
  reverseSettle(data = {}) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/summaryBill/reverse`,
      data,
    })
  },
  
  // 导出扎帐信息
  export(data = {}) {
    return fileStreamDownload('/bizcenter/summaryBill/export', data, {}, {
      name: '扎帐信息.xls'
    })
  },
}