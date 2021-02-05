/**
 * 页面操作权限
 */
// 气价配置
export const permission = {
  // 临时综合
  temporary: ['temporary:guohu', 'temporary:chaibiao', 'temporary:hb', 'temporary:bk', 'temporary:bq', 'temporary:tq', 'temporary:fk', 'temporary:yqlxbg', 
  'temporary:yckz', 'temporary:khzl', 'temporary:khs', 'temporary:cjgd', 'temporary:bzsl', 'temporary:kh', 'temporary:drkh', 'temporary:dz', 'temporary:tjbc'],
  // 日常综合
  dailyWork: ['dailyWork:view(已删除)', 'dailyWork:readCard(已删除)', 'dailyWork:tf', 'dailyWork:zhtf', 'dailyWork:fagl', 'dailyWork:zhazhang', 'dailyWork:khs'],
  // 普表抄表
  generalReadMeter: [],
  // 物联网抄表
  iotReadMeter: ['readMeterIot:ts', 'readMeterIot:jzsj', 'readMeterIot:ch', 'readMeterIot:bh', 'readMeterIot:sh', 'readMeterIot:dyjftz', 'readMeterIot:dycktz', 'readMeterIot:ycsjtj', 'readMeterIot:cbdr', 'readMeterIot:dkdr', 'readMeterIot:dkdc', 'readMeterIot:filter-dts', 'readMeterIot:filter-ybh', 'readMeterIot:filter-dsh', 'readMeterIot:filter-djs', 'readMeterIot:filter-dsf', 'readMeterIot:filter-ysf'],
  community: ['community:streetAdd', 'community:streetEdit', 'community:streetDelete', 'community:add', 'community:edit', 'community:delete', 'community:detailsAddressAdd', 'community:detailsAddressEdit', 'community:detailsAddressDelete', 'community:batchAddAddress'],
  gasPrice: ['gasPrice:useGasTypeAdd', 'gasPrice:useGasTypeEdit', 'gasPrice:useGasTypeDelete', 'gasPrice:ladderPriceAdd', 'gasPrice:batchChangePrice', 'gasPrice:lateFeeAdd'],
  buyGasLimit: ['buyGasLimit:add', 'buyGasLimit:edit', 'buyGasLimit:delete'],
  userLimit: ['userLimit:add', 'userLimit:remove', 'userLimit:export'],
  lateFee: ['lateFee:add', 'lateFee:edit', 'lateFee:delete'],
  preferential: ['preferential:add', 'preferential:edit', 'preferential:delete'],
  // 缴费减免
  feeReduce: ['feeReduce:add', 'feeReduce:edit', 'feeReduce:delete'],
  // 充值赠送
  rechargeGive: ['rechargeGive:add', 'rechargeGive:edit', 'rechargeGive:delete'],
  // 厂家网关配置
  iot: ['iot:add', 'iot:edit', 'iot:delete'],
  // 电子发票平台配置
  invoice: ['invoice:add', 'invoice:edit', 'invoice:delete'],
  // 发票参数配置
  invoiceParam: ['invoiceParam:add', 'invoiceParam:edit'],
}