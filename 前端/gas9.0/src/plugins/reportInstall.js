/*
 * @Description: 常量
 * @Author: lingw
 * @Date: 2020-11-12 09:02:08
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-19 16:38:17
 */
export const constants = {
  WAIT_RESOLVE: 0, // 待受理
  HAVE_RESOLVED: 1, // 已受理
  WAIT_SURVEY: 2, // 待踏勘
  WAIT_DESIGN: 3, // 待设计
  WAIT_CHARGE: 4, // 待收费
  WAIT_BUILD: 5, // 待施工
  WAIT_CHECK: 6, // 待验收
  WAIT_SETTLE: 7, // 待结单
  HAVE_SETTLED: 8, // 已结单
  HAVE_END: 9 // 终止
}

export default {
  install: function(Vue) {
    Vue.prototype.$constant = key => constants[key]
  }
}