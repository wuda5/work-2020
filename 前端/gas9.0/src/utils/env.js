/**
 * 环境判断相关的
 */

// 判断是否是开发环境
export function isDevelopment() {
  return process.env.NODE_ENV === 'development'
}
// 判断是否是生产环境
export function isProduction() {
  return process.env.NODE_ENV === 'production'
}