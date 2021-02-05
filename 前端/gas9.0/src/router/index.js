import loginApi from '@/api/Login.js'
import Layout from '@/layout'
import store from '@/store/index'
import getPageTitle from '@/utils/get-page-title'
import db from '@/utils/localstorage'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import Vue from 'vue'
import Router from 'vue-router'
import {Message} from 'element-ui';

// 李良波路由测试添加
import lilbTestRouter from './modules/lilb'

const lilbDevelopRouter = lilbTestRouter

import lingwDevRouter from './modules/lingw'
// end 李良波路由测试添加

// console.log(store.state.account.routes)
// console.log(db.get('USER_ROUTER'))

// ★★★★获取登陆后跳转地址
function getFirstRoute(routes) {
  let firstRoute = routes[0]
  let str = ''

  if (firstRoute.name === '404') {
    Message.error('你当前无资源分配，请联系管理员！')
    return false
  }

  // 如果跳转
  if (firstRoute.redirect) {
    str = firstRoute.path + '/' + firstRoute.children[0].path
  } else {
    str = firstRoute.children[0].path
  }
  return str
}

// getFirstRoute()

// 解决跳转路由跳转，在控制台报错问题（路由版本过高的原因）
const originalPush = Router.prototype.push
Router.prototype.push = function push(location, onResolve, onReject) {
  if (onResolve || onReject) return originalPush.call(this, location, onResolve, onReject)
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(Router)

const constRouter = [
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path*',
        component: resolve => require(['@/views/redirect/index'], resolve)
      }
    ]
  },
  {
    path: '/404',
    component: resolve => require(['@/views/error-page/404'], resolve),
    hidden: true
  },
  {
    path: '/login',
    name: '登录页',
    component: () => import('@/views/login/index')
  },
  /*{
    path: '/',
    component: Layout,
    redirect: '/dailyWork/Index',
    children: [
      {
        path: 'dashboard',
        component: resolve => require(['@/views/dashboard/index'], resolve),
        name: 'Dashboard',
        meta: {title: 'dashboard', icon: 'dashboard', affix: true}
      }
    ]
  },*/
  {
    path: '/profile',
    component: Layout,
    redirect: '/profile/index',
    hidden: true,
    children: [
      {
        path: 'index',
        component: resolve => require(['@/views/profile/index'], resolve),
        name: 'Profile',
        meta: {title: 'profile', icon: 'user', noCache: true}
      },
      {
        hidden: true,
        path: '/sms/manage/edit',
        component: resolve => require(['@/views/gmis/sms/manage/Edit'], resolve),
        name: 'smsEdit',
        meta: {
          title: '发送短信', icon: '', noCache: true
        }
      }
    ]
  },
  {
    path: '/error',
    component: Layout,
    redirect: 'noRedirect',
    name: 'ErrorPages',
    meta: {
      title: 'errorPages',
      icon: '404'
    },
    children: [
      {
        path: '404',
        component: resolve => require(['@/views/error-page/404'], resolve),
        name: 'Page404',
        meta: {title: 'page404', noCache: true}
      }
    ]
  },
  ...lingwDevRouter,
  ...lilbDevelopRouter
  // 为什么写在这里 就会出错？
  // {
  //   path: "*",
  //   // redirect: '/404',
  //   component: () => import('@/views/error-page/404'),
  //   name: "all_404",
  //   hidden: false,
  //   alwaysShow: false
  // }
]

// 开发环境添加后台开发API选择
const env = process.env.NODE_ENV
if (env === 'development') {
  // 开发环境路由
  const devConstRouter = [
    {
      path: '/select-api',
      name: 'SelectApi',
      component: Layout,
      children: [
        {
          path: 'index',
          name: 'SelectApi',
          component: () => import('@/views/select-api/Index.vue'),
          meta: {
            title: '选择后台api',
          }
        }
      ],
    },
    {
      path: '/base',
      name: 'baseLayout',
      component: Layout,
      children: [
        {
          path: 'dict',
          name: 'dict',
          component: () => import('@/views/gmis/base/dict/Index'),
          meta: {
            title: '数据字典维护',
          }
        }
      ],
    },
  ]
  constRouter.push(...devConstRouter)
}

const router = new Router({
  scrollBehavior: () => ({y: 0}),
  routes: constRouter
})

const whiteList = ['/login', '/select-api/index']

// 加载的路由信息
let asyncRouter

// 导航守卫，渲染动态路由
router.beforeEach((to, from, next) => {
  NProgress.start()

  // set page title
  document.title = getPageTitle(to.meta.title)
  //如果请求理由不在白名单
  if (whiteList.indexOf(to.path) !== -1) {
    // 将加载的路由信息置空
    // asyncRouter = null
    next()
  }
  // 如果白名单没有
  else {
    const token = db.get('TOKEN', '')
    const user = db.get('USER')
    const userRouter = db.get('USER_ROUTER', '') //缓存中的路由
    // const userRouter = store.state.account.routes //缓存中的路由
    // 如果有token 和 user
    if (token && token.length && user) {
      // 如果没有动态路由
      if (!asyncRouter) {
        // 缓存中的路由也没有
        if (!userRouter) {
          loginApi.getRouter({}).then((response) => {
            const res = response.data

            // ★★★处理单菜单不能显示layout布局问题 -----------------------------------------
            let router1 = res.data
            let router2 = router1.map(function (item, index, array) {
              if (item.children) {
                return item
              } else {
                let oldComponent = item.component
                item.component = 'Layout'
                item.redirect = 'Index'
                item.children = [{
                  path: 'Index',
                  component: oldComponent,
                  name: item.name,
                  meta: item.meta
                }]

                return item
              }
            })
            // console.log(router2);

            // 格式如下：
            // let my = {
            //   // 用户档案
            //   path: '/userInfo',
            //   component: 'Layout',
            //   redirect: 'Index',
            //   name:'用户档案',
            //   children: [
            //     {
            //       path: 'Index',
            //       component:'gmis/userInfo/Index',
            //       name: 'meterInfo',
            //       meta: {title: '用户档案', icon: 'user', noCache: true}
            //     }
            //   ]
            // }
            // let editRouter = res.data[0]=my
            // -----------------------------------------
            asyncRouter = router2
            // asyncRouter = res.data

            if (!(asyncRouter && asyncRouter.length > 0)) {
              asyncRouter = []
            }
            asyncRouter.push({
              alwaysShow: false,
              component: 'error-page/404',
              hidden: false,
              name: '404',
              path: '*'
            });

            store.commit('account/setRoutes', asyncRouter)

            go(to, next)
          })
        } else {
          asyncRouter = userRouter
          go(to, next)
        }
      } else {
        // console.log({to,from})
        // 权限资源判断
        if (to.path === '/') {
          // console.log(asyncRouter)
          let userIndex = getFirstRoute(asyncRouter)
          // console.log(userIndex);
          if (userIndex) {
            next(userIndex)
          } else {
            // next('/login')
            return
          }
        }
        next()
      }
    } else {

      if (to.path === '/login') {
        // 将加载的路由信息置空
        asyncRouter = null
        next()
      } else {
        next('/login')
      }
    }
  }
})

router.afterEach(() => {
  NProgress.done()
})

function go(to, next) {
  asyncRouter = filterAsyncRouter(asyncRouter)
  router.addRoutes(asyncRouter)
  next({...to, replace: true})
}

function filterAsyncRouter(routes) {
  return routes.filter((route) => {
    const component = route.component
    if (component) {
      if (route.component === 'Layout') {
        route.component = Layout
      } else {
        route.component = view(component)
      }
      if (route.children && route.children.length) {
        route.children = filterAsyncRouter(route.children)
      }
      return true
    }
  })
}

function view(path) {
  return function (resolve) {
    // 这段代码莫名奇妙就开始报错了，之前是好的
    // import(`@/views/${path}.vue`).then(mod => {
    //   resolve(mod)
    // })
    require([`@/views/${path}.vue`], resolve)
  }
}

export default router
