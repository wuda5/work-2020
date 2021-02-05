/*
 * @Descripttion: 
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-15 09:07:37
 */
import Vue from 'vue'
import Vuex from 'vuex'

import getters from './getters'
// // https://webpack.js.org/guides/dependency-management/#requirecontext
const modulesFiles = require.context('./modules', true, /\.js$/)

// you do not need `import app from './modules/app'`
// it will auto require all vuex module from modules file
const modules = modulesFiles.keys().reduce((modules, modulePath) => {
  // set './app.js' => 'app'
  const moduleName = modulePath.replace(/^\.\/(.*)\.\w+$/, '$1')
  const value = modulesFiles(modulePath)
  modules[moduleName] = value.default
  return modules
}, {})

// 加载所有模块。
// function loadModules() {
//   const context = require.context('./modules', false, /([a-z_]+)\.js$/i)

//   const modules = context
//     .keys()
//     .map((key) => ({ key, name: key.match(/([a-z_]+)\.js$/i)[1] }))
//     .reduce(
//       (modules, { key, name }) => ({
//         ...modules,
//         [name]: context(key).default
//       }),
//       {}
//     )

//   return { context, modules }
// }

// const { context, modules } = loadModules()

Vue.use(Vuex)

const store = new Vuex.Store({
  modules,
  getters
})

// if (module.hot) {
//   // 在任何模块发生改变时进行热重载。
//   module.hot.accept(context.id, () => {
//     const { modules } = loadModules()

//     store.hotUpdate({
//       modules
//     })
//   })
// }

export default store
