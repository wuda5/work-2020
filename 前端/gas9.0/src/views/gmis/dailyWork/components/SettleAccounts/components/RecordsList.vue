<template>
  <div v-loading="loading" class="RecordsList-container">
    <!-- 扎帐记录 -->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">扎帐记录</span>
      </div>
      <div class="operation-box">
        <div class="fl">
          <el-form :ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
            <el-form-item label="">
              <el-date-picker
                v-model="queryParams.model.searchDateRange"
                type="datetimerange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                value-format="yyyy-MM-dd HH:mm:ss"
                :picker-options="pickerOptions"
                :default-time="['00:00:00', '23:59:59']"
              >
              </el-date-picker>
            </el-form-item>
            <el-form-item label="">
              <el-button type="primary" name="records-search" class="search-btn records-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div class="fr">
          <el-button class="reverse-settle-btn" name="reverse-settle-btn" :disabled="multipleSelection.length === 0 || submitLoading" type="primary" @click="handleReverseSettle">{{ $t('反扎帐') }}</el-button>
        </div>
      </div>
      <p class="text-danger hint-text">只有近一个月的扎帐记录可以进行反扎帐操作</p>
      <!--数据-->
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        border
        :data="list"
        tooltip-effect="dark"
        row-key="id"
        :highlight-current-row="true"
        @row-click="handleRowClick"
        @selection-change="handleSelectionChange"
      >
        <!-- 多选框 -->
        <el-table-column
          align="center"
          type="selection"
          width="40px"
          :selectable="setSelectable"
          :reserve-selection="false"
        />
        <el-table-column
          type="index"
          :label="$t('table.index')"
        >
        </el-table-column>
        <!-- <el-table-column prop="chargeNo" label="扎帐流水号" width="100" show-overflow-tooltip /> -->
        <el-table-column prop="createTime" label="扎帐时间" width="80" show-overflow-tooltip />
        <el-table-column prop="createTime" label="扎帐时间段" width="250" show-overflow-tooltip>
          <template #default="{ row }">
            {{ row.summaryStartDate }}-{{ row.summaryEndDate || row.createTime }}
          </template>
        </el-table-column>
        <el-table-column prop="chargeMethodName" label="收费详情" align="center">
          <el-table-column prop="cashAmount" label="现金" width="80" />
          <el-table-column prop="bankTransferAmount" label="银行转账" width="80" />
          <el-table-column prop="alipayAmount" label="支付宝" width="80" />
          <el-table-column prop="wechatAmount" label="微信" width="80" />
          <el-table-column prop="refundAmount" label="退费金额" width="80" />
          <el-table-column prop="totalAmount" label="合计金额" width="80" />
        </el-table-column>
        <el-table-column prop="chargeMethodName" label="发票详情" align="center">
          <el-table-column prop="receiptTotalNum" label="票据" width="80" />
          <el-table-column prop="blueInvoiceTotalNum" label="蓝票" width="80" />
          <el-table-column prop="redInvoiceTotalNum" label="红票" width="80" />
          <el-table-column prop="invalidInvoiceTotalNum" label="废票" width="80" />
          <el-table-column prop="receiptInvoiceTotalNum" label="合计发票数" width="90" />
          <el-table-column prop="receiptInvoiceTotalAmount" label="合计发票金额" width="100" />
        </el-table-column>
      </el-table>
      <!--分页-->
      <pagination
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="handleGetList"
      />
    </el-card>
    
    <!--业务记录-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">业务记录</span>
      </div>
      <el-tabs v-model="activeName" @tab-click="handleTabClick">
        <el-tab-pane label="收费明细" name="charge">
          <!-- 收费列表 -->
          <charge-list :loading="charge.listLoading" :data="charge.list">
            <!--分页-->
            <template v-slot:pagination>
              <pagination
                :page.sync="charge.queryParams.current"
                :limit.sync="charge.queryParams.size"
                :total="+charge.total"
                @pagination="getChargeList()"
              />
            </template>
          </charge-list>
        </el-tab-pane>
        <el-tab-pane label="开票明细" name="invoice">
          <!-- 开票列表 -->
          <invoice-list :loading="invoice.listLoading" :data="invoice.list">
            <!--分页-->
            <template v-slot:pagination>
              <pagination
                :page.sync="invoice.queryParams.current"
                :limit.sync="invoice.queryParams.size"
                :total="+invoice.total"
                @pagination="getInvoiceList()"
              />
            </template>
          </invoice-list>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import accountsApi from '@/api/dailyWork/accounts'
import chargeList from './ChargeList.vue' // 缴费列表
import invoiceList from './InvoiceList.vue' // 发票列表

export default {
  name: 'RecordsList',
  components: {
    chargeList,
    invoiceList
  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    return {
      ...this.initListData({
        queryParams: this.initQueryParams({
          model: {
            searchDateRange: [
              // new Date(new Date(new Date().toLocaleDateString()).getTime()),
              // new Date(new Date(new Date().toLocaleDateString()).getTime() + (24 * 3600 * 1000 - 1)),
            ],
            createTimeEd: null,
            createTimeSt: null,
          }
        })
      }),
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now()
        },
      },
      activeName: 'charge',
      // 缴费列表相关的
      charge: {
        listRef: 'chargeListRef',
        list: [], // 列表数据存放
        total: 0,
        listLoading: false, // 表格数据loading
        queryParams: this.initQueryParams({
          model: {
            id: null, // 扎帐记录id
          }
        }),
      },
      // 发票列表相关的
      invoice: {
        listRef: 'invoiceListRef',
        list: [], // 列表数据存放
        total: 0,
        listLoading: false, // 表格数据loading
        queryParams: this.initQueryParams({
          model: {
            id: null, // 扎帐记录id
          }
        }),
      },
      submitLoading: false, // 反结算loading
    }
  },
  computed: {
    // 显示收费tabs
    showChargeTabs() {
      return this.activeName === 'charge'
    },
    // 显示发票tabs
    showInvoiceTabs() {
      return this.activeName === 'invoice'
    },
  },
  watch: {
    // 监听搜索日期范围
    'queryParams.model.searchDateRange': {
      handler(value) {
        this.queryParams.model.createTimeEd = value ? value[0] || '' : ''
        this.queryParams.model.createTimeSt = value ? value[1] || '' : ''
      }
    },
  },
  created() {
    // this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {
       await this.getList()
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        accountsApi.getRecordsList(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            this.$nextTick(() => {
              this.loadData()
            })
            resolve(records)
          } else {
            resolve(false)
          }
          this.listLoading = false
        }).catch(() => {
          resolve(false)
          this.listLoading = false
        })
      })
    },
    
    // 获取扎帐记录之后加载其它数据
    loadData() {
      let currentItem = null
      // 如果只有一条数据，默认加载信息
      if (this.list.length === 1) {
        currentItem = this.list[0]
      } else {
        // 如果当前选中的数据不存在于data中，则设置选中行高亮,气表数据置空
        currentItem = this.list.find((item) => item.id === this.currentRow?.id)
      }
      if (currentItem) {
        // 设置选中行高亮
        this.$refs[this.listRef]?.setCurrentRow(currentItem)
        this.currentRow = currentItem
        this.$nextTick(() => {
          this.getBussinessRecords()
        })
      } else {
        // 当前选中数据置空
        this.currentRow = null
      }
    },

    // 获取业务记录数据
    async getBussinessRecords() {
      const { id } = this.currentRow || {}
      if (id) {
        this.charge.queryParams.model.id = id
        this.invoice.queryParams.model.id = id
        if (this.showChargeTabs) {
          await this.getChargeList()
        } else if (this.showInvoiceTabs) {
          await this.getInvoiceList()
        }
      }
    },
    
    // 获取缴费明细
    async getChargeList(params = {}) {
      const { charge } = this
      charge.listLoading = true
      const generateParams = this.generateQueryParams(params, charge)
      const { data: res } = await accountsApi.getRecordsChargeBill(generateParams)
      charge.listLoading = false
      if (res.isSuccess) {
        const { records, total } = res.data
        charge.list = records
        charge.total = total
      }
    },
    // 获取发票明细
    async getInvoiceList(params = {}) {
      const { invoice } = this
      invoice.listLoading = true
      const generateParams = this.generateQueryParams(params, invoice)
      const { data: res } = await accountsApi.getRecordsInvoiceList(generateParams)
      invoice.listLoading = false
      if (res.isSuccess) {
        const { records, total } = res.data
        invoice.list = records
        invoice.total = total
      }
    },
    
    // tab切换
    handleTabClick(tab) {
      this.getBussinessRecords()
    },

    // 单击行
    handleRowClick(row) {
      this.currentRow = cloneDeep(row)
      this.getBussinessRecords()
    },

    // 设置每行是否可以多选
    setSelectable(row, index) {
      return (+new Date() - 30 * 24 * 3600 * 1000) <= +new Date(row.createTime)
    },

    // 选中反扎帐
    handleReverseSettle() {
      this.submitLoading = true
      return new Promise((resolve) => {
        accountsApi.reverseSettle(this.multipleSelection)
        .then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.$message.success('反结算操作成功')
            this.getList()
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
        .finally(() => (this.submitLoading = false))
      })
    }
  }
}
</script>

<style scoped lang="scss">
  .RecordsList-container {
    .hint-text {
      color: $danger;
    }
  }
</style>
