/**
 * 运营配置相关路由
 */

import Layout from '@/layout'

const router = {
  path: '/maintain',
  component: Layout,
  redirect: '/maintain/command',
  children: [{
    path: 'command',
    name: 'commandMaintain',
    component: () => import('@/views/gmis/maintain/command/Index.vue'),
    meta: {
      title: '指令维护'
    }
  }]
}

 export default router