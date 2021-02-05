/**
 * 气价配置国际化
 */

 // 用气类型表单
 const useGasFormFieldsMap = {
  alarmGas: '报警气量',
  dataStatus: '状态',
  gasType: '燃气类型',
  maxChargeGas: '最大充值气量',
  maxChargeMoney: '最大充值金额',
  openDecrement: '启用开户按月递减',
  decrement: '递减量',
  populationBase: '人口基数',
  populationGrowth: '启用人口递增',
  populationIncrease: '递增量',
  priceType: '气价类型',
  useGasTypeName: '用气类型', // 存放的是选择的用气类型code
  // gasTypeName: '用气类型名称', // 用户输入的用气类型名称
  userTypeCode: '客户类型',
  userTypeName: '客户类型',
  maxDeposit: '最大储蓄量',
  minDeposit: '最小储蓄量',
  alarmMoney: '一级报警金额',
  alarmMoneyTwo: '二级报警金额',
 }

 // 阶梯价格信息表单
 const priceFormFieldsMap = {
  compensationPrice: '补差价格',
  startTime: '启用时间',
  endTime: '结束时间',
  settlementDay: '结算日',
  startMonth: '起始月',
  cycle: '周期',
  priceChangeIsClear: '调价是否清零',
  useGasTypeId: '用气类型ID',
  dataStatus: '状态',
  fixedPrice: '固定价格',
  isHeating: '是否采暖',
  cycleStartTime: '切换时间',
  heatingcycleStartTime: '采暖方案切换时间',
  nonHeatingcycleStartTime: '非采暖方案切换时间',
 }

 // 滞纳金信息表单
 const lateFeeFieldsMap = {
  activationTime: '启用时间',
  // chargeDay: '缴费天数',
  compoundInterest: '复利',
  fixedCap: '固定上限',
  principalCap: '本金即上线',
  rate: '利率',
  useGasTypeId: '用气类型ID',
  executeDay: '滞纳金执行日',
  executeMonth: '滞纳金执行月',
  dataStatus: '状态',
 }

 export default {
   title: '气价配置',
   /**
    * 用气类型相关
    */
   useGasTypeTitle: '用气类型列表',
   addUseGasType: '新增用气类型',
   editUseGasType: '编辑用气类型',
   // 用气类型表单错误提示
   maxChargeGasHint: '报警金额必须大于0',
   maxChargeGasNumberHint: '最大充值气量必须为正数',
   maxChargeMoneyNumberHint: '最大充值金额必须为正数',
   alarmGasNumberHint: '报警气量必须是正数',
   alaralarmMoneyNumberHint: '报警金额必须是正数',
   alarmMoneyNumberHint: '一级报警金额必须是正数',
   alarmMoneyTwoNumberHint: '二级报警金额必须是正数',
   alarmMoneyCompareHint: '二级报警金额必须大于一级报警金额',
   alarmMoneyandaxChargeMoneyCompareHint: '报警金额必须小于最大充值金额',
   populationBaseNumberHint: '人口基数必须是大于1的正整数',
   populationIncreaseNumberHint: '人口递增量必须是正数',
   decrementNumberHint: '递减量必须是正数',
   minDepositNumberHint: '最小储蓄量必须正整数',
   maxDepositNumberHint: '最大储蓄量必须正整数',
   depositCompareHint: '最大储蓄量必须大于最小储蓄量',
   deleteUseGasTypeConfirm: '您确定要删除该用气类型信息（包括该用气类型下的所有价格信息和滞纳金信息）吗?',
   ...useGasFormFieldsMap,
   /**
    * 价格信息相关
    */
   priceTitle: '价格信息',
   ladderInfo: '阶梯气量信息',
   priceInfo: '阶梯单价信息',
   addPrice: '新增阶梯价格信息',
   editPrice: '编辑阶梯价格信息',
   addLadderPrice: '新增阶梯价格',
   editLadderPrice: '编辑阶梯价格',
   ladderPrice: '阶梯价格',
   heatingPrice: '采暖价格',
   heatingPricePlan: '采暖阶梯价格方案',
   nonHeatingPricePlan: '非采暖阶梯价格方案',
   fixedPrice: '固定价格',
   addFixedPrice: '新增固定价格',
   editFixedPrice: '编辑固定价格',
   addHeatingPrice: '新增采暖价格',
   editHeatingPrice: '编辑采暖价格',
   viewPrice: '查看阶梯价格信息',
   ladderPriceLable: '阶单价',
   ladderGas: '阶气量',
   gas: '阶梯气量',
   price: '阶梯价格',
   selectUseGasTypeHint: '请先选择用气类型',
   adjustmentPrice: '批量远程调价',
   compensationPriceNumberHint: '补差价格必须是正数',
   fixedPriceNumberHint: '单价必须是正数',
   ladderLable: '阶梯',
   gasLable: '气量',
   priceLable: '单价',
   isHeatingLable: '采暖/非采暖阶梯方案',
   validTimeLabel: '有效时间',
   heatingPriceLabel: '采暖',
   nonheatingPriceLabel: '非采暖',
   numberHint: '必须是正数',
   integerHint: '必须是正整数',
   notEmptyHint: '不能为空。',
   compareHint: '必须大于',
   adjustmentPriceSuccess: '批量远程调价操作成功',
   ...priceFormFieldsMap,
   /**
    * 滞纳金相关的
    */
   lateFeeTitle: '滞纳金信息',
   principalCapTitle: '上限控制',
   rateLabel: '利率%',
   fixedCapLable: '滞纳金固定上限',
   addLateFee: '新增滞纳金信息',
   editLateFee: '编辑滞纳金信息',
   viewLateFee: '查看滞纳金信息',
   rateNumberHint: '滞纳金利率必须是正数',
   fixedCapNumberHint: '滞纳金固定上限必须是正数',
   ...lateFeeFieldsMap,

 }

 export {
  useGasFormFieldsMap,
  priceFormFieldsMap,
  lateFeeFieldsMap,
 }