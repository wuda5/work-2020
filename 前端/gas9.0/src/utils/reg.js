// 手机
export const reg_phone = /^1[3|4|5|7|8|9][0-9]{9}$/
// 身份证
export const reg_IDCard = /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$)/
// 密码 必须包含字母、数字，至少6个字符，最多16个字符。
export const reg_pwd = /(?=.*[0-9])(?=.*[a-zA-Z]).{6,16}/

/**
 * 常用的正则枚举
 */

// 手机号码
export const mobileReg = /^(13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[8-9])[0-9]{8}$/

// 固定电话
export const telephoneReg = /^((\d{3,4})|\d{3,4}-|\s)?\d{8}$/

// 联系电话（手机号码或者固定电话）
export const phoneReg = /^(((13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[8-9])[0-9]{8})|(((\d{3,4})|\d{3,4}-|\s)?\d{8}))$/

// 身份证号(为了匹配后端验证规则)
// export const idcardReg = /^(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}$)$/
export const idcardReg = /^(^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}$)$/

// 所有数字（正数、负数），包括整数、小数、0
export const numberReg = /^(-)?(([0-9])|([1-9]([0-9]+)))(.[0-9]+)?$/

// 所有正数，包括整数、小数、0
export const positiveNumberReg = /^(([0-9])|([1-9]([0-9]+)))(.[0-9]+)?$/

// 正整数
export const positiveIntegerReg = /^\d+?$/

// 数字和字母组成
export const numberAndLetterReg = /^[a-z0-9]+$/i

// 数字、字母和下划线组成
export const numberAndLetterAndUnderscoreReg = /^\w+$/

