/*
 * @Descripttion:
 * @Author: lingw
 * @Date: 2020-10-08 13:16:38
 * @LastEditors: lingw
 * @LastEditTime: 2020-12-22 18:46:01
 */
import axiosApi from '../AxiosApi.js'

const apiList = {
  getBillList: {
    method: 'POST',
    // url: '/bizcenter/charges/charge/page'
    url: '/bizcenter/charges/charge/pageList'
  },
  getInvoiceList: {
    method: 'POST',
    url: `/bizcenter/bill/fuzzySearch`
  },
  printInvoiceBasedOnReceipt: {
    method: 'POST',
    // url: `/bizcenter/bill/printInvoiceBasedOnReceipt`
    url: `/bizcenter/bill/printInvoiceByCharge`,
  },
  getReceipt: {
    method: 'GET',
    url: '/bizcenter/charges/charge/receiptNoManualEntry'
  },
}

export default {
  // 查询票据
  getBillList(data) {
    return axiosApi({
      ...apiList.getBillList,
      data
    })
  },
  // 查询发票
  getInvoiceList(data) {
    return axiosApi({
      ...apiList.getInvoiceList,
      data
    })
  },
  // 查询发票明细
  getInvoiceDetail(id) {
    return axiosApi({
      url: `/bizcenter/bill/queryInvoiceDetails?invoiceId=${id}`,
      method: 'GET'
    })
  },
  // 查询缴费记录查询明细
  getBillDetail(id) {
    return axiosApi({
      url: `/bizcenter/charges/charge/getItemDetailsByChargeNo?chargeNo=${id}`,
      method: 'GET'
    })
  },
  // 校验发票编号是否存在
  checkInvoiceNumber(number) {
    return axiosApi({
      url: `/bizcenter/bill/checkInvoiceNumber?invoiceNumber=${number}`,
      method: 'GET'
    })
  },
  // 打印发票（基于票据）
  printInvoiceBasedOnReceipt(data) {
    return axiosApi({
      ...apiList.printInvoiceBasedOnReceipt,
      data
    })
  },
  // 获取票据缴费记录数据 - 唐平
  getPrintRecords(chargeNo) {
    return axiosApi({
      url: `/bizcenter/charges/charge/printReceiptLoad?chargeNo=${chargeNo}`,
      method: 'GET'
    })
  },
  // 修改发票状态 - 唐平
  updateInvoiceStatus(chargeNo) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/charges/completeOpenReceipt?chargeNo=${chargeNo}`
    })
  },

  // 重开发票  重新开票
  reMakeOutAnInvoice(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/bill/retryKp`,
      data
    })
  },

  // 补打发票  重新推送数据到发票服务平台开票
  rePrintInvoice(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/bill/retryPrint`,
      data
    })
  },

  // 判断是否人工输入编号
  getReceipt(data) {
    return axiosApi({
      ...apiList.getReceipt,
      data
    })
  },

}
