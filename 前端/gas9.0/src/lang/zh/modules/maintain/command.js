/**
 * 指令维护 国际化
 */
// 表单字段
const formFieldsMap = {
  commandStatus: '执行状态',
  commandType: '指令类型',
  commandStage: '执行阶段',
  createTime: '创建时间',
  executeResult: '执行结果',
  executeTime: '执行时间',
  meterNo: '表身号',
  sendTime: '发送时间',
  transactionNo: '流水号',
  errorDesc: '异常描述',
}

export default {
  ...formFieldsMap,
  title: '指令维护列表',
  deleteConfirm: '您确定要删除该指令维护吗',
  disableConfirm: '此操作将禁用此指令维护，是否继续？',
  dataStatusLabel: '是否启用',
  add: '新增指令维护',
  edit: '编辑指令维护',
  retry: '重新执行',
  cancel: '取消执行',
  batchRetry: '重试选中',
  batchCancel: '取消执行选中',
  retrySuccess: '指令重试操作发送成功',
  cancelSuccess: '取消执行指令操作发送成功',
  sendTimeStart: '发送时间起',
  sendTimeEnd: '发送时间止',
  executeTimeStart: '执行时间起',
  executeTimeEnd: '执行时间止',
}

export {
  formFieldsMap
}