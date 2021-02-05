<template>
  <el-card shadow="never" style="height: 235px">
    <div slot="header">
      <span class="card-title">表具列表</span>
      <!-- 操作按钮 -->
      <div class="card-tool-bar">
        <el-button
          v-has-permission="['dailyWork:tf']"
          type="primary"
          plain
          @click="dialogOpen('showReturnPremium')"
        >
          业务退费
        </el-button>
      </div>
      <div class="card-tool-bar">
        <el-button
          v-has-permission="['dailyWork:zhtf']"
          type="primary"
          plain
          @click="dialogOpen('showAccountReturnPremium')"
        >
          账户退费
        </el-button>
      </div>
    </div>
    <!-- 用户信息列表 -->
    <el-table
      ref="tableRef"
      :data="tableData"
      tooltip-effect="dark"
      style="width: 100%; height: 130px"
      :border="true"
      height="118"
      :highlight-current-row="true"
      @row-click="handleRowClick"
    >
      <el-table-column type="index" label="#" width="45" />
      <!-- 缴费编号 -->
      <el-table-column
        prop="customerChargeNo"
        label="缴费编号"
        width="150"
        :show-overflow-tooltip="true"
      />
      <!-- 表身号 -->
      <el-table-column
        prop="gasMeterNumber"
        label="表身号"
        width="150"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        prop="customerName"
        label="客户姓名"
        width="150"
        :show-overflow-tooltip="true"
      />
      <el-table-column prop="telphone" label="联系电话" width="100" />
      <el-table-column prop="customerTypeName" label="客户类型" width="100" />
      <el-table-column
        prop="useGasTypeName"
        label="用气类型"
        width="120"
        :show-overflow-tooltip="true"
      />

      <!-- 气表类型 -->
      <el-table-column
        prop="orderSourceName"
        :label="$t('meterInfo.gasMeterTypeName')"
        show-overflow-tooltip
      >
        <template #default="{ row }">
          {{ gasMeterTypeMap[row.orderSourceName] }}
        </template>
      </el-table-column>
      <!-- 气表状态 -->
      <el-table-column prop="dataStatus" label="气表状态" width="100">
        <template #default="{ row }">
          {{ meterStatusMap[+row.dataStatus] }}
        </template>
      </el-table-column>
      <!-- <el-table-column label="调压箱号">
        <template slot-scope="scope">{{
          !scope.row.nodeNumber ? '---' : scope.row.nodeNumber
        }}</template>
      </el-table-column> -->
      <el-table-column label="气表厂家" width="300">
        <template slot-scope="scope">
          {{ !scope.row.gasMeterFactoryName ? '---' : scope.row.gasMeterFactoryName }}
        </template>
      </el-table-column>
      <el-table-column label="气表版号">
        <template slot-scope="scope">
          {{ !scope.row.gasMeterVersionName ? '---' : scope.row.gasMeterVersionName }}
        </template>
      </el-table-column>
      <el-table-column prop="moreGasMeterAddress" label="安装地址" width="300" />
    </el-table>
    <div class="pagination">
      <el-pagination
        background
        layout="prev, pager, next"
        :current-page="paginations.currentPage"
        :page-size="paginations.pageSize"
        :total="paginations.total"
        @current-change="handleSearch"
        @prev-click="handleSearch"
        @next-click="handleSearch"
      />
    </div>
    <!--退费-->
    <!-- data-key="showReturnPremium"
      @close="dialogClose"
      :v-if="showReturnPremium" -->
    <el-dialog width="1200px" title="业务退费" :visible.sync="showReturnPremium">
      <return-premium
        :v-if="showReturnPremium"
        :customer-charge-no-from-daily="customerChargeNo"
      />
    </el-dialog>
    <el-dialog
      width="1200px"
      title="账户退费"
      :visible.sync="showAccountReturnPremium"
      @closed="rushPage"
    >
      <return-account-premium
        :v-if="showAccountReturnPremium"
        :customer-name-from-daily="customerName"
        :is-refund-success="isRefundSuccess"
      />
    </el-dialog>
  </el-card>
</template>

<script>
import { dictionaryCodeMap } from '@/enums/dictionary'
import meterMixin from '@/mixins/meter'
import ReturnPremium from '@/components/QcRefund' // 余额退费
import ReturnAccountPremium from '@/components/QcAccountRefund' // 账户退费

export default {
  name: 'DailyWorkUserList',
  filters: {},
  components: {
    ReturnPremium, // 退费
    ReturnAccountPremium,
  },
  mixins: [meterMixin],
  props: {
    tableData: Array,
    rowClick: Function,
    tableSelect: Function,
    paginations: Object,
    searchByCurrentPage: Function,
    handleChargeList: Function,
    currentRow: Object,
  },
  data() {
    return {
      isRefundSuccess: {
        value: false,
      },
    }
  },
  computed: {
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
    customerChargeNo() {
      return this.currentRow ? this.currentRow.customerChargeNo : ''
    },
    customerName() {
      return this.currentRow ? this.currentRow.customerName : ''
    },
  },
  watch: {
    tableData(data) {
      if (data.length === 1) {
        this.$refs.tableRef?.setCurrentRow(data[0])
        this.handleChargeList(data[0])
      }
    },
  },
  methods: {
    rushPage() {
      if (this.isRefundSuccess.value) {
        this.$router.go(0)
      }
    },
    handleSearch(page) {
      this.searchByCurrentPage(page)
    },
    handleRowClick(row) {
      // this.handleChargeList(row.customerCode, row.gasCode,row.useGasTypeId)
      // this.handleChargeList('BC202009090000000193', 'BMC202009080000000100')
      this.handleChargeList(row)
    },
  },
}
</script>

<style lang="scss" scoped>
.card-tool-bar {
  .el-button {
    margin-left: 10px;
  }
}

.el-card {
  position: relative;
}

.pagination {
  // margin: 10px 0 0 0;
  position: absolute;
  left: 20px;
  bottom: 10px;
}
</style>
