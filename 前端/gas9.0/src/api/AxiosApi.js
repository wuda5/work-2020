
import store from '@/store/index';
import db from '@/utils/localstorage';
import axios from 'axios';
import {
  Message,
  MessageBox
} from 'element-ui';
import {
  Base64
} from 'js-base64';
import { cloneDeep, merge } from 'lodash';
import qs from 'qs';
import { getBaseUrl } from '@/utils/api'
import vue from '@/main';

// 请求添加条件，如token
axios.interceptors.request.use(config => {

  // console.log('config', config)

  const isToken = config.headers['X-isToken'] === false ? config.headers['X-isToken'] : true;
  const token = db.get('TOKEN', '');
  if (token && isToken) {
    config.headers.token = 'Bearer ' + token;
  }

  config.headers.tenant = db.get('TENANT', '')
  const clientId = process.env.VUE_APP_CLIENT_ID;
  const clientSecret = process.env.VUE_APP_CLIENT_SECRET;
  config.headers['Authorization'] = `Basic ${Base64.encode(`${clientId}:${clientSecret}`)}`;
  return config
},
  error => {
    return Promise.reject(error)
  }
)

// 接口返回处理
axios.interceptors.response.use(
  response => {
    return response
  },
  error => {
    return Promise.reject(error)
  }
)

function handleError(error, reject, opts) {
  // debugger
  let isAlert = opts.custom ? opts.custom['isAlert'] : true;
  if (isAlert) {
    if (error.code === 'ECONNABORTED') {
      Message({
        message: '请求超时',
        onClose() {
          store.commit('common/SET_LOADING', false)
        }
      })
      //全局关闭loading层
      vue.$loading().close()
    } else if (error.response && error.response.data) {
      Message({
        message: error.response.data
      })
    } else if (error.message) {
      Message({
        message: error.message
      })
    }
  }
  reject(error)
}

function handleSuccess(res, resolve, opts) {
  let isAlert = opts.custom ? opts.custom['isAlert'] : true;
  if (res.data.isError) {
    // 未登录
    if (res.data.code === 40000 || res.data.code === 40001 ||
      res.data.code === 40002 || res.data.code === 40003 ||
      res.data.code === 40005 || res.data.code === 40006 ||
      res.data.code === 40008
    ) {
      // debugger
      MessageBox.alert(res.data.msg, '提醒', {
        confirmButtonText: '确定',
        callback: () => {
          window.location.hash = '/login'
        }
      })
    } else {
      if (isAlert) {
        Message.warning(res.data.msg);
        console.log(
          `%c ${res.config.method} %c ${res.config.url} %c ${res.data.msg}`,
          'background:#E6A23C ; padding: 1px; border-radius: 3px 0 0 3px;  color: #fff',
          'background:#909399 ; padding: 1px; color: #fff',
          'background:#F56C6C ; padding: 1px; border-radius: 0 3px 3px 0;  color: #fff',
        )
      }
    }
  }
  resolve(res)
}

// http请求
const httpServer = (opts) => {
  const cloneOpts = cloneDeep(opts)

  // 公共参数
  const publicParams = {
    ts: Date.now()
  }

  // http默认配置
  const method = opts.method.toUpperCase()
  // baseURL
  // 开发环境： /api                 // 开发环境在 vue.config.js 中有 devServer.proxy 代理
  // 生产环境： http://IP:PORT/api   // 生产环境中 代理失效， 故需要配置绝对路径
  const httpDefaultOpts = {
    baseURL: getBaseUrl(),
    responseType: '',
    timeout: 30000,
    // 序列化params参数
    paramsSerializer: (params) => {
      return qs.stringify(params, {
        arrayFormat: 'repeat'
      })
    }
  }

  const generateHttpOpts = {}

  if (opts['meta']) {
    generateHttpOpts.headers = opts['meta']
  }

  const dataRequest = ['PUT', 'POST', 'PATCH', 'DELETE']
  if (dataRequest.includes(method)) {
    generateHttpOpts.data = opts.data || {}
    generateHttpOpts.params = {
      ...publicParams,
      ...(opts.params || {})
    }
  } else {
    generateHttpOpts.params = {
      ...publicParams,
      ...(opts.data || {}),
      ...(opts.params || {})
    }
  }

  // formData转换
  if (opts.formData) {
    generateHttpOpts.transformRequest = [data => {
      const formData = new FormData()
      if (data) {
        Object.entries(data).forEach(item => {
          formData.append(item[0], item[1])
        })
      }
      return formData
    }]
  }

  //删除上面已经转换的属性
  delete cloneOpts['meta']
  delete cloneOpts['params']
  delete cloneOpts['data']
  delete cloneOpts['formData']

  // 最后的属性
  const finallyHttpOpts = merge(httpDefaultOpts, generateHttpOpts, cloneOpts)

  const promise = new Promise((resolve, reject) => {
    axios(finallyHttpOpts).then(response => {
      handleSuccess(response, resolve, opts)
    }).catch(error => {
      handleError(error, reject, opts)
    })
  })
  return promise
}

export default httpServer
