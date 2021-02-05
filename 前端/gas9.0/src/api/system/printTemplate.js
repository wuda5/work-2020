// 打印模板 文件 配置
import axiosApi from '@/api/AxiosApi.js'
export default {
  // 模板分类查询（包含一级、二级）
  templateClassify(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/template/listAll`,
      data
    })
  },

  // 列表数据查询
  page(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/page`,
      data
    })
  },

  // 删除模板
  delete(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/deleteTemplateItem`,
      data
    })
  },

  // 通过ID查询模板列表
  getSubTemplateCalssifyByCode(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/groupByCode`,
      data
    })
  },

  // 新增模板
  addNewTemplate(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/save`,
      data
    })
  },

  // 更新模板
  update(data) {
    return axiosApi({
      method: 'PUT',
      url: `/bizcenter/sysparam/template/templateItem/update`,
      data
    })
  },

   // 设置默认模板
   setDefault(data) {
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/setTemplateDefault`,
      data
    })
  },

  // 共享模板详情（需要平台管理员审核）
  shareTemplate(data){
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/share`,
      data
    })
  },

  // 获取平台模板(公共模板)
  publicTemplate(data){
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/pageAdminTemplate`,
      data
    })
  },

  // 获取默认模板
  getDefaultTemplate(data){
    return axiosApi({
      method: 'POST',
      url: `/bizcenter/sysparam/template/templateItem/getDefaultTemplate`,
      data
    })
  }
}
