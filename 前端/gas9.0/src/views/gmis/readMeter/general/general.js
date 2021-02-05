// 普表抄表

import { cloneDeep } from 'lodash'
// tools
import {parseDate2Str} from '@/utils/commons.js'
import apiImport from '@/api/readMeter/import.js'

// 业务组件
import ReadMeterBook from './components/readMeterBook/ReadMeterBook.vue' // 抄表册
import ReadMeterImport from './components/import/ReadMeterImport.vue' //  抄表导入
import ReadMeterPlan from './components/readMeterPlan/ReadMeterPlan.vue' // 抄表计划
import WithholdImport from './components/WithholdImport.vue' // 代扣导入
import RejectReason from '@/components/QcPopUpWindow/RejectReason.vue' // 驳回
import add from './components/add.vue' // 添加
import Edit from './components/Edit.vue' // 纠正数据

// tabs
import CustomerDetails from '@/components/QcTabsInfo/CustomerDetails.vue' // 客户信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails' // 表具信息
import ReadMeterRecords from '@/components/QcTabsInfo/ReadMeterRecords.vue' // 抄表记录
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo' // 欠费明细
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords' // 缴费记录
import PricePlan from '@/components/QcTabsInfo/PricePlan' // 气价方案
import MeterStatusDetails from '@/components/QcTabsInfo/MeterStatusDetails.vue' // 气表状态
import ReadMeterStatistics from './components/tabs/ReadMeterStatistics.vue' // 统计模块
// 引入用气类型类型接口
import {getUseGasTypeList} from '@/api/operation/gasPrice'
import {initQueryParams} from '@/utils/commons'
import { processField, chargeStatusField } from '@/enums/readMeter'

// 进度状态显示按钮
const processStatusBtns = {
  [processField.TO_BE_REVIEWED]: {
    text: '待提审',
    permission: ['readMeterGeneral:filter-dts'],
  },
  [processField.REVIEW_REJECTED]: {
    text: '已驳回',
    permission: ['readMeterGeneral:filter-bh'],
  },
  [processField.SUBMIT_FOR_REVIEW]: {
    text: '待审核',
    permission: ['readMeterGeneral:filter-dsh'],
  },
  [processField.APPROVED]: {
    text: '待结算',
    permission: ['readMeterGeneral:filter-djs'],
  },
}

// 收费状态显示按钮
const chargeStatusBtns = {
  // [chargeStatusField.ARREARS]: {
  //   text: '欠费',
  //   permission: ['readMeterGeneral:qf'],
  // },
  [chargeStatusField.NO_CHARGE]: {
    text: '待收费',
    permission: ['readMeterGeneral:filter-dsf'],
  },
  [chargeStatusField.CHARGED]: {
    text: '已收费',
    permission: ['readMeterGeneral:filter-ysf'],
  },
  // [chargeStatusField.INVOICED]: '已出票',
}

export default {
  name: 'GeneralReadMeter',
  components: {

    ReadMeterBook, // 抄表册
    ReadMeterPlan, // 抄表计划
    ReadMeterImport, // 抄表导入
    WithholdImport, // 代扣导入
    RejectReason, // 驳回
    add,
    Edit,

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
  data() {
    return {
      // 搜索
      searchForm: this.initQueryParams({
        model: {
          gasMeterNumber: '', // 表身号
          customerChargeNo: '', // 缴费编号
          address: '', // 	安装地址
          customerName: '', // 客户名称
          useGasTypeName: '', // 用气类型名称
          readTime: '', // 抄表年月
          readMeterUserName: '', // 抄表员名称

          /**
           * 数据状态
           * 未抄表：-1
           * 取消：2
           * 已抄：0
           **/
          dataStatus: 0,

          /*
           * 审核状态
           * 待审核：TO_BE_REVIEWED
           * 提审：SUBMIT_FOR_REVIEW
           * 审核通过（待结算）： APPROVED
           * 审核驳回： REVIEW_REJECTED
           */
          processStatus: 'TO_BE_REVIEWED',

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
      }),
      // list
      tableData: [],
      total: 0,
      listLoading: false,

      // 高亮选择状态
      curBtn: 'TO_BE_REVIEWED',

      multipleSelection: [],

      rejectedMsg: '',

      curPlan: null, // 当前修改数据
      useGasTypeList: {},//用气类型数据
      // 弹出组件控制
      showReadMeterBook: false, // 抄表册
      showReadMeterPlan: false, // 抄表计划
      showReadMeterImport: false, // 抄表导入
      showWithholdImport: false, // 代扣导入
      showRejectReason: false, // 驳回
      showAdd: false, // 添加
      showEdit: false, // 纠正数据

      currentItem: {}, // 当前点击行
      btnDisable: false,

      curTabsLabel: '客户信息', // 右侧当前点击标签名
      filterProcessStatusBtns: {}, // 显示的进度按钮
      filterChangeStatusBtns: {}, // 显示的收费相关按钮
    }
  },
  computed: {
    // 显示结算日期
    showSettlementTime() {
      return [chargeStatusField.NO_CHARGE, chargeStatusField.CHARGED].includes(this.curBtn)
    },
    // 是否可移出数据
    IS_REMOVE_DATA() {
      return [processField.TO_BE_REVIEWED].includes(this.curBtn)
    },
    // 是否可提审
    IS_SUBMIT_FOR_REVIEW() {
      return [processField.TO_BE_REVIEWED, processField.REVIEW_REJECTED].includes(this.curBtn)
    },
    // 是否可撤回数据
    IS_WITHDRAW() {
      return ![processField.TO_BE_REVIEWED, 'all'].includes(this.curBtn)
    },
    // 是否可驳回数据
    IS_REVIEW_REJECTED() {
      return [processField.SUBMIT_FOR_REVIEW].includes(this.curBtn)
    },
    // 是否可审核数据
    IS_APPROVED() {
      return [processField.SUBMIT_FOR_REVIEW].includes(this.curBtn)
    },
    // 是否可结算数据
    IS_SETTLEMENT() {
      return [processField.APPROVED].includes(this.curBtn)
    },
    // 是否可收费数据
    IS_NO_CHARGE() {
      return [chargeStatusField.NO_CHARGE].includes(this.curBtn)
    },
    // 是否可打印缴费通知
    IS_PRINT_PAY() {
      return [chargeStatusField.NO_CHARGE].includes(this.curBtn)
    },
    // 是否可打印催款通知
    IS_PRINT_DUNNING() {
      return [chargeStatusField.ARREARS].includes(this.curBtn)
    },
    // 是否可纠正数据
    IS_UPDATE() {
      return [processField.TO_BE_REVIEWED, processField.REVIEW_REJECTED].includes(this.curBtn)
    },
  },
  created() {
    this.filterBtns()
    // this.search()
    this.getUseGasTypeListData()
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
      apiImport.queryReadMeterWorkInfo(searchForm).then(res => {
        let {isSuccess, data} = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = parseInt(data.total)
          this.$nextTick(() => {
            this.$refs.multipleTable?.doLayout()
          })
        }
      }).finally(() => (this.listLoading = false))
    },

    handleSearch() {
      // 重置分页
      this.searchForm.current = 1
      this.$nextTick(() => {
        this.search()
      })
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

    // 获取所有用气类型名称
    getUseGasTypeListData(params = {}) {
      if (this.useGasTypeList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({size: 10000, ...params})).then((result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            const {total, records} = data
            this.useGasTypeList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 重置条件
    resetCondition() {
      this.searchForm.model.dataStatus = 0
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

    // 表格行点击
    rowClick(row, column, event) {
      this.currentItem = row
    },

    // 表格多选数据
    tableSelect(val) {
      this.multipleSelection = val
    },

    // 驳回
    rejectedHandle() {
      this.showRejectReason = true
      this.btnDisable = true
    },

    // 驳回
    handleReviewRejected() {
      this.handleProcessStatus(processField.REVIEW_REJECTED)
    },

    // 审核
    handleApproved() {
      this.handleProcessStatus(processField.APPROVED)
    },

    // 提审、审核、撤回、驳回
    handleProcessStatus(code) {
      this.btnDisable = true
      let ids = []
      if (code === 'REVIEW_REJECTED') {
        ids = this.multipleSelection.map(item => {
          return {
            id: item.id,
            processStatus: {
              code,
            },
            reviewObjection: this.rejectedMsg,
          }
        })
      } else {
        ids = this.multipleSelection.map(item => {
          return {
            id: item.id,
            processStatus: {
              code,
            },
          }
        })
      }

      apiImport.examine(ids).then(res => {
        this.btnDisable = false
        this.showRejectReason = false
        let {isSuccess} = res.data
        if (isSuccess) {
          this.rejectedMsg = ''
          // 如果点击的是撤回按钮
          if (code === 'TO_BE_REVIEWED') {
            if (res.data.msg !== 'ok') {
              this.msg(res.data.msg, 'error')
            }
          } else {
            this.msg('操作成功', 'success')
          }

          this.search()
        }
      }).finally(() => {
        this.btnDisable = false
        this.showRejectReason = false
      })
    },

    // 撤回 移除待提审数据
    removeReaderMeterData() {
      this.btnDisable = true
      let ids = []
      ids = this.multipleSelection.map(item => {
        return item.id
      })

      apiImport.withDraw(ids).then(res => {
        this.btnDisable = false
        const {isSuccess} = res.data
        if (isSuccess) {
          // todo 和杨明对接接口

          this.search()
        }
      }).finally(() => {
        this.btnDisable = false
      })
    },

    // 提审
    handleSubmitForReview() {
      this.handleProcessStatus(processField.SUBMIT_FOR_REVIEW)
    },

    // 撤回
    handleWithdraw() {
      this.handleProcessStatus(processField.TO_BE_REVIEWED)
    },

    // 结算
    handleSettlement() {
      this.btnDisable = true
      const multipleSelection = this.multipleSelection
      if (multipleSelection.length === 0) {
        this.$message.error('请至少选中一条数据')
        return false
      }
      apiImport.settlement(multipleSelection.map((item) => item.id)).then((response) => {
        this.btnDisable = false
        const {isSuccess} = response.data
        if (isSuccess) {
          this.$message.success('选中抄表数据结算成功')
          this.search()
        }
      }).finally(() => {
        this.btnDisable = false
      })
    },

    // 纠正数据
    edit(row) {
      this.showEdit = true
      this.curPlan = JSON.parse(JSON.stringify(row))
    },

    // 纠正数据成功
    handleEditSuccess() {
      this.showEdit = false
      this.search()
    },
    exportMsg(val) {
      console.warn(val)
    },

    // 设置多选框是否能够选择
    setSelectable(row) {
      return !row.dataType
    },

    // 抄表数据添加成功
    handleAddSuccess() {
      // this.showAdd = false
      this.search()
    }
  },
}
