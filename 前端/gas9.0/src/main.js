import DataStatusSearch from '@/components/DataStatusSearch/index'
import Pagination from '@/components/Pagination/index.vue'
import QcDialog from '@/components/QcDialog/index' // 弹出窗
import QcSwitch from '@/components/Switch/index' // 封装的el-switch组件
import QcNumberInput from '@/components/QcNumberInput/Index.vue' // 封装的数字组件
// 添加全局组件
import pubComponents from '@/mixins/pubComponents'
import '@/styles/index.scss' // global css
import request from '@/utils/request'
import Element from 'element-ui'
import 'normalize.css/normalize.css' // a modern alternative to CSS resets
// v-charts
import VeHistogram from 'v-charts/lib/histogram.common'
import VeLine from 'v-charts/lib/line.common' //折线图
import VeBar from 'v-charts/lib/bar.common' //条形图
import Vue from 'vue'
import App from './App'
import * as filters from './filters' // global filters
import * as directives from './directive' // global directive
import './icons' // icon
import i18n from './lang' // internationalization
import router from './router'
import store from './store'
import './styles/element-variables.scss'
import './utils/error-log' // error log
import { hasAnyPermission, hasNoPermission, hasPermission } from './utils/permissionDirect'
import constants from './plugins/reportInstall'
import sc_constants from './plugins/securityCheck'

// el-dialog 默认点击遮照为不关闭 ESC不关闭
Element.Dialog.props.closeOnClickModal.default = false;
Element.Dialog.props.closeOnPressEscape.default = false;

const Plugins = [
  hasPermission,
  hasNoPermission,
  hasAnyPermission
]

Plugins.map((plugin) => {
  Vue.use(plugin)
})

Vue.use(Element, {
  size: 'mini', // set element-ui default size
  i18n: (key, value) => i18n.t(key, value)
})

Vue.use(constants)
Vue.use(sc_constants)

Vue.component(VeHistogram.name, VeHistogram)
Vue.component(VeLine.name, VeLine)
Vue.component(VeBar.name,VeBar)
// Vue.prototype.$lodash = lodash

Vue.mixin(pubComponents)

Vue.component(Pagination.name, Pagination)
Vue.component(QcDialog.name, QcDialog)
Vue.component(QcSwitch.name, QcSwitch)
Vue.component(QcNumberInput.name, QcNumberInput)
Vue.component(DataStatusSearch.name, DataStatusSearch)

Vue.prototype.$post = request.post
Vue.prototype.$get = request.get
Vue.prototype.$put = request.put
Vue.prototype.$delete = request.delete
Vue.prototype.$download = request.download
Vue.prototype.$upload = request.upload
Vue.prototype.$login = request.login

// register global utility filters
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})
// register global utility directives
Object.keys(directives).forEach(key => {
  Vue.directive(key, directives[key])
})

Vue.config.productionTip = false

const vue = new Vue({
  el: '#app',
  router,
  store,
  i18n,
  render: h => h(App)
})

export default vue