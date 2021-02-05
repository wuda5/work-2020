/*
 * @Description: 常量
 * @Author: lingw
 * @Date: 2020-11-19 09:02:08
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-19 17:26:00
 */
export const constants = {
  WAIT_ARRAIGNED: 0, // 待提审
  WAIT_AUDIT: 1, // 待审核
  WAIT_ORDER: 2, // 待派工
  WAIT_CHECK: 3, // 待安检
  WAIT_FALLBACK: 4, // 待回访
  EXCEPTION: 5, // 异常
  HAVE_SETTLED: 6, // 已结单
  HAVE_END: 7 // 终止
}

export default {
  install: function(Vue) {
    Vue.prototype.$sc_constant = key => constants[key]
  }
}