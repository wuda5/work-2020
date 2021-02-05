/**
 * 气价先关的枚举
 */
import { dataStatusField } from './common'
import i18n from '@/lang/index'

 const HEATING_PRICE = 'HEATING_PRICE' // 采暖价
 const LADDER_PRICE = 'LADDER_PRICE' // 阶梯价
 const FIXED_PRICE = 'FIXED_PRICE' // 固定单价

 export const priceTypeField = {
  HEATING_PRICE,
  LADDER_PRICE,
  FIXED_PRICE,
 }
 
 // 是否采暖map（1-采暖，0-非采暖）
 export const isHeatingMap = {
  [dataStatusField.VALID]: i18n.t('operation.gasPrice.heatingPriceLabel'), //采暖
  [dataStatusField.INVALID]: i18n.t('operation.gasPrice.nonheatingPriceLabel'), // 非采暖
 }