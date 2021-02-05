<!-- 抄表人员统计 -->
<template>
  <el-card>
    <div slot="header">
      <!-- search -->
      <search-box>
        <div slot="left">
          <span class="card-title">抄表人员统计</span>
        </div>
        <div slot="right">
          <el-date-picker
            v-model="dataRange"
            type="monthrange"
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
      <el-table-column prop="readMeterUserName" label="人员" />
      <el-table-column prop="readMeterDate" label="抄表月" />

      <el-table-column prop="totalMeter" label="应抄表（户）" />

      <el-table-column prop="readMeterCount" label="已抄表(户)" />
      <el-table-column prop="notFinishedCount" label="未抄表(户)" />
      <el-table-column prop="completionRate" label="抄表率(%)" />
    </el-table>

    <pagination layout="prev, pager, next" :total="10" />
  </el-card>
</template>

<script>
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'ReadMeter',
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
  computed: {},
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
        endDay: '',
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
      tjApi.SReadMeterCounter(this.search).then(res => {
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
