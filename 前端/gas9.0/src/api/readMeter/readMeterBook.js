// 抄表册
import axiosApi from '@/api/AxiosApi.js'

const apiList = {

  // index页面----------------------------------

  // 抄表册页面----------------------------------

  // 分页查询抄表册信息
  listReadMeterBook: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/readMeterBook/page`
  },

  // 新增抄表册信息
  addReadMeterBook: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/readMeterBook/add`
  },

  // 更新抄表册信息
  updateReadMeterBook: {
    method: 'PUT',
    url: `/bizcenter/readmeter/register/readMeterBook/update`
  },
  // 抄表册批量修改关联用户
  updateBookRecord: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/update`
  },
  // (单个删除)删除抄表册信息
  deleteReadMeterBook: {
    method: 'DELETE',
    url: `/bizcenter/readmeter/register/readMeterBook/delete`
  },

  // 导出抄表册
  exportReadMeterBook: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/readMeterBook/export`
  },

  // 导出抄表册（模板）
  exportTemplateReadMeterBook: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/readMeterBook/exportCombobox`
  },

  // 关联客户----------------------------------

  // 分页查询抄表册关联客户
  listGasMeterBookRecord: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/page`
  },

  // 根据id批量获取抄表册关联客户
  gasMeterBookRecordById: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/queryList`
  },

  // 抄表册关联小区(村、xx路)----------------------------------

  // 新增抄表册关联小区(村、xx路)(条件新增)
  addCommunityByQuery: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/addByQuery`
  },

  // 新增抄表册关联小区(村、xx路)(选中新增)
  addCommunityByChoice: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/addList`
  },

  // 删除抄表册关联小区(村、xx路)
  deleteCommunity: {
    method: 'POST',
    url: `/bizcenter/readmeter/register/gasMeterBookRecord/delete`
  },

  // 根据角色查询出用户集合
  getUserList: {
    method: 'POST',
    url: `/authority/role/user/pageUserByRoleCode`
  },

}

export default {
  listReadMeterBook(data) {
    return axiosApi({
      ...apiList.listReadMeterBook,
      data
    })
  },
  addReadMeterBook(data) {
    return axiosApi({
      ...apiList.addReadMeterBook,
      data
    })
  },
  updateReadMeterBook(data) {
    return axiosApi({
      ...apiList.updateReadMeterBook,
      data
    })
  },
  updateBookRecord(data) {
    return axiosApi({
      ...apiList.updateBookRecord,
      data
    })
  },
  deleteReadMeterBook(data) {
    return axiosApi({
      ...apiList.deleteReadMeterBook,
      data
    })
  },
  exportReadMeterBook(data) {
    return axiosApi({
      ...apiList.exportReadMeterBook,
      data
    })
  },
  exportTemplateReadMeterBook(data) {
    return axiosApi({
      ...apiList.exportTemplateReadMeterBook,
      data
    })
  },
  // 分页查询抄表册关联客户
  customerPage(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/readmeter/register/gasMeterBookRecord/page`,
      data,
    })
  },
  // 获取抄表册总数
  listGasMeterBookRecord(data) {
    return axiosApi({
      ...apiList.listGasMeterBookRecord,
      data
    })
  },
  gasMeterBookRecordById(data) {
    return axiosApi({
      ...apiList.gasMeterBookRecordById,
      data
    })
  },
  addCommunityByQuery(data) {
    return axiosApi({
      ...apiList.addCommunityByQuery,
      data
    })
  },
  addCommunityByChoice(data) {
    return axiosApi({
      ...apiList.addCommunityByChoice,
      data
    })
  },
  deleteCommunity(data) {
    return axiosApi({
      ...apiList.deleteCommunity,
      data
    })
  },
  getUserList(data) {
    return axiosApi({
      ...apiList.getUserList,
      data
    })
  }
}
