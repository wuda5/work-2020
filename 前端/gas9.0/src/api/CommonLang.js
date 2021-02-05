import axiosApi from './AxiosApi.js'

const apiList = {
  page: {
    method: 'POST',
    url: `/authority/lang/page`,
  },
  query: {
    method: 'POST',
    url: `/authority/lang/query`,
  },
  update: {
    method: 'PUT',
    url: `/authority/lang`
  },
  save: {
    method: 'POST',
    url: `/authority/lang`
  },
  delete: {
    method: 'DELETE',
    url: `/authority/lang`
  },
  export: {
    method: 'POST',
    url: `/authority/lang/export`
  },
  preview: {
    method: 'POST',
    url: `/authority/lang/preview`
  },
  import: {
    method: 'POST',
    url: `/authority/lang/import`
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