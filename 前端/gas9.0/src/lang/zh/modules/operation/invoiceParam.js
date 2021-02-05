/**
 * 开票参数配置国际化
 */

 // 开票参数配置信息表单
 const invoiceParamFieldsMap = {

    accountLevel: '账号等级',
    address:'销方地址',
    bankAccount:'销方银行账户',
    bankName:'销方开户行名称',
    invoiceStatus: '数据状态',
    name: '销方名称',
    remark: '备注',
    taxpayerNo: '销方纳税人编号',
    telephone: '销方电话',
   }
  
  export default {
    title: '开票参数配置',
    deleteConfirm: '您确定要删除该开票参数配置吗',
    disableConfirm: '此操作将禁用此开票参数配置，是否继续？',
    invoiceStatusLabel: '是否启用',
    add: '新增开票参数配置',
    edit: '编辑开票参数配置',
    invoiceParamTitle: '开票参数信息',
    ...invoiceParamFieldsMap
  }
  
  export {
    invoiceParamFieldsMap
  }