/**
 * 运营配置
 */

 // 街道(乡镇)配置信息
 const streetFormFieldsMap = {
  region: '省市区',
  provinceName: '省名称',
  provinceCode: '省id',
  cityCode: '市id',
  cityName: '市名称',
  areaCode: '区id',
  areaName: '区名称',
  streetName: '街道(乡镇)名称',
  dataStatus: '状态'
}

// 小区(村、xx路)信息
const communityFormFieldsMap = {
 communityAddress: '详细地址',
 communityName: '小区(村、xx路)',
 dataStatus: '状态',
 streetId: '街道(乡镇)ID',
}

// 详细地址表单
const detailsFormFieldsMap = {
  communityId: '小区(村、xx路)ID',
  building: '栋',
  unit: '单元',
  detailAddress: '详细地址',
  moreDetailAddress: '详细地址',
  dataStatus: '状态',
  flag: '地址类型',
}

// 批量建址表单
const batchAddAddressFormFieldsMap = {
  streetId: '街道名称',
  communityId: '小区(村、xx路)',
  communityName: '小区(村、xx路)',
  building: '栋',
  unit: '单元',
  households: '每层户数',
  storey: '楼层数',
  dataStatus: '状态',
  flag: '地址类型',
  nodeFlag: '批量调压箱号录入',
  nodeCount: '总调压箱数',
}

export default {
  // 街道配置
  ...streetFormFieldsMap,
  config: '地址配置',
  streetList: '街道(乡镇)列表',
  deleteStreetConfirm: '您确定要删除该街道(乡镇)信息（包括该街道(乡镇)下的所有小区(村、xx路)信息）吗?',
  disableStreetConfirm: '您确定要禁用该街道(乡镇)信息吗?',
  addStreet: '新增街道(乡镇)',
  editStreet: '编辑街道(乡镇)',
  // 小区配置
  ...communityFormFieldsMap,
  deleteCommunityConfirm: '您确定要删除该小区(村、xx路)信息吗?',
  disableCommunityConfirm: '您确定要禁用该小区(村、xx路)信息吗?',
  list: '小区(村、xx路)列表',
  currentStreet: '当前街道(乡镇)：',
  editCommunity: '编辑小区(村、xx路)',
  addCommunity: '新增小区(村、xx路)',
  selectStreetHint: '请先选择街道(乡镇)列表',
  batchAddAddressText: '批量建址',

  // 详细地址相关
  ...detailsFormFieldsMap,
  selectCommunityHint: '请先选择小区(村、xx路)',
  detailsAddresslist: '详细地址列表',
  deleteDetailsAddressConfirm: '您确定要删除该详细地址信息吗?',
  disableDetailsAddressConfirm: '您确定要禁用该详细地址信息吗?',
  addDetailsAddress: '新增详细地址',
  editDetailsAddress: '编辑详细地址',

  // 批量建址相关
  batchAddAddress: {
    ...batchAddAddressFormFieldsMap,
    streetName: '街道名称',
    communityName: '小区名称',
    storeyAppend: '层',
    householdsAppend: '户',
  },

  // 杂项
  'searchEmptyText': '暂无数据，必须先选择省市区、街道(乡镇)以及小区(村、xx路)进行搜索。',

}

export {
 streetFormFieldsMap,
 communityFormFieldsMap,
 detailsFormFieldsMap,
 batchAddAddressFormFieldsMap
}