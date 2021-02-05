/**
 * 安检子项配置国际化
 */

 // 安检子项配置信息表单
 const securitySubItemFieldsMap = {

    dangerLevel: '隐患级别',
    name:'子项名称',
    securityCode:'安检项编码',
    securityName:'安检项名称',
    // chargeDay: '缴费天数',
    dataStatus: '数据状态',
   }
  
  export default {
    title: '安检子项配置',
    deleteConfirm: '您确定要删除该安检子项配置吗',
    disableConfirm: '此操作将禁用此安检子项配置，是否继续？',
    dataStatusLabel: '是否启用',
    add: '新增安检子项配置',
    edit: '编辑安检子项配置',
    securitySubItemTitle: '安检子项信息',
    ...securitySubItemFieldsMap
  }
  
  export {
    securitySubItemFieldsMap
  }