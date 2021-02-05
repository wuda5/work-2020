/*
 * @Descripttion: 报装 - 状态管理
 * @Author: lingw
 * @Date: 2020-10-08 15:39:26
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 10:46:24
 */
import { SET_COUNTER, SET_PROCESS, SET_DESIGN, SET_ACCEPT, SET_RESULT } from '../mutation-types'

export default {
  namespaced: true,
  state: {
    // 统计报装
    counter: {},
    // 流程信息
    processList: [],
    // 设计方案
    design: {},
    // 验收资料详情
    accept: {},
    // 安装结果
    result: {}
  },
  mutations: {
    [SET_COUNTER]: (state, val) => {
      state.counter = val
    },
    [SET_PROCESS]: (state, val) => {
      state.processList = val
    },
    [SET_DESIGN]: (state, val) => {
      state.design = val
    },
    [SET_ACCEPT]: (state, val) => {
      state.accept = val
    },
    [SET_RESULT]: (state, val) => {
      state.result = val
    }
  }
}
