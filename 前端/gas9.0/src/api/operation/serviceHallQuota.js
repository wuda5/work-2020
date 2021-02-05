
// 营业厅配额
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询营业厅信息
  hallPage: {
    method: 'POST',
    url: `/bizcenter/operparam/bizhalllimit/businessHall/page`
  },

  // 新增
  add: {
    method: 'POST',
    url: `/bizcenter/operparam/bizhalllimit/businessHallQuotaRecord/add`
  },
  // 分页查询营业厅配额信息
  hallQuotaPage: {
    method: 'POST',
    url: `/bizcenter/operparam/bizhalllimit/businessHallQuotaRecord/page`
  },
  hallInfoById: {
    method: 'GET',
    url: `/bizcenter//operparam/bizhalllimit`
  },
}

export default {
  hallPage (data) {
    return axiosApi({
      ...apiList.hallPage,
      data
    })
  },
  add (data) {
    return axiosApi({
      ...apiList.add,
      data
    })
  },
  hallQuotaPage (data) {
    return axiosApi({
      ...apiList.hallQuotaPage,
      data
    })
  },
  getHallInfoById (id) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/operparam/bizhalllimit/${id}`
    })
  }
}
