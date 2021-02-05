// 营业厅配置
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
  // 分页查询
  page: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/template/page`
  },
  // 新增
  add: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/template/save`
  },
  // 更新
  update: {
    method: 'PUT',
    url: `/bizcenter/msgs/sms/template/update`
  },
  // 短信模板开启/关闭
  updateStatus: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/template/updateStatus`
  },
  // 发送短信接口
  testSend: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/smsTask/testSend`
  },

  // 短信签名====================================================================
  // 查询短信签名
  signPage: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/sign/page`
  },

  // 添加短信签名
  signSave: {
    method: 'POST',
    url: `/bizcenter/msgs/sms/sign/saveSignFileStr`
  },

  // 修改短信签名
  signUpdate: {
    method: 'PUT',
    url: `/bizcenter/msgs/sms/sign/updateSignFileStr`
  },

  // 删除短信签名
  signDelete: {
    method: 'DELETE',
    url: `/bizcenter/msgs/sms/sign/delete`
  },

}

export default {
  page (data) {
    return axiosApi({
      ...apiList.page,
      data
    })
  },
  add (data) {
    return axiosApi({
      ...apiList.add,
      data
    })
  },
  delete (data) {
    return axiosApi({
      method: 'DELETE',
      url: `/bizcenter/msgs/sms/template/delete`,
      data
    })
  },
  update (data) {
    return axiosApi({
      ...apiList.update,
      data
    })
  },
  testSend (data) {
    return axiosApi({
      ...apiList.testSend,
      data
    })
  },
  updateStatus (data) {
    return axiosApi({
      ...apiList.updateStatus,
      data
    })
  },

  signPage (data) {
    return axiosApi({
      ...apiList.signPage,
      data
    })
  },

  signSave (data) {
    return axiosApi({
      ...apiList.signSave,
      data
    })
  },

  signUpdate (data) {
    return axiosApi({
      ...apiList.signUpdate,
      data
    })
  },

  signDelete (data) {
    return axiosApi({
      ...apiList.signDelete,
      data
    })
  },

  // 初始化短信模板
  initSmsTemplate (data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/msgs/sms/sign/initSmsTemplate`,
      data
    })
  },

  // 设置默认短信模板
  setDefaultSms (data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/msgs/sms/template/setDefaultSms`,
      data
    })
  },

}
