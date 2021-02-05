<!-- 安检工单数统计 -->
<template>
  <div class="tablePart">
    <!-- search -->
    <search-box>
      <div slot="left">
        <span class="card-title">安检工单数统计</span>
      </div>
      <div slot="right">
        <el-date-picker
          v-model="dataRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
        <el-button type="primary" plain>确认</el-button>
        <el-button type="primary" plain>导出数据</el-button>
      </div>
    </search-box>

    <!-- table -->
    <el-table
      :data="tableData"
      style="width: 100%"
      :border="true"
    >
      <el-table-column
        label="序号"
        type="index"
        width="80"
      >
      </el-table-column>
      <el-table-column
        prop="Organization"
        label="售气机构"
      />
      <el-table-column
        prop="year"
        label="年份"
      />
      <el-table-column
        prop="name"
        label="人员"
      />
      <el-table-column
        prop="countNum"
        label="服务次数(次)"
      />
      <el-table-column
        prop="rate"
        label="占比(%)"
      />
      <el-table-column
        prop="branchTotal"
        label="分(子)公司总计"
      />
      <el-table-column
        prop="branchRate"
        label="分(子)公司占比"
      />

    </el-table>

    <pagination
      layout="prev, pager, next"
      :total="10"
    />
  </div>
</template>

<script>
export default {
  name: 'WorkOrderStatistics',
  props: {},
  data() {
    return {
      dataRange: '',
      tableData: [
        {
          Organization: '四川分公司',
          year: '2020',
          name: '李三',
          countNum: '2334',
          rate: '8.16%',
          branchTotal: '10799',
          branchRate: '37.76%'

        }, {
          Organization: '四川分公司',
          year: '2020',
          name: '李三',
          countNum: '1236',
          rate: '8.16%'
        }, {
          Organization: '四川分公司',
          year: '2020',
          name: '李三',
          countNum: '1236',
          rate: '8.16%'

        }, {
          Organization: '四川分公司',
          year: '2020',
          name: '李三',
          countNum: '1236',
          rate: '8.16%'

        }]
    }
  },
  computed: {},
  mounted() {

  },
  methods: {
    exportData(title) {
      // this.exportTitle = `${title}数据导出`
      // this.showExportData = true
    },
  }
}
</script>

<style scoped>
.tablePart {
  margin: 30px 0;
}
</style>
