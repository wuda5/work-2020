/*
  抄表枚举
*/

// 抄表进度
const TO_BE_REVIEWED = 'TO_BE_REVIEWED'
const SUBMIT_FOR_REVIEW = 'SUBMIT_FOR_REVIEW'
const APPROVED = 'APPROVED'
const SETTLED = 'SETTLED'
const REVIEW_REJECTED = 'REVIEW_REJECTED'

export const processField = {
  TO_BE_REVIEWED,
  SUBMIT_FOR_REVIEW,
  APPROVED,
  SETTLED,
  REVIEW_REJECTED,
}

export const processMap = {
  [TO_BE_REVIEWED]: '待审核',
  [SUBMIT_FOR_REVIEW]: '提审',
  [APPROVED]: '审核通过（待结算）',
  [SETTLED]: '结算完成',
  [REVIEW_REJECTED]: '审核驳回',
}

// 收费状态

const NO_CHARGE = 'NO_CHARGE'
const ARREARS = 'ARREARS'
const CHARGED = 'CHARGED'
const INVOICED = 'INVOICED'

export const chargeStatusField = {
  NO_CHARGE,
  ARREARS,
  CHARGED,
  INVOICED,
}

export const chargeStatusMap = {
  [NO_CHARGE]: '待收费',
  [ARREARS]: '欠费',
  [CHARGED]: '已收费（待出票）',
  [INVOICED]: '已出票',
}

// 物联网抄表数据状态
export const iotDataStatusMap = {
  0: '无效数据',
  1: '上报异常',
  2: '结算异常',
} 