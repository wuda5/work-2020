<!--
 * @Description: 安检
 * @Author: lingw
 * @Date: 2020-11-19 09:54:19
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-28 10:53:58
-->

<template>
  <div class="qc-main">
    <!--search-->
    <search-box>
      <el-form :model="queryParams" inline>
        <!-- 客户姓名 -->
        <el-form-item>
          <el-input v-model="queryParams.model.customerName" placeholder="客户名称" />
        </el-form-item>
        <!-- 客户编号 -->
        <el-form-item>
          <el-input v-model="queryParams.model.customerCode" placeholder="客户编号" />
        </el-form-item>
        <!-- 气表编号 -->
        <el-form-item>
          <el-input v-model="queryParams.model.gasCode" placeholder="气表编号" />
        </el-form-item>
        <!-- 安检员 -->
        <el-form-item>
          <el-input v-model="queryParams.model.securityCheckUserName" placeholder="安检人员" />
        </el-form-item>
        <!-- 安检编号 -->
        <el-form-item>
          <el-input
            v-model="queryParams.model.scNo"
            placeholder="安检编号"
          />
        </el-form-item>
        <el-form-item>
          <!-- 查询 -->
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>
    </search-box>
    <!-- 安检 -->
    <el-row :gutter="10">
      <!--center-->
      <el-col :lg="{span:17}" :xs="24" :sm="24" style="margin-top: 10px">
        <div style="height: 760px;">
          <!-- 安检列表 -->
          <el-card shadow="never" style="height: 420px">
            <div slot="header">
              <span class="card-title">安检列表</span>
                <!-- 操作按钮 -->
                <div class="butGroup card-tool-bar">
                  <!-- 提审 -->
                  <el-button v-if="approval_visible" type="primary" @click="handleApproval">提审</el-button>
                  <!-- 审核  -->
                  <el-button v-if="audit_visible" type="primary" @click="handleAudit">审核</el-button>
                  <!-- 撤回 -->
                   <el-button v-if="recall_visible" type="primary">撤回</el-button>
                   <!-- 终止 -->
                   <el-button v-if="end_visible" type="danger" @click="stopVisible = true">终止</el-button>
                  <!-- 派工工单 -->
                  <el-button v-if="send_survey_visible" type="primary" @click="handleDispatch">派工</el-button>
                  <!-- 转单 -->
                  <!-- <el-button v-if="transfer_visible" type="primary" @click="handleTransferOrder">转单</el-button> -->
                  <!-- 驳回 -->
                  <!-- <el-button v-if="reject_visible" type="primary" @click="refuseVisible = true">驳回</el-button> -->
                  <!-- 结单 -->
                  <el-button v-if="resolve_visible" type="primary" @click="handleOver">结单</el-button>
                  <!-- 导出 -->
                  <!-- <el-button v-if="tableDataList.list.length" type="primary">导出</el-button> -->
                </div>
            </div>
            <div class="butGroup card-tool-bar" style="margin: -10px 0 10px 0">
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('WAIT_ARRAIGNED'))">待提审</el-button>
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('WAIT_AUDIT'))">待审核</el-button>
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('WAIT_ORDER'))">待派工</el-button>
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('WAIT_CHECK'))">待安检</el-button>
              <!-- <el-button type="primary" plain @click="() => handleSearch($sc_constant('WAIT_FALLBACK'))">待回访</el-button> -->
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('EXCEPTION'))">异常</el-button>
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('HAVE_SETTLED'))">已结单</el-button>
              <el-button type="primary" plain @click="() => handleSearch($sc_constant('HAVE_END'))">终止</el-button>
              <el-button type="primary" plain @click="handleSearch">全部</el-button>
            </div>
            <!-- 安检列表 -->
            <sc-list :table-data-list="tableDataList" @pagination="handleChange" @row-click="handleRowClick" @edit="(val, row) => handleSecurityCheck(val, row)"
              @data-input="handleInputData"
/>
          </el-card>
          <el-card shadow="never">
            <el-tabs v-model="activeTabName" @tab-click="handleTabChange">
              <el-tab-pane label="工单列表" name="orderList">
                <order-list :order-list="orderList" @row-click="handleOrderRowClick" @pagination="handleOrderChange" />
              </el-tab-pane>
              <el-tab-pane label="隐患列表" name="warnList">
                <warn-list :warn-list="warnList" :warn-level="warnLevel" @handleWarnEdit="handleWarnEdit" @pagination="handleWarnChange" />
              </el-tab-pane>
            </el-tabs>
          </el-card>
        </div>
      </el-col>

      <!--right-->
      <el-col :lg="7" :xs="24" :sm="24" style="margin-top: 10px">
        <!-- 更多信息 -->
        <div style="height: 760px">
          <el-tabs v-model="rightActiveName" class="moreInfo" tab-position="left" style="height: 760px;" @tab-click="fetchProcessAndInfo">
            <el-tab-pane label="安检统计" name="statistics">
              <!-- 安检统计 -->
              <el-card shadow="never" class="counter">
                <div slot="header">
                  <span class="card-title">安检统计</span>
                </div>
                <counter-statistics />
              </el-card>
            </el-tab-pane>
            <!-- 缴费信息 -->
            <el-tab-pane label="流程信息" name="process">
              <process-info :process-list="processList" />
            </el-tab-pane>
            <!-- 安检信息 -->
            <el-tab-pane label="安检信息" name="securityInfo">
              <security-check-info :security-info="securityInfo" />
            </el-tab-pane>
          </el-tabs>
        </div>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div class="footNav-item" @click="() => handleSecurityCheck(1)">
        <div class="icon">
          <svg-icon icon-class="installMeter" />
        </div>
        <p>批量安检</p>
      </div>
    </qc-foot-menu>
    <!-- 弹框 start -->
    <!-- 安检资料 -->
    <qc-dialog
      :width="800"
      title="安检资料"
      :visible="showUpload"
      data-key="showUpload"
      @close="showUpload = false"
    >
      <qc-upload />
    </qc-dialog>
    <!-- 安检 - 新增/编辑 -->
    <qc-dialog
      :visible="editVisible"
      :width="1080"
      :title="editTitle"
      data-key="editVisible"
      @close="editVisible = false"
    >
      <edit ref="edit" :use-gas-type="useGasType" :user-list="userList"
      :customer-code="currentTarget.customerCode"
      @search="handleUserSearch" @submit="handleSCEdit"
      />
    </qc-dialog>
    <!-- 安检 - 派单 -->
    <qc-dialog
      :visible="sendVisible"
      :width="400"
      title="派工"
      data-key="sendVisible"
      @close="sendVisible = false"
    >
      <dispatch-order ref="dispatchOrder" :worker-list="workerList" @diapatch="handleDispatchOrder" />
    </qc-dialog>
    <!-- 安检 - 录入隐患资料 -->
    <qc-dialog
      :visible="inputWarnVisible"
      :width="520"
      title="录入隐患资料"
      data-key="inputWarnVisible"
      @close="inputWarnVisible = false"
    >
      <security-warn-detail ref="warnDetail" :warn-level="warnLevel" @submit="handleScWarnSubmit" @cancel="inputWarnVisible = false" />
    </qc-dialog>
    <!-- 安检 - 录入安检结果 -->
    <qc-dialog
      :visible="inputDataVisible"
      :width="520"
      title="录入安检结果"
      data-key="inputDataVisible"
      @close="inputDataVisible = false"
    >
     <!-- :result-list="resultList" -->
      <security-check-detail ref="resultDetail" :all-check-infos="allCheckInfos" @submit="handleScDataSubmit" @cancel="inputDataVisible = false" />
    </qc-dialog>
    <!-- 安检 - 工单材料详情 -->
    <qc-dialog
      :visible="orderFilesVisible"
      :width="520"
      title="工单材料详情"
      data-key="orderFilesVisible"
      @close="orderFilesVisible = false"
    >
      <order-files-info ref="orderFilesInfo" :order-files-info="orderFilesInfo"
      :order-info="currentOrder"
/>
    </qc-dialog>
    <!-- 安检 - 终止 -->
    <qc-dialog
      :visible="stopVisible"
      :width="400"
      title="终止"
      data-key="stopVisible"
      @close="stopVisible = false"
    >
      <el-form class="jh-text" label-position="top">
        <el-form-item label="终止原因">
          <el-input v-model="stopDesc"></el-input>
        </el-form-item>
      </el-form>
      <el-button :loading="stopLoading" type="primary" @click="handleStop">
        终止
      </el-button>
    </qc-dialog>
  </div>
</template>

<script>
import { deepClone } from '@/utils'
import Edit from './components/Edit'
import ScList from './components/SCList'
import OrderList from './components/OrderList'
import WarnList from './components/WarnList'
import ProcessInfo from './components/ProcessInfo'
import SecurityWarnDetail from './components/SecurityWarning'
import SecurityCheckDetail from './components/SecurityCheckDetail'
import CounterStatistics from './components/CounterStatistics' // 统计模块
import SecurityCheckInfo from './components/SecurityCheckInfo'
import DispatchOrder from './components/DispatchOrder'
import OrderFilesInfo from './components/OrderFilesInfo'
import dictionaryItemApi from '@/api/DictionaryItem'
import securityCheckApi from '@/api/safeCheck'
import { default as Api } from '@/api/temporary/index.js';
import { dataStatusField } from '@/enums/common'
import { initQueryParams } from '@/utils/commons'
import { constants as STATUS } from '@/plugins/securityCheck'
import { forEach } from 'jszip'
const SECURITY_CHECK = 1;
const EDIT = 2;

export default {
  name: 'SecurityCheck',
  components: {
    Edit,
    CounterStatistics,
    ScList,
    OrderList,
    WarnList,
    ProcessInfo,
    DispatchOrder,
    SecurityWarnDetail,
    SecurityCheckDetail,
    OrderFilesInfo,
    SecurityCheckInfo
  },
 
  data() {
    return {
      showUpload: false,
      editVisible: false,
      sendVisible: false,
      stopVisible: false,
      inputDataVisible: false,
      inputWarnVisible: false,
      stopLoading: false, // 终止 按钮 loading
      orderFilesVisible: false,
      securityCheckerLoading: false,
      activeTabName: 'orderList', // 标签页
      rightActiveName: 'statistics',
      chargeSectionOne: {
        receivedMoney: '100.00',
        waitMoney: '0.00',
        amountMoney: '100.00'
      },
      tableDataList: {
        list: [],
        size: 5,
        current: 1,
        total: 0,
      },
      orderList: {
        list: [],
        size: 5,
        current: 1,
        total: 0,
      },
      warnList: {
        list: [],
        size: 5,
        current: 1,
        total: 0
      },
      workerList: [], // 工人列表
      chargeData: [
        {
          chargeItem: '安装费',
          amount: '100',
          status: '待收'
        },
        {
          chargeItem: '安装费',
          amount: '100.00',
          status: '已收'
        }
      ],
      editType: 1, // 默认是安检 1： 安检 2：修改
      reportTypes: [], // 包装类型
      cardTypes: [], // 证件类型
      communityList: [], // 小区列表
      detailList: [], // 详细地址列表
      processList: [], // 流程列表
      // 搜索条件查询安检列表
      queryParams: initQueryParams({
        model: {
          customerName: '', // 安检人 - 客户名称
          telphone: '', // 联系电话
          addressRemark: '', // 安检地址 - 详细地址备注
          dataStatus: '',  // 安检状态
          community: {},
          street: {},
          securityCheckUserId: '', // 安检员ID
          securityCheckUserName: '', // 安检员名称
        },
        size: 5,
        page: 1
      }),
      // 安检工单参数
      orderQueryParams: initQueryParams({
        model: {
          businessOrderNumber: '', // 安检编号
        },
        size: 5,
        page: 1
      }),
      currentTarget: {},
      stopDesc: '', // 终止原因
      orderFilesInfo: [], // 工单材料列表
      currentOrder: {}, // 工单材料详情
      // 燃气类型
      useGasType: [],
      userList: {
        records: [],
        total: 0,
        pages: 1,
        size: 10
      },
      // 安检结果列表
      resultList: [],
      // 所有安检项及其子项信息
      allCheckInfos: [],
      // 右侧-安检信息
      securityInfo: {

      },
      // 隐患等级
      warnLevel: []
    }
  },
  computed: {
    approval_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_ARRAIGNED
    },
    editTitle() {
      return this.editType === SECURITY_CHECK ? '安检受理' : '编辑'
    },
    recall_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_AUDIT
    },
    survey_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_ORDER
    },
    reject_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_AUDIT
    },
    transfer_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_BUILD
    },
    audit_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_AUDIT
    },
    resolve_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_CHECK
    },
    send_survey_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_ORDER
    },
    end_visible() {
      const currentStatus = this.currentTarget.dataStatus
      if (currentStatus === STATUS.WAIT_ARRAIGNED || currentStatus === STATUS.WAIT_AUDIT || currentStatus === STATUS.WAIT_ORDER) {
        return true
      }
      return false
    },
    input_warn_visible() {
      // return this.currentTarget.dataStatus === STATUS.HAVE_SETTLED
      return true
    }
  },
  watch: {
    editVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.edit.reset()
        this.$refs.edit.loading = false
        this.$refs.edit.toggleSelection([])
      } else {
        if (this.userList.records.length) {
          return
        }
        this.getUserList()
      }
    },
    sendVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.dispatchOrder.reset()
        this.$refs.dispatchOrder.loading = false
      }
    },
    inputDataVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.resultDetail.reset()
        this.$refs.resultDetail.loading = false
      }
    },
    inputWarnVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.warnDetail.reset()
        this.$refs.warnDetail.loading = false
      }
    },
    stopVisible(newVal, oldVal) {
      if (!newVal) {
        this.stopLoading = false
        this.stopDesc = ''
      }
    }
  },
  created() {
    this.getSCList(this.queryParams)
    this.getUseGasType()
  },
  methods: {
    // 获取用气类型
    getUseGasType() {
      Api.getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then(res => {
        const { isSuccess, data } = res.data

        if (isSuccess) {
          this.useGasType = data.records
        }
      })
    },
    // 安检计划列表 - 选中某行
    handleRowClick(record) {
      this.currentTarget = {
        ...record
      }
      this.fetchOtherInfoWhileClick()
    },
    // 行点击的时候请求其他数据
    fetchOtherInfoWhileClick() {
      this.fetchOrderOrWarnList()
      this.fetchProcessAndInfo()
    },
    // 获取工单或者隐患列表
    fetchOrderOrWarnList() {
      if (this.activeTabName === 'orderList') {
        this.getOrderList({
          id: this.currentTarget.scNo
        })
      } else if (this.activeTabName === 'warnList') {
        this.getWarnList({
          scNo: this.currentTarget.scNo
        })
      }
    },
    // 右侧tab信息切换 请求数据
    fetchProcessAndInfo() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      if (this.rightActiveName === 'process') {
        this.getProcessInfo()
      } else if (this.rightActiveName === 'securityInfo') {
        this.getSecurityInfo()
      } else if (this.rightActiveName === 'statistics') {
        console.warn('暂时没有统计信息')
      }
    },
    // 获取安检流程信息
    async getProcessInfo() {
      if (this.processList.length && this.processList[0].scNo === this.currentTarget.scNo) {
        return
      }
      const payload = {
        securityCheckNunber: this.currentTarget.scNo
      }
      const { data: res } = await securityCheckApi.queryProcess(payload)
      if (res.isSuccess) {
        this.processList = res?.data ?? []
      }
    },
    // 新增里面 搜索用户列表
    handleUserSearch(params) {
      this.getUserList(params)
    },
    async getUserList(params) {
      const { data: res } = await Api.list(params)
      if (res.isSuccess) {
        this.userList = res.data ?? []
      }
    },
    // 搜索查询
    handleSearch(status) {
      if (typeof status === 'number') {
        this.queryParams.model.dataStatus = status
      } else {
        delete this.queryParams.model.dataStatus
      }
      this.getSCList(this.queryParams)
    },
    // 获取安检列表信息
    async getSCList(payload) {
      const { data: res } = await securityCheckApi.page(payload)
      if (res.isSuccess) {
        const { data } = res
        this.tableDataList = {
          list: data?.records ?? [],
          size: data?.size ?? 5,
          total: data?.total ?? 0,
          current: data?.current ?? 1
        }
      }
    },
    // 翻页
    handleChange({ size = 5, current = 1 } = {}) {
      this.queryParams.size = size
      this.queryParams.current = current
      this.getSCList(this.queryParams)
    },
    // tabs页签切换
    handleTabChange() {
      this.queryParams.current = 1
      this.fetchOrderOrWarnList()
    },
    // 获取安检信息
    async getSecurityInfo() {
      if (this.securityInfo?.scNo === this.currentTarget.scNo) {
        return
      }
      const payload = {
          scNo: this.currentTarget.scNo
        }
      const { data: res } = await securityCheckApi.getCheckResult(payload)
      if (res.isSuccess) {
        this.securityInfo = res?.data ?? {}
      }
    },
    // 获取工单列表
    async getOrderList({ size = 5, current = 1, id } = {}) {
      if (this.orderList?.list?.length && this.orderList.current === current && this.orderList.list[0].scNo === this.currentTarget.scNo) {
        return
      }
      const payload = {
        model: {
          businessOrderNumber: id ?? this.currentTarget.scNo,
        },
        size,
        current
      }
      const { data: res } = await securityCheckApi.orderPage(payload)
      if (res.isSuccess) {
        const { data } = res
        this.orderList = {
          list: data?.records ?? [],
          size: data?.size ?? 5,
          total: data?.total ?? 0,
          current: data?.current ?? 1
        }
      }
    },
    // 获取隐患列表
    async getWarnList({ size = 5, current = 1, scNo } = {}) {
      if (this.warnList?.list?.length && current === this.warnList.current && this.warnList.list[0].scNo === scNo) {
        return
      }
      const payload = {
        model: {
          scNo: scNo ?? this.currentTarget.scNo,
        },
        size,
        current
      }
      const { data: res } = await securityCheckApi.queryCheckItems(payload)
      if (res.isSuccess) {
        const { data } = res
        this.warnList = {
          list: data?.records ?? [],
          size: data?.size ?? 5,
          total: data?.total ?? 0,
          current: data?.current ?? 1
        }
      }
    },
    // 工单翻页
    handleOrderChange(params) {
      this.getOrderList(params)
    },
    // 隐患列表翻页
    handleWarnChange(params) {
      this.getWarnList(params)
    },
    // 获取工人列表
    async fetchWorkerList() {
      const payload = initQueryParams({
        'current': 1,
        'dataScope': 1,
        'model': {
        
        },
        'size': 10
      })
      const { data: res } = await securityCheckApi.queryUser(payload)
      if (res.isSuccess) {
        const list = res.data.records
        if (list.length) {
          this.workerList = list.map(({ id, name }) => ({
            receiveUserName: name,
            receiveUserId: id
          }))
        }
      }
    },
    // 安检受理 or 编辑
    handleSecurityCheck(val, row) {
      this.editVisible = true
      this.editType = val
      // const selectedRow = this.userList.records.filter(item => item.customerCode === row.customerCode) 
      this.$nextTick(async () => {
        const edit = this.$refs.edit
        if (val === SECURITY_CHECK) {
          edit.btnText = '受理'
        } else {
          edit.btnText = '保存'
          // this.$refs.edit.toggleSelection(selectedRow)
          const record = {
            ...row,
            street: {
              streetId: row.streetId,
              streetName: row.streetName
            },
            community: {
              communityId: row.communityId,
              communityName: row.communityName
            },
            addressRemark: row.addressRemark,
          }
          this.$refs.edit.form = deepClone(record)
        }
      })
    },
    // 安检计划 - 新增/编辑 回调
    handleSCEdit(form) {
      this.saveSC(form)
    },
    // 安检记录 - 新增/编辑
    async saveSC(payload) {
      const { data: res } = await securityCheckApi.save(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: this.editType === SECURITY_CHECK ? '安检提交成功' : '安检修改成功' ,
          onClose: () => {
            this.editVisible = false
            this.$refs.edit.reset()
            this.$refs.edit.loading = false
            this.queryParams.current = 1
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 点击提审按钮
    async handleApproval() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      const payload = {
        id: this.currentTarget.id,
        companyCode: this.currentTarget.companyCode,
        scNo: this.currentTarget.scNo
      }
      const { data: res } = await securityCheckApi.approval(payload)
      if (res.data) {
        this.$message({
          type: 'success',
          message: '提审成功',
          onClose: () => {
            // 刷新列表应从首页开始
            this.queryParams.current = 1
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 点击审核按钮
    async handleAudit() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      const payload = {
        id: this.currentTarget.id,
        companyCode: this.currentTarget.companyCode,
        scNo: this.currentTarget.scNo
      }
      const { data: res } = await securityCheckApi.approvaled(payload)
      if (res.data) {
        this.$message({
          type: 'success',
          message: '审核成功',
          onClose: () => {
            // 刷新列表应从首页开始
            this.queryParams.current = 1
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 点击终止按钮
    async handleEnd() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      const payload = {
        id: this.currentTarget.id,
        companyCode: this.currentTarget.companyCode,
        stopDesc: this.stopDesc
      }
      const { data: res } = await securityCheckApi.end(payload)
      if (res.data) {
        this.$message({
          type: 'success',
          message: '终止成功',
          onClose: () => {
            // 刷新列表应从首页开始
            this.queryParams.current = 1
            this.stopVisible = false
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 派单
    handleDispatch(status) {
      this.sendVisible = true
      // 赋值
      this.$nextTick(function () {
        this.$refs.dispatchOrder.overForm = {
          businessOrderNumber: this.currentTarget.installNumber,
          customerCode: this.currentTarget?.customerCode ?? '',
          customerName: this.currentTarget?.customerName ?? '',
          customerMobile: this.currentTarget?.telphone ?? '',
          addressDetail: `${this.currentTarget?.streetName ?? ''}${this.currentTarget?.communityName ?? ''}${this.currentTarget?.addressRemark ?? ''}`,
        }
      })
      this.fetchWorkerList()
    },
    // 转单
    async handleTransferOrder() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      const payload = {
        orderRecord: {
          ...this.currentTarget
        },
        securityCheckRecord: {

        }
      }
      const { data: res } = await securityCheckApi.transferOrder(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '转单成功'
        })
      }
    },
    // 结单
    async handleOver() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      const payload = {
        id: this.currentTarget.id,
        companyCode: this.currentTarget.companyCode,
        scNo: this.currentTarget.scNo
      }
      const { data: res } = await securityCheckApi.completeOrder(payload)
      if (res.data) {
        this.$message({
          type: 'success',
          message: '结单成功',
          onClose: () => {
            // 刷新列表应从首页开始
            this.queryParams.current = 1
            this.stopVisible = false
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 派遣工单
    async handleDispatchOrder(params) {
      const payload = {
        orderRecord: {
          ...params,
        },
        securityCheckRecord: {
          scNo: this.currentTarget.scNo,
          companyCode: this.currentTarget.companyCode,
          id: this.currentTarget.id
        }
      }
      delete payload.orderRecord.worker
      const { data: res } = await securityCheckApi.leaflet(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '派单成功',
          onClose: () => {
            this.sendVisible = false
            this.queryParams.current = 1
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 点击终止按钮
    handleStop() {
      this.stopLoading = true
      this.handleEnd()
    },
    // 点击录入安检结果按钮
    handleInputData(record) {
      if (!record.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      this.inputDataVisible = true
      this.currentTarget = {
        ...record
      }
      const { companyCode, customerCode, customerName, scNo, securityCheckTime, securityCheckUserName, securityCheckResult, useGasTypeId, securityCheckUserId, gasCode, gasMeterFactoryId } = record
      this.$nextTick(function() {
        this.$refs.resultDetail.form = {
          gasMeterFactoryId,
          useGasTypeId,
          gasCode,
          companyCode,
          customerCode,
          customerName,
          scNo,
          securityCheckTime,
          securityCheckUserId,
          securityCheckUserName,
          securityCheckResult
        }
      })
      this.getScItemsResult()
    },
    // 安检结果回显接口
    async getScItemsResult() {
      const { data: res } = await securityCheckApi.getScItemsResult(this.currentTarget.scNo)
      if (res.data) {
        const firstForm = res.data?.securityCheckResult ?? {}
        const items = res.data?.scItemsOperVo ?? []
        let selected = [], filterArr = []
        if (items.length) {
          items.forEach((item) => {
            let arr = item.scItemList.filter(it => it.selected)
             selected.push(...arr.map(item => item.scTermItemsId))
             filterArr.push(...arr)
          })
          this.$nextTick(() => {
            this.$refs.resultDetail.allCheckInfos = [...items]
            this.$refs.resultDetail.checkList = [...selected]
            this.$refs.resultDetail.filterCheckList = [...filterArr]
          })
        }
        this.$nextTick(() => {
          const form = this.$refs.resultDetail.form
          this.$refs.resultDetail.form = {
            ...form,
            ...firstForm,
          }
        })
      }
    },
    // 点击录入安检隐患按钮
    handleWarnEdit(params) {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择安检计划'
        })
        return
      }
      this.inputWarnVisible = true
      const { scNo, scTermItemsName, remark, hiddenDanger, handleStatus, id, companyCode, dangerLeve } = params
      this.$nextTick(function() {
        this.$refs.warnDetail.form = {
          id,
          companyCode,
          scNo,
          scTermItemsName,
          remark,
          hiddenDanger,
          dangerLeve
          // handleStatus
        }
      })
      this.getWarnLevel()
    },
    // 工单列表行点击
    async handleOrderRowClick(row) {
      this.currentOrder = {
        ...row
      }
      this.orderFilesVisible = true
      const { data: res } = await securityCheckApi.fetchOrderFiles(row.id)
      if (res.isSuccess) {
        this.orderFilesInfo = res?.data ?? []
      }
    },
    // 上传安检结果huidiao
    async handleScDataSubmit(params) {
      const { data: res } = await securityCheckApi.saveCheckResult(params)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '上传安检结果成功',
          onClose: () => {
            this.inputDataVisible = false
            this.queryParams.current = 1
            this.getSCList(this.queryParams)
          }
        })
      }
    },
    // 上传安检隐患
    async handleScWarnSubmit(params) {
      const { data: res } = await securityCheckApi.updateCheckWarn(params)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '上传安检隐患整改信息成功',
          onClose: () => {
            this.inputWarnVisible = false
            this.getWarnList({ scNo: params.scNo })
          }
        })
      }
    },
    // 获取隐患级别
    async getWarnLevel() {
      const WARN = '1325623696387211264'
      const payload = Object.assign({}, {
        sort: 'sortValue',
        order: 'ascending',
        model: {
          dictionaryId: WARN
      }})
      const { data: res } = await dictionaryItemApi.page(payload)
      if (res.isSuccess) {
        this.warnLevel = res.data?.records ?? []
      }
    }
  }
}

</script>
<style lang="scss" scoped>
  /* 收费列表 */
  .butGroup {
   .el-button + .el-button {
     margin-left: 10px;
   }
  }
  .charge-section {
    background: #F7F7F7;
    .jh-text {
      .el-form-item {
        width: calc(100% / 3);
      }
    }
  }
</style>
