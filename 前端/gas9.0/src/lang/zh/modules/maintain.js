/**
 * 运营配置模块统一国际化入口
 */
let pages = []
try {
  const pagesFiles = require.context('./maintain', true, /\.js$/)
  pages = pagesFiles.keys().reduce((pages, pagePath) => {
    // set './app.js' => 'app'
    const pageName = pagePath.replace(/^\.\/(.*)\.\w+$/, '$1')
    const value = pagesFiles(pagePath)
    pages[pageName] = value?.default || {}
    return pages
  }, {})
} catch (error) {
  console.log('page in18 error:', error)
}

// console.log('pages', pages)

 export default {
   ...pages
 }
