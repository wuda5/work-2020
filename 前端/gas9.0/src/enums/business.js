/**
 * 业务相关的枚举
 */

  // 收费状态
const UNCHARGE = 'UNCHARGE' // 待收费
const CHARGING = 'CHARGING' // 收费中
const CHARGED = 'CHARGED' // 已收费
const REFUND = 'REFUND' // 已退费
const CHARGE_FAILURE = 'CHARGE_FAILURE' //收费失败

export const chargeStatusFields = {
  UNCHARGE,
  CHARGING,
  CHARGED,
  REFUND,
  CHARGE_FAILURE,
}

export const chargeStatusMap = {
  [UNCHARGE]: '待收费',
  [CHARGING]: '收费中',
  [CHARGED]: '已收费',
  [REFUND]: '已退费',
  [CHARGE_FAILURE]: '收费失败',
}

export const chargeStatusClassMap = {
  [UNCHARGE]: 'warning',
  [CHARGING]: 'primary',
  [CHARGED]: 'success',
  [REFUND]: 'info',
  [CHARGE_FAILURE]: 'danger',
}

// 发票状态
const NOT_OPEN = 0 //未开票
const NOT_OPEN_CODE = 'NOT_OPEN' //未开票
const OPENING = 1 //开票中
const OPENING_CODE = 'OPENING' //开票中
const OPEN_SUCCESS = 2 //开票成功
const OPEN_SUCCESS_CODE = 'OPEN_SUCCESS' //开票成功
const OPENED = 2 //开票成功
const OPENED_CODE = 'OPENED' //开票成功
const OPEN_FAIL = 3 //开票失败
const OPEN_FAIL_CODE = 'OPEN_FAIL' //开票失败

export const invoiceStatusFields = {
  NOT_OPEN,
  NOT_OPEN_CODE,
  OPENING,
  OPENING_CODE,
  OPEN_SUCCESS,
  OPEN_SUCCESS_CODE,
  OPEN_FAIL,
  OPEN_FAIL_CODE,
  OPENED,
  OPENED_CODE,
}

// 所有发票状态值映射
export const allInvoiceStatusMap = {
  [NOT_OPEN]: '未开票',
  [NOT_OPEN_CODE]: '未开票',
  [OPENING]: '开票中',
  [OPENING_CODE]: '开票中',
  [OPEN_SUCCESS]: '开票成功',
  [OPEN_SUCCESS_CODE]: '开票成功',
  [OPENED]: '已开票',
  [OPENED_CODE]: '已开票',
  [OPEN_FAIL]: '开票失败',
  [OPEN_FAIL_CODE]: '开票失败',
}

export const invoiceStatusMap = {
  [NOT_OPEN]: '未开票',
  [OPENING]: '开票中',
  [OPEN_SUCCESS]: '开票成功',
  [OPEN_FAIL]: '开票失败',
}

// 发票状态tag样式映射
export const invoiceStatusClassMap = {
  [NOT_OPEN]: 'warning',
  [NOT_OPEN_CODE]: 'warning',
  [OPENING]: 'primary',
  [OPENING_CODE]: 'primary',
  [OPEN_SUCCESS]: 'success',
  [OPEN_SUCCESS_CODE]: 'success',
  [OPEN_FAIL]: 'danger',
  [OPEN_FAIL_CODE]: 'danger',
}

// 充值状态
export const moneyFlowStatus = {
  waite_deal: '待处理（下发|写卡）',
  waite_to_meter: '待上表',
  success: '处理成功', // （已上表成功）
  deal_failure: '处理失败（下发|写卡）',
  meter_failure: '上表失败',
}

// 发票种类
const RED_INVOICE = 0 //红票
const BLUE_INVOICE = 1 //蓝票
const INVALID_INVOICE = 2 //废票

export const invoiceKindFields = {
  RED_INVOICE,
  BLUE_INVOICE,
  INVALID_INVOICE,
}

export const invoiceKindMap = {
  [RED_INVOICE]: '红票',
  [BLUE_INVOICE]: '蓝票',
  [INVALID_INVOICE]: '废票',
}

// 收费场景
const INSURANCE_FEE = 'INSURANCE_FEE' // 保险费
const GAS_FEE = 'GAS_FEE' // 燃气费
const OPEN_ACCOUNT = 'OPEN_ACCOUNT' // 开户
const OTHER = 'OTHER' // 附加费
const ISSUE_CARD = 'ISSUE_CARD' // 发卡
const CARD_REPLACEMENT = 'CARD_REPLACEMENT' // 补卡
const CHANGE_METER = 'CHANGE_METER' // 换表
const TRANSFER = 'TRANSFER' // 过户
const DIS_METER = 'DIS_METER' // 拆表
const GAS_COMPENSATION = 'GAS_COMPENSATION' // 调价补差

// 收费场景字段
export const chargeSceneFields = {
  INSURANCE_FEE,
  GAS_FEE,
  OPEN_ACCOUNT,
  OTHER,
  ISSUE_CARD,
  CARD_REPLACEMENT,
  CHANGE_METER,
  TRANSFER,
  DIS_METER,
  GAS_COMPENSATION,
}
