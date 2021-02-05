/**
 * 购气配额限制 国际化
 */
// 表单字段
const buyGasLimitFormFieldsMap = {
  dataStatus: '状态',
  useGasTypeId: '用气类型ID',
  useGasTypeName: '用气类型',
  limitName: '限购名称',
  limitType: '限制类型',
  startTime: '启用时间',
  endTime: '结束时间',
  cycle: '周期',
  cycleNum: '重复次数',
  maxChargeGas: '最大充值气量',
  maxChargeMoney: '最大充值金额',
  selectType: '限制方式',
}

export default {
  title: '限购配置',
  useGasTypeLabel: '用气类型名称',
  deleteConfirm: '您确定要删除该限购配置吗',
  disableConfirm: '此操作将禁用此限购配置，是否继续？',
  dataStatusLabel: '是否启用',
  maxChargeGasNumberHint: '最大充值气量必须是正数',
  maxChargeMoneyNumberHint: '最大充值金额必须是正数',
  cycleNumNumberHint: '重复次数必须是是大于1的正整数',
  startTimeCompareHint: '开始时间必须小于结算时间',
  endTimeCompareHint: '结束时间必须大于开始时间',
  add: '新增限购方案',
  edit: '编辑限购方案',
  all: '所有',
  person: '个人',
  byMonth: '按月份',
  byRangeTime: '按指定时间',
  ...buyGasLimitFormFieldsMap
}

export {
  buyGasLimitFormFieldsMap
}