<!--
 * @Descripttion: 扎帐
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-16 09:07:18
-->

<template>
  <div v-loading="pageLoading" class="settleAccounts-page">
    <el-tabs v-model="currentTabsName" type="border-card" @tab-click="handleSettleAccountTabClick">
      <el-tab-pane label="待扎帐" name="await">
        <!--查询-->
        <template>
          <el-date-picker
            v-model="searchDate"
            style="margin-bottom: 10px"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            value-format="yyyy-MM-dd HH:mm:ss"
            :picker-options="pickerOptions"
            :default-time="['00:00:00', '23:59:59']"
          >
          </el-date-picker>
          <el-button style="margin-left: 12px" type="primary" @click="handleSearch">查询</el-button>
        </template>

        <!--扎帐信息-->
        <el-card shadow="never" class="no-border">
          <div slot="header">
            <span class="card-title">扎帐信息</span>
          </div>
          <business-info :loading="businessInfoLoading" :data="businessInfo">
            <!-- 操作区域 -->
            <template v-slot:operation>
              <el-button type="primary" :disabled="!canSettleAccounts || submitLoading" :loading="submitLoading" @click="handleSaveSettleAccount">扎帐</el-button>
              <el-button v-if="isTest" :disabled="!canSettleAccounts" type="primary" @click="handlePrint()">打印</el-button>
              <el-button type="primary" :disabled="!canSettleAccounts || submitLoading" :loading="exportLoading" @click="handleExport">导出</el-button>
            </template>
          </business-info>
        </el-card>

        <!--业务记录-->
        <el-card shadow="never" class="no-border">
          <div slot="header">
            <span class="card-title">业务记录</span>
          </div>
          <el-tabs v-model="activeName" @tab-click="handleTabClick">
            <el-tab-pane label="收费明细" name="charge">
              <!-- 收费列表 -->
              <charge-list :loading="tableLoading" :data="chargeList.records">
                <!--分页-->
                <template v-slot:pagination>
                  <pagination
                    :page="+chargeList.pages"
                    :limit="+chargeList.size"
                    :total="+chargeList.total"
                    @pagination="getChargeList"
                  />
                </template>
              </charge-list>
            </el-tab-pane>
            <el-tab-pane label="开票明细" name="invoice">
              <!-- 开票列表 -->
              <invoice-list :loading="tableLoading" :data="invoiceList.records">
                <!--分页-->
                <template v-slot:pagination>
                  <pagination
                    :page="+invoiceList.current"
                    :limit="+invoiceList.size"
                    :total="+invoiceList.total"
                    @pagination="getInvoiceList"
                  />
                </template>
              </invoice-list>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="扎帐记录" name="records">
        <!-- 扎帐记录 -->
        <records-list ref="recordsRef"></records-list>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import { isEmpty } from 'lodash'
import Accounts from '@/api/dailyWork/accounts'
import { parseDate2Str, initQueryParams, initListData } from '@/utils/commons'
import print from '@/utils/print/print.js'
import businessInfo from './components/BusinessInfo.vue' // 扎帐信息
import chargeList from './components/ChargeList.vue' // 缴费列表
import invoiceList from './components/InvoiceList.vue' // 发票列表
import recordsList from './components/RecordsList.vue' // 扎帐记录

export default {
  name: 'SettleAccounts',
  components: {
    businessInfo, // 扎帐信息
    chargeList, // 缴费列表
    invoiceList, // 发票列表
    recordsList,
  },
  filters: {
  },
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          const nowDate = new Date()
          nowDate.setDate(nowDate.getDate() + 1)
          // return time.getTime() >= Date.now()
          return time.getTime() >= +new Date(`${parseDate2Str(+nowDate)} 00:00:00`)
        },
      },
      // 切换tab显示 loadig
      tableLoading: false,
      submitLoading: false, // 保存扎帐loading
      exportLoading: false, // 导出扎帐信息loading
      // 查询时间
      searchDate: [
        new Date(new Date(new Date().toLocaleDateString()).getTime()),
        new Date(new Date(new Date().toLocaleDateString()).getTime() + (24 * 3600 * 1000 - 1)),
      ],
      // 缴费明细 发票明细参数
      queryParam: initQueryParams({}),
      activeName: 'charge',
      businessInfo: {},
      businessInfoLoading: false, // 扎帐信息loading
      // 缴费明细
      chargeList: {
        records: [],
        total: 0,
      },
      // 发票明细
      invoiceList: {
        records: [],
        total: 0,
      },

      // 顶部tabs
      currentTabsName: 'await', // 待扎帐：await，扎帐记录：records
    }
  },
  computed: {
    searchDateCom() {
      const format = 'YYYY-MM-DD HH:mm:ss'
      const [start, end] = this.searchDate || []
      console.log(start, end)
      const payload = {
        startTime: start ? parseDate2Str(start, format) : '',
        endTime: start ? parseDate2Str(end, format) : '',
      }
      return payload
    },
    ...mapGetters(['pageLoading']),
    // 显示待扎帐tabs
    showAwaitTabs() {
      return this.currentTabsName === 'await'
    },
    // 显示扎帐记录tabs
    showRecordsTabs() {
      return this.currentTabsName === 'records'
    },
    // 显示收费tabs
    showChargeTabs() {
      return this.activeName === 'charge'
    },
    // 显示发票tabs
    showInvoiceTabs() {
      return this.activeName === 'invoice'
    },

    // 是否可以进行扎帐
    canSettleAccounts() {
      return !isEmpty(this.businessInfo)
    },
  },
  created() {
    this.handleSearch()
  },
  methods: {
    // 搜索
    async handleSearch() {
      // this.SET_LOADING(true)
      await this.getBusinessInfo()
      if (this.showChargeTabs) {
        await this.getChargeList()
      } else if(this.showInvoiceTabs) {
        await this.getInvoiceList()
      }
      // this.SET_LOADING(false)
    },
    // 获取扎帐信息
    async getBusinessInfo() {
      this.businessInfoLoading = true
      const { data: res } = await Accounts.queryAccount(this.searchDateCom)
      this.businessInfoLoading = false
      if (res.isSuccess) {
        this.businessInfo = { ...res.data, summaryStartDate: this.searchDateCom.startTime, summaryEndDate: this.searchDateCom.endTime}
      }
    },
    // 获取缴费明细
    async getChargeList(params = {}) {
      this.tableLoading = true
      const payload = {
        ...this.queryParam,
        current: params.current || this.queryParam.current,
        size: params.size || this.queryParam.size,
        model: {
          createTimeSt: this.searchDateCom.startTime,
          createTimeEd: this.searchDateCom.endTime,
        },
      }
      const { data: res } = await Accounts.getChargeBill(payload)
      this.tableLoading = false
      if (res.isSuccess) {
        this.chargeList = res.data
      } else {
        // 清空已有数据列表
        this.chargeList.records = []
      }
    },
    // 获取发票明细
    async getInvoiceList(params = {}) {
      this.tableLoading = true
      const payload = {
        ...this.queryParam,
        current: params.current || this.queryParam.current,
        size: params.size || this.queryParam.size,
        model: {
          createTimeSt: this.searchDateCom.startTime,
          createTimeEd: this.searchDateCom.endTime,
        },
      }
      const { data: res } = await Accounts.getInvoiceList(payload)
      this.tableLoading = false
      if (res.isSuccess) {
        this.invoiceList = res.data
      } else {
        // 清空已有数据列表
        this.invoiceList.records = []
      }
    },
    // tab切换
    handleTabClick(tab) {
      if (this.showChargeTabs) {
        this.getChargeList()
      } else {
        this.getInvoiceList()
      }
    },
    // 导出报表
    async handleExport() {
      this.exportLoading = true
      await Accounts.export(this.businessInfo)
      this.exportLoading = false
    },
    ...mapMutations('common', [
      'SET_LOADING'
    ]),
    //顶部tabs切换
    handleSettleAccountTabClick(tab) {
      if (this.showAwaitTabs) {
        this.handleSearch()
      } else if (this.showRecordsTabs) {
        this.$refs.recordsRef?.getList()
      }
    },
    
    // 扎帐
    handleSaveSettleAccount() {
      this.submitLoading = true
      return new Promise((resolve) => {
        Accounts.saveSettleAccount(this.businessInfo)
        .then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.$message.success('保存扎帐信息成功!')
            // 清空扎帐信息
            this.businessInfo = {}
            // this.handleSearch()
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
        .finally(() => (this.submitLoading = false))
      })
    },

    // 打印扎帐信息
    async handlePrint() {
      await print['GAS_BILL'](this.businessInfo)
    }
  },
}
</script>

<style lang="scss" scoped>
// 发票筛选
.card-tool-bar {
  .el-input {
    width: 250px;
    ::v-deep .el-input-group__append {
      padding-left: 0;
    }
  }
}

//
.el-table {
  border: 1px solid #eee;
}
::v-deep thead {
  tr {
    background: #fafafa;

    th {
      background: transparent;
    }
  }
}
::v-deep .el-tabs__content {
    height: 100%;
}
.settleAccounts-page {
  ::v-deep {
    .el-card {
      .el-card__body {
        padding: 10px 20px;
      }
      &:not(:last-of-type) {
        margin-bottom: 15px;
      }
    }
  }
}
</style>
