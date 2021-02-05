/**
 * 购气配额限制 国际化
 */
// 表单字段
const preferentialFormFieldsMap = {
  dataStatus: '是否启用',
  deleteStatus: '删除状态',
  activityName: '活动名称',
  activityMoney: '活动金额',
  activityMoneyType: '活动金额方式',
  activityPercent: '活动比例(%)',
  activityScene: '活动场景',
  endTime: '结束时间',
  startTime: '开始时间',
  giveGas: '赠送气量',
  useGasTypes: '用气类型',
}

export default {
  title: '赠送减免活动配置',
  useGasTypeLabel: '用气类型名称',
  activityMoneyLabel: '赠送金额',
  derateMoneyLabel: '减免金额',
  deleteConfirm: '您确定要删除该赠送减免活动配置吗',
  disableConfirm: '此操作将禁用此赠送减免活动配置，是否继续？',
  dataStatusLabel: '是否启用',
  activityPercentNumberHint: '活动比例必须是正数',
  giveGasNumberHint: '赠送气量必须是正数',
  activityMoneyNumberHint: '活动金额必须是正数',
  activityMoneyIntegerHint: '活动金额必须是正整数',
  startTimeCompareHint: '开始时间必须小于结束时间',
  endTimeCompareHint: '结束时间必须大于开始时间',
  add: '新增赠送减免活动',
  edit: '编辑赠送减免活动',
  ...preferentialFormFieldsMap
}

export {
  preferentialFormFieldsMap
}