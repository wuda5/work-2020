/**
 * 滞纳金国际化
 */

 // 滞纳金信息表单
 const lateFeeFieldsMap = {
  activationTime: '启用时间',
  // chargeDay: '缴费天数',
  compoundInterest: '复利',
  fixedCap: '固定上限',
  principalCap: '本金即上限',
  rate: '利率',
  useGasTypeId: '用气类型',
  executeDay: '滞纳金执行日',
  executeMonth: '滞纳金执行月',
  dataStatus: '状态',
  executeName: '滞纳金名称',
 }

export default {
  title: '滞纳金配置',
  useGasTypeLabel: '用气类型名称',
  deleteConfirm: '您确定要删除该滞纳金配置吗',
  disableConfirm: '此操作将禁用此滞纳金配置，是否继续？',
  dataStatusLabel: '是否启用',
  add: '新增滞纳金配置',
  edit: '编辑滞纳金配置',
  lateFeeTitle: '滞纳金信息',
  principalCapTitle: '上限控制',
  rateLabel: '利率%',
  fixedCapLable: '滞纳金固定上限',
  addLateFee: '新增滞纳金信息',
  editLateFee: '编辑滞纳金信息',
  viewLateFee: '查看滞纳金信息',
  rateNumberHint: '滞纳金利率必须是正数',
  fixedCapNumberHint: '滞纳金固定上限必须是正数',
  ...lateFeeFieldsMap
}

export {
  lateFeeFieldsMap
}