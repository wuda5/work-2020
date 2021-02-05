/**
 * 气表表信息枚举
 */
import i18n from '@/lang/index'

// 订单来源（即现在的气表类型）
const IC_RECHARGE = 'IC_RECHARGE' // IC卡充值
const REMOTE_READMETER = 'REMOTE_READMETER' // 物联网中心计费（远程抄表后付费）
const CENTER_RECHARGE = 'CENTER_RECHARGE' // 中心计费（物联网后付费表）
const REMOTE_RECHARGE = 'REMOTE_RECHARGE' // 远程充值（物联网表表端计费）
const READMETER_PAY = 'READMETER_PAY' // 抄表缴费（普表）

export const orderSourceNameField = {
  IC_RECHARGE,
  REMOTE_READMETER,
  CENTER_RECHARGE,
  REMOTE_RECHARGE,
  READMETER_PAY,
}

// 气表类型(原来的)
const GENERAL_GASMETER = 'GENERAL_GASMETER' // 普表
const INTERNET_GASMETER = 'INTERNET_GASMETER' // 物联网气表
const CARD_GASMETER = 'CARD_GASMETER' // 卡表

export const gasMeterTypeField = {
  IC_RECHARGE,
  REMOTE_READMETER,
  CENTER_RECHARGE,
  REMOTE_RECHARGE,
  READMETER_PAY,
}

// 物联网表设备状态
const UNKNOWN = -1 // 未知
const INACTIVE = 0 // 未注册
const ACTIVE = 0 // 注册成功
const ENABLED = 1 // 开户成功
const CLOSED = 4 // 注销

// 物联网设备状态字段
export const iotDeviceStatusFields = {
  UNKNOWN,
  INACTIVE,
  ACTIVE,
  ENABLED,
  CLOSED,
}

 // 气表状态
 const YJD = 0; // 预建档
 const DAZ = 1; // 待安装
 const DKH = 2; // 待开户
 const DTQ = 3; // 待通气
 const YTQ = 4; // 已通气
 const CC = 5; // 拆除
 const HB = 6; // 换表

 // 气表状态字段
 export const meterStatusField = {
  YJD,
  DAZ,
  DKH,
  DTQ,
  YTQ,
  CC,
  HB,
 }

 // 气表状态映射
 export const meterStatusMap = {
   [YJD]: '预建档',
   [DAZ]: '待安装',
   [DKH]: '待开户',
   [DTQ]: '待通气',
   [YTQ]: '已通气',
   [CC]: '拆除',
  //  [HB]: '换表',
 }

 // 气表通气方向
 const LEFT_IN = 'LEFT' // 左进
 const RIGHT_IN = 'RIGHT' //右进 

 export const diretionField = {
  LEFT_IN,
  RIGHT_IN,
 }

 // 通气状态 0 表示 没通气  1表示通气
 const NO = 0 //没通气
 const YES = 1 //通气

 export const ventilateStatusField = {
  NO,
  YES,
 }

 export const ventilateStatusMap = {
   [NO]: i18n.t('meterInfo.ventilateStatusNo'),
   [YES]: i18n.t('meterInfo.ventilateStatusYes'),
 }

 // 阀状态
const POWER_CLOSE = 'PowerClose' //关
const OPEN = 'Open' // 开
const EXCEPTION = 'Exception' // 异常
const NONE = 'None' // 无阀门
const CLOSE = 'Close' // 普通关阀

export const valveStateField = {
  POWER_CLOSE,
  OPEN,
  EXCEPTION,
  NONE,
  CLOSE,
}

export const valveStateMap = {
  [POWER_CLOSE]: i18n.t('meterInfo.valveState.powerClose'),
  [OPEN]: i18n.t('meterInfo.valveState.open'),
  [EXCEPTION]: i18n.t('meterInfo.valveState.exception'),
  [NONE]: i18n.t('meterInfo.valveState.none'),
  [CLOSE]: i18n.t('meterInfo.valveState.close'),

}
// 结算方式
const READMETER_MODE = 'READMETER'
const METER_MODE = 'METER'
const SERVICE_MODE = 'SERVICE'

export const settlementModeField = {
  READMETER_MODE,
  METER_MODE,
  SERVICE_MODE,
}

export const settlementModeMap = {
  [READMETER_MODE]: '抄表结算',
  [METER_MODE]: '表端结算',
  [SERVICE_MODE]: '服务端结算',
}

 // 结算类型
 const GAS = 'GAS' //气量
 const MONEY = 'MONEY' // 金额

 export const settlementTypeField = {
   GAS,
   MONEY
 }

 export const amountMarkField = {
   GAS,
   MONEY
 }

 // 报警器状态
 const ALARM_NOT_CONNECTED = 0 // 未连接
 const ALARM_CONNECTED = 1 // 已连接

 export const alarmStatusField = {
  ALARM_NOT_CONNECTED,
  ALARM_CONNECTED
 }

 export const alarmStatusMap = {
   [ALARM_NOT_CONNECTED]: i18n.t('meterInfo.alarmStatus.notConnected'),
   [ALARM_CONNECTED]: i18n.t('meterInfo.alarmStatus.connected'),
 }

 // 指令类型
 const ADDDOMAIN = 'ADDDOMAIN' // 加入设备
 const UPDATEDEVICE = 'UPDATEDEVICE' // 更新设备
 const OPENACCOUNT = 'OPENACCOUNT' // 开户
 const RECHARGE = 'RECHARGE' // 充值
 const VALVECONTROL = 'VALVECONTROL' // 阀控(单)
 const MODIFYPRICE = 'MODIFYPRICE' // 调价
 const PARAMETER = 'PARAMETER' // 参数设置
 const REGISTER = 'REGISTER' // 注册设备
 const UPGRADEKEY = 'UPGRADEKEY' // 密钥升级
 const CLOSEVALVE = 'CLOSEVALVE' // 阀控(关阀)
 const OPENVALVE = 'OPENVALVE' // 阀控(开阀)
 const REMOVEDEVICE = 'REMOVEDEVICE' // 移除设备
 const REMOVEDOMAIN = 'REMOVEDOMAIN' // 移除逻辑域
 const DAILYSETTLEMENT = 'DAILYSETTLEMENT' // 更新余额、单价
 const READMETER = 'READMETER' // 补抄
 const METERCLEAN = 'METERCLEAN' // 清零
 export const commandTypeField = {
  ADDDOMAIN,
  UPDATEDEVICE,
  OPENACCOUNT,
  RECHARGE,
  VALVECONTROL,
  MODIFYPRICE,
  PARAMETER,
  REGISTER,
  UPGRADEKEY,
  CLOSEVALVE,
  OPENVALVE,
  REMOVEDEVICE,
  REMOVEDOMAIN,
  DAILYSETTLEMENT,
  READMETER,
  METERCLEAN,
 }

 // 指令类型映射
 export const commandTypeMap = {
   [ADDDOMAIN]: '加入设备',
   [UPDATEDEVICE]: '更新设备',
   [OPENACCOUNT]: '开户',
   [RECHARGE]: '充值',
   [VALVECONTROL]: '阀控',
   [MODIFYPRICE]: '调价',
   [PARAMETER]: '参数设置',
   [REGISTER]: '注册设备',
   [UPGRADEKEY]: '密钥升级',
   [CLOSEVALVE]: '关阀',
   [OPENVALVE]: '开阀',
   [REMOVEDEVICE]: '移除设备',
   [REMOVEDOMAIN]: '移除逻辑域',
   [DAILYSETTLEMENT]: '更新余额、单价',
   [READMETER]: '补抄',
   [METERCLEAN]: '清零',
 }

 // 指令执行阶段
 const WaitSend = 0 // 等待发送
 const SendToNet = 1 // 发送至网关
 const SendToDevice = 2 // 发送至设备
 const DeviceExecute = 3 // 设备已执行
 const CancleExecute = 4 // 设备已取消

 export const commandExecuteStageField = {
  WaitSend,
  SendToNet,
  SendToDevice,
  DeviceExecute,
  CancleExecute,
 }

 export const commandExecuteStageMap = {
  [WaitSend]: '等待发送',
  [SendToNet]: '发送至网关',
  [SendToDevice]: '发送至设备',
  [DeviceExecute]: '设备已执行',
  [CancleExecute]: '设备已取消',
 }

 // 指令执行状态
 const NOT_START = 0 //未开始
 const SUCCESS = 1 //操作成功
 const RECHARGED = 2 //已充值(表示重复执行)
 const RECHARGE_AMOUNT_EXCEEDED = 3 //充值金额超限
 const RECHARGE_MISMATCH = 4 //充值校验不符
 const LADDER_PRICE_AGREEMENT_MISMATCH = 5 //阶梯价格不符协议或公司号不能为0
 const METER_STATUS_MISMATCH = 6 //表状态不匹配
 const KEYUPGRADE_MISMATCH = 7 //密钥升级不符
 const LOWVOLTAGE_FLASH_DISABLED = 8 //低电压、FLASH被禁用
 const LOWVOLTAGE_EEPROM_DISABLED = 9 //低电压、eeprom被禁用
 const RECEIVED_NOTDEAL = 10 //已收到，但不处理或不及时处理
 const ERROR = 11 //操作错误
 const INFORMATION_MISMATCH = 12 //身份不符、数据重复或密钥错
 const PROTOCOL_NOTSUPPORT = 13 //不支持该协议版本
 const CANCELED = 106 //已取消
 export const commandExecuteStatusField = {
  NOT_START,
  SUCCESS,
  RECHARGED,
  RECHARGE_AMOUNT_EXCEEDED,
  RECHARGE_MISMATCH,
  LADDER_PRICE_AGREEMENT_MISMATCH,
  METER_STATUS_MISMATCH,
  KEYUPGRADE_MISMATCH,
  LOWVOLTAGE_FLASH_DISABLED,
  LOWVOLTAGE_EEPROM_DISABLED,
  RECEIVED_NOTDEAL,
  ERROR,
  INFORMATION_MISMATCH,
  PROTOCOL_NOTSUPPORT,
  CANCELED,
 }

 export const commandExecuteStatusMap = {
  [NOT_START]: '未开始',
  [SUCCESS]: '操作成功',
  [RECHARGED]: '已充值',
  [RECHARGE_AMOUNT_EXCEEDED]: '充值金额超限',
  [RECHARGE_MISMATCH]: '充值校验不符',
  [LADDER_PRICE_AGREEMENT_MISMATCH]: '阶梯价格不符协议或公司号不能为0',
  [METER_STATUS_MISMATCH]: '表状态不匹配',
  [KEYUPGRADE_MISMATCH]: '密钥升级不符',
  [LOWVOLTAGE_FLASH_DISABLED]: '低电压、FLASH被禁用',
  [LOWVOLTAGE_EEPROM_DISABLED]: '低电压、eeprom被禁用',
  [RECEIVED_NOTDEAL]: '已收到，但不处理或不及时处理',
  [ERROR]: '操作错误',
  [INFORMATION_MISMATCH]: '身份不符、数据重复或密钥错',
  [PROTOCOL_NOTSUPPORT]: '不支持该协议版本',
  [CANCELED]: '已取消',
 }

 // 指令执行结果
 const RESULT_NOT = 0 // 未执行
 const RESULT_SUCCESS = 1 // 执行成功
 const RESULT_FAIL = 11 // 执行失败

 export const commandExecuteResultField = {
  RESULT_NOT,
  RESULT_SUCCESS,
  RESULT_FAIL,
 }

 export const commandExecuteResultMap = {
  [RESULT_NOT]: '未执行',
  [RESULT_SUCCESS]: '执行成功',
  [RESULT_FAIL]: '执行失败',
 }

//  周期量控制
const CLEARED = 1
const NOT_CLEARED = 2

export const cycleSumControlField = {
  CLEARED,
  NOT_CLEARED,
}

export const cycleSumControlMap = {
  [CLEARED]: '清零',
  [NOT_CLEARED]: '不清零',
}

// 气表厂家
const QC = '01' // 成都秦川物联网科技股份有限公司

// 厂家字段枚举
export const meterFactoryField = {
  QC
}