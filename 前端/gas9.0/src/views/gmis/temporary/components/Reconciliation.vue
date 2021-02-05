<!--对账-->
<template>
  <div>
    <el-form :inline="true" :model="queryParams" class="search jh-text">
      <el-form-item label="" style="width: auto">
        <el-date-picker
          v-model="rangeTime"
          type="daterange"
          value-format="yyyy-MM-dd"
           range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="queryParams.model.orderNumber" placeholder="订单号" />
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="queryParams.model.customerName" placeholder="客户姓名" />
      </el-form-item><el-form-item label="">
        <el-button :loading="btnLoading" type="primary" size="mini" @click="handleSearch">查询</el-button>
      </el-form-item>
    </el-form>
    <!--list-->
    <el-card shadow="never" class="no-border">
      <div class="butGroup">
        <div class="fl">
          <el-button type="warning" plain @click="() => handleSearch(1)">异常</el-button>
          <el-button type="primary" plain @click="handleSearch">全部</el-button>
        </div>
        <div class="fr">
          <el-button :loading="exportBtnLoading" type="primary" @click="exportBillsList">导出</el-button>
        </div>
      </div>
      <div class="clearfix"></div>
      <el-table
        :data="tableData.records"
        tooltip-effect="dark"
        :border="false"
        style="margin-top: 10px; width: 100%; border:1px solid #eee"
        :highlight-current-row="true"
        header-row-class-name="ddd"
        height="380px"
      >
        <!-- <el-table-column
          type="selection"
          width="55"
        >
        </el-table-column>
        <el-table-column
          type="index"
          label="序号"
        /> -->
        <el-table-column
          fixed
          prop="orderNumber"
          label="订单号"
          width="180"
        />
        <el-table-column
          prop="customerCode"
          label="客户编号"
          width="180"
        />
        <el-table-column
          prop="customerName"
          label="客户姓名"
        />
        <el-table-column
          prop="pay"
          label="微信订单金额"
          width="140"
        />
        <el-table-column
          prop="orderPay"
          label="系统订单金额"
          width="140"
        />
        <el-table-column
          prop="contrastStateName"
          label="对账状态"
        >
          <template slot-scope="{ row }">
            <el-tag :type="row.contrastStateName === 1 ? 'danger' : 'success'">
              {{ row.contrastStateName === 1 ? '异常' : '正常' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="createTime"
          label="订单时间"
          width="160"
        />
        <el-table-column
          prop="transactionTime"
          label="支付时间"
          width="160"
        />
        <el-table-column
          prop="contrastRemark"
          label="差异说明"
          width="120"
        />
      </el-table>
      <pagination
        :page="+tableData.current"
        :limit="+tableData.size"
        :total="+tableData.total"
        layout="total, prev, pager, next, jumper"
        @pagination="handleChange"
      />
    </el-card>
  </div>
</template>

<script>
import { default as temporaryApi } from '@/api/temporary/index.js';
import { fileStreamDownload } from '@/api/File'
import {debounce} from '@/utils/index';
import { initQueryParams } from '@/utils/commons'
export default {
  name: 'Reconciliation',
  data() {
    return {
      btnLoading: false,
      exportBtnLoading: false,
      tableData: {
        records: [],
        size: 10,
        current: 1
      },
      rangeTime: [],
      queryParams: initQueryParams({
        size: 10,
        current: 1,
        model: {
          startTime: '',
          endTime: '',
          orderNumber: '',
          customerName: ''
        }
      })
    }
  },
  mounted() {
    this.getBillsList()
  },
  methods: {
    handleSearch (state) {
      delete this.queryParams.model.contrastState
      if (state === 1) {
        this.queryParams.model.contrastState = state
      }
      this.queryParams.size = 10
      this.queryParams.current = 1
      this.getBillsList()
    },
    // 查询账单
    getBillsList: debounce(function() {
      const [startTime = '', endTime = ''] = this.rangeTime
      this.queryParams.model.startTime = startTime
      this.queryParams.model.endTime = endTime
      temporaryApi.queryWeixinBill(this.queryParams)
      .then(res => {
        const { data } = res.data
        if (data) {
          this.tableData = data
        } else {
          this.tableData = {
            records: [],
            size: 10,
            current: 1
          }
        }
      })
    }, 300),
    // 导出账单
    async exportBillsList() {
      this.exportBtnLoading = true
      const [startTime = '', endTime = ''] = this.rangeTime
      this.queryParams.model.startTime = startTime
      this.queryParams.model.endTime = endTime
      try {
        await fileStreamDownload(
          '/bizcenter/pay/onlinepay/wxBill/export',
          this.queryParams,
          {
            method: 'POST',
          },
          {
            name: '微信对账单.xls',
          }
        )
      } catch(e) {
        console.warn(e)
      } finally {
        this.exportBtnLoading = false
      }
    },
    // 翻页
    handleChange({ size = 10, current = 1 } = {}) {
      this.queryParams.size = size
      this.queryParams.current = current
      this.getBillsList()
    }
  }
}
</script>

<style lang="scss" scoped>
  .search {
    margin-bottom: 12px;
    ::v-deep .el-date-editor {
      width: 240px;

      ::v-deep .el-range-input {
        width: 100px;
      }
    }

    .el-form-item {
      width: 130px;
      margin-right: 0;
      margin-bottom: 10px;
    }

    .el-button {
      margin-left: 0;
    }
  }

  .el-divider {
    margin: 0 auto;
  }

  // 设置表格头部背景
  ::v-deep .el-table th {
    background-color: #f5f7fa !important;
  }

</style>
