/**
 * 运营配置相关路由
 */

import Layout from '@/layout'

const router = {
  path: '/operation',
  component: Layout,
  redirect: '/operation/community',
  children: [{
    path: 'community',
    name: 'Street',
    component: () => import('@/views/gmis/operation/community/Index.vue'),
    meta: {
      title: '地址配置'
    }
  },{
    path: 'gasPrice',
    name: 'GasPrice',
    component: () => import('@/views/gmis/operation/gasPrice/Index.vue'),
    meta: {
      title: '气价配置'
    }
  },]
}

 export default router