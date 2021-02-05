// 抄表导入
import axiosApi from '@/api/AxiosApi.js'
import { fileStreamDownload } from '@/api/File'

export default {
  // 下载抄表导入模板
  downloadImportTemplete() {
      return fileStreamDownload('/bizcenter/readmeter/dataiot/readMeterData/exportTemplate', { size: 0, model: {} }, {}, {
          name: '抄表导入信息模板.xls'
      })
  },

  // 抄表导入
  importExcel(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/dataiot/readMeterData/import`,
      data
    })
  },

  // 抄表数据审核
  examine(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/dataiot/readMeterData/examine`,
      data
    })
  },

  // 分页查询抄表数据
  queryReadMeterWorkInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/dataiot/readMeterData/page`,
      data
    })
  },

  // 抄表数据批量修改
  updateList(data, isEdit) {
    let url = '/bizcenter/readmeter/dataiot/readMeterData/updateErrorList'
    if (isEdit) {
      url = '/bizcenter/readmeter/dataiot/readMeterData/updateList'
    }
    return axiosApi({
      method: 'POST',
      url,
      data
    })
  },

  // 抄表数据录入及修改接口
  update(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/dataiot/readMeterData/update`,
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

  // 批量发送补抄指令
  batchSendFixCommand(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iot/business/readiotmeter`,
      data
    })
  },

  // 自动填充数据
  batchAutoFill(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/iot/business/autoaddmeter`,
      data
    })
  },

  // 分页查询物联网异常抄表数据
  abnormalPage(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/dataiot/readMeterData/pageError`,
      data
    })
  },
  
}
