// 定义一些和权限有关的 Vue指令

// 必须包含列出的所有权限，元素才显示
export const hasPermission = {
  install (Vue) {
    Vue.directive('hasPermission', {
      bind (el, binding, vnode) {
        const permissions = vnode.context.$store.state.account.permissions
        const value = binding.value
        let flag = true
        for (const v of value) {
          if (!permissions.includes(v)) {
            flag = false
          }
        }
        if (!flag) {
          if (!el.parentNode) {
            el.style.display = 'none'
          } else {
            el.parentNode.removeChild(el)
          }
        }
      }
    })
  }
}

// 当不包含列出的权限时，渲染该元素
export const hasNoPermission = {
  install (Vue) {
    Vue.directive('hasNoPermission', {
      bind (el, binding, vnode) {
        const permissions = vnode.context.$store.state.account.permissions

        const value = binding.value
        let flag = true
        for (const v of value) {
          if (permissions.includes(v)) {
            flag = false
          }
        }
        if (!flag) {
          if (!el.parentNode) {
            el.style.display = 'none'
          } else {
            el.parentNode.removeChild(el)
          }
        }
      }
    })
  }
}

// 只要包含列出的任意一个权限，元素就会显示
export const hasAnyPermission = {
  install (Vue) {
    Vue.directive('hasAnyPermission', {
      bind (el, binding, vnode) {
        const permissions = vnode.context.$store.state.account.permissions
        const value = binding.value
        let flag = false
        for (const v of value) {
          if (permissions.includes(v)) {
            flag = true
          }
        }
        if (!flag) {
          if (!el.parentNode) {
            el.style.display = 'none'
          } else {
            el.parentNode.removeChild(el)
          }
        }
      }
    })
  }
}

// 这里使用v-if的方式判断
import store from '@/store'
export function checkPermission(value) {
  if (value && value instanceof Array && value.length > 0) { // 如果传入的是length大于0的数组
    const roles = store.state.account.permissions // 获取后台得到的按钮权限
    const permissionRoles = value // 把value 的值赋值给permissionRoles

    const hasPermission = roles.some(role => { // 查找权限： 在返回的权限里查找，只要满足含有传入数组中的任意一个值，就OK
      return permissionRoles.includes(role)
    })

    if (!hasPermission) { // 没有权限返回 false
      return false
    }
    return true // 有权限返回 true
  } else {
    console.error(`need roles! Like v-permission="['admin','editor']"`) // 参数不是数组格式，给出提示
    return false
  }
}
