
/**
 * 开票参数配置
 */

// @ts-ignore
import axiosApi from '@/api/AxiosApi.js'

// 查询开票参数
export function getInvoiceParamList(data = {}, params = {}) {
  return axiosApi({
    method: 'POST',
    url: '/bizcenter/sysparam/invoiceParam/invoiceParam/page',
    params,
    data
  })
}
// 保存开票参数
export function saveInvoiceParam(data, id = null,params = {}) {
    let method = 'POST'
    let url = '/bizcenter/sysparam/invoiceParam/invoiceParam/add'
    if (id) {
        method = 'PUT'
        url = '/bizcenter/sysparam/invoiceParam/invoiceParam/update'
    }
    return axiosApi({
        method,
        url,
        params,
        data
    })
  }