/*
 * @Descripttion: 
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 10:41:25
 */
const getters = {
  visitedViews: state => state.tagsView.visitedViews,
  cachedViews: state => state.tagsView.cachedViews,
  pageLoading: state => state.common.loading,
  counter: state => state.install.counter,
  processList: state => state.install.processList,
  design: state => state.install.design,
  accept: state => state.install.accept,
  result: state => state.install.result
}
export default getters
