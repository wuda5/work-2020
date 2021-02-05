/**
 * 电子发票平台服务配置 国际化
 */
// 表单字段
const formFieldsMap = {
  appSecret: 'app_secret',
  contacts: '联系人',
  openId: 'open_id',
  otherParam: '其它参数',
  platName: '电子发票平台名称',
  platCode: '平台编码',
  telephone: '联系电话',
  url: '请求路径',
  dataStatus: '状态',
  deleteStatus: '状态',
  file: '文件上传',
  keyStoreAlias: '证书别名',
  keyStorePwd: '证书密码',
}

export default {
  ...formFieldsMap,
  title: '电子发票平台配置',
  deleteConfirm: '您确定要删除该电子发票平台配置吗',
  disableConfirm: '此操作将禁用此电子发票平台配置，是否继续？',
  dataStatusLabel: '是否启用',
  add: '新增电子发票平台配置',
  edit: '编辑电子发票平台配置',
  all: '所有',
  urlHint: '请求路径格式不正确',
  telephoneHint: '联系电话格式不正确',
  otherParamLabel: '其它参数(json格式)',
  otherParamHint: '在线json校验格式化工具链接:',
  otherParamErrorHint: '参数格式不正确',
  fileHint: '请上传文件',
}

export {
  formFieldsMap
}