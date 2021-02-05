/*
 * @Description: 每日上报接口
 * @Author: lingw
 * @Date: 2021-02-02 11:46:50
 * @LastEditors: lingw
 * @LastEditTime: 2021-02-02 11:48:57
 */
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 获取每日上报列表
  getReportList: {
    method: 'POST',
    url: '/bizcenter/iot/device/queryData',
  },
}
export default {
  getReportList(data) {
    return axiosApi({
        ...apiList.getReportList,
        data
    })
  }
}
