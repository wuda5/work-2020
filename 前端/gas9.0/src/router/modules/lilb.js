/**
 * lilb开发测试路由
 */
import EmptyLayout from '@/layout/index.vue'
import Layout from '@/layout'

const router = [
  {
    path: '/lilb-test',
    component: EmptyLayout,
    redirect: '/lilb-test/index',
    children: [{
      path: 'index',
      name: 'LilbTestIndex',
      component: () => import('@/views/lilb-test/Index.vue'),
      meta: {
        title: 'test'
      }
    }, {
      path: 'export',
      name: 'LilbTestExport',
      component: () => import('@/views/lilb-test/Export.vue'),
      meta: {
        title: '导出文件demo'
      }
    },{
      path: 'scan',
      name: 'LilbTestSacn',
      component: () => import('@/views/lilb-test/Scan.vue'),
      meta: {
        title: '扫码test'
      }
    },]
  },
  {
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
  },
]

 export default router
