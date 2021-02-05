/**
 *  物联网配置接口
 */

import axiosApi from '@/api/AxiosApi.js'

export default {
  // 分页查询
  page (data) {
    return axiosApi({
      url: '/bizcenter/sysparam/invoicePlatConfig/page',
      method: 'post',
      data
    })
  },

  // 保存
  save (data, params = {}) {
    let url = '/bizcenter/sysparam/invoicePlatConfig/add'
    let method = 'post'
    if (data.id) {
      url = '/bizcenter/sysparam/invoicePlatConfig/update'
      method = 'put'
    }
    return axiosApi({
      url,
      method,
      params,
      data
    })
  },

  // 保存
  saveWithFile (data, params = {}) {
    let url = '/bizcenter/sysparam/invoicePlatConfig/saveWithFile'
    let method = 'post'
    if (data.id) {
      url = '/bizcenter/sysparam/invoicePlatConfig/updateWithFile'
      method = 'post'
    }
    const formData = new FormData()
    for (const k in data) {
      formData.append(k, data[k])
    }
    // console.log('formData', formData)
    return axiosApi({
      url,
      method,
      headers: {
        'Content-Type': 'multipart/form-data'
      },
      params,
      data: formData
    })
  },
  // 删除
  delete (data) {
    return axiosApi({
      url: '/bizcenter/sysparam/invoicePlatConfig/delete',
      method: 'delete',
      data
    })
  }
}

