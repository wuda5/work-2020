/**
 * 购气配额限制 国际化
 */
// 表单字段
// 客户列表搜索表单
const customerSearchFormFieldsMap = {
  customerChargeNo: '缴费编号',
  customerCode: '客户编号',
  customerName: '客户名称',
  gasCode: '气表编号',
  gasMeterNumber: '表身号',
  gasMeterAddress: '安装地址',
  moreGasMeterAddress: '安装地址',
  communityId: '小区(村、xx路)ID',
  streetId: '街道(乡镇)ID',
  telphone: '联系电话',
  areaCode: '区id',
  cityCode: '市id',
  provinceCode: '省id',
}

export default {
  title: '限购客户配置',
  buyGasLimitTitle: '限购方案列表',
  limitName: '限购名称',
  useGasTypeLabel: '用气类型名称',
  streetName: '街道(乡镇)',
  communityName: '小区(村、xx路)',
  useGasTypeId: '用气类型id',
  useGasTypeName: '用气类型',
  gasMeterFactoryName: '气表厂家',
  gasMeterVersionName: '气表版号',
  customerTitle: '客户列表',
  customerLimitTitle: '限制客户列表',
  removeLimitBtn: '移出',
  batchRemoveLimitBtn: '批量移出',
  addLimitBtn: '添加',
  batchAddLimitBtn: '批量添加',
  export: '导出',
  add: '增加限制客户',
  selectBuyGasLimitHint: '请先选择限购方案',
  batchRemoveLimitHint: '请勾选需要批量移出的限购客户',
  batchAddLimitHint: '请勾选需要批量添加的限购客户',
  addLimitSuccess: '添加限购客户成功',
  removeLimitSuccess: '限购客户移出成功',
  ...customerSearchFormFieldsMap,
}

export {
  customerSearchFormFieldsMap
}