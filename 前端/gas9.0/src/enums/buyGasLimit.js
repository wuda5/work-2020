/**
 * 购气限制枚举
 */
import i18n from '@/lang/index'

// 购气限制类型 1-个人 0-所有
const PERSON = 0
const ALL = 1

export const limitTypeMap = {
  [PERSON]: i18n.t('operation.buyGasLimit.person'),
  [ALL]: i18n.t('operation.buyGasLimit.all'),
}

// 限制方式 0: '按月份',1: '按指定时间',
const BY_MONTH = 0
const BY_RANGE_TIME = 1
export const selectTypeMap = {
  [BY_MONTH]: i18n.t('operation.buyGasLimit.byMonth'),
  [BY_RANGE_TIME]: i18n.t('operation.buyGasLimit.byRangeTime'),
}