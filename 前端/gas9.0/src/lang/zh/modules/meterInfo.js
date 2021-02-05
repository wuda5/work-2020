/**
 * 表具档案
 */

// 表具表单字段映射
const meterFormFieldsMap = {
  gasMeterFactoryId: '气表厂家',
  gasMeterFactoryName: '气表厂家',
  gasMeterVersionId: '气表版号',
  gasMeterVersionName: '气表版号',
  gasMeterModelId: '气表型号',
  gasMeterModelName: '气表型号',
  gasMeterTypeCode: '气表类型',
  gasMeterTypeName: '气表类型',
  settlementMode: '结算模式',
  settlementType: '结算类型',
  chargeType: '收费类型',
  direction: '进气方向',
  gasCode: '气表编号',
  gasMeterNumber: '表身号',
  gasMeterBase: '气表底数',
  checkTime: '检定时间',
  checkUser: '检定人',
  buyTime: '购买时间',
  safeCode: '防盗扣编号',
  dataStatus: '气表状态',
  remark: '备注',
  remoteServiceFlag: '远程业务标志',
  amountMark: '金额标志',
  orderSourceName: '订单来源',
  radix: '开户时是否必须录入气表底数',
}
// 气表信息表单字段映射
const gasMeterFormFieldsMap = {
  ...meterFormFieldsMap,
  longitude: '经度',
  customerChargeNo: '缴费编号',
  latitude: '纬度',
  installNumber: '报装编号',
  nodeNumber: '调压箱号',
  population: '使用人口',
  openAccountTime: '开户时间',
  openAccountUserId: '开户人ID',
  openAccountUserName: '开户人',
  securityUserId: '安检人ID',
  securityUserName: '安检人',
  ventilateStatus: '通气状态',
  ventilateTime: '通气时间',
  ventilateUserId: '通气人ID',
  ventilateUserName: '通气人名称',
  useGasTypeId: '用气类型',
  useGasTypeName: '用气类型',
  gasMeterAddress: '安装地址',
  moreGasMeterAddress: '详细地址',
  region: '省市区',
  provinceCode: '省',
  provinceName: '省',
  cityCode: '市',
  cityName: '市',
  areaCode: '区',
  areaName: '区',
  streetId: '街道(乡镇)名称',
  streetName: '街道(乡镇)名称',
  communityId: '小区(村、xx路)',
  communityName: '小区(村、xx路)',
}

export default {
  meterToStore: '表具入库',
  useGasTypeId: '用气类型',
  useGasTypeName: '用气类型',
  installNumber: '报装编号',
  readCard: '读卡',
  selectVersionHint: '请先选择气表厂家',
  selectModelHint: '请先选择气表版号',
  gasMeterNumberHint: '表身号只能字母和数字组成',
  moreGasMeterAddressPlaceholder: '表具安装地址',
  add: '新增表具信息',
  edit: '编辑表具信息',
  detailsTitle: '表具信息',
  // 通气状态
  ventilateStatusNo: '未通气',
  ventilateStatusYes: '已通气',

  ...gasMeterFormFieldsMap,
  
  // 导入表具信息
  importToStore: '表具导入',
  importTitle: '导入表具信息',
  downloadMeterTemplate: '下载导入表具信息模板',
  importLoading: '表具信息正在导入中，请稍候...',
  importSuccess: '表具信息导入成功！',
  uploadDes1: '将文件拖到此处，或',
  uploadDes2: '点击上传',
  uploadHint: '只支持上传.xlsx, .xls文件',

  // 扫码入库
  scanToStore: '扫码入库',
  scanMeterTitle: '扫码入库',
  meterBaseInfo: '表具基本信息',
  scanMeterList: '入库列表',
  inputBaseInfoHint: '请先填写带*号的表具基本信息再进行扫码操作',
  repeatingMeterTitle: '表具重复',
  repeatingMeterBody: '以下表具已存在入库列表中，请先核对后再操作：',
  selectMeterHint: '请先勾选表具信息',
  noneMeterHint: '没有需要保存的表具',
  scanPlaceholder: '点击此处开始表具扫码',
  scanHint: '点击输入框即可进行扫码操作，也可直接输入表身号(多个表身号用英文逗号隔开)按enter键进行添加',

  // 开户相关的
  selectGasMeterAddress: ' 选择安装地址',
  populationPositiveIntegerHint: ' 请输入大于等于1的正整数',
  openAccountSuccess: '开户成功',
  selectCustomer: '请选择客户信息',
  selectMeter: '请选择表具信息',

  // 气表状态相关
  meterStatus: {
    // 杂项
    detailsTitle: '气表状态',
    valveStateClose: '关',
    valveStateOpen: '开',
    lastReadMeterGas: '最后抄表量',

    // 表单信息
    totalUseGas: '累计用气量',
    meterTotalGas:'表端累计用气量',
    totalUseGasMoney: '累计用气金额',
    cycleUseGas: '周期累计用气量',
    cycleChargeGas: '周期累计充值量',
    cycleChargeMoney: '周期累计充值金额',
    dayIotUseGas: '物联网表上日止数',
    monthIotUseGas: '物联网上月止数',
    gasMeterBalance: '气表余额',
    gasMeterGasBalance: '气表余量',
    currentPrice: '当前价格',
    currentLadder: '当前阶梯',
    initialMeasurementBase: '初始气量',
    lastChargeTime: '最后充值时间',
    lastPayTime: '最后缴费时间',
    lastReadMeterTime: '最后抄表时间',
    cardVerifyData: 'IC卡校验码',
    additionalCount: '气表补充次数',
    compatibleParameter: '兼容特殊参数',
    priceSchemeId: '表端价格号',
    readMeterEndGas: '最后抄表末值',
    readMeterGas: '最后抄表结算值',
    readMeterStartGas: '最后抄表初量',
    replacementCardCount: '气表补卡次数',
    totalAdditionalCount: '累计补气次数',
    totalChargeCount: '累计充值次数',
    totalPayCount: '累计缴费次数',
    totalChargeGas: '累计充值气量',
    totalChargeMoney: '累计充值金额',
    totalMaintenanceCount: '累计维修次数',
    totalReadMeterCount: '累计抄表次数',
    totalReplacementCardCount: '累计补卡次数',
    value1: '上次充值量',
    value2: '上上次充值量',
    value3: '上上上次充值量',
    moneyValue1: '上次充值金额',
    moneyValue2: '上上次充值金额',
    moneyValue3: '上上上次充值金额',
    valveState: '阀状态',
    alarm: '报警器',
    updateTime: '更新时间',
    exceptionInfo: '异常信息',
  },
  
  // 阶梯用量信息
  ladder: {
    // 阶梯用量
    detailsTitle: '阶梯用量信息',
  },

  // 枚举相关
  alarmStatus: {
    notConnected: '未连接',
    connected: '已连接',
  },
  valveState: {
    powerClose: '关',
    open: '开',
    exception: '异常',
    none: '无阀门状态',
    close: '普通关阀',
  },

  // 物联网表
  iot: {
    control: '控制',
    closeValveSuccess: '关阀指令已成功发送。',
    forceCloseValveSuccess: '关阀指令已成功发送。',
    openValveSuccess: '开阀指令已成功发送。',
  },

  // 杂项
  title: '档案列表',
  
}

export {
  meterFormFieldsMap,
  gasMeterFormFieldsMap
}

