/**
 * 全局相关的
 */
import i18n from '@/lang/index'

// 数据状态
const INVALID = 0 // 无效
const VALID = 1 // 有效
const ALL = '' // 全部

export const dataStatusField = {
  INVALID,
  VALID
}

export const dataStatusMap = {
  [INVALID]: i18n.t('invalid'), // 无效
  [VALID]: i18n.t('valid'), // 有效
}

export const dataStatusDisableMap = {
  [INVALID]:  i18n.t('havedDisable'), // 禁用
  [VALID]: i18n.t('havedEnable'), //启用
}

// 导入数据状态
export const importDataStatusMap = {
  [INVALID]:  i18n.t('fail'), // 禁用
  [VALID]: i18n.t('success'), //启用
}

// 数据状态查询
export const dataStatusSearchMap = {
  [VALID]: i18n.t('valid'),
  [INVALID]: i18n.t('invalid'),
  [ALL]: i18n.t('all'),
}

// 表格过滤数据状态选项
export const dataStatusfilters = Object.keys(dataStatusDisableMap).map((value) => ({ text: dataStatusDisableMap[value], value }))

// 表格过滤导出数据状态选项
export const importDataStatusfilters = Object.keys(importDataStatusMap).map((value) => ({ text: importDataStatusMap[value], value }))

// 删除数据状态
const DELETE_INVALID = 0 // 删除无效
const DELETE_VALID = 1 // 删除有效

export const deleteStatusField = {
  DELETE_INVALID,
  DELETE_VALID
}

// 启用，禁用
const DISABLE = 0 // 无效
const ENABLE = 1 // 无效

export const useStatusField = {
  DISABLE,
  ENABLE
}

// 用于el-tag显示数据状态
export const dataStatusClassMap = {
  [dataStatusField.INVALID]: 'danger',
  [dataStatusField.VALID]: 'success',
}