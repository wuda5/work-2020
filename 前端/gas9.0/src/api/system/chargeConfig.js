// 收费配置
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询
  page: {
    method: 'POST',
    url: `/bizcenter/sysparam/toll/tollItem/page`
  },
  // 新增
  add: {
    method: 'POST',
    url: `/bizcenter/sysparam/toll/tollItem/add`
  },
  // 删除
  delete: {
    method: 'DELETE',
    url: `/bizcenter/sysparam/toll/tollItem/delete`
  },
  // 更新
  update: {
    method: 'PUT',
    url: `/bizcenter/sysparam/toll/tollItem/update`
  },
  // 批量更新
  updateBatch: {
    method: 'PUT',
    url: `/bizcenter/sysparam/toll/tollItem/updateBatch`
  },
  // 获取下拉参数
  params: {
    method: 'POST',
    url: `/bizcenter/sysparam/toll/tollItem/params`
  },
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
  },
  updateBatch(data) {
    return axiosApi({
      ...apiList.updateBatch,
      data
    })
  },
  params(data) {
    return axiosApi({
      ...apiList.params,
      data
    })
  }
}
