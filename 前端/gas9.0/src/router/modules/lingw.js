/*
 * @Description: 开发测试路由
 * @Author: lingw
 * @Date: 2021-02-02 09:46:13
 * @LastEditors: lingw
 * @LastEditTime: 2021-02-02 09:50:45
 */
import EmptyLayout from '@/layout/index.vue'
import Layout from '@/layout'

const router = [
  {
    // 实时监控
    path: '/monitor',
    component: Layout,
    redirect: '/monitor/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/gmis/monitor/Index'),
        name: 'monitor',
        meta: { title: 'monitor', icon: 'monitor', noCache: true }
      }
    ]
  },
  {
    // 燃气商店
    path: '/shop',
    component: Layout,
    redirect: '/shop/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/gmis/goodsCart/Index'),
        name: 'shop',
        meta: { title: 'shop', icon: 'goodscart', noCache: true }
      }
    ]
  },
  {
    // 每日上报
    path: '/daily-report',
    component: Layout,
    redirect: '/daily-report/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/gmis/reportInfo/dailyReport/Index'),
        name: 'dailyReport',
        meta: { title: 'dailyReport', icon: 'dailyReport', noCache: true }
      }
    ]
  },
  {
    // 每日团标上报
    path: '/group-report',
    component: Layout,
    redirect: '/group-report/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/gmis/reportInfo/groupReport/Index'),
        name: 'groupReport',
        meta: { title: 'groupReport', icon: 'goodscart', noCache: true }
      }
    ]
  },
]

 export default router
