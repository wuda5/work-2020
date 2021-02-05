<!--
 * @Description: 每日团标上报
 * @Author: lingw
 * @Date: 2021-02-02 08:36:30
 * @LastEditors: lingw
 * @LastEditTime: 2021-02-02 13:58:49
-->
<template>
  <div class="qc-main">
    <search-box>
      <el-input v-model.trim="queryParams.customerChargeNo" clearable placeholder="缴费编号" />
      <el-input v-model.trim="queryParams.gasMeterNumber" clearable placeholder="表身号" />
      <el-input v-model.trim="queryParams.customerName" clearable placeholder="客户名称" />
      <el-date-picker
        v-model="queryParams.rangeTime"
        type="daterange"
        value-format="yyyy-MM-dd"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
      />
      <el-button type="success" @click="getReportList">查询</el-button>
    </search-box>
    <report-list :meter-type="1" :report-list="reportList" @pagination="handlePagination" />
  </div>
</template>

<script>
import ReportList from '../components/ReportTable'
import reportInfoApi from '@/api/reportInfo'
export default {
  name: 'GroupReprot',
  components: {
    ReportList
  },
  data() {
    return {
      queryParams: {
        customerChargeNo: '',
        gasMeterNumber: '',
        customerName: '',
        meterType: 1, // 0 - 表端计费 1 - 终端计费
        uploadTime: [],
        pageNo: 1,
        pageSize: 10
      },
      reportList: {
        records: [],
        total: 0,
        size: 10,
        current: 1
      }
    }
  },
  mounted() {
    this.getReportList()
  },
  methods: {
    async getReportList() {
      const { data: { data } } = await   reportInfoApi.getReportList(this.queryParams)
      if (data) {
        const { records, size, total } = data
        this.reportList = {
          ...this.reportList,
          records,
          size,
          total
        }
      }
    },
    handlePagination({ current, size }) {
      this.queryParams = {
        ...this.queryParams,
        pageNo: current,
        pageSize: size
      }
      this.getReportList()
    }
  }
}
</script>