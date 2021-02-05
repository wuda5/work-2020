
/**
 * 活动管理 国际化
 */
// 活动公用表单字段
const commonFormFieldsMap = {
  dataStatus: '是否启用',
  deleteStatus: '删除状态',
  activityName: '活动名称',
  activityMoney: '赠送金额',
  activityMoneyType: '活动金额方式',
  activityScene: '活动场景',
  endTime: '结束时间',
  startTime: '开始时间',
}

// 充值赠送活动表单字段
const rechargeGiveFormFieldsMap = {
  ...commonFormFieldsMap,
  activityPercent: '赠送比例', 
  giveGas: '赠送气量',
  useGasTypes: '用气类型',
}

// 缴费减免活动表单字段
const feeReduceFormFieldsMap = {
  ...commonFormFieldsMap,
  tollItemScene: '收费场景',
  tollItemId: '收费项ID',
  tollItemName: '收费项',
}

export default {
  // 充值赠送活动相关的
  rechargeGive: {
    ...rechargeGiveFormFieldsMap,
    
    // 杂项
    title: '充值赠送活动配置',
    useGasTypeLabel: '用气类型名称',
    activityMoneyTypeLabel: '赠送方式',
    activityMoneyLabel: '赠送金额',
    activityPercentLabel: '赠送比例(%)',
    deleteConfirm: '您确定要删除该充值赠送活动配置吗',
    disableConfirm: '此操作将禁用此充值赠送活动配置，是否继续？',
    dataStatusLabel: '是否启用',
    activityPercentNumberHint: '活动比例必须是正数',
    giveGasNumberHint: '赠送气量必须是正数',
    activityMoneyNumberHint: '赠送金额必须是正数',
    activityMoneyIntegerHint: '赠送金额必须是正整数',
    startTimeCompareHint: '开始时间必须小于结束时间',
    endTimeCompareHint: '结束时间必须大于开始时间',
    add: '新增充值赠送活动',
    edit: '编辑充值赠送活动',
  },

  // 缴费减免活动相关
  feeReduce: {
    ...feeReduceFormFieldsMap,
    
    // 杂项
    title: '缴费减免活动配置',
    activityMoneyTypeLabel: '减免方式',
    activityMoneyLabel: '减免金额',
    deleteConfirm: '您确定要删除该缴费减免活动配置吗',
    disableConfirm: '此操作将禁用此缴费减免活动配置，是否继续？',
    dataStatusLabel: '是否启用',
    activityPercentNumberHint: '活动比例必须是正数',
    giveGasNumberHint: '赠送气量必须是正数',
    activityMoneyNumberHint: '活动金额必须是正数',
    activityMoneyIntegerHint: '活动金额必须是正整数',
    activityMoneyInputHint: '减免金额输入范围:',
    activityMoneyValidHint: '减免金额请输入规定范围内正数',
    startTimeCompareHint: '开始时间必须小于结束时间',
    endTimeCompareHint: '结束时间必须大于开始时间',
    add: '新增缴费减免活动',
    edit: '编辑缴费减免活动',
  },
}

export {
  rechargeGiveFormFieldsMap,
  feeReduceFormFieldsMap
}