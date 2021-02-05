/**
 * 表具档案
 */

 // 表具基本信息字段映射
 const baseCustomerFormFieldsMap = {
  customerCode: '客户编号',
  customerName: '客户名称',
  sex: '客户性别',
  telphone: '联系电话',
  contactAddress: '客户地址',
  idTypeCode: '证件类型',
  idTypeName: '证件类型',
  idNumber: '证件号码',
  idCard: '身份证号码',
  remark: '备注',
  customerTypeCode: '客户类型',
  customerTypeName: '客户类型',
 }

// 表具表单字段映射
const customerFormFieldsMap = {
  ...baseCustomerFormFieldsMap,
  customerStatus: '客户状态',
  blackStatus: '黑名单',
  createTime: '创建时间',
  openTime: '开户时间',
  balance: '账户余额',
  preStoreCount: '预存次数',
  preStoreMoney: '预存总额',
  cardholder: '持卡人',
  bankAccount: '银行账号',
  bank: '开户行',
  contractNumber: '代扣合同编号',
  contractStatus: '代扣签约状态',
  insuranceEndTime: '保险到期时间',
  insuranceNo: '保险编号',
  invoiceAddress: '发票地址',
  invoiceBankAccount: '发票开户行及账号',
  orgName: '组织名称',
}

export default {
  title: '客户列表',
  meterTitle: '气表列表',
  importCustomer: '批量导入客户',
  removeBlack: '移出黑名单',
  addBlack: '加入黑名单',
  detailsTitle: '客户信息',
  add: '新增客户信息',
  edit: '编辑客户信息',
  contractNo: '未签约',
  contractYes: '已签约',
  ...customerFormFieldsMap,
  telphoneHint: '请输入正确的客户电话',
  idCardHint: '请输入正确的身份证号码',
  saveSuccess: '客户信息保存成功',
  
  // 导入表具信息
  importTitle: '导入客户信息',
  downloadMeterTemplate: '下载导入客户信息模板',
  importLoading: '客户信息正在导入中，请稍候...',
  importSuccess: '客户信息导入成功！',
  uploadDes1: '将文件拖到此处，或',
  uploadDes2: '点击上传',
  uploadHint: '只支持上传.xlsx, .xls文件',

  // 开户
  openAccount: '开户',
  importOpenAccount: '开户导入',
  downloadOpenAccountTemplate: '下载导入开户信息模板',
  importOpenAccountLoading: '开户信息正在导入中，请稍候...',
  importOpenAccountSuccess: '导入开户成功！',
  importOpenAccountTitle: '导入开户列表',
}

export {
  baseCustomerFormFieldsMap,
  customerFormFieldsMap,
}