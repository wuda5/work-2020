/**
 * 限购客户型配置
 */
import axiosApi from '@/api/AxiosApi.js'
import axios from 'axios'

// 测试文件流下载
export function download(data = {}, params = {}) {
  return axiosApi({
    // baseURL: 'http://172.16.92.34:8774/',
    method: 'POST',
    responseType: 'blob',
    url: '/bizcenter/readmeter/register/readMeterBook/export',
    params,
    data: {
      'current': 1,
      'map': {},
      'model': {
              
      },
      'order': 'descending',
      'size': 10,
      'sort': 'id'
    },
    headers: {

    }
  }).then((result) => {
    const reader = new FileReader()
    reader.readAsText(result.data, 'utf-8')
    reader.onload = (e) => {
      console.log('----', reader)
      console.log('----', JSON.parse(reader.result))
      console.log('----', JSON.parse(e.target.result))
    }
    const blob = new Blob([result.data], {
      type: 'application/vnd.ms-excel'
    })
    const fileName = 'license.xlsx'

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
  })
}
