/**
 * api 相关函数工具
 */
import db from '@/utils/localstorage';
import { Base64 } from 'js-base64';

const env = process.env.NODE_ENV
const baseApi = process.env.VUE_APP_BASE_API
const devApiUrl = process.env.VUE_APP_DEV_REQUEST_DOMAIN_PREFIX + baseApi
const prodApiUrl = process.env.VUE_APP_PROD_REQUEST_DOMAIN_PREFIX + baseApi

// 获取调用api前缀
export function getBaseUrl() {
  let baseUrl
  const localstorageApiUrl = db.get('API_URL', false, false)
  if (env === 'development') {
    if (localstorageApiUrl && localstorageApiUrl !== devApiUrl) {
      // console.log('切换api了') 
      baseUrl = localstorageApiUrl
    } else {
      baseUrl = devApiUrl
    }
  } else {
    baseUrl = prodApiUrl
  }
  return baseUrl
}

// 生成最终的请求参数
export function generateRequestConfig(config = {}) {
  config.headers = config.headers || {}
  config.baseURL = getBaseUrl()
  const isToken = config?.headers?.['X-isToken'] === false ? config.headers['X-isToken'] : true
  const token = db.get('TOKEN', '')
  if (token && isToken) {
    config.headers.token = 'Bearer ' + token
  }

  config.headers.tenant = db.get('TENANT', '')
  const clientId = process.env.VUE_APP_CLIENT_ID
  const clientSecret = process.env.VUE_APP_CLIENT_SECRET;
  config.headers['Authorization'] = `Basic ${Base64.encode(`${clientId}:${clientSecret}`)}`
  return config
}