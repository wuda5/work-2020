/**
 * 优惠活动枚举
 */
import { dataStatusField } from './common'
import i18n from '@/lang/index'

// 活动有效期：1-长期有效 2-开户有效 3-固定时间有效	
const CQYX = 1
const KHYX = 2
const GDSJYX = 3

export const preferentialActivateField = {
  CQYX,
  KHYX,
  GDSJYX,
}

export const preferentialActivateMap = {
  [CQYX]: '长期有效',
  [KHYX]: '开户有效',
  [GDSJYX]: '固定时间有效',
}

// 1.百分比  （百分比，金额不可用）2.固定金额 3.不固定金额',
const BFBJE = 'percent'
const GDJE = 'fixed'
const BGDJE = 'unfixed'

export const activityMoneyTypeField = {
  BFBJE,
  GDJE,
  BGDJE,
}

export const activityMoneyTypeMap = {
  [BFBJE]: '百分比',
  [GDJE]: '固定金额',
  [BGDJE]: '不固定金额',
}

// 是否持续优惠
export const isAlwaysPreferentialMap = {
  [dataStatusField.INVALID]: i18n.t('no'),
  [dataStatusField.VALID]: i18n.t('yes'),
}

export const isAlwaysPreferentialClassMap = {
  [dataStatusField.INVALID]: 'danger',
  [dataStatusField.VALID]: 'success',
}

// 充值场景 1.百分比  （百分比，金额不可用）2.固定金额 3.不固定金额',
const RECHARGE_GIVE = 'RECHARGE_GIVE' //充值赠送
const PRECHARGE_GIVE = 'PRECHARGE_GIVE' //预存赠送
const CHARGE_DE = 'CHARGE_DE' //缴费减免

export const activitySceneField = {
  RECHARGE_GIVE,
  PRECHARGE_GIVE,
  CHARGE_DE,
}