/**
 * 购气配额限制 国际化
 */
// 表单字段
const formFieldsMap = {
  appId: 'appId',
  appSecret: 'appSecret',
  domainId: '唯一标识',
  factoryCode: '厂家编码',
  factoryName: '厂家名称',
  gatewayName: '网关名称',
  gatewayUrl: '网关地址',
  gatewayVersion: '网关版本',
  licence: 'licence',
  // noticeCacheDay: '缓存通知天数',
  noticeType: '通知类型',
  // noticeUrl: '通知地址',
  noticeUrl: '通知ip(域名)',
  remark: '备注',
  // subscribe: '是否订阅',
  dataStatus: '状态'
}

export default {
  ...formFieldsMap,
  title: '厂家网关配置',
  deleteConfirm: '您确定要删除该厂家网关配置吗',
  disableConfirm: '此操作将禁用此厂家网关配置，是否继续？',
  dataStatusLabel: '是否启用',
  add: '新增厂家网关配置',
  edit: '编辑厂家网关配置',
  all: '所有',
  gatewayUrlHint: '网关地址格式不正确',
  noticeUrlHint: '通知地址格式不正确',
}

export {
  formFieldsMap
}