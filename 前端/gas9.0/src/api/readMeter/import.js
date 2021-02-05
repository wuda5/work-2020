// 抄表导入
import axiosApi from '@/api/AxiosApi.js'

export default {

  // 抄表导入
  importExcel(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/import`,
      data
    })
  },

  // 抄表数据审核
  examine(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/examine`,
      data
    })
  },

  // 分页查询抄表数据
  queryReadMeterWorkInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/page`,
      data
    })
  },

  // 抄表数据批量修改
  updateList(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/updateList`,
      data
    })
  },

  // 抄表数据录入及修改接口
  update(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/update`,
      data
    })
  },

  // 抄表数据手动结算
  settlement(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/settlement`,
      data
    })
  },

  // 待提审数据移除（撤回）
  withDraw(data){
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/data/readMeterData/withdraw`,
      data
    })
  }
}
