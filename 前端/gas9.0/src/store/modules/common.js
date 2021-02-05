/*
 * @Descripttion:
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-10 17:16:01
 */
import db from '@/utils/localstorage'
import {SET_LOADING} from '../mutation-types'

// 设置dictMap

let getDicMap = (dict) => {
  let dictMap = {}
  for (let key in dict) {
    dictMap[key] = {}
    let item = dict[key]
    for (let i = 0; i < item.length; i++) {
      const itemElement = item[i];
      dictMap[key][itemElement.code] = itemElement.name
    }
  }
  // console.log('getDictMap')
  return dictMap
}

const state = {
  dict: db.get('DICT') || {}, // 字典对象
  dictMap: getDicMap(db.get('DICT')),
  loading: false // 页面级加载显示
}

const mutations = {
  setDict(state, val = {}) {
    db.save('DICT', val)
    state.dict = val
  },
  [SET_LOADING](state, val) {
    state.loading = val
  }
}

export default {
  namespaced: true,
  state,
  mutations
}
