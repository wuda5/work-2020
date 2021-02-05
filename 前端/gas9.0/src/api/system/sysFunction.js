// 系统功能项配置
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 更新
  update: {
    method: 'POST',
    url: `/bizcenter/sysparam/functionSwitchPlus/updateSysAllSetting`
  },
}

export default {
  page() {
    return axiosApi({
      method: 'GET',
      url: '/bizcenter/sysparam/functionSwitchPlus/getSysAllSettingMap',
    })
  },
  update(data) {
    return axiosApi({
      ...apiList.update,
      data
    })
  },
  // 获取一个参数配置
  getOne(params = {}) {
    return axiosApi({
      method: 'GET',
      url: '/bizcenter/sysparam/functionSwitchPlus/getSystemSetting',
      params,
    })
  },
}
