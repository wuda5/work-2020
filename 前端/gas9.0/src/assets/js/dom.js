/*
 * @Description: 
 * @Author: lingw
 * @Date: 2020-10-20 08:44:59
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 08:45:18
 */
export const matchesSelectorToParentElements = (el, selector, baseNode) => {
  let node = el
  do {
    if (node.matches(selector)) return true
    if (node === baseNode) return false
    node = node.parentNode
  } while (node)

  return false
}
