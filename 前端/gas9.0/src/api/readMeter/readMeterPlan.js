// 抄表计划
import axiosApi from '@/api/AxiosApi.js'

export default {

  // 新增抄表任务分配信息
  addReadMeterWorkInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/add`,
      data
    })
  },

  // 计划任务分配==========================================

  // (移除)删除抄表任务分配信息
  deleteReadMeterWorkInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/delete`,
      data
    })
  },

  // 分页查询抄表任务分配信息
  queryReadMeterWorkInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/page`,
      data
    })
  },
  // =========================================================

  // 分页查询没有绑定的抄表册
  getUnboundBook(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/pageUnboundBook`,
      data
    })
  },

  // 批量新增抄表任务分配信息
  addUnboundBook(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/addList`,
      data
    })
  },

  // 修改计划状态（-1：未开启；1：执行中；2-暂停；0-执行完成）
  updatePlanStatus(data) {
    return axiosApi({
      method: 'PUT',
      url: `/bizcenter/readmeter/register/readMeterPlan/updateSatus`,
      data
    })
  },

  // ============================================================
  // 根据id批量获取抄表任务分配信息
  queryMeterInfoById(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/queryList`,
      data
    })
  },

  // 更新抄表任务分配信息
  updateMeterWorkInfo(data) {
    return axiosApi({
      method: 'PUT',
      url: `/bizcenter/readmeter/register/planScope/update`,
      data
    })
  },

  // 导出抄表名单
  exportMeterData(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/readMeterBook/exportMeterData`,
      data
    })
  },

  // 新增抄表计划信息
  addReadMeterPlanInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/readMeterPlan/add`,
      data
    })
  },

  // （单个）删除抄表计划信息
  deleteReadMeterPlanInfo(data) {
    return axiosApi({
      method: 'DELETE',
      url: `/bizcenter/readmeter/register/readMeterPlan/delete`,
      data
    })
  },

  // 分页查询抄表计划信息
  queryReadMeterPlanInfo(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/readMeterPlan/page`,
      data
    })
  },

  // 更新抄表计划信息
  updateReadMeterPlanInfo(data) {
    return axiosApi({
      method: 'PUT',
      url: `/bizcenter/readmeter/register/readMeterPlan/update`,
      data
    })
  },

  // 获取计划下的抄表册数据
  getPlanInfoData(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/planScope/page`,
      data
    })
  }

}
