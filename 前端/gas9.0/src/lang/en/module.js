/**
 * 模块国际化统一入口
 */
let modules = []
try {
  const modulesFiles = require.context('./modules', false, /\.js$/)
  modules = modulesFiles.keys().reduce((modules, modulePath) => {
    // set './app.js' => 'app'
    const moduleName = modulePath.replace(/^\.\/(.*)\.\w+$/, '$1')
    const value = modulesFiles(modulePath)
    modules[moduleName] = value?.default || {}
    return modules
  }, {})
} catch (error) {
  console.log('module.js error:', error)
}

// console.log('modules', modules)

export default modules