<!--抄表业务-->
<template>
  <div class="readmeter-add">
    <!--search-->
    <search-box>
      <el-form ref="searchForm" :inline="true" :model="searchForm.model" :rules="formRules">
      <!-- 缴费编号 -->
      <el-form-item prop="customerChargeNo">
        <el-input v-model="searchForm.model.customerChargeNo" placeholder="缴费编号" />
      </el-form-item>
      <!-- 安装地址 -->
      <el-form-item prop="moreGasMeterAddress">
        <el-input v-model="searchForm.model.moreGasMeterAddress" style="width: auto" placeholder="安装地址" />
      </el-form-item>
      <!-- 小区 -->
      <!-- 抄表员 -->
      <el-form-item prop="readMeterUserId">
        <el-select v-model="searchForm.model.readMeterUserId" clearable filterable placeholder="抄表员">
            <el-option
              v-for="(item,index) in userList"
              :key="index"
              :label="item.userName"
              :value="item.userId"
            >
            </el-option>
          </el-select>
      </el-form-item>
      <!-- 用气类型 -->
      <el-form-item prop="useGasTypeId">
        <el-select v-model="searchForm.model.useGasTypeId" clearable filterable placeholder="用气类型">
          <el-option
            v-for="(item,index) in useGasTypeList"
            :key="index"
            :label="item.useGasTypeName"
            :value="item.id"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 客户编号 -->
      <!-- <el-form-item prop="customerCode">
        <el-input v-model="searchForm.model.customerCode" placeholder="客户编号" />
      </el-form-item> -->
      <!-- 抄表册 -->
      <el-form-item prop="bookId" class="mandatory">
        <el-select v-model="searchForm.model.bookId" filterable clearable placeholder="抄表册">
          <el-option
            v-for="(item,index) in readMeterBookList"
            :key="index"
            :label="item.bookName"
            :value="item.id"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- <el-input v-model="searchCondition.meterNo" placeholder="气表编号" /> -->
      <!-- 客户姓名 -->
      <el-form-item prop="customerName">
        <el-input v-model="searchForm.model.customerName" placeholder="客户名称" />
      </el-form-item>
      <!-- 查询月份 -->
      <el-form-item prop="readTime" class="mandatory" style="margin:0;">
        <el-date-picker
          v-model="searchForm.model.readTime"
          type="month"
          placeholder="抄表年月"
          value-format="yyyy-MM"
          :picker-options="queryPickerOptions"
        ></el-date-picker>
      </el-form-item>

      <!-- 查询 -->
      <el-button type="primary" @click="search">查询</el-button>
      </el-form>
    </search-box>

    <!-- 抄表数据审核 -->
    <el-card shadow="never">
      <div slot="header">
        <search-box style="margin-bottom: 0">
          <div slot="left">
            <span class="card-title">待抄表</span>
          </div>
          <div slot="right">
            <el-button type="success" :disabled="multipleSelection.length === 0 || btnLoading" :loading="btnLoading" @click="batchSave">保存数据</el-button>
          </div>
        </search-box>
      </div>

      <!-- list -->

      <el-table
        ref="multipleTable"
        v-loading="listLoading"
        :data="tableData"
        tooltip-effect="dark"
        border
        style="width: 100%"
        @selection-change="SelectionChange"
      >
        <!-- 选择 -->
        <el-table-column type="selection" width="45" :selectable="setSelectable" />
        <el-table-column type="index" label="#" width="30" />
        <el-table-column prop="customerChargeNo" show-overflow-tooltip label="缴费编号" />
        <el-table-column prop="customerName" label="客户姓名" width="80" />
        <el-table-column prop="gasMeterNumber" show-overflow-tooltip label="表身号" />
        <el-table-column prop="useGasTypeName" show-overflow-tooltip label="用气类型名称	" width="100" />
        <el-table-column prop="moreGasMeterAddress" show-overflow-tooltip label="安装地址" />
        <el-table-column prop="lastTotalGas" label="上期止数" width="80" fixed="right">
          <template slot-scope="{ row }">
            {{ row.lastTotalGas | numberFormat }}
          </template>
        </el-table-column>
        <el-table-column prop="currentTotalGas" label="本期止数" width="80" fixed="right">
          <template slot-scope="{ row, $index }">
            <qc-number-input v-model="row.currentTotalGas" class="table-number-input" :precision="0" :min="+row.lastTotalGas || 0" placeholder="" @blur="handleCurrentTotalGasBlur(row, $index)"></qc-number-input>
          </template>
        </el-table-column>
        <el-table-column prop="monthUseGas" label="本期用量" width="80" fixed="right" />
        <el-table-column prop="readMeterUserName" show-overflow-tooltip label="抄表员" width="70" />
        <!-- <el-table-column label="抄表月" width="70">
          <template #default="{ row }">
            {{ row.readMeterYear }}-{{ row.readMeterMonth }}
          </template>
        </el-table-column> -->
        <el-table-column prop="recordTime" label="抄表日期" width="160" fixed="right">
          <template slot-scope="{row, $index}">
            <el-date-picker
              v-model="row.recordTime"
              style="width: 100%"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="选择日期"
              :default-value="`${row.readMeterYear}-${row.readMeterMonth}`"
              :picker-options="setPickerOptions()"
              @blur="handleRecordTimeBlur(row, $index)"
            />
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <pagination
        :page-sizes="[10, 15, 20]"
        layout="total,sizes, prev, pager, next, jumper"
        :limit="searchForm.size"
        :total="total"
        @pagination="pagination"
      />
    </el-card>
  </div>
</template>

<script>
import { cloneDeep } from 'lodash'
import apiImport from '@/api/readMeter/import.js'
import { parseTime } from '@/utils/index.js'
import { parseDate2Str, initQueryParams } from '@/utils/commons.js'
import { positiveNumberReg, positiveIntegerReg } from '@/utils/reg'
import BN from '@/utils/bigNumber'
import apiReadMeterBook from '@/api/readMeter/readMeterBook'
// 引入用气类型类型接口
import {getUseGasTypeList} from '@/api/operation/gasPrice'
export default {
  name: 'Add',
  components: {
  },
  filters: {
    numberFormat(value) {
      return Number.parseFloat(value)?.toFixed(2) ?? 0
    },
  },
  data() {
    return {
      // 搜索
      searchForm: this.initQueryParams({
        model: {
          moreGasMeterAddress: '', // 	安装地址
          customerName: '', // 客户名称
          customerCode: '', //客户编号
          customerChargeNo: '', //缴费编号
          useGasTypeName: '', // 用气类型名称
          readTime: '', // 抄表年月
          readMeterUserName: '', // 抄表员名称
          bookId:'',//抄表册

          /**
           * 数据状态
           * 未抄表：-1
           * 取消：2
           * 已抄：0
           **/
          dataStatus: -1,

          /*
           * 审核状态
           * 待审核：TO_BE_REVIEWED
           * 提审：SUBMIT_FOR_REVIEW
           * 审核通过（待结算）： APPROVED
           * 审核驳回： REVIEW_REJECTED
           */
          processStatus: 'TO_BE_REVIEWED',

          /**
           * 收费状态
           * 待收费：TO_BE_CHARGED
           * 欠费：ARREARS
           * 已收费（待出票）：CHARGED
           * 已出票：INVOICED
           **/
          chargeStatus: null,
        },
      }),
      //保存修改数据按钮是否可用，true不可用
      btnLoading: false,
      listLoading: false, // 列表加载
      // list
      tableData: [],
      readMeterBookList:{},//抄表册数据
      useGasTypeList:{},//用气类型数据
      userList:{},//抄表员数据
      // 抄表册搜索数据
      readMeterSearchData: {
        current: 1,
        model: {
          bookName: '',
          readMeterUserName: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      total: 0,
      // 高亮选择状态
      curBtn: 'TO_BE_REVIEWED',
      //多选操作
      multipleSelection:[],
      formRules: {
        bookId: [
          { required: true, message: '必填', trigger: 'change' },
        ],
        readTime: [
          { required: true, message: '必填', trigger: 'change' },
        ],
      },
      // 筛选项日期选择配置项
      queryPickerOptions: {
        disabledDate(date) {
          const nowDate = new Date()
          nowDate.setDate(1)
          nowDate.setMonth(nowDate.getMonth() + 1)
          return +new Date(parseTime(nowDate, '{y}-{m}-01 00:00:00')) <= +new Date(date)
        },
      },
      // 日期选择配置项
      pickerOptions: {

      },

    }
  },
  watch: {
  },
  created() {
    // this.search()
    this.getListReadMeterBook()
    this.getUseGasTypeListData()
    this.initUserList()
    this.searchForm.model.readTime = parseTime(new Date(), '{y}-{m}')
  },
  mounted(){

  },
  methods: {
    // 搜索数据
    search() {
      // 处理搜索日期
      let searchForm = JSON.parse(JSON.stringify(this.searchForm))
      let readMeterYear = null
      let readMeterMonth = null
      if (searchForm.model.readTime) {
        readMeterYear = parseInt(searchForm.model.readTime.split('-')[0])
        readMeterMonth = parseInt(searchForm.model.readTime.split('-')[1])
      }
      searchForm.model.readMeterYear = readMeterYear
      searchForm.model.readMeterMonth = readMeterMonth
      delete searchForm.model.readTime
      this.$refs.searchForm.validate((valid) =>{
        if(valid){
          this.listLoading = true
          apiImport.queryReadMeterWorkInfo(searchForm).then(res => {
            let { isSuccess, data } = res.data
            if (isSuccess) {
              this.tableData = data.records
              this.total = parseInt(data.total)
            }
          }).finally(() => (this.listLoading = false))
        }
      })

    },

    // 重置条件
    resetCondition() {
      this.searchForm.model.dataStatus = null
      this.searchForm.model.processStatus = null
      this.searchForm.model.chargeStatus = null
    },

    // 分页数据改变
    pagination(pageData) {
      this.searchForm.size = pageData.size
      this.searchForm.current = pageData.current
      this.search()
    },
    // 分页查询抄表册信息
    getListReadMeterBook() {
      return new Promise((resolve) => {
        apiReadMeterBook.listReadMeterBook(this.readMeterSearchData).then(res => {
          let { isSuccess, data } = res.data
          // console.log({isSuccess, data})
          if (isSuccess) {
            this.readMeterBookList = data?.records || []
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },
    //获取抄表员列表
    async initUserList() {
        const queryParams = initQueryParams({
          model: {
            roleCode: 'METER_READER'
          }
        })
        const { data: res } = await apiReadMeterBook.getUserList(queryParams)
        if (res.isSuccess) {
          this.userList = res.data.records.map(item => ({
            ...item,
            value: item.userName
          }))
        }
      },
    // 获取所有用气类型名称
    getUseGasTypeListData(params = {}) {
        if (this.useGasTypeList.length > 0) {
        return true
        }
        return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({ size: 10000, ...params })).then((result) => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
            const { total, records } = data
            this.useGasTypeList = records
            resolve(records)
            } else {
            resolve(false)
            }
        }).catch(() => {
            resolve(false)
        })
        })
    },
    // 批量保存
    async batchSave() {
      const cloneData = cloneDeep(this.multipleSelection)
      const { parseInt } = Number
      const generateData = cloneData.map((item) => {
        return {
          id: item.id,
          lastTotalGas: parseInt(item.lastTotalGas),
          currentTotalGas: parseInt(item.currentTotalGas),
          monthUseGas: parseInt(item.monthUseGas),
          recordTime: item.recordTime,
          gasMeterCode: item.gasMeterCode,
          readMeterYear: parseInt(item.readMeterYear),
          readMeterMonth: parseInt(item.readMeterMonth),
        }
      })
      this.btnLoading = true
      const { data: res } = await apiImport.updateList(generateData)
      this.btnLoading = false
      if (res.isSuccess) {
        this.msg('保存数据成功','success')
        this.search()
        this.$emit('success')
      }
    },
    // 多选操作
    SelectionChange(val) {
      this.multipleSelection = val
    },
    setPickerOptions() {
      const searchDate = this.searchForm.model.readTime
      const pickerOptions = {
        disabledDate(date) {
          const currentTime = +new Date(date)
          // 参照日期
          const referDate = `${searchDate}-01 00:00:00`
          // const referDateObj = new Date(referDate)
          // 开始日期
          const startTime = +new Date(referDate)

          // 结束日期
          // const endDate = new Date(referDate)
          // endDate.setMonth(endDate.getMonth() + 1)
          // const endTime = +endDate

          // 当前时间
          const nowTime = +Date.now()
          return currentTime < startTime ||  currentTime > nowTime
        }
      }
      return pickerOptions
    },

    //验证本期止数
    validateCurrentTotalGas(row, showMsg = true) {
      const { currentTotalGas, lastTotalGas } = row
      if (!positiveIntegerReg.test(currentTotalGas) || +lastTotalGas > +currentTotalGas) {
        showMsg && this.$message.error('本期止数必须大于等于上期止数')
        return false
      }
      return true
    },

    // 验证抄表日期
    validateRecordTime(row, showMsg = true) {
      const { recordTime } = row
      if (!recordTime) {
        showMsg && this.$message.error('抄表日期不能为空')
        return false
      }
      return true
    },

    // 设置多选框是否选中
    setRowSelection(row, selected) {
      this.$refs.multipleTable?.toggleRowSelection(row, selected)
    },

    // 计算本期用量
    calcMonthUseGas(row, fillValue = true) {
      const { currentTotalGas, lastTotalGas } = row
      const monthUseGas = Number.parseFloat(BN.minus(+currentTotalGas || 0, +lastTotalGas || 0)).toFixed(2)
      if (fillValue) {
        row.monthUseGas = monthUseGas
      }
      return monthUseGas
    },

    handleCurrentTotalGasBlur(row) {
      let flag = false
      if (this.validateCurrentTotalGas(row)) {
        this.calcMonthUseGas(row)
        if (this.validateRecordTime(row, false)) {
          flag = true
        }
      }
      this.setRowSelection(row, flag)
    },

    handleRecordTimeBlur(row) {
      let flag = false
      if (this.validateRecordTime(row)) {
        if (this.validateCurrentTotalGas(row, false)) {
          this.calcMonthUseGas(row)
          flag = true
        }
      }
      this.setRowSelection(row, flag)
    },

    // 设置该行多选框是否可以选择
    setSelectable(row, index) {
      const { monthUseGas } = row
      return this.validateCurrentTotalGas(row, false) && this.validateRecordTime(row, false) && +monthUseGas === +this.calcMonthUseGas(row, false)
    },
  },
}
</script>
<style lang="scss" scoped>
  .mandatory::after{
    content:'*';
    display: inline-block;
    color: red;
    padding:2px;
  }
 ::v-deep .searchBox .el-input{
    margin:0;
  }
  .readmeter-add {
    ::v-deep {
      .table-number-input {
        .el-input__inner {
          padding: 0 5px;
        }
      }
    }
  }
</style>
