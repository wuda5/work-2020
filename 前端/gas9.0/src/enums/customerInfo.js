/**
 *  客户档案枚举
 */
import i18n from '@/lang/index'

 // 黑名单
 const NO = 0 // 不是黑名单
 const YES = 1 // 黑名单

 export const blackStatusField = {
   NO,
   YES,
 }

 // 黑名单状态
 export const blackStatusMap = {
    [NO]: i18n.t('no'),
    [YES]: i18n.t('yes'),
 }

 // 代扣签约状态
const CONTRACT_NO = false //未签约
const CONTRACT_YES = false //已签约

export const contractStatusField = {
   CONTRACT_NO,
   CONTRACT_YES
}

export const contractStatusMap = {
   [CONTRACT_NO]: i18n.t('customerInfo.contractNo'),
   [CONTRACT_YES]: i18n.t('customerInfo.contractYes'),
}

 // 客户性别
 const MAN = 'MAN' // 男
 const WOMEN = 'WOMEN' // 女

 export const sexField = {
    MAN,
    WOMEN
 }

 // 客户状态
 const YJD = 0; // 预建档
 const VALID = 1; // 有效
 const INVALID = 2; // 无效

 // 客户状态字段
 export const customerStatusField = {
  YJD,
  VALID,
  INVALID,
 }