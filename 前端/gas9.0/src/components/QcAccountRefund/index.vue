<!-- 日常综合 账户退费 -->
<template>
  <div>
    <div>
      <el-tabs v-model="activeName" @tab-click="handleTabClick">
        <el-tab-pane label="账户列表" name="goCharge"> </el-tab-pane>
        <el-tab-pane label="账户退费列表" name="goRefund"> </el-tab-pane>
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
        />
      </div>
    </div>

    <!-- 缴费明细 -->
    <div v-if="activeName === 'goCharge'">
      <!-- :refund="refund" -->
      <ChargeDetail
        ref="chargeDetailComponent"
        :charge-detail-list="chargeDetailList"
        :charge-detail-form="chargeDetailForm"
        :is-refund-money="isRefundMoney"
        :apply="apply"
        :cur-row="curRow"
        :handle-refund="handleRefund"
        :handle-sumbit="handleSumbit"
        :refund-apply-form="refundApplyForm"
        :refund-type="refundType"
        :no-card-text="noCardText"
        :apply-refund-form="applyRefundForm"
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
        :is-back-gas="isBackGas"
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
    customerNameFromDaily: String,
    isRefundSuccess: Object,
  },
  data() {
    return {
      apply: false,
      // refund: false,
      isVisible: false,
      activeName: 'goCharge',
      searchChargeForm: {
        // customerChargeNo: '',
        // start: '',
        // end: '',
        // chargeNo: '',
        // activeDate: null,
        customerName: '', //客户名称
        identityCardNo: '', //证件号
        phone: '', //电话
      },
      searchRefundForm: {
        // customerChargeNo: '',
        // refundNo: '',
        // chargeNo: '',
        // activeDate: null,
        start: '',
        end: '',
        customerName: '', //客户名称
        identityCardNo: '', //证件号
        phone: '', //电话
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
      refundDetailForm: {
        customerName: '-',
        methodName: '-',
        applyReason: '-',
        accountMoney: '-',
      },
      chargeDetailForm: {
        customerName: '-',
        identityCardNo: '-',
        address: '-',
        accountMoney: '-',
      },
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
        refundType: 'CASH',
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
        ACCOUNT_REFUND_METHOD: {},
      },
      refundType: null,
      refundStatus: '',

      // 当前点击行数据
      curRow: null,
      curRow1: null,
      noCardText: '当前充值已写卡，请谨慎操作，否则将影响以后充值上表。',
      isBackGas: null,
      applyRefundForm: {
        actualRefundMoney: '', //实退金额
        customerCode: '', //客户编码
        refundMethod: '', //退费方式: 退回账户；现金退费
        refundReason: '', //退费原因
      },
    }
  },
  computed: {
    isRefundMoney() {
      const { receivableMoney, prechargeDeductionMoney } = this.chargeDetailForm
      return BN.minus(receivableMoney, prechargeDeductionMoney)
    },
  },
  watch: {
    customerNameFromDaily(n,o) {
      // console.log(n, o)
      if (n) {
        this.searchChargeForm.customerName = n
        this.search()
      }else{
        this.searchChargeForm.customerName = ''
        this.search()
      }
    },
  },
  mounted() {
    //初始化数据字典
    this.dicts = {
      ACCOUNT_REFUND_METHOD: this.dictMap[dictionaryCodeMap.ACCOUNT_REFUND_METHOD],
    }
    //初始化退费方式
    const refundType = []
    for (var i in this.dicts.ACCOUNT_REFUND_METHOD) {
      refundType.push({
        value: i,
        label: this.dicts.ACCOUNT_REFUND_METHOD[i],
      })
    }
    this.refundType = refundType
  },
  created() {
    this.getChargeList()
    //如果有传入的customerChargeNo，则直接搜索
    // console.log(this.customerNameFromDaily)
    if (this.customerNameFromDaily) {
      this.searchChargeForm.customerName = this.customerNameFromDaily
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
      ChargeApi.accountRefundCancelRefund(id)
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
      // console.log(this.startRefundForm)
      ChargeApi.accountRefundAudit(startRefundForm)
        .then(res => {
          if (res.data.isSuccess) {
            console.log(res)
            this.search()
            this.resetRefundDetailForm()
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
      const { data: res } = await ChargeApi.custPageList(chargePrams).finally(() => {
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
      const { data: res } = await ChargeApi.accountPageList(refundPrams).finally(() => {
        this.$refs.refundListComponent.closeLoading()
      })
      if (res.isSuccess) {
        this.refundList = res.data
      }
    },
    async checkRefundApply(row) {
      const res = await ChargeApi.checkAccountRefundApply(row.customerCode)
      return res.data.data
    },
    // async loadRefundAllInfo(row) {
    //   const res = await ChargeApi.loadRefundAllInfo(row.id)
    //   this.isBackGas = res.data.data.isBackGas
    //   // debugger
    //   return res.data.data
    // },
    //刷新chargeDetail
    refushChargeDetail() {
      this.chargeDetailForm = {
        customerName: '-',
        identityCardNo: '-',
        address: '-',
        accountMoney: '-',
      }
      this.applyRefundForm = {
        actualRefundMoney: '', //实退金额
        customerCode: '', //客户编码
        refundMethod: '', //退费方式: 退回账户；现金退费
        refundReason: '', //退费原因
      }
      // this.curRow = null
      this.apply = false
    },
    // 收费列表 表格行点击
    handleRowClick: debounce(async function (row, column, event) {
      // this.refund = false
      this.refushChargeDetail()
      this.getChargeDetail(row.chargeNo)
      this.chargeDetailForm = deepClone(row)
      const checkRefundApply = await this.checkRefundApply(row)
      this.apply = checkRefundApply.isApplyRefund
      this.refundApplyForm.nonRefund = checkRefundApply.nonRefund
      this.refundApplyForm.canRefundMoney = row.receivableMoney
      this.curRow = row
      // debugger
      this.curRow.isViewIC = checkRefundApply.isViewIC
    }, 300),
    // 退费列表 表格行点击
    handleRowClick1: debounce(async function (row, column, event) {
      this.apply = false
      // this.refund = false
      this.refundStatus = row.refundStatus
      this.refundDetailForm = deepClone(row)
      // const loadRefundAllInfo = await this.loadRefundAllInfo(row)
      // this.refundDetailForm.customerName = loadRefundAllInfo.chargeRecord?.customerName
      // this.getRefundDetail(loadRefundAllInfo.chargeRecord.chargeNo)
      this.curRow1 = row
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
      this.chargePrams.current = 1
      this.refundPrams.current = 1
      if (this.activeName === 'goCharge') {
        const { searchChargeForm } = this
        // searchChargeForm.start = searchChargeForm.activeDate ? searchChargeForm.activeDate[0] : ''
        // searchChargeForm.end = searchChargeForm.activeDate ? searchChargeForm.activeDate[1] : ''
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
    async handleRefund() {
      // this.refund = true
      this.applyRefundForm.customerCode = this.curRow.customerCode
      const res = await ChargeApi.accountRefundApply(this.applyRefundForm)
      if (res.data.isSuccess) {
        this.$message({
          message: '退费成功!',
          type: 'success',
        })
        this.isRefundSuccess.value = true
        this.refushChargeDetail()
        this.curRow = null
      }
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
    handleSumbit() {
      const { refundApplyForm } = this
      const params = deepClone(refundApplyForm)
      params.chargeNo = this.chargeDetailForm.chargeNo
      params.refundMethod = params.refundType
      params.actualRefundMoney = this.isRefundMoney
      params.canRefundMoney = this.isRefundMoney
      ChargeApi.refundApply(params)
        .then(res => {
          if (res.data.isSuccess) {
            this.search()
            this.resetRefundApplyForm()
            // this.refund = false
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
