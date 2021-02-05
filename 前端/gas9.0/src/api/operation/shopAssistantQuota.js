
// 操作员配额
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询营业厅营业员配额信息
  counterPage: {
    method: 'POST',
    url: `/bizcenter/operparam/operatorlimit/businessHall/page`
  },

  // 新增用户配额
  add: {
    method: 'POST',
    url: `/bizcenter/operparam/operatorlimit/companyUserQuotaRecord/add`
  },

  // 分页查询用户配额信息
  companyUserQuotaRecord: {
    method: 'POST',
    url: `/bizcenter/operparam/operatorlimit/companyUserQuotaRecord/page`
  },
}

export default {
  counterPage (data) {
    return axiosApi({
      ...apiList.counterPage,
      data
    })
  },
  add (data) {
    return axiosApi({
      ...apiList.add,
      data
    })
  },
  companyUserQuotaRecord (data) {
    return axiosApi({
      ...apiList.companyUserQuotaRecord,
      data
    })
  },

}
