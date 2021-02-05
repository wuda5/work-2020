<!--抄表计划-->
<template>
  <div>
    <el-row :gutter="15">
      <el-col :span="12">
        <!-- search -->
        <search-box>
          <div slot="left">
            <!-- 日期 -->
            <el-date-picker
              v-model="readMeteTime"
              type="month"
              placeholder="选择时间"
              value-format="yyyy-MM"
            ></el-date-picker>
            <el-button type="primary" @click="searchPlanList">查询</el-button>
          </div>
          <div slot="right">
            <el-button type="success" @click="addPlan">新增</el-button>
          </div>
        </search-box>
        <!-- 数据列表 -->
        <el-table
          :data="planDataList"
          height="500"
          border
          :highlight-current-row="true"
          @row-click="handelRowClick"
        >
          <!-- 序号 -->
          <el-table-column type="index" label="#" width="40"></el-table-column>
          <!-- 抄表月 -->
          <el-table-column prop="date" label="抄表月" width="70">
            <template slot-scope="{ row }">{{ row.readMeterYear }}-{{ row.readMeterMonth }}</template>
          </el-table-column>
          <!-- 开始时间 -->
          <el-table-column prop="date" label="开始时间" width="90">
            <template slot-scope="{ row }">{{
              row.planStartTime | dataFormat('yyyy-MM-dd')
            }}</template>
          </el-table-column>
          <!-- 结束时间 -->
          <el-table-column prop="date" label="结束时间" width="90">
            <template slot-scope="{ row }">{{
              row.planEndTime | dataFormat('yyyy-MM-dd')
            }}</template>
          </el-table-column>
          <!-- 状态 -->
          <el-table-column prop="name" label="状态" width="82">
            <template slot-scope="{ row }">
              <el-tag :type="row.dataStatus | statusFilter">{{
                row.dataStatus | statusValueFilter
              }}</el-tag>
            </template>
          </el-table-column>
          <!-- 操作 -->
          <el-table-column prop="name" label="操作">
            <template slot-scope="{ row }">
              <el-button type="primary" :disabled="row.dataStatus !== -1" @click="updatePlan(row)">修改</el-button>
              <el-button v-if="row.dataStatus === -1" type="success" @click="updateSatus(row, 1)">启动</el-button>
              <el-button v-if="row.dataStatus === 1" type="warning" @click="updateSatus(row, 2)">取消</el-button>
              <el-button v-if="row.dataStatus === 2" type="info" @click="updateSatus(row, 1)">重启</el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- 分页 -->
        <pagination
          name="pagination"
          :total="total"
          :page-sizes="[10, 20, 30]"
          :limit="planSearch.size"
          layout="total,sizes, prev, pager, next, jumper"
          @pagination="pagination"
        />
      </el-col>

      <!-- 计划内的操表册 -->
      <el-col v-if="curPlan" :span="12">
        <div class="subTitle">抄表册信息</div>
        <!-- 操作 -->
        <search-box>
          <div slot="right">
            <el-button
              type="warning"
              :disabled="multipleSelection.length === 0"
              :loading="loadingRemove"
              @click="removeFromPlan"
              >移除</el-button>
            <el-button type="success" @click="addReadMeterBook">添加</el-button>
            <!-- <el-tooltip content="启动计划后才能导出" placement="top"> -->
            <el-button v-if="curPlan.dataStatus !== -1" type="primary" @click="exprot">导出</el-button>
            <!-- </el-tooltip> -->
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
          <el-table-column prop="readMeterUserName" label="抄表员" width="80">
            <template slot-scope="{ row }">{{ row.readMeterUserName || 'unknown' }}</template>
          </el-table-column>
          <!-- 总户数 -->
          <el-table-column prop="totalReadMeterCount" label="总户数" width="60" />
          <!-- 已超 -->
          <el-table-column prop="readMeterCount" label="已超" width="60" />
          <!-- 状态 -->
          <el-table-column prop="dataStatus" label="状态" width="80">
            <template slot-scope="{ row }">
              <el-tag :type="row.dataStatus | statusFilter">{{
                row.dataStatus | statusValueFilter
              }}</el-tag>
            </template>
          </el-table-column>
        </el-table>

        <!-- 分页 -->
        <pagination
          name="pagination"
          :total="total2"
          :page-sizes="[10, 20, 30]"
          :limit="planInfoSearch.size"
          layout="total,sizes, prev, pager, next, jumper"
          @pagination="pagination2"
        />
      </el-col>
      <no-select v-else :height="540" tips="请选择抄表计划"></no-select>
    </el-row>
    <!-- 弹窗 -->
    <!-- 添加 | 编辑 计划 -->
    <el-dialog
      :visible.sync="showAddPlan"
      :append-to-body="true"
      :title="formType === 'add' ? '添加' : '修改'"
      width="500px"
      @close="searchPlanList"
    >
      <edit-plan
        v-if="showAddPlan"
        :cur-plan="curPlan"
        :form-type="formType"
        @close=";(showAddPlan = false), searchPlanList"
      ></edit-plan>
    </el-dialog>

    <!-- 添加抄表册到计划 -->
    <el-dialog
      :visible.sync="showAddReadMeterBookToPlan"
      :append-to-body="true"
      :title="formType === 'add' ? '添加' : '修改'"
      width="500px"
      @close="getPlanInfoData"
    >
      <add-read-meter-book-to-plan
        v-if="showAddReadMeterBookToPlan"
        :form-type="formType"
        :cur-plan="curPlan"
        @close=";(showAddReadMeterBookToPlan = false), getPlanInfoData"
      ></add-read-meter-book-to-plan>
    </el-dialog>
  </div>
</template>

<script>
import apiReadMeterPlan from '@/api/readMeter/readMeterPlan'
import { fileStreamDownload } from '@/api/File'
import EditPlan from './EditPlan.vue'
import AddReadMeterBookToPlan from './AddReadMeterBookToPlan.vue'
import NoSelect from '@/components/QcNoSelect/index.vue'

export default {
  name: 'ReadMeterPlan',
  components: {
    EditPlan,
    NoSelect,
    AddReadMeterBookToPlan,
  },
  filters: {
    statusFilter(status) {
      const map = {
        '-1': 'info',
        1: 'parimary',
        2: 'warning',
        0: 'success',
      }
      return map[status] || 'success'
    },

    // '状态（-1：未开启；1：执行中；2-暂停；0-执行完成）
    statusValueFilter(status) {
      const map = {
        '-1': '未开启',
        1: '执行中',
        2: '暂停',
        0: '执行完成',
      }
      return map[status] || ''
    },

    // -1:未抄表；1:抄表中；0:抄表完成
    statusPlanInfiFilter(status) {
      const map = {
        '-1': '未抄表；1',
        1: '抄表中；0',
        0: '抄表完成',
      }
      return map[status] || ''
    },
  },
  data() {
    return {
      // ======================================================

      // 抄表计划 搜索
      readMeteTime: '', // 抄表时间，年月 提交时拆分给下面使用
      planSearch: this.initQueryParams({
        model: {
          readMeterMonth: 0,
          readMeterYear: 0,
        },
      }),
      showAddPlan: false,
      planDataList: [], // 抄表计划列表数据
      total: 0,

      // 当前抄表行数据
      formType: 'add',
      curPlan: null,

      // ===============================================
      loadingRemove: false,

      // 抄表计划-抄表册搜索
      planInfoSearch: this.initQueryParams({
        model: {
          readmeterPlanId: '',
        },
      }),
      total2: 0,
      showAddReadMeterBookToPlan: false, // 是否显示添加抄表册组件
      readMeterBookList: [], //操表册信息列表
      multipleSelection: [], // 关联客户多选数据
    }
  },
  created() {
    this.searchPlanList()
  },
  methods: {
    // =======================================
    // 抄表计划搜索
    searchPlanList() {
      if (this.readMeteTime) {
        let timeArr = this.readMeteTime.split('-')
        this.planSearch.model.readMeterYear = timeArr[0]
        this.planSearch.model.readMeterMonth = timeArr[1]
      } else {
        this.planSearch.model.readMeterYear = ''
        this.planSearch.model.readMeterMonth = ''
      }
      apiReadMeterPlan.queryReadMeterPlanInfo(this.planSearch).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.planDataList = data.records
          this.total = parseInt(data.total)
        }
      })
    },

    // 添加抄表计划
    addPlan() {
      this.showAddPlan = true
      this.formType = 'add'
      this.curPlan = null
    },

    // 更新抄表计划
    updatePlan(row) {
      this.showAddPlan = true
      this.curPlan = row
      this.formType = 'edit'
    },

    // 更新抄表计划状态
    updateSatus(row, satus) {
      this.curPlan = row
      let { id, readMeterYear, readMeterMonth } = row
      let updateData = {
        id,
        dataStatus: satus,
        readMeterYear,
        readMeterMonth,
      }
      console.log(row)
      console.log(updateData)
      apiReadMeterPlan.updatePlanStatus(updateData).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.msg('操作成功', 'success')
          this.searchPlanList()
        }
      })
    },

    //  操表计划行点击
    handelRowClick(row) {
      this.curPlan = row
      let id = row.id
      this.planInfoSearch.model.readmeterPlanId = id
      this.getPlanInfoData()
    },

    // 分页数据改变
    pagination(pageData) {
      this.planSearch.size = pageData.size
      this.planSearch.current = pageData.current
      this.searchPlanList()
    },

    // =======================================

    // 分页数据改变
    pagination2(pageData) {
      console.log(pageData)
      this.planInfoSearch.size = pageData.size
      this.planInfoSearch.current = pageData.current
      this.getPlanInfoData()
    },

    // 获取计划下抄表册数据
    getPlanInfoData() {
      apiReadMeterPlan.getPlanInfoData(this.planInfoSearch).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.readMeterBookList = data.records
          this.total2 = parseInt(data.total)
        }
      })
    },

    // 多选操作
    selectionChange(val) {
      this.multipleSelection = val
    },

    // 移除计划
    removeFromPlan() {
      this.loadingRemove = true
      let ids = this.multipleSelection.map(item => {
        return item.id
      })

      apiReadMeterPlan
        .deleteReadMeterWorkInfo(ids)
        .then(res => {
          let { isSuccess } = res.data
          if (isSuccess) {
            this.msg('删除成功', 'success')
            this.getPlanInfoData()
          }
          this.loadingRemove = false
        })
        .catch(err => {
          this.loadingRemove = false
        })
    },

    // 添加
    addReadMeterBook() {
      this.showAddReadMeterBookToPlan = true
    },

    // 导出
    exprot() {
      // 这个地方传递 planId
      // console.log(this.curPlan, this.multipleSelection)
      if (!this.multipleSelection.length) {
        this.$message({
          type: 'warning',
          message: '请先选择抄表册再导出'
        })
        return
      }
      fileStreamDownload(
        '/bizcenter/readmeter/register/readMeterBook/exportReadMeterList',
        this.multipleSelection.map(item => item.id),
        {},
        { name: `抄表计划(${this.curPlan.readMeterYear}-${this.curPlan.readMeterMonth}).xls` }
      )
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 4);
    }
  }

  .userInfo {
    .el-form-item {
      margin-top: 15px;
    }
  }

  ::v-deep .el-card__body {
    padding: 0;
  }
</style>
