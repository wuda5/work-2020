<!--添加抄表册到抄表计划-->
<template>
  <div>
    <search-box>
      <div slot="right">
        <el-button :disabled="multipleSelection.length === 0" :loading="submitLoading" type="success" @click="saveDataToPlan">新增</el-button>
      </div>
    </search-box>
    <!-- list -->
    <el-table
      ref="multipleTable"
      :data="readMeterBookList"
      tooltip-effect="dark"
      border
      :height="473"
      @selection-change="selectionChange"
    >
      <!-- 多选 -->
      <el-table-column type="selection" width="45" />
      <!-- 编号 -->
      <el-table-column type="index" label="#" width="45" />
      <!-- 抄表册 -->
      <el-table-column prop="bookName" label="抄表册" />
      <!-- 抄表员 -->
      <el-table-column prop="readMeterUserName" label="抄表员">
        <template slot-scope="{ row }">{{ row.readMeterUserName || 'unknown' }}</template>
      </el-table-column>
      <!-- 总户数 -->
      <el-table-column prop="totalReadMeterCount" label="总户数" />
    </el-table>

    <!-- 分页 -->
    <pagination
      name="pagination"
      :total="total"
      :page-sizes="[10, 20, 30]"
      :limit="searchForm.size"
      layout="total,sizes, prev, pager, next, jumper"
      @pagination="pagination"
    />
  </div>
</template>

<script>
import apiReadMeterPlan from '@/api/readMeter/readMeterPlan'
export default {
  name: 'AddReadMeterBookToPlan',
  props: {
    curPlan: {
      type: Object,
    },
  },
  data() {
    return {
      // 计划表单
      searchForm: this.initQueryParams({
        model: {
          readMeterYear: this.curPlan.readMeterYear,
          readMeterMonth: this.curPlan.readMeterMonth,
        },
      }),
      readMeterBookList: [],
      multipleSelection: [],
      total: 0,
      submitLoading:false,
    }
  },
  created() {
    this.getData()
  },
  methods: {
    // 获取数据
    getData() {
      apiReadMeterPlan.getUnboundBook(this.searchForm).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.readMeterBookList = data.records
          this.total = parseInt(data.total)
        }
      })
    },

    // 多选操作
    selectionChange(val) {
      this.multipleSelection = val
    },

    // 分页数据改变
    pagination(pageData) {
      this.searchForm.size = pageData.size
      this.searchForm.current = pageData.current
      this.getData()
    },

    // 保存到抄表册
    saveDataToPlan(type) {
      this.submitLoading = true;
      let ids = this.multipleSelection.map(item => {
        return item.id
      })

      let postData = {
        bookIds: ids,
        planId: this.curPlan.id,
      }

      apiReadMeterPlan.addUnboundBook(postData).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.msg('添加成功', 'success')
          this.$emit('close')
          this.submitLoading = false;
        }
      })
    },
  },
}
</script>
