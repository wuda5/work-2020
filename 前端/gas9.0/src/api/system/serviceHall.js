// 营业厅配置
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询
  page: {
    method: 'POST',
    url: `/bizcenter/sysparam/bizhall/businessHall/page`
  },

  // 通过OrgID查询
  getById:{
    method: 'GET',
    url: `/bizcenter/sysparam/bizhall/queryByOrgId/{id}`
  },

  // 新增
  add: {
    method: 'POST',
    url: `/bizcenter/sysparam/bizhall/businessHall/add`
  },
  // 删除
  delete: {
    method: 'DELETE',
    url: `/bizcenter/sysparam/bizhall/businessHall/delete`
  },
  // 更新
  update: {
    method: 'PUT',
    url: `/bizcenter/sysparam/bizhall/businessHall/update`
  },
  // 批量更新
  updateBatch: {
    method: 'PUT',
    url: `/bizcenter/sysparam/bizhall/businessHall/updateBatch`
  },
}

export default {
  page(data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  getById(id) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/sysparam/bizhall/queryByOrgId/${id}`
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
  }
}
