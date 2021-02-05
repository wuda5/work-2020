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

// 地址配置信息
const communityFormFieldsMap = {
 communityAddress: '详细地址',
 communityName: '小区(村、xx路)名称',
 dataStatus: '状态',
 streetId: '街道(乡镇)ID',
}

export default {
  ...streetFormFieldsMap,
  ...communityFormFieldsMap,
  config: '地址配置',
  streetList: '街道(乡镇)列表',
  list: '小区(村、xx路)列表',
  deleteStreetConfirm: '您确定要删除该街道(乡镇)信息（包括该街道(乡镇)下的所有小区(村、xx路)信息）吗?',
  deleteCommunityConfirm: '您确定要删除该小区(村、xx路)信息吗?',
  currentStreet: '当前街道(乡镇)：',
  selectStreetHint: '请先在左侧街道(乡镇)列表选择街道(乡镇)',
  addCommunity: '新增小区(村、xx路)',
  editCommunity: '编辑小区(村、xx路)',
  addStreet: '新增街道(乡镇)',
  editStreet: '编辑街道(乡镇)',
}

export {
 streetFormFieldsMap,
 communityFormFieldsMap
}