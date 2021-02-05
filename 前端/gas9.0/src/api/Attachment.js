import axiosApi from './AxiosApi.js'

const apiList = {
  page: {
    method: 'POST',
    url: `/file/attachment/page`
  },
  upload: {
    method: 'POST',
    url: `/bizcenter/file/attachment/upload`
  },
  download: {
    method: 'GET',
    url: `/file/attachment/download`
  },
  downloadBiz: {
    method: 'GET',
    url: `/file/attachment/download/biz`
  },
  downloadUrl: {
    method: 'GET',
    url: `/file/attachment/download/url`
  },
  delete: {
    method: 'DELETE',
    url: `/file/attachment`
  }
}

export default {
  page (data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  upload (data) {
    return axiosApi({
      ...apiList.upload,
      data
    })
  },
  download (data) {
    return axiosApi({
      ...apiList.download,
      responseType: 'blob',
      data
    })
  },
  downloadBiz (data) {
    return axiosApi({
      ...apiList.downloadBiz,
      data
    })
  },
  downloadUrl (data) {
    return axiosApi({
      ...apiList.downloadUrl,
      data
    })
  },
  delete (data) {
    return axiosApi({
      ...apiList.delete,
      data
    })
  },

  // 用户资料上传++++++++++++++++++++++
  uploadMaterial(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/customerMaterial/uploadMaterial`,
      data
    })
  },

  // 查询资料图片
  queryMaterial(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/customerMaterial/query`,
      data
    })
  },

  // 删除资料图片
  deleteMaterial(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/archive/customerMaterial/logicalDelete`,
      data
    })
  },

}
