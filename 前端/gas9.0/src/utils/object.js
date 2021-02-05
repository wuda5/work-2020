
/**
 * 判断一个对象是不是空对象
 * @param {object} object 判断的值
 */
export function isEmptyObject(obj) {
  return JSON.stringify(obj) === '{}'
}

