<!-- 日常综合 退费 -->
<template>
  <div>
    <div>
      <el-tabs v-model="activeName" @tab-click="handleTabClick">
        <el-tab-pane label="缴费列表" name="goCharge"> </el-tab-pane>
        <el-tab-pane label="退费列表" name="goRefund"> </el-tab-pane>
      </el-tabs>
      <!-- 缴费列表  -->
      <div v-if="activeName === 'goCharge'">
        <ChargeList
          ref="chargeListComponent"
          :search-charge-form="searchChargeForm"
          :charge-list="chargeList"
          :search="search"
          :get-charge-list="getChargeList"
          :handle-row-click="handleRowClick"
        />
      </div>
      <!-- 退费列表  -->
      <div v-else>
        <RefundList
          ref="refundListComponent"
          :search-refund-form="searchRefundForm"
          :refund-list="refundList"
          :search="search"
          :get-refund-list="getRefundList"
          :handle-row-click1="handleRowClick1"
          :filter="filter"
          :now-refund-status="nowRefundStatus"
          :cur-row="curRow1"
        />
      </div>
    </div>

    <!-- 缴费明细 -->
    <div v-if="activeName === 'goCharge'">
      <ChargeDetail
        ref="chargeDetailComponent"
        :charge-detail-list="chargeDetailList"
        :charge-detail-form="chargeDetailForm"
        :is-refund-money="isRefundMoney"
        :apply="apply"
        :refund="refund"
        :cur-row="curRow"
        :handle-refund="handleRefund"
        :handle-sumbit="handleSumbit"
        :refund-apply-form="refundApplyForm"
        :refund-type="refundType"
        :no-card-text="noCardText"
      />
    </div>

    <!-- 退费明细 -->
    <div v-else>
      <RefundDetail
        ref="refundDetailComponent"
        :refund-detail-list="refundDetailList"
        :refund-detail-form="refundDetailForm"
        :refund-status="refundStatus"
        :cancel-refund="cancelRefund"
        :start-refund-form="startRefundForm"
        :refund-sumbit="refundSumbit"
        :cur-row="curRow1"
        :search="search"
        :no-card-text="noCardText"
        :load-refund-all-info-data="loadRefundAllInfoData"
      />
    </div>
    <refund-edit
      ref="edit"
      :dialog-visible="isVisible"
      :record="currentRecord"
      @close="isVisible = false"
      @success="search"
    />
  </div>
</template>

<script>
import { debounce } from 'lodash'
import RefundEdit from './components/Edit'
import ChargeList from './components/ChargeList'
import RefundList from './components/RefundList'
import ChargeDetail from './components/ChargeDetail'
import RefundDetail from './components/RefundDetail'
import ChargeApi from '@/api/charges'
import InvoiceApi from '@/api/dailyWork/invoiceManage'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { deepClone } from '@/utils'
import BN from '@/utils/bigNumber'
import { lateFeeFieldsMap } from '@/lang/zh/modules/operation/gasPrice'
import { orderSourceNameField } from '@/enums/meterInfo'
import CardApi from '@/api/card/index'

export default {
  name: 'QcRefund',
  components: {
    RefundEdit,
    ChargeList,
    RefundList,
    ChargeDetail,
    RefundDetail,
  },
  filters: {
    filterEmpty(val) {
      return val ?? '--'
    },
    filterStatus(val) {
      switch (val) {
        case 1:
          return '成功'
        case 2:
          return '拒绝'
        default:
          return '--'
      }
    },
  },
  props: {
    customerChargeNoFromDaily: String,
  },
  data() {
    return {
      apply: false,
      refund: false,
      isVisible: false,
      activeName: 'goCharge',
      searchChargeForm: {
        customerChargeNo: '',
        start: '',
        end: '',
        chargeNo: '',
        activeDate: null,
      },
      searchRefundForm: {
        customerChargeNo: '',
        start: '',
        end: '',
        refundNo: '',
        chargeNo: '',
        activeDate: null,
      },
      currentRecord: {}, // 编辑的记录
      chargeList: {},
      refundList: {},
      chargeDetailList: [],
      refundDetailList: [],
      startRefundForm: {
        auditOpinion: '', //审核意见
        refundId: 0, //退费id
        status: true, //是否可退费
      },
      refundDetailForm: {},
      chargeDetailForm: {},
      refundApplyForm: {
        actualRefundMoney: '', //实退
        canRefundMoney: '', //可退
        chargeNo: '', //缴费单号
        // customerChargeNo: '', //客户缴费编号
        customerName: '', //客户姓名
        refundMethod: '', //退费方式
        refundReason: '', //退费原因
        nonRefund: '',
        submitAudit: true,
        whetherNoCard: 0,
        refundType: 'BACK_ACCOUNT',
      },
      chargePrams: {
        model: {
          chargeNo: '',
          customerChargeNo: '',
          customerCode: '',
          end: '',
          gasMeterCode: '',
          start: '',
        },
        current: 1,
        size: 5,
      },
      refundPrams: {
        model: {
          auditStatus: '',
          chargeNo: '',
          customerChargeNo: '',
          customerCode: '',
          end: '',
          refundNo: '',
          start: '',
        },
        current: 1,
        size: 5,
      },
      //数据字典
      dicts: {
        REFUND_METHOD: {},
      },
      refundType: null,
      refundStatus: '',

      // 当前点击行数据
      curRow: null,
      curRow1: null,
      noCardText: '当前充值已写卡，请谨慎操作，否则将影响以后充值上表。',
      nowRefundStatus: null,
      checkRefundApplyData: {},
      loadRefundAllInfoData: {},
    }
  },
  computed: {
    isRefundMoney() {
      const { receivableMoney, prechargeDeductionMoney } = this.chargeDetailForm
      return BN.minus(receivableMoney, prechargeDeductionMoney)
    },
  },
  watch: {
    customerChargeNoFromDaily(n, o) {
      // console.log(n, o)
      if (n) {
        this.searchChargeForm.customerChargeNo = n
        this.search()
      } else {
        this.searchChargeForm.customerChargeNo = ''
        this.search()
      }
    },
    showReturnPremium(n) {
      console.log(n)
    },
  },
  mounted() {
    //初始化数据字典
    this.dicts = {
      REFUND_METHOD: this.dictMap[dictionaryCodeMap.REFUND_METHOD],
    }
    //初始化退费方式
    const refundType = []
    for (var i in this.dicts.REFUND_METHOD) {
      refundType.push({
        value: i,
        label: this.dicts.REFUND_METHOD[i],
      })
    }
    this.refundType = refundType
  },
  created() {
    this.getChargeList()
    //如果有传入的customerChargeNo，则直接搜索
    // console.log(this.customerChargeNoFromDaily)
    if (this.customerChargeNoFromDaily) {
      this.searchChargeForm.customerChargeNo = this.customerChargeNoFromDaily
      this.search()
    }
  },
  methods: {
    filter(status) {
      this.search(status)
      this.refundDetailList = []
      this.refundDetailForm = {}
      this.refundStatus = ''
    },
    cancelRefund(id) {
      ChargeApi.cancelRefund(id)
        .then(res => {
          console.log(res)
          this.search()
        })
        .finally(() => {
          this.$refs.refundDetailComponent.closeCancelLoading()
        })
    },
    refundSumbit() {
      const startRefundForm = deepClone(this.startRefundForm)
      startRefundForm.refundId = this.refundDetailForm.id
      console.log(this.startRefundForm)
      ChargeApi.audit(startRefundForm)
        .then(res => {
          if (res.data.isSuccess) {
            console.log(res)
            this.search()
          }
        })
        .finally(() => {
          this.$refs.refundDetailComponent.closeRefundLoading()
        })
    },
    async getChargeList(params = {}) {
      const { chargePrams } = this
      chargePrams.current = params.current || chargePrams.current
      chargePrams.size = params.size || chargePrams.size
      chargePrams.model = { ...chargePrams.model, ...params.model }
      const { data: res } = await ChargeApi.pageList(chargePrams).finally(() => {
        this.$refs.chargeListComponent.closeLoading()
      })
      if (res.isSuccess) {
        this.chargeList = res.data
      }
    },
    async getRefundList(params = {}) {
      const { refundPrams } = this
      refundPrams.current = params.current || refundPrams.current
      refundPrams.size = params.size || refundPrams.size
      refundPrams.model = { ...refundPrams.model, ...params.model }
      const { data: res } = await ChargeApi.refundPage(refundPrams).finally(() => {
        this.$refs.refundListComponent.closeLoading()
      })
      if (res.isSuccess) {
        this.refundList = res.data
      }
    },
    async checkRefundApply(row) {
      const res = await ChargeApi.checkRefundApply(row.chargeNo)
      // console.log(res.data.data)
      return res.data.data
    },
    async loadRefundAllInfo(row) {
      const res = await ChargeApi.loadRefundAllInfo(row.id)
      this.nowRefundStatus = res.data.data.chargeRefund.refundStatus
      return res.data.data
    },
    // 收费列表 表格行点击
    handleRowClick: debounce(async function (row, column, event) {
      this.refund = false
      this.getChargeDetail(row.chargeNo)
      this.chargeDetailForm = deepClone(row)
      const checkRefundApply = await this.checkRefundApply(row)
      this.apply = checkRefundApply.isApplyRefund
      this.checkRefundApplyData = checkRefundApply
      this.refundApplyForm.nonRefund = checkRefundApply.nonRefund
      this.refundApplyForm.canRefundMoney = row.receivableMoney
      // console.log(checkRefundApply)
      // this.resetRefundApplyForm()
      // 添加拒绝原因 wujh
      this.curRow = row
      this.curRow.isCardMeter = checkRefundApply.isCardMeter
      console.log(row)
      if (row.chargeMethodCode === 'CASH') {
        this.refundType = this.refundType.filter(i => {
          return i.value != 'PAY_METHOD_REFUND'
        })
      } else {
        this.refundType = this.refundType.filter(i => {
          return i.value != 'CASH'
        })
      }
      // console.log(this.refundType)
      // debugger
      // this.curRow.isViewIC = checkRefundApply.isViewIC
    }, 300),
    // 退费列表 表格行点击
    handleRowClick1: debounce(async function (row, column, event) {
      this.apply = false
      this.refund = false
      this.refundStatus = row.refundStatus
      this.refundDetailForm = deepClone(row)
      const loadRefundAllInfo = await this.loadRefundAllInfo(row)
      this.loadRefundAllInfoData = loadRefundAllInfo
      this.refundDetailForm.customerName = loadRefundAllInfo.chargeRecord?.customerName
      this.getRefundDetail(loadRefundAllInfo.chargeRecord.chargeNo)
      this.curRow1 = row
      this.curRow1.isCardMeter = loadRefundAllInfo.isCardMeter
      // this.curRow1.isViewIC = loadRefundAllInfo.isViewIC
    }, 300),
    // 头部点击
    handleTabClick() {
      this.activeName === 'goCharge' ? this.getChargeList() : this.getRefundList()
    },
    // 获取收费明细
    async getChargeDetail(chargeNo) {
      const { data: res } = await InvoiceApi.getBillDetail(chargeNo)
      if (res.isSuccess) {
        this.chargeDetailList = res.data
      }
    },
    // 获取收费明细
    async getRefundDetail(chargeNo) {
      const { data: res } = await InvoiceApi.getBillDetail(chargeNo)
      if (res.isSuccess) {
        this.refundDetailList = res.data
      }
    },
    search(status) {
      if (this.activeName === 'goCharge') {
        const { searchChargeForm } = this
        searchChargeForm.start = searchChargeForm.activeDate ? searchChargeForm.activeDate[0] : ''
        searchChargeForm.end = searchChargeForm.activeDate ? searchChargeForm.activeDate[1] : ''
        this.getChargeList({ model: searchChargeForm })
        this.resetChargeDetailForm()
      } else {
        const { searchRefundForm } = this
        searchRefundForm.start = searchRefundForm.activeDate ? searchRefundForm.activeDate[0] : ''
        searchRefundForm.end = searchRefundForm.activeDate ? searchRefundForm.activeDate[1] : ''
        searchRefundForm.auditStatus = status ? status : ''
        this.getRefundList({ model: searchRefundForm })
        this.resetRefundDetailForm()
      }
    },
    handleEdit(record) {
      this.currentRecord = {
        ...record,
      }
      this.isVisible = true
    },
    handleRefund() {
      this.refund = true
    },
    //清空退费Detail 组件数据
    resetRefundDetailForm() {
      this.refundDetailForm = {}
      this.refundDetailList = []
      this.curRow1 = null
    },
    //清空收费Detail 组件数据
    resetChargeDetailForm() {
      this.curRow = null
      this.chargeDetailList = []
      this.chargeDetailForm = {}
    },
    //清空退费请求表单 refundApplyForm
    resetRefundApplyForm() {
      this.refundApplyForm = {
        actualRefundMoney: '', //实退
        canRefundMoney: '', //可退
        chargeNo: '', //缴费单号
        // customerChargeNo: '', //客户缴费编号
        customerName: '', //客户姓名
        refundMethod: '', //退费方式
        refundReason: '', //退费原因
        submitAudit: true,
        refundType: 'CASH',
      }
    },
    //提审
    async handleSumbit() {
      const { refundApplyForm } = this
      const params = deepClone(refundApplyForm)
      let next = false
      if (this.checkRefundApplyData.isCardRefund) {
        //是否要读卡
        const res = await CardApi.readCar(
          (code, readData) => {
            params.readData = readData
          },
          () => {
            next = true
            this.$refs.chargeDetailComponent.closeLoading()
          }
        )
      }
      if (next) {
        return
      }
      params.chargeNo = this.chargeDetailForm.chargeNo
      params.refundMethod = params.refundType
      params.actualRefundMoney = this.isRefundMoney
      params.canRefundMoney = this.isRefundMoney
      params.isCardRefund = this.checkRefundApplyData?.isCardRefund
      params.isCardMeter = this.checkRefundApplyData?.isCardMeter
      params.isMoneyMeter = this.checkRefundApplyData?.isMoneyMeter
      ChargeApi.refundApply(params)
        .then(res => {
          if (res.data.isSuccess) {
            this.search()
            this.resetRefundApplyForm()
            this.refund = false
            this.apply = false
          }
        })
        .catch(() => {
          this.$refs.chargeDetailComponent.closeLoading()
        })
        .finally(() => {
          this.$refs.chargeDetailComponent.closeLoading()
        })
    },
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  .el-row {
    width: 100%;
  }
  .el-form-item {
    width: 16%;
  }
}
.jh-text .el-form-item {
  width: 20%;
}
::v-deep .el-table td {
  border-bottom: 0;
}
</style>
