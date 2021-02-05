<!--
 * @Description: 报装
 * @Author: lingw
 * @Date: 2020-11-04 10:44:19
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-28 09:09:37
-->

<template>
  <div class="qc-main">
    <!--search-->
    <search-box>
      <!-- 客户姓名 -->
      <el-input v-model="queryParams.model.customerName" placeholder="客户名称" />
      <!-- 联系电话 -->
      <el-input v-model="queryParams.model.telphone" placeholder="联系电话" />
      <!-- 安装地址 -->
      <el-input v-model="queryParams.model.addressRemark" placeholder="安装地址" />
      <!-- 查询 -->
      <el-button type="primary" @click="() => handleSearch()">查询</el-button>
    </search-box>
    <!-- 报装 -->
    <el-row :gutter="10">
      <!--center-->
      <el-col :lg="{span:17}" :xs="24" :sm="24" style="margin-top: 10px">
        <div style="height: 760px;">
          <!-- 报装列表 -->
          <el-card shadow="never" style="height: 420px">
            <div slot="header">
              <span class="card-title">报装列表</span>
                <!-- 操作按钮 -->
                <div class="butGroup card-tool-bar">
                  <el-button v-if="marterial_visible" type="primary" @click="showUpload = true">报装材料</el-button>
                  <!-- <el-button type="primary">提审</el-button> -->
                  <el-button v-if="survey_visible" type="primary" @click="() => handleStatusChange($constant('WAIT_SURVEY'))">勘查</el-button>
                  <el-button v-if="audit_visible" type="primary" @click="() => handleStatusChange($constant('HAVE_RESOLVED'))">审核</el-button>
                  <el-button v-if="design_visible" type="primary" @click="() => handleStatusChange($constant('WAIT_DESIGN'))">设计</el-button>
                  <el-button v-if="check_visible" type="primary" @click="() => handleStatusChange($constant('WAIT_CHECK'))">验收</el-button>
                  <el-button v-if="charge_visible" type="primary" @click="chargeVisible = true">收费</el-button>
                  <!-- <el-button type="primary" @click="refuseVisible = true">驳回</el-button> -->
                  <el-button v-if="build_visible" type="primary" @click="() => handleStatusChange($constant('WAIT_BUILD'))">施工</el-button>
                  <!-- <el-button v-if="input_charge_visible" type="primary">收费资料录入</el-button> -->
                  <!-- 踏勘工单 -->
                  <el-button v-if="send_survey_visible" type="primary" @click="() => handleDispatch($constant('WAIT_SURVEY'))">派工</el-button>
                  <!-- 施工工单 -->
                  <el-button v-if="send_visible" type="primary" @click="() => handleDispatch($constant('WAIT_BUILD'))">派工</el-button>
                  <!-- 验收工单 -->
                  <el-button v-if="send_check_visible" type="primary" @click="() => handleDispatch($constant('WAIT_CHECK'))">派工</el-button>
                  <el-button v-if="resolve_visible" type="primary" @click="() => handleStatusChange($constant('HAVE_SETTLED'))">结单</el-button>
                  <el-button v-if="end_visible" type="danger" @click="stopVisible = true">终止</el-button>
                  <!-- 导出 -->
                  <el-button v-if="tableDataList.list.length" type="primary">导出</el-button>
                </div>
            </div>
            <div class="butGroup card-tool-bar" style="margin: -10px 0 10px 0">
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_RESOLVE'))">待受理</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_SURVEY'))">待踏勘</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_DESIGN'))">待设计</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_CHARGE'))">待收费</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_BUILD'))">待施工</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_CHECK'))">待验收</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('WAIT_SETTLE'))">待结单</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('HAVE_SETTLED'))">已结单</el-button>
              <el-button type="primary" plain @click="() => handleSearch($constant('HAVE_END'))">终止</el-button>
              <el-button type="primary" plain @click="handleSearch">全部</el-button>
            </div>
            <!-- 报装列表 -->
            <report-list :table-data-list="tableDataList" @pagination="handleChange" @row-click="handleRowClick" @edit="(val, row) => handleReport(val, row)" @accept="handleAccept" @design="handleDesign" />
          </el-card>

          <el-card shadow="never">
            <el-tabs v-model="activeTabName" @tab-click="fetchOrderOrInstallList">
              <el-tab-pane label="工单列表" name="order">
                <order-list :order-list="orderList" @row-click="handleOrderRowClick" @pagination="handleOrderChange" />
              </el-tab-pane>
              <el-tab-pane label="安装列表" name="install">
                <div style="width: 100%; display: flex; justify-content: flex-end;">
                  <el-button :loading="btnLoading" type="primary" @click="handleExport">模板下载</el-button>
                  <el-button v-if="currentTarget && currentTarget.dataStatus === input_install_visible" type="primary" @click="handleInstall">录入安装资料</el-button>
                  <el-button type="primary" @click="batchInstallFileVisible = true">批量录入</el-button>
                </div>
                <install-list :install-list="installList" style="margin-top: 8px;" />
              </el-tab-pane>
            </el-tabs>
          </el-card>
        </div>
      </el-col>

      <!--right-->
      <el-col :lg="7" :xs="24" :sm="24" style="margin-top: 10px">
        <!-- 更多信息 -->
        <div style="height: 760px">
          <el-tabs v-model="activeName" class="moreInfo" tab-position="left" style="height: 760px;" @tab-click="fetchProcessAndInfo">
            <el-tab-pane label="报装统计" name="counter">
              <!-- 报装统计 -->
              <el-card shadow="never" class="counter">
                <div slot="header">
                  <span class="card-title">报装统计</span>
                </div>
                <counter-statistics />
              </el-card>
            </el-tab-pane>
            <!-- 流程信息 -->
            <el-tab-pane label="流程信息" name="process">
              <process-info :process-list="processList" />
            </el-tab-pane>
            <el-tab-pane label="费用明细" name="charge">
              <div class="charge-section">
                <el-form label-position="top" :model="chargeSectionOne" class="jh-text">
                  <el-form-item label="已收金额">
                    <span>{{ chargeSectionOne.receivedMoney }}</span>
                  </el-form-item>
                  <el-form-item label="待收金额">
                    <span>{{ chargeSectionOne.waitMoney }}</span>
                  </el-form-item>
                  <el-form-item label="合计金额">
                    <span>{{ chargeSectionOne.amountMoney }}</span>
                  </el-form-item>
                </el-form>
              </div>
              <el-table :data="chargeData">
                <el-table-column label="收费项" prop="chargeItem">
                </el-table-column>
                <el-table-column label="金额" prop="amount">
                </el-table-column>
                <el-table-column label="状态" prop="status">
                </el-table-column>
              </el-table>
            </el-tab-pane>
            <!-- 设计方案 -->
            <el-tab-pane label="设计方案" name="design">
              <design-scheme-show ref="designSchemeShow" :design="design" />
            </el-tab-pane>
            <!-- 验收资料 -->
            <el-tab-pane label="验收资料" name="accept">
              <accept-detail-show :accept="accept" />
            </el-tab-pane>
          </el-tabs>
        </div>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div class="footNav-item" @click="() => handleReport(1)">
        <div class="icon">
          <svg-icon icon-class="installMeter" />
        </div>
        <p>报装受理</p>
      </div>

      <div class="footNav-item" @click="handleBatch">
        <div class="icon">
          <svg-icon icon-class="openAccount" />
        </div>
        <p>批量报装</p>
      </div>
    </qc-foot-menu>
    <!-- 弹框 start -->
    <!-- 报装资料 -->
    <qc-dialog
      :width="800"
      title="报装资料"
      :visible="showUpload"
      data-key="showUpload"
      @close="showUpload = false"
    >
      <qc-upload />
    </qc-dialog>
    <!-- 报装 - 编辑 -->
    <qc-dialog
      :visible="editVisible"
      :width="500"
      :title="editTitle"
      data-key="editVisible"
      @close="editVisible = false"
    >
      <edit ref="edit" :report-types="reportTypes" :card-types="cardTypes" :street-list="streetList" :community-list="communityList" :detail-list="detailList" @save="handleSave" @fetchCommunity="fetchCommunity" />
    </qc-dialog>
    <!-- 报装 - 批量报装 -->
    <qc-dialog
      :visible="batchVisible"
      :width="800"
      title="批量报装"
      data-key="batchVisible"
      @close="batchVisible = false"
    >
      <batch-install :report-types="reportTypes" :street-list="streetList" :community-list="communityList" @save="handleSave" @fetchCommunity="fetchCommunity" />
    </qc-dialog>
    <!-- 报装 - 派单 -->
    <qc-dialog
      :visible="sendVisible"
      :width="400"
      title="派工"
      data-key="sendVisible"
      @close="sendVisible = false"
    >
      <dispatch-order ref="dispatchOrder" :order-type-list="orderTypeList" :worker-list="workerList" @diapatch="handleDispatchOrder" />
    </qc-dialog>
    <!-- 报装 - 设计方案 -->
    <qc-dialog
      :visible="design_scheme_dialog_visible"
      :width="400"
      title="设计方案"
      data-key="design_scheme_dialog_visible"
      @close="design_scheme_dialog_visible = false"
    >
      <design-scheme ref="designScheme" :worker-list="workerList" @submit="handleDesignSubmit" />
    </qc-dialog>
    <!-- 报装 - 录入安装资料 -->
    <qc-dialog
      :visible="install_detail_visible"
      :width="400"
      title="录入安装资料"
      data-key="install_detail_visible"
      @close="install_detail_visible = false"
    >
        <install-detail ref="installDetail" :street-list="streetList" :community-list="communityList"
        :use-gas-type="useGasType"
        :current-record="currentTarget"
        @fetchCommunity="fetchCommunity" @submit="handleInstallSubmit"
      />
    </qc-dialog>
    <!-- 报装 - 录入验收资料 -->
    <qc-dialog
      :visible="accept_detail_visible"
      :width="400"
      title="录入验收资料"
      data-key="accept_detail_visible"
      @close="accept_detail_visible = false"
    >
      <accept-detail ref="acceptDetail" :accept="accept" @submit="handleAcceptSubmit" />
    </qc-dialog>
     <!-- 报装 - 工单材料详情 -->
    <qc-dialog
      :visible="orderFilesVisible"
      :width="520"
      title="工单材料详情"
      data-key="orderFilesVisible"
      @close="orderFilesVisible = false"
    >
      <order-files-info ref="orderFilesInfo" :order-files-info="orderFilesInfo" :order-info="currentOrder" />
    </qc-dialog>
    <!-- 报装 - 终止 -->
    <qc-dialog
      :visible="stopVisible"
      :width="400"
      title="终止"
      data-key="stopVisible"
      @close="stopVisible = false"
    >
      <el-form class="jh-text" label-position="top">
        <el-form-item label="终止原因">
          <el-input v-model="stopReason"></el-input>
        </el-form-item>
      </el-form>
      <el-button :loading="stopLoading" type="primary" @click="handleStop">
        终止
      </el-button>
    </qc-dialog>
    <!-- 安装列表批量导入文件 -->
    <el-dialog
      width="1000"
      title="导入安装文件"
      :visible="batchInstallFileVisible"
      data-key="batchInstallFileVisible"
      :close-on-click-modal="false"
      @close="batchInstallFileVisible = false"
    >
      <upload-file @success="handleImportInstallFileSuccess" />
    </el-dialog>
  </div>
</template>

<script>
import {mapGetters, mapMutations} from 'vuex'
import { deepClone, param } from '@/utils'
import Edit from './components/Edit'
import ReportList from './components/ReprotList'
import OrderList from './components/OrderList'
import InstallList from './components/InstallList'
import ProcessInfo from './components/ProcessInfo'
import BatchInstall from './components/Batch'
import AcceptDetail from './components/AcceptDetail'
import AcceptDetailShow from './components/AcceptDetailShow'
import InstallDetail from './components/InstallDetail'
import CounterStatistics from './components/CounterStatistics' // 统计模块
import DispatchOrder from './components/DispatchOrder'
import DesignScheme from './components/DesignScheme'
import UploadFile from './components/UploadFile'
import DesignSchemeShow from './components/DesignSchemeShow'
import OrderFilesInfo from './components/OrderFilesInfo'
import dictionaryItemApi from '@/api/DictionaryItem'
import { getStreetList, getCommunityList } from '@/api/operation/userLimit'
import { default as Api } from '@/api/temporary/index.js'
import { getDetailsAddressList } from '@/api/operation/community'
import meterBookApi from '@/api/readMeter/readMeterBook'
import reportInstallApi from '@/api/reportInstall'
import { fileStreamDownload } from '@/api/File'
import { dataStatusField } from '@/enums/common'
import { initQueryParams } from '@/utils/commons'
import { constants as STATUS } from '@/plugins/reportInstall'
const INSTALL = 1;
const EDIT = 2;

export default {
  name: 'ReportInstall',
  components: {
    Edit,
    BatchInstall,
    CounterStatistics,
    ReportList,
    OrderList,
    InstallList,
    ProcessInfo,
    DispatchOrder,
    DesignScheme,
    AcceptDetail,
    InstallDetail,
    OrderFilesInfo,
    DesignSchemeShow,
    AcceptDetailShow,
    UploadFile
  },
 
  data() {
    return {
      btnLoading: false,
      showUpload: false,
      batchVisible: false,
      editVisible: false,
      sendVisible: false,
      stopVisible: false,
      chargeVisible: false,
      accept_detail_visible: false,
      install_detail_visible: false,
      design_scheme_dialog_visible: false,
      stopLoading: false, // 终止 按钮 loading
      orderFilesVisible: false,
      batchInstallFileVisible: false, // 批量上传安装文件
      input_install_visible: STATUS.WAIT_BUILD,
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
      installList: [],
      // 工单类型列表
      orderTypeList: [],
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
      editType: 1, // 默认是报装 1： 报装 2：修改
      reportTypes: [], // 包装类型
      cardTypes: [], // 证件类型
      streetList: [], // 街道列表
      communityList: [], // 小区列表
      detailList: [], // 详细地址列表
      // processList: [], // 流程列表
      queryParams: initQueryParams({
        model: {
          customerName: '', // 报装人 - 客户名称
          telphone: '', // 联系电话
          addressRemark: '', // 报装地址 - 详细地址备注
          dataStatus: '',  // 报装状态
        },
        size: 5,
        page: 1
      }),
      // 报装工单参数
      orderQueryParams: initQueryParams({
        model: {
          businessOrderNumber: '', // 报装编号
        },
        size: 5,
        page: 1
      }),
      currentTarget: {},
      stopReason: '', // 终止原因
      orderFilesInfo: [], // 工单材料列表
      currentOrder: {}, // 工单材料详情
      useGasType: [], // 燃气类型
      activeName: 'counter', // 右侧选项卡
      activeTabName: 'order' // 中间下部选项卡
    }
  },
  computed: {
    editTitle() {
      return this.editType === INSTALL ? '报装受理' : '编辑'
    },
    marterial_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_RESOLVE
    },
    charge_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_DESIGN
    },
    survey_visible() {
      return this.currentTarget.dataStatus === STATUS.HAVE_RESOLVED
    },
    design_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_SURVEY
    },
    input_charge_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_DESIGN
    },
    check_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_BUILD
    },
    audit_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_RESOLVE
    },
    resolve_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_CHECK
    },
    send_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_BUILD
    },
    send_check_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_CHECK
    },
    send_survey_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_SURVEY
    },
    build_visible() {
      return this.currentTarget.dataStatus === STATUS.WAIT_DESIGN
    },
    end_visible() {
      const currentStatus = this.currentTarget.dataStatus
      if (currentStatus === STATUS.WAIT_RESOLVE || currentStatus === STATUS.HAVE_RESOLVED || currentStatus === STATUS.WAIT_SURVEY) {
        return true
      }
      return false
    },
    ...mapGetters([
      'counter',
      'processList',
      'design',
      'accept',
      'result'
    ])
  },
  watch: {
    editVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.edit.reset()
        this.$refs.edit.loading = false
      }
    },
    sendVisible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.dispatchOrder.reset()
        this.$refs.dispatchOrder.loading = false
      }
    },
    design_scheme_dialog_visible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.designScheme.reset()
        this.$refs.designScheme.loading = false
        this.$refs.designScheme.imgFileList = []
      }
    },
    install_detail_visible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.installDetail.reset()
        this.$refs.installDetail.loading = false
      }
    },
    accept_detail_visible(newVal, oldVal) {
      if (!newVal) {
        this.$refs.acceptDetail.reset()
        this.$refs.acceptDetail.loading = false
      }
    }
  },
  created() {
    this.getReportList(this.queryParams)
    this.getUseGasType()
  },
  methods: {
    // 获取用气类型
    getUseGasType() {
      Api.getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then(res => {
        const { data } = res.data
        if (data) {
          const list = data?.records ?? []
          if (list.length) {
            this.useGasType = list.map(({ id, useGasTypeName }) => ({
              useGasTypeId: id,
              useGasTypeName
            }))
          }
        }
      })
    },
    // 选中某行
    handleRowClick(row) {
      this.currentTarget = {
        ...row
      }
      this.fetchOtherInfoWhileClick()
    },
    // 行点击的时候请求其他数据
    fetchOtherInfoWhileClick() {
      this.fetchOrderOrInstallList()
      this.fetchProcessAndInfo()
    },
    // 获取工单或者安装列表
    fetchOrderOrInstallList() {
      if (!this.currentTarget.installNumber) {
        this.$message({
          type: 'warning',
          message: '请先选择一项报装记录'
        })
        return
      }
      if (this.activeTabName === 'order') {
        this.getOrderList({
          id: this.currentTarget.installNumber
        })
      } else if (this.activeTabName === 'install') {
        this.getInstallFilesList(this.currentTarget.installNumber)
      }
    },
    // 右侧tab信息切换 请求数据
    fetchProcessAndInfo() {
      if (!this.currentTarget.installNumber) {
        this.$message({
          type: 'warning',
          message: '请先选择一项报装记录'
        })
        return
      }
      if (this.activeName === 'process') {
        this.getProcessInfo()
      } else if (this.activeName === 'counter') {
        console.warn('暂时没有统计信息')
      } else if (this.activeName === 'design') {
        this.getDesign()
      } else if (this.activeName === 'accept') {
        this.fetchAcceptDetailBefore(this.currentTarget)
      }
    },
    // 获取报装流程信息
    async getProcessInfo() {
      if (this.processList.length && this.processList[0].installNumber === this.currentTarget.installNumber) {
        return
      }
      const { data: res } = await reportInstallApi.queryProcess(this.currentTarget.installNumber)
      if (res.isSuccess) {
        this.SET_PROCESS(res?.data ?? [])
      }
    },
    async getDesign() {
      const { data: res } = await reportInstallApi.queryDesign(this.currentTarget.installNumber)
        if (res.data) {
          const { data: { budget, designUserName, workload, remark, designUrl } } = res
          let fileList = []
          const images = designUrl.split(',')
          if (images.length) {
            fileList = images.map((item, index) => ({
              url: item,
              id: `${Math.random()}-${index}`
            }))
          }
          const payload = {
            designUserName,
            budget,
            workload,
            remark,
            imageList: fileList
          }
          this.SET_DESIGN(payload)
        } else {
          this.SET_DESIGN({})
        }
    },
    // 搜索查询
    handleSearch(status) {
      if (typeof status === 'number') {
        this.queryParams.model.dataStatus = status
      } else {
        delete this.queryParams.model.dataStatus
      }
      this.getReportList(this.queryParams)
    },
    // 批量报装
    handleBatch() {
      this.batchVisible = true
      this.fetch()
    },
    // 获取报装列表信息
    async getReportList(payload) {
      const { data: res } = await reportInstallApi.page(payload)
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
      this.getReportList(this.queryParams)
    },
    // 获取工单列表
    async getOrderList({ size = 5, current = 1, id } = {}) {
      if (this.orderList?.list?.length && this.orderList.current === current && this.orderList.list[0].scNo === this.currentTarget.scNo) {
        return
      }
      const payload = {
        model: {
          businessOrderNumber: id ?? this.orderQueryParams.model.businessOrderNumber,
        },
        size,
        current
      }
      const { data: res } = await reportInstallApi.orderPage(payload)
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
    // 获取安装列表
    async getInstallFilesList(id) {
      if (this.installList.length && this.installList[0].installNumber === this.currentTarget.installNumber) {
        return
      }
      const { data: res } = await reportInstallApi.fetchInstallFilesList(id)
      if (res.data) {
        this.installList = res?.data ?? []
      }
    },
    // 工单翻页
    handleOrderChange(params) {
      this.getOrderList(params)
    },
    // 获取报装类型 证件类型等列表
    async fetch() {
      const initPayload = initQueryParams({
        sort: 'sortValue',
        order: 'ascending'
      })
      const payload = Object.assign({}, initPayload, {
        model: {
          dictionaryId: '7'
        },
      })
      const cardPayload = Object.assign({}, initPayload, {
        model: {
          dictionaryId: '5'
        },
      })
      const [reportTypes, cardTypes, streetList] = await Promise.allSettled([
        dictionaryItemApi.page(payload),
        dictionaryItemApi.page(cardPayload),
        getStreetList(initQueryParams({ size: 10000, dataStatus: dataStatusField.VALID }))
      ]);
      if (reportTypes.status === 'fulfilled') {
        const { value: { data: res } } = reportTypes
        const records = res?.data?.records ?? [];
        if (records.length) {
          this.reportTypes = records.map(({ code, name, id }) => ({
            label: name,
            value: code,
            id
          }))
        }
      }
      if (cardTypes.status === 'fulfilled') {
        const { value: { data: res } } = cardTypes
        const records = res?.data?.records ?? [];
        if (records.length) {
          this.cardTypes = records.map(({ code, name, id }) => ({
            label: name,
            value: code,
            id
          }))
        }
      }
      if (streetList.status === 'fulfilled') {
        const { value: { data: res } } = streetList
        const records = res?.data?.records ?? [];
        if (records.length) {
          this.streetList = records.map(({ streetName, id }) => ({
            streetName,
            streetId: id
          }))
        }
      }
    },
    // 踏勘工单
    handleDispatch(status) {
      this.sendVisible = true
      let type = ''
      switch(status) {
        case STATUS.WAIT_SURVEY:
          type = 'SURVEY'
          break
        case STATUS.WAIT_BUILD:
          type = 'INSTALL'
          break
        case STATUS.WAIT_CHECK:
          type = 'ACCEPT'
          break
        default:
          type = ''
          break
      }
      // 赋值
      this.$nextTick(function () {
        this.$refs.dispatchOrder.overForm = {
          businessOrderNumber: this.currentTarget.installNumber,
          customerCode: this.currentTarget?.customerCode ?? '',
          customerName: this.currentTarget?.customerName ?? '',
          customerMobile: this.currentTarget?.telphone ?? '',
          addressDetail: `${this.currentTarget?.streetName ?? ''}${this.currentTarget?.communityName ?? ''}${this.currentTarget?.addressRemark ?? ''}`,
          workOrderType: type
        }
      })
      this.fetchDispatchOrderTypes()
      this.fetchWorkerList()
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
      const { data: res } = await reportInstallApi.queryUser(payload)
      if (res.isSuccess) {
        const list = res.data.records
        if (list.length) {
          this.workerList = list.map(({ id, name }) => ({
            designUserName: name,
            designUser: id
          }))
        }
      }
    },
    // 获取工单类型列表
    async fetchDispatchOrderTypes() {
      const { data: res } = await dictionaryItemApi.getType('INSTALL_ORDER_TYPE')
      if (res.isSuccess) {
        const { data } = res
        this.orderTypeList = data ?? []
      }
    },
    // 报装受理 or 编辑
    handleReport(val, row) {
      this.editVisible = true
      this.editType = val
      this.fetch()
      this.$nextTick(async () => {
        const edit = this.$refs.edit
        if (val === INSTALL) {
          edit.btnText = '受理'
        } else {
          edit.btnText = '保存'
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
          await this.fetchCommunity(row.streetId)
          this.$refs.edit.form = deepClone(record)
        }
      })
    },
    handleSave(form) {
      this.saveReport(form)
    },
    // 报装 - 保存/更新
    async saveReport(payload) {
      const { data: res } = await reportInstallApi.save(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: this.editType === INSTALL ? '报装提交成功' : '报装修改成功' ,
          onClose: () => {
            this.editVisible = false
            this.$refs.edit.reset()
            this.$refs.edit.loading = false
            this.queryParams.current = 1
            this.getReportList(this.queryParams)
          }
        })
      }
    },
    // 获取对应街道小区列表
    async fetchCommunity(id) {
      const payload = initQueryParams({ size: 10000, dataStatus: dataStatusField.VALID, model: {
        streetId: id
      } })
      const { data: res } = await getCommunityList(payload)
      if (res.isSuccess) {
        const records = res?.data?.records ?? [];
        if (records.length) {
          this.communityList = records.map(({ communityName, id }) => ({
            communityName,
            communityId: id
          }))
        }
      }
    },
    // 更改报装的状态
    async handleStatusChange(status, stopReason = '', callback) {
      const payload = {
        installRecordId: this.currentTarget.id,
        installStatus: status,
        stopReason
      }
      const { data: res } = await reportInstallApi.updateStatus(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '更改状态成功',
          onClose: () => {
            // 刷新列表应从首页开始
            this.queryParams.current = 1
            this.getReportList(this.queryParams)
            callback && callback()
          }
        })
      }
    },
    // 派遣工单
    async handleDispatchOrder(params) {
      const payload = {
        ...params
      }
      delete payload.worker
      const { data: res } = await reportInstallApi.orderSend(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '派单成功',
          onClose: () => {
            this.sendVisible = false
          }
        })
      }
    },
    // 点击终止按钮
    handleStop() {
      this.stopLoading = true
      this.handleStatusChange(this.$constant('HAVE_END'), this.stopReason, () => {
        this.stopLoading = false
        this.stopVisible = false
      })
    },
    // 点击收费按钮
    handleCharge() {
      console.warn('handleCharge')
      // this.handleStatusChange(this.$constant('WAIT_BUILD'))
    },
    // 提交上传设计图成功
    async handleDesignSubmit(params) {
      const payload = {
        ...params,
        installNumber: this.currentTarget.installNumber
      }
      const { data: res } = await reportInstallApi.addDesign(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '上传设计图成功',
          onClose: () => {
            this.design_scheme_dialog_visible = false
          }
        })
      }
    },
    // 点击上传验收资料按钮
    handleAccept(record) {
      this.accept_detail_visible = true
      this.fetchAcceptDetailBefore(record)
      this.currentTarget = {
        ...record
      }
    },
    // 点击上传安装资料按钮
    handleInstall() {
      if (!this.currentTarget.id) {
        this.$message({
          type: 'warning',
          message: '请先选择一项报装记录'
        })
        return
      }
      this.install_detail_visible = true
      this.fetchInstallDetailBefore(this.currentTarget)
    },
    // 上传验收资料 在每次点击上传资料按钮前先获取一下是否已经提交过，判断是否为编辑
    async fetchAcceptDetailBefore(record) {
      if (this.accept?.installNumber && this.accept.installNumber === this.currentTarget.installNumber) {
        return
      }
      const { data: res } = await reportInstallApi.queryAccept(record.installNumber)
      if (res.data) {
        const payload = {
          ...res.data ?? {},
          acceptSuggest: res?.data?.acceptSuggest === true ? '1' : res?.data?.acceptSuggest === false ? '0' : ''
        }
        const imageUrl = res?.data?.acceptUrl ?? ''
        const images = imageUrl.split(',')
        let fileList = []
        if (images.length) {
          fileList = images.map((item, index) => ({
            name: `design${index}.png`,
            url: item
          }))
        }
        payload.fileList = fileList
        this.SET_ACCEPT(payload)
        this.$refs.acceptDetail.form = {
          ...payload,
        }
        this.$refs.acceptDetail.fileList = [...fileList]
      }
    },
    // 上传安装资料 在每次点击上传资料按钮前先获取一下是否已经提交过，判断是否为编辑
    async fetchInstallDetailBefore(record) {
      const { data: res } = await reportInstallApi.queryInstallDetail(record.installNumber)
      const { data: streetRes } = await getStreetList(initQueryParams({ size: 10000, dataStatus: dataStatusField.VALID }))
      if (streetRes.isSuccess) {
        const { data: { records = [] } } = streetRes
        if (records.length) {
          this.streetList = records.map(({ streetName, id }) => ({
            streetName,
            streetId: id
          }))
        }
      }
      if (res.data) {
        const { data } = res
        const record = {
            ...data,
            street: {
              streetId: data.streetId,
              streetName: data.streetName
            },
            community: {
              communityId: data.communityId,
              communityName: data.communityName
            },
            addressRemark: data.addressRemark,
          }
          await this.fetchCommunity(data.streetId)
          this.$refs.installDetail.form = deepClone(record)
      }
    },
    // 上传验收资料
    async handleAcceptSubmit(params) {
      const payload = {
        ...params,
        installNumber: this.currentTarget.installNumber
      }
      const { data: res } = await reportInstallApi.saveInstallAccept(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '录入验收资料成功',
          onClose: () => {
            this.accept_detail_visible = false
          }
        })
      }
    },
    // 上传安装资料
    async handleInstallSubmit(params) {
      const payload = {
        ...params,
        installNumber: this.currentTarget.installNumber
      }
      const { data: res } = await reportInstallApi.saveInstallDetail(payload)
      if (res.isSuccess) {
        this.$message({
          type: 'success',
          message: '录入安装资料成功',
          onClose: () => {
            this.install_detail_visible = false
          }
        })
      }
    },
    // 工单点击查询工单材料详情
    async handleOrderRowClick(row) {
      this.orderFilesVisible = true
      this.currentOrder = {
        ...row
      }
      const { data: res } = await reportInstallApi.fetchOrderFiles(row.id)
      if (res.isSuccess) {
        this.orderFilesInfo = res.data
      }
    },
    // 打开报装设计方案
    async handleDesign(record) {
      this.design_scheme_dialog_visible = true
      if (!this.workerList.length) {
        this.fetchWorkerList()
      }
      const { data: res } = await reportInstallApi.queryDesign(record.installNumber)
      if (res.data) {
        const { data: { budget, designUserName, designUser, workload, remark, designUrl, id } } = res
        this.$refs.designScheme.form = {
          designUserInfo: {
            designUserName,
            designUser
          },
          budget,
          workload,
          remark,
          id
        }
        const images = designUrl.split(',')
        if (images.length) {
          this.$refs.designScheme.fileList = images.map((item, index) => ({
            name: `design${index}.png`,
            url: item
          }))
        }
      }
    },
    // 模板导出
    async handleExport() {
      this.btnLoading = true
      await fileStreamDownload(
        `/bizcenter/install/details/exportInstallDetailTemplate`,
        {},
        {
          method: 'POST',
        },
        {
          name: '安装模板.xls',
        }
      )
      this.btnLoading = false
    },
    handleImportInstallFileSuccess() {
      this.batchInstallFileVisible = false
    },
    ...mapMutations({
      SET_COUNTER: 'install/SET_COUNTER',
      SET_PROCESS: 'install/SET_PROCESS',
      SET_DESIGN: 'install/SET_DESIGN',
      SET_ACCEPT: 'install/SET_ACCEPT',
      SET_RESULT: 'install/SET_RESULT'
    })
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
