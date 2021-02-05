/*
 * @Description: 登录界面API
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2021-01-21 09:23:41
 */
import axiosApi from './AxiosApi.js'

const apiList = {
  captcha: `/oauth/anno/captcha`,
  login: `/oauth/anno/token`,
  //router: `/oauth/menu/router?lang=en_US`,
  router: `/oauth/menu/router?lang=zh_CN`,
  resource: `/oauth/resource/visible`,
  dict: `/authority/dictionary/queryAllDic`

}

export default {
  getCaptcha(randomId) {
    return axiosApi({
      method: 'GET',
      url: apiList.captcha + `?key=${randomId}`,
      responseType: 'arraybuffer',
      meta: {
        'X-isToken': false
      }
    })
  },
  login(data) {
    return axiosApi({
      method: 'POST',
      url: apiList.login,
      data
    })
  },
  getRouter(data) {
    return axiosApi({
      method: 'GET',
      url: apiList.router,
      data: data || {}
    })
  },
  getResource(data) {
    return axiosApi({
      method: 'GET',
      url: apiList.resource,
      data: data || {}
    })
  },
  getDict(data) {
    return axiosApi({
      method: 'POST',
      url: apiList.dict,
      data
    })
  },
  getTenant(url) {
    return axiosApi({
      method: 'GET',
      url: `/authority/tenant/code/${url}`
    })
  },
  getCompanyInfo(code) {
    return axiosApi({
      method: 'GET',
      url: `/bizcenter/operparam/address/companyInfo?code=${code}`
    })
  }
}
