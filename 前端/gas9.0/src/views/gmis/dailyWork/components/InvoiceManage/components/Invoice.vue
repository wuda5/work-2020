<!--
 * @Descripttion: 发票Tab
 * @Author: lingw
 * @Date: 2020-10-12 11:40:53
 * @LastEditors: lingw
 * @LastEditTime: 2021-01-15 15:40:55
-->
<template>
 <div>
    <!-- 发票列表 -->
      <el-table
        :data="invoiceList.records"
        tooltip-effect="dark"
        :border="true"
        :highlight-current-row="true"
        @row-click="handleRowClick"
      >
        <el-table-column
          prop="invoiceNumber"
          label="发票编号"
          fixed
          width="100"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.invoiceNumber | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="payNo"
          label="缴费单号"
          width="100"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.payNo | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="billingDate"
          label="开票日期"
          width="130"
        >
          <span slot-scope="{row}">
            {{ row.billingDate | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="pdfDownloadUrl"
          label="操作"
          width="100"
          align="center"
        >
        <span slot-scope="{row}">
           <el-link :disabled="row.pdfDownloadUrl==null" icon="el-icon-download" type="primary" target="_blank" :href="row.pdfDownloadUrl">下载</el-link>
          </span>
        </el-table-column>
        <el-table-column
          prop="customerName"
          label="客户姓名"
          width="100"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.customerName | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="invoiceType"
          label="发票类型"
          width="80"
        >
          <span slot-scope="{row}">
            {{ row.invoiceType | emptyStr | filterType }}
          </span>
        </el-table-column>
        <el-table-column
          prop="invoiceKind"
          label="发票种类"
          width="100"
        >
          <span slot-scope="{row}">
            {{ row.invoiceKind | emptyStr | filterKind }}
          </span>
        </el-table-column>
        <el-table-column
          prop="invoiceType"
          label="是否作废"
          width="80"
        >
          <span slot-scope="{row}">
            {{ row.invalidStatus | emptyStr | filterInvalid }}
          </span>
        </el-table-column>
        <el-table-column
          prop="invoiceStatus"
          label="发票状态"
          width="80"
        >
          <span slot-scope="{row}">
           <span v-if="row.invoiceStatus == null">--</span>
            <el-tag v-else :type="row.invoiceStatus | filterStatusType">{{ row.invoiceStatus | filterStatus }}</el-tag>
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerName"
          label="发票抬头"
          min-width="200"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.buyerName | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerTinNo"
          label="纳税人识别号"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.buyerTinNo | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerAddress"
          label="购买人地址"
          min-width="200"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.buyerAddress | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerPhone"
          label="购买人电话"
          width="200"
        >
          <span slot-scope="{row}">
            {{ row.buyerPhone | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="telphone"
          label="联系电话"
          min-width="200"
        >
          <span slot-scope="{row}">
            {{ row.telphone | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerBankName"
          label="开户行名称"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.buyerBankName | emptyStr }}
          </span>
        </el-table-column>
        <el-table-column
          prop="buyerBankAccount"
          label="开户行账号"
          width="140"
          show-overflow-tooltip
        >
          <span slot-scope="{row}">
            {{ row.buyerBankAccount | emptyStr }}
          </span>
        </el-table-column>
      </el-table>
      <Pagination
        v-if="+invoiceList.total"
        layout="prev, pager, next"
        :page="+invoiceList.current"
        :limit="+invoiceList.size"
        :total="+invoiceList.total"
        @pagination="handleChange"
      />
 </div>
</template>

<script>
export default {
  name: 'Invoice',
  filters: {
    // 发票种类格式化
    filterKind(val) {
      switch (val) {
        case '0':
          return '红票'
        case '1':
          return '蓝票'
        case '2':
          return '废票'
        default:
          return val
      }
    },
    filterInvalid(val) {
      switch(val) {
        case 0:
          return '否'
        case 1:
          return '是'
        default:
          return '--'
      }
    },
    // 发票类型
    filterType(val) {
      switch (val) {
        case 'GENERAL_INVOICE':
          return '普票'
        case 'SPECIAL_INVOICE':
          return '专票'
        case 'ELECTRONIC_INVOICE':
          return '电票'
        case 'RECEIPT':
          return '票据'
        default:
          return val
      }
    },
    filterStatusType(val) {
      switch (val) {
        case '0':
          return 'warning'
        case '1':
          return 'info'
        case '2':
          return 'success'
        case '3':
          return 'danger'
        default:
          return 'info'
      }
    },
    filterStatus(val) {
      switch (val) {
        case '0':
          return '未开票'
        case '1':
          return '开票中'
        case '2':
          return '开票成功'
        case '3':
          return '开票失败'
        default:
          return val
      }
    },
  },
  props: {
    invoiceList: {
      required: true,
      type: Object,
      default: () => {
        return {
          records: [],
        }
      },
    },
  },
  created(){
    console.log(this.invoiceList)
  },
  methods: {
    handleChange(params) {
      this.$emit('pagination', params)
    },
    handleRowClick(row, column, event) {
      this.$emit('row-click', row, column, event)
    },
  },
}
</script>

<style lang='scss' scoped>
</style>
