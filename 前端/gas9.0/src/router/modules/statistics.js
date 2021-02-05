/**
 * 统计分析相关路由
 */

import Layout from '@/layout'

const router = {
  path: '/statistics',
  component: Layout,
  redirect: '/statistics/index',
  children: [{
    path: 'index',
    name: 'Statistic',
    component: () => import('@/views/gmis/statistics/Index.vue'),
    meta: {
      title: '统计分析'
    }
  }]
}

 export default router