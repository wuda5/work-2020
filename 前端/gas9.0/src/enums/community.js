/**
 * 地址配置枚举
 */

 // 详细地址类型
 const COUNTRY = 0 // 农村
 const CITY = 1 // 城市

 export const addressTypeField = {
  COUNTRY,
  CITY,
 }

 export const addressTypeMap = {
   [COUNTRY]: '农村',
   [CITY]: '城市',
 }