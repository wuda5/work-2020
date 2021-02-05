/**
 * 气表信息相关的混入
 */

import {dictionaryCodeMap} from '@/enums/dictionary'
import {
  meterStatusField,
  ventilateStatusMap,
  gasMeterTypeField,
  amountMarkField,
  valveStateMap,
  alarmStatusMap,
  iotDeviceStatusFields,
} from '@/enums/meterInfo'
import {parseTime} from '@/utils/index'

export default {
  filters: {
    // 阀状态
    valveStateFormat(value) {
      return valveStateMap[value] ?? '--'
    },
    // 通气状态
    ventilateStatusFormat(value) {
      return ventilateStatusMap[+value] ?? '--'
    },
    // 时间格式化
    timeFormat(value, format) {
      return parseTime(value, format) || '--'
    },
    // 报警器连接状态
    alarmFormat(value) {
      return alarmStatusMap[value] ?? '--'
    },
  },
  data() {
    return {}
  },
  computed: {
    // 气表类型映射
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
    // 气表状态
    meterStatusMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.GAS_METER_STATE)
    },
    // 进气方向map
    directionMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.VENTILATION_DIRECTION)
    },
  },
  methods: {
    // 判断气表类型是否存存在
    checkGasMeterType(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return !!this.gasMeterTypeMap[meterInfo?.orderSourceName]
    },
    // 是否是普表
    IS_GENERAL_GASMETER(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return gasMeterTypeField.READMETER_PAY === meterInfo?.orderSourceName
    },
    // 是否是物联网中心计费（远程抄表后付费）表
    IS_REMOTE_READMETER(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [gasMeterTypeField.REMOTE_READMETER].includes(meterInfo?.orderSourceName)
    },
    // 中心计费（物联网后付费表）表
    IS_CENTER_RECHARGE(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [gasMeterTypeField.CENTER_RECHARGE].includes(meterInfo?.orderSourceName)
    },
    // 远程充值（物联网表表端计费）表
    IS_REMOTE_RECHARGE(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [gasMeterTypeField.REMOTE_RECHARGE].includes(meterInfo?.orderSourceName)
    },
    // 是否是物联网表
    IS_INTERNET_GASMETER(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return this.IS_REMOTE_READMETER(meterInfo) || this.IS_CENTER_RECHARGE(meterInfo) || this.IS_REMOTE_RECHARGE(meterInfo)
    },
    // 是否是卡表
    IS_CARD_GASMETER(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return gasMeterTypeField.IC_RECHARGE === meterInfo?.orderSourceName
    },
    // 是否是气量卡表
    IS_CARD_GASMETER_OF_GAS(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return this.IS_CARD_GASMETER(meterInfo) && amountMarkField.GAS === meterInfo?.amountMark
    },
    // 是否是金额卡表
    IS_CARD_GASMETER_OF_MONEY(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return this.IS_CARD_GASMETER(meterInfo) && amountMarkField.MONEY === meterInfo?.amountMark
    },
    // 是否是开户的
    isOpenAccount(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return ![meterStatusField.YJD, meterStatusField.DAZ, meterStatusField.DKH].includes(+meterInfo?.dataStatus)
    },

    // 是否是表端结算
    isMeterMode(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return this.IS_REMOTE_RECHARGE(meterInfo)
    },

    // 是否可以进行通气操作
    isOpenGas(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return +meterInfo?.dataStatus === meterStatusField.DTQ
    },
    // 是否可以进行远程控制操作
    isRemoteControl(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [meterStatusField.DTQ, meterStatusField.YTQ].includes(+meterInfo?.dataStatus) && this.IS_INTERNET_GASMETER(meterInfo)
    },
    // 是否可以进行移除设备操作（只针对物联网表预建档）
    isRemoveMeter(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [meterStatusField.YJD].includes(+meterInfo?.dataStatus) && this.IS_INTERNET_GASMETER(meterInfo)
    },
    // 是否可以进行用气类型变更操作
    isUseGasTypeChange(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return true
    },

    // 开户之后可进行的操作
    isAfterOpenAccount(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return [meterStatusField.DTQ, meterStatusField.YTQ].includes(+meterInfo?.dataStatus)
    },

    // 是否物联网表注册网关了
    isRegisterGateway(meterInfo) {
      meterInfo = meterInfo || this.meterInfo || {}
      return this.IS_INTERNET_GASMETER(meterInfo) && [iotDeviceStatusFields.ACTIVE, iotDeviceStatusFields.ENABLED].includes(meterInfo?.deviceState)
    }
  },
}
