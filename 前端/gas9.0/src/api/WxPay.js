import axiosApi from './AxiosApi.js'

const apiList = {
  page: {
    method: 'POST',
    url: `/pay/wxPay/page`,
  },
  query: {
    method: 'POST',
    url: `/pay/wxPay/query`,
  },
  update: {
    method: 'PUT',
    url: `/pay/wxPay`
  },
  save: {
    method: 'POST',
    url: `/pay/wxPay`
  },
  delete: {
    method: 'DELETE',
    url: `/pay/wxPay`
  },
  export: {
    method: 'POST',
    url: `/pay/wxPay/export`
  },
  preview: {
    method: 'POST',
    url: `/pay/wxPay/preview`
  },
  import: {
    method: 'POST',
    url: `/pay/wxPay/import`
  }
}

export default {
  page (data, custom = {}) {
    return axiosApi({
      ...apiList.page,
      data,
      custom
    })
  },
  query (data, custom = {}) {
    return axiosApi({
      ...apiList.query,
      data,
      custom
    })
  },
  save (data, custom = {}) {
    return axiosApi({
      ...apiList.save,
      data,
      custom
    })
  },
  update (data, custom = {}) {
    return axiosApi({
      ...apiList.update,
      data,
      custom
    })
  },
  delete (data, custom = {}) {
    return axiosApi({
      ...apiList.delete,
      data,
      custom
    })
  },
  export (data, custom = {}) {
    return axiosApi({
      ...apiList.export,
      responseType: "blob",
      data,
      custom
    })
  },
  preview (data, custom = {}) {
    return axiosApi({
      ...apiList.preview,
      data,
      custom
    })
  },
  import (data, custom = {}) {
    return axiosApi({
      ...apiList.import,
      data,
      custom
    })
  }
}