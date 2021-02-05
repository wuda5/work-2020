// 文件上传、删除、下载

import axiosApi from './AxiosApi.js'
import { merge } from 'lodash'

const apiList = {
  upload: {
    method: 'POST',
    url: `/bizcenter/sysparam/attachment/attachment/upload`,
  },

  delete: {
    method: 'DELETE',
    url: `/bizcenter/sysparam/attachment/attachment/deleteByIds`
  },

  download: {
    method: 'GET',
    url: `/bizcenter/sysparam/attachment/attachment/downloadById`
  }
}

export default {
  upload(data) {
    return axiosApi({
      ...apiList.upload,
      data
    })
  },
  delete(data) {
    return axiosApi({
      ...apiList.delete,
      data
    })
  },
  download(data) {
    return axiosApi({
      ...apiList.download,
      data
    })
  },

  getFile(url){
    return axiosApi({
      method: 'GET',
      responseType: 'blob',
      url
    })

  }
}

/**
 * 统一文件流下载
 * @param {*} url 下载api地址
 * @param {*} data 传递数据
 * @param {*} axiosConfig axios配置
 * @param {*} fileOptions 下载文件属性
 */
export function fileStreamDownload(url, data, axiosConfig = {}, fileOptions = {}) {
  // 默认的axios配置
  const defaultAxiosConfig = {
    method: 'POST',
    responseType: 'blob',
  }

  // 默认下载文件属性
  const defaultFileOptions = {
    type: 'application/vnd.ms-excel', // 文件MIME类型， https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    name: '', // 文件名 + 扩展名, 实例：'文件下载.xls'
  }

  fileOptions = merge(defaultFileOptions, fileOptions)
  axiosConfig = merge(defaultAxiosConfig, { url, data }, axiosConfig)

  return new Promise((resolve, reject) => {
    axiosApi(axiosConfig).then((result) => {
        // const reader = new FileReader()
        // reader.readAsText(result.data, 'utf-8')
        // reader.onload = (e) => {
        //   console.log('----', reader)
        //   console.log('----', JSON.parse(reader.result))
        //   console.log('----', JSON.parse(e.target.result))
        // }
        const blob = new Blob([result.data], {
          type: fileOptions.type
        })
        const fileName = fileOptions.name
    
        // 对于<a>标签，只有 Firefox 和 Chrome（内核） 支持 download 属性
        // IE10以上支持blob但是依然不支持download
        const link = document.createElement('a') // 创建a标签
        if ('download' in link) { // 支持a标签download的浏览器
          link.download = fileName // a标签添加属性
          link.style.display = 'none'
          link.href = URL.createObjectURL(blob)
          document.body.appendChild(link)
          link.click() // 点击进行下载
          URL.revokeObjectURL(link.href) // 释放Url
          document.body.removeChild(link) // 释放标签
        } else {
          navigator.msSaveBlob(blob, fileName)
        }
        resolve(true)
      }).catch((err) => {
        // console.log('err', err)
        // console.log('err', err.response)
        const { response } = err
        let message = ''
        if (response) {
          const { status, statusText, data } = response
          if (data) {
            const { type } = data
            if (type === 'application/json') {
              const reader = new FileReader()
              reader.readAsText(err.response.data, 'utf-8')
              reader.onload = (e) => {
                // console.log('----', reader)
                // console.log('----', JSON.parse(reader.result))
                // console.log('----', JSON.parse(e.target.result))
                const resultData = JSON.parse(reader.result)
                message = resultData?.message || '服务器错误。'
                reject(message)
              }
            }
          } else {
            message = `errorCode: ${status};\n message: ${statusText}`
            reject(message)
          }
        } else {
          message = '连接后台服务失败。'
          reject(err)
        }
      })
  })

}
