// 物联网抄表
import { cloneDeep } from 'lodash'
//tools
import meterMixin from '@/mixins/meter'
import iotApi from '@/api/readMeter/iot.js'
import {dataStatusField} from '@/enums/common'
import {processField, processMap, chargeStatusField, chargeStatusMap} from '@/enums/readMeter'
import {parseDate2Str} from '@/utils/commons.js'

// 业务组件
import ReadMeterImport from './components/import/ReadMeterImport.vue' //  抄表导入
import WithholdImport from './components/WithholdImport.vue' // 代扣导入

import RejectReason from '@/components/QcPopUpWindow/RejectReason.vue' // 驳回
import FixReadMeter from './components/FixReadMeter.vue' // 添加、补抄数据

// tabs
import CustomerDetails from '@/components/QcTabsInfo/CustomerDetails.vue' // 客户信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails' // 表具信息
import ReadMeterRecords from '@/components/QcTabsInfo/ReadMeterRecords.vue' // 抄表记录
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo' // 欠费明细
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords' // 缴费记录
import PricePlan from '@/components/QcTabsInfo/PricePlan' // 气价方案
import MeterStatusDetails from '@/components/QcTabsInfo/MeterStatusDetails.vue' // 气表状态
import ReadMeterStatistics from './components/tabs/ReadMeterStatistics.vue' // 统计模块

// 进度状态显示按钮
const processStatusBtns = {
  // [processField.TO_BE_REVIEWED]: {
  //   text: '待提审',
  //   permission: ['readMeterIot:filter-dts'],
  // },
  // [processField.REVIEW_REJECTED]: {
  //   text: '已驳回',
  //   permission: ['readMeterIot:filter-ybh'],
  // },
  // [processField.SUBMIT_FOR_REVIEW]: {
  //   text: '待审核',
  //   permission: ['readMeterIot:filter-dsh'],
  // },
  [processField.APPROVED]: {
    text: '待结算',
    permission: ['readMeterIot:filter-djs'],
  },
}

// 收费状态显示按钮
const chargeStatusBtns = {
  // [chargeStatusField.ARREARS]: '欠费',
  [chargeStatusField.NO_CHARGE]: {
    text: '待收费',
    permission: ['readMeterIot:filter-dsf'],
  },
  [chargeStatusField.CHARGED]: {
    text: '已收费',
    permission: ['readMeterIot:filter-ysf'],
  },
  // [chargeStatusField.INVOICED]: '已出票',
}

export default {
  name: 'IotReadMeter',
  components: {
    ReadMeterImport, // 抄表导入
    WithholdImport, // 代扣导入
    RejectReason, // 驳回
    FixReadMeter,

    // tabs
    CustomerDetails,
    MeterDetails,
    ReadMeterRecords,
    MeterStatusDetails,
    ArrearageInfo,
    PaymentRecords,
    PricePlan,
    ReadMeterStatistics, // 统计
  },
  filters: {
    parsedTime(date) {
      return date ? parseDate2Str(date) : '--'
    }
  },
  mixins: [meterMixin],
  data() {
    return {
      // 搜索
      searchForm: this.initQueryParams({
        model: {
          gasMeterAddress: '', // 	安装地址
          customerName: '', // 客户名称
          customerCode: '', //客户编号
          useGasTypeName: '', // 用气类型名称
          readTime: '', // 抄表年月
          readMeterUserName: '', // 抄表员名称
          customerChargeNo: '', // 缴费编号
          gasMeterNumber: '', // 表身号

          /**
           * 数据状态
           * 未抄表：-1
           * 取消：2
           * 已抄：0
           **/
          dataStatus: dataStatusField.VALID,

          /*
           * 审核状态
           * 待审核：TO_BE_REVIEWED
           * 提审：SUBMIT_FOR_REVIEW
           * 审核通过（待结算）： APPROVED
           * 审核驳回： REVIEW_REJECTED
           */
          processStatus: processField.APPROVED,

          /**
           * 收费状态
           * 待收费：NO_CHARGE
           * 欠费：ARREARS
           * 已收费（待出票）：CHARGED
           * 已出票：INVOICED
           **/
          chargeStatus: null,
        },
        size: 15,

        curTabsLabel: '客户信息', // 右侧当前点击标签名
      }),
      // list
      tableData: [],
      total: 0,
      listLoading: false,

      // 高亮选择状态
      curBtn: processField.APPROVED,

      multipleSelection: [],

      rejectedMsg: '',

      curPlan: null, // 当前修改数据

      // 弹出组件控制
      showReadMeterImport: false, // 抄表导入
      showWithholdImport: false, // 代扣导入
      showRejectReason: false, // 驳回
      showAdd: false, // 添加
      fixReadMeterDialogVisible: false, // 纠正数据

      currentRow: {}, // 当前行的数据
      btnLoading: false,
      isEdit: true, // 是否是添加异常数据标志

      curTabsLabel: '客户信息', // 右侧当前点击标签名
      filterProcessStatusBtns: {}, // 显示的进度按钮
      filterChangeStatusBtns: {}, // 显示的收费相关按钮
    }
  },
  computed: {
    // 筛选出当前状态的数据
    // filterMultipleSelection() {
    //   if (this.curBtn === 'all') {
    //     return this.multipleSelection
    //   } else {
    //     return this.multipleSelection.filter((item) => item.processStatus?.code === this.curBtn || item.chargeStatus?.code === this.curBtn)
    //   }
    // },
    // 是否可提审
    IS_SUBMIT_FOR_REVIEW() {
      return (this.curBtn === processField.TO_BE_REVIEWED || this.curBtn === processField.REVIEW_REJECTED) || this.curBtn === 'all'
    },
    // 可提审的选中数据
    submitForReviewData() {
      return this.filterMultipleSelection([processField.TO_BE_REVIEWED, processField.REVIEW_REJECTED])
    },
    // 是否可补抄数据
    IS_FIX_READ_METER() {
      return (this.curBtn === processField.TO_BE_REVIEWED || this.curBtn === processField.REVIEW_REJECTED) || this.curBtn === 'all'
    },
    // 可补抄的选中数据
    fixReadMeterData() {
      return this.filterMultipleSelection([processField.TO_BE_REVIEWED, processField.REVIEW_REJECTED])
    },
    // 是否可撤回数据
    IS_WITHDRAW() {
      // return (this.curBtn === processField.SUBMIT_FOR_REVIEW) || this.curBtn === 'all'
      return [chargeStatusField.NO_CHARGE, chargeStatusField.CHARGED].includes(this.curBtn) || this.curBtn === 'all'
    },
    // 可撤回的选中数据
    withdrawData() {
      return this.filterMultipleSelection([processField.SUBMIT_FOR_REVIEW])
    },
    // 是否可驳回数据
    IS_REVIEW_REJECTED() {
      return (this.curBtn === processField.SUBMIT_FOR_REVIEW) || this.curBtn === 'all'
    },
    // 可驳回的选中数据
    reviewRejectedData() {
      return this.filterMultipleSelection([processField.SUBMIT_FOR_REVIEW])
    },
    // 是否可审核数据
    IS_APPROVED() {
      return (this.curBtn === processField.SUBMIT_FOR_REVIEW) || this.curBtn === 'all'
    },
    // 可审核的选中数据
    appovedData() {
      return this.filterMultipleSelection([processField.SUBMIT_FOR_REVIEW])
    },
    // 是否可结算数据
    IS_SETTLEMENT() {
      return (this.curBtn === processField.APPROVED) || this.curBtn === 'all'
    },
    // 可结算的选中数据
    settlementData() {
      return this.filterMultipleSelection([processField.APPROVED])
    },
    // 是否待收费数据
    IS_NO_CHARGE() {
      return (this.curBtn === chargeStatusField.NO_CHARGE) || this.curBtn === 'all'
    },
    // 待收费的选中数据
    noChargeData() {
      return this.filterMultipleSelection([chargeStatusField.NO_CHARGE])
    },
    // 是否欠费数据
    IS_ARREARS() {
      return (this.curBtn === chargeStatusField.ARREARS) || this.curBtn === 'all'
    },
    // 欠费的选中数据
    arrearsData() {
      return this.filterMultipleSelection([chargeStatusField.ARREARS])
    },
  },
  created() {
    // this.search()
    this.filterBtns()
  },
  methods: {
    // 搜索数据
    search() {
      // 处理搜索日期
      let searchForm = JSON.parse(JSON.stringify(this.searchForm))
      let readMeterYear = null
      let readMeterMonth = null
      if (searchForm.model.readTime) {
        readMeterYear = parseInt(searchForm.model.readTime.split('-')[0])
        readMeterMonth = parseInt(searchForm.model.readTime.split('-')[1])
      }
      searchForm.model.readMeterYear = readMeterYear
      searchForm.model.readMeterMonth = readMeterMonth
      delete searchForm.model.readTime
      this.listLoading = true
      iotApi.queryReadMeterWorkInfo(searchForm).then(res => {
        let {isSuccess, data} = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = parseInt(data.total)
          this.$nextTick(() => {
            this.loadData()
          })
        }
      }).finally(() => (this.listLoading = false))
    },

    // 获取客户档案之后加载其它数据
    loadData() {
      // 如果当前选中的数据不存在于data中，则设置选中行高亮,气表数据置空
      const currentRow = this.tableData.find((item) => item.customerCode === this.currentRow?.customerCode)
      if (currentRow) {
        // 设置选中行高亮
        this.$refs?.multipleTable?.setCurrentRow(currentRow)
      } else {
        this.currentRow = {}
      }
    },

    // 过滤需要显示的筛选按钮
    filterBtns() {
      const cloneProcessStatusBtns = cloneDeep(processStatusBtns)
      const cloneChargeStatusBtns = cloneDeep(chargeStatusBtns)
      let currentBtn = null
      for (const key in processStatusBtns) {
        if(!this.checkPermission(processStatusBtns[key].permission)) {
          delete cloneProcessStatusBtns[key]
        } else {
          if (!currentBtn) {
            currentBtn = key
            this.changeProcessStatus(key)
          }
        }
      }
      for (const key in chargeStatusBtns) {
        if (!this.checkPermission(chargeStatusBtns[key].permission)) {
          delete cloneChargeStatusBtns[key]
        } else {
          if (!currentBtn) {
            currentBtn = key
            this.changeChargeStatus(key)
          }
        }
      }
      this.filterProcessStatusBtns = cloneProcessStatusBtns
      this.filterChangeStatusBtns = cloneChargeStatusBtns
      this.curBtn = currentBtn
    },

    handleSearch() {
      // 重置分页
      this.searchForm.current = 1
      this.$nextTick(() => {
        this.search()
      })
    },

    rowClick(row) {
      this.currentRow = row
    },

    // 重置条件
    resetCondition() {
      this.searchForm.model.dataStatus = dataStatusField.VALID
      this.searchForm.model.processStatus = null
      this.searchForm.model.chargeStatus = null
    },

    // 搜索全部
    queryAll() {
      this.resetCondition()
      this.curBtn = 'all'
      this.search()
    },

    // 抄表状态
    changeDataStatus(code) {
      this.resetCondition()
      this.searchForm.model.dataStatus = code
      this.curBtn = code
      this.search()
    },

    // 审核状态
    changeProcessStatus(code) {
      this.resetCondition()
      this.searchForm.model.processStatus = code
      this.curBtn = code
      this.search()
    },

    // 收费状态
    changeChargeStatus(code) {
      this.resetCondition()
      this.searchForm.model.chargeStatus = code
      this.curBtn = code
      this.search()
    },

    // 表格多选数据
    tableSelect(val) {
      this.multipleSelection = val
    },

    // 提审、审核、撤回、驳回
    handleProcessStatus(code, filterMultipleSelection) {
      if (filterMultipleSelection.length === 0) {
        this.$message.error('请至少选中一条数据')
        return false
      }
      let ids = []
      if (code === processField.REVIEW_REJECTED) {
        ids = filterMultipleSelection.map(item => {
          return {
            id: item.id,
            processStatus: {
              code,
            },
            reviewObjection: this.rejectedMsg,
          }
        })
      } else {
        ids = filterMultipleSelection.map(item => {
          return {
            id: item.id,
            processStatus: {
              code,
            },
          }
        })
      }
      return new Promise((resolve) => {
        this.btnLoading = true
        iotApi.examine(ids).then(res => {
          let {isSuccess} = res.data
          if (isSuccess) {
            this.rejectedMsg = ''
            this.msg('操作成功', 'success')
            this.search()
          }
          resolve(isSuccess)
        })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.btnLoading = false))
      })
    },

    // 提审操作
    handleSubmitForReview() {
      this.handleProcessStatus(processField.SUBMIT_FOR_REVIEW, this.submitForReviewData)
    },

    // 撤回操作
    handleWithdraw() {
      this.handleProcessStatus(processField.TO_BE_REVIEWED, this.withdrawData)
    },

    // 驳回操作
    async handleReviewRejected() {
      const result = await this.handleProcessStatus(processField.REVIEW_REJECTED, this.reviewRejectedData)
      if (result) {
        this.showRejectReason = false
        this.rejectedMsg = null
      }
    },

    // 审核操作
    handleApproved() {
      this.handleProcessStatus(processField.APPROVED, this.appovedData)
    },

    // 结算
    handleSettlement() {
      const multipleSelection = this.settlementData
      if (multipleSelection.length === 0) {
        this.$message.error('请至少选中一条数据')
        return false
      }
      iotApi.settlement(multipleSelection.map((item) => item.id)).then((response) => {
        const {isSuccess} = response.data
        if (isSuccess) {
          this.$message.success('选中抄表数据结算成功')
          this.search()
        }
      }).catch(() => {
      })
    },
    exportMsg(val) {
      console.warn(val)
    },
    // 新增抄表数据成功
    handleAddReadMeterSuccess() {
      this.search()
    },

    // 补抄数据成功
    handleFixReadMeterSuccess(data) {
      this.search()
      if (data) {
        this.fixReadMeterDialogVisible = false
      }
    },

    // 下载抄表导入信息模板
    handleDownloadTemplateFile() {
      iotApi.downloadImportTemplete().then((result) => {
        // console.log('result', result)
      }).catch(() => {
      })
    },

    // 筛选出当前状态的数据
    filterMultipleSelection(codeArr) {
      if (!Array.isArray(codeArr)) {
        codeArr = [codeArr]
      }
      return this.multipleSelection.filter((item) => codeArr.includes(item.processStatus?.code) || codeArr.includes(item.chargeStatus?.code))
    },

    // 打开数据修正弹出框
    handleOpenFixReadMeterDialog(flag) {
      this.isEdit = flag
      this.fixReadMeterDialogVisible = true
    },

    // 设置多选框是否能够选择
    setSelectable(row) {
      return !row.dataType
    }
  },
}
