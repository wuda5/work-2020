<!-- 柜台人员统计 -->
<template>
  <el-card>
    <div slot="header">
      <!-- search -->
      <search-box>
        <div slot="left">
          <span class="card-title">柜台人员统计</span>
        </div>
        <div slot="right">
          <el-date-picker
            v-model="dataRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            value-format="yyyy-MM-dd"
          />
          <el-button type="primary" plain @click="getData">确认</el-button>
          <!--<el-button type="primary" plain>导出数据</el-button>-->
        </div>
      </search-box>
    </div>

    <!-- table -->
    <el-table :data="tableData" style="width: 100%" :border="true">
      <el-table-column label="序号" type="index" width="80"> </el-table-column>
      <el-table-column prop="name" label="人员" />
      <el-table-column prop="serviceCount" label="收费次数(次)" />
      <el-table-column prop="changeMoney" label="收费金额（元）" />
      <el-table-column prop="invoiceCount" label="发票(张)" />
    </el-table>

    <pagination
      layout="total, prev, pager, next"
      :page.sync="search.pageNo"
      :limit.sync="search.pageSize"
      :total="total"
      @pagination="getData()"
    />
  </el-card>
</template>

<script>
import tjApi from '@/api/statistics/index.js' // 折线图图表

export default {
  name: 'CounterStaff',
  props: {
    propsData: {
      type: Object,
      default: function () {
        return {
          orgId: '',
        }
      },
    },
  },
  data() {
    return {
      dataRange: '',
      search: this.initSearchCondition(),
      tableData: [],
      total: 0,
    }
  },
  watch: {
    propsData() {
      this.getData()
    },

  },
  mounted() {
    this.getData()
  },
  methods: {
    initSearchCondition() {
      return {
        businessHallId: 0,
        companyCode: '',
        endDay: '',
        orgId: 0,
        startDay: '',
        pageSize: 10, // 一页显示几条数据
        pageNo: 1, // 当前第几页
      }
    },

    getData() {
      if (this.dataRange) {
        this.search.startDay = this.dataRange[0]
        this.search.endDay = this.dataRange[1]
      }
      this.search.orgId = this.propsData.orgId
      tjApi.SStaffCounter(this.search).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = parseInt(data.total)
        }
      })
    },
  },
}
</script>

<style scoped>
  .tablePart {
    margin: 30px 0;
  }
</style>
