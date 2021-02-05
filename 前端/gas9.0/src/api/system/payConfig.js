// 支付配置
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询
  page: {
    method: 'POST',
    url: `/bizcenter/sysparam/payInfo/payInfo/page`
  },
  // 新增
  add: {
    method: 'POST',
    url: `/bizcenter/sysparam/payInfo/payInfo/add`
  },
  // 删除
  delete: {
    method: 'DELETE',
    url: `/bizcenter/sysparam/payInfo/payInfo/delete`
  },
  // 更新
  update: {
    method: 'PUT',
    url: `/bizcenter/sysparam/payInfo/payInfo/update`
  }
}

export default {
  page(data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  add(data) {
    return axiosApi({
      ...apiList.add,
      data
    })
  },
  delete(data) {
    return axiosApi({
      ...apiList.delete,
      data
    })
  },
  update(data) {
    return axiosApi({
      ...apiList.update,
      data
    })
  }
}
