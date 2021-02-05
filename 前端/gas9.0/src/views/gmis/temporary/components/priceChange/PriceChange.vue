<!--调价补差-->
<template>
  <div class="PriceChange-container">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <!--form-->
      <el-form :ref="searchFormRef" :model="searchForm" inline class="qc-search-form">
        <!--时间范围-->
        <el-form-item label="" prop="rangeTime">
            <el-date-picker
                v-model="searchForm.rangeTime"
                type="daterange"
                clearable
                :start-placeholder="$t('开始日期')"
                :end-placeholder="$t('结束日期')"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd"
            >
            </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-select
            v-model="searchForm.useGasTypeIds"
            name="useGasTypeId"
            multiple
            collapse-tags
            clearable
            filterable
            placeholder="用气类型"
          >
            <el-option
              v-for="(item, index) in useGasTypeList"
              :key="index"
              :label="item.useGasTypeName"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-input v-model="searchForm.customerName" placeholder="客户名称" />
        </el-form-item>
        <!-- 缴费编号 -->
        <el-form-item>
          <el-input v-model="searchForm.customerChargeNo" placeholder="缴费编号" />
        </el-form-item>
        <!-- <el-form-item>
          <el-input v-model="searchForm.gasCode" placeholder="气表编号" />
        </el-form-item> -->
        <!-- 表身号 -->
        <el-form-item>
          <el-input v-model="searchForm.gasMeterNumber" placeholder="表身号" />
        </el-form-item>
        <!-- <el-form-item style="width: calc(100%/5*2)">
          <el-date-picker v-model="searchForm.gasMeterAddress" placeholder="安装地址" />
        </el-form-item> -->
        <el-form-item>
          <el-button type="primary" class="width100" @click="getListData">查询</el-button>
        </el-form-item>
      </el-form>
    </search-box>
    <el-card shadow="never" class="no-border">
      <template v-slot:header>
        <search-box class="search-box">
          <template v-slot:left>
            <span class="card-title">调价补差数据列表</span>
          </template>
          <!-- 操作区域 -->
          <template v-slot:right>
            <el-button v-if="curBtn == 'TO_BE_REVIEWED'" type="primary" :disabled="btnLoading || multipleSelection.length === 0" @click="saveCaculate">核算</el-button>
            <!-- <el-button type="primary">提审</el-button> -->
            <el-button v-if="curBtn == 'SUBMIT_FOR_REVIEW'" type="primary" :disabled="btnLoading || multipleSelection.length === 0" @click="examineData">审核</el-button>
            <el-button v-if="curBtn == 'SUBMIT_FOR_REVIEW'" type="primary" :disabled="btnLoading || multipleSelection.length === 0" @click="withdrawData">撤回</el-button>
            <el-button v-if="curBtn == 'SUBMIT_FOR_REVIEW'" type="primary" :disabled="btnLoading || multipleSelection.length === 0" @click="rejectData">驳回</el-button>
            <el-button v-if="curBtn == 'NO_CHARGE'" type="primary" :disabled="btnLoading || multipleSelection.length === 0" @click="withdrawChargeData">撤销收费</el-button>
            <!-- 打印缴费通知 -->
            <!-- <el-button v-if="curBtn == 'CHARGED'" :disabled="btnLoading || multipleSelection.length === 0" type="primary">打印缴费通知</el-button> -->
          </template>
        </search-box>
      </template>
      <div class="clearfix"></div>
      <div class="butGroup">
        <div class="fl">
          <el-button 
          type="primary"
          :plain="curBtn !== 'TO_BE_REVIEWED'"
          @click="changeProcessStatus(0,'TO_BE_REVIEWED')"
          >待核算</el-button>
          <el-button 
          type="primary"
          :plain="curBtn !== 'SUBMIT_FOR_REVIEW'"
          @click="changeProcessStatus(1,'SUBMIT_FOR_REVIEW')"
          >待审</el-button>
          <el-button 
          type="primary"
          :plain="curBtn !== 'NO_CHARGE'"
          @click="changeProcessStatus(2,'NO_CHARGE')"
          >待收费</el-button>
          <el-button 
          type="primary"
          :plain="curBtn !== 'CHARGED'"
          @click="changeProcessStatus(3,'CHARGED')"
          >已收费</el-button>
        </div>
      </div>
      <!--入库列表-->
      <div class="tableDelete">
        <el-table
          :ref="listRef"
          :data="list"
          :loading="listLoading"
          tooltip-effect="dark"
          style="width: 100%"
          stripe
          height="400"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="55" />
          <el-table-column type="index" label="序号" />
          <el-table-column label="缴费编号" prop="customerChargeNo" />
          <!-- <el-table-column label="客户编号" prop="customerCode" /> -->
          <el-table-column prop="customerName" label="客户姓名" />
          <!-- <el-table-column label="气表编号" prop="gasmeterCode" /> -->
          <!-- <el-table-column label="表身号" prop="gasMeterNumber" /> -->
          <el-table-column label="表身号" prop="bodyNumber" />
          <el-table-column prop="customerTypeName" label="客户类型" />
          <el-table-column prop="useGasTypeName" label="用气类型">
            <template #default="scope">
              {{ useGasTypeNameFormat(scope.row.useGasTypeId) }}
            </template>
          </el-table-column>
          <el-table-column prop="compensationGas" label="补差量">
            <template slot-scope="{ row, $index }">
              <qc-number-input v-if="IS_TO_BE_REVIEWED" v-model="row.compensationGas" class="table-number-input" :precision="0" :min="0" placeholder="" @blur="handleCompensationGasBlur(row, $index)"></qc-number-input>
              <span v-else>{{ row.compensationGas }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="compensationPrice" label="补差价格">
              <template slot-scope="{ row, $index }">
                <qc-number-input v-if="IS_TO_BE_REVIEWED" v-model="row.compensationPrice" class="table-number-input" :precision="2" placeholder="" @blur="handleCompensationPriceBlur(row, $index)"></qc-number-input>
                <span v-else>{{ row.compensationPrice }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="compensationMoney" label="补差金额" />
          <el-table-column prop="source" label="来源">
            <template #default="scope">
              {{ scope.row.source | sourceFormat }}
            </template>
          </el-table-column>
          <el-table-column prop="checkStartTime" label="核算日期" width="160">
            <template #default="{ row }">
              {{ row.checkStartTime | checkRangeTime(row.checkEndTime) }}
            </template>
          </el-table-column>
          <el-table-column prop="dataStatus" label="补差状态">
            <template #default="scope">
              {{ scope.row.dataStatus | dataStatusFormat }}
            </template>
          </el-table-column>
          <el-table-column prop="reviewObjection" label="驳回原因" width="80" show-overflow-tooltip />
        </el-table>
        <!--分页-->
        <pagination
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="getListData()"
        />
      </div>
      <!-- 驳回弹窗 -->
      <qc-dialog :width="400" title="驳回" :visible.sync="showRejectReason" @close="dialogClose">
        <reject-reason
          v-if="showRejectReason"
          v-model="rejectedMsg"
          @submit="submitReject"
        />
      </qc-dialog>
      <div class="change-step-box bottom text-right">
          <el-button type="primary" size="medium" class="button" round @click="preStep()">上一步</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, isUndefined, isNull } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { formStatusField } from '@/enums/form'
import RejectReason from '@/components/QcPopUpWindow/RejectReason.vue' // 驳回
// 引入业务运营配置下 燃气类型接口
import { getUseGasTypeList } from '@/api/operation/gasPrice'
import { initQueryParams } from '@/utils/commons'
import { positiveNumberReg, numberReg } from '@/utils/reg'
import BN from '@/utils/bigNumber'
import {
  page,
  examine,
  caculate,
  reject,
  withdraw,
  withdrawCharge,
} from '@/api/temporary/priceChange'

const sourceMap = {
  0: '抄表',
  1: '充值',
  2: '人工录入',
}

export default {
  name: 'PriceChange',
  components:{
    RejectReason
  },
  filters: {
    //来源
    sourceFormat(value) {
      return sourceMap[+value]
    },
    //补差状态
    dataStatusFormat(value) {
      return +value === 0 ? '待核算' : +value === 1 ? '待审' : +value === 2 ? '待收费' : '已收费'
    },
    // 核算日期
    checkRangeTime(startTime, endTime) {
      let result = ''
      if (startTime) {
        result+= `${startTime}至`
      }
      if (endTime) {
        result+= endTime
      }
      return result
    },
  },
  mixins: [commonMixin, listMixin],
  props: {
    // 用气类型列表
    useGasTypeList: Array,
    // 用气类型
    useGasTypeId: Array,
  },
  data() {
    return {
      // 收费表单
      searchForm: {
          rangeTime: '',
          startTime:'',
          endTime:'',
          useGasTypeIds: [],
          customerName:'',
          gasCode:'',
          /**
           * 数据状态
           * 待核算:0
           * 待审：1
           * 待收费：2
           * 已收费：3
           **/
          compensationState: 0,
          customerChargeNo: '',
          gasMeterNumber: '',
        
        // gasMeterAddress:'',
      },
      //驳回原因
      rejectedMsg: '',
      // 高亮选择状态
      curBtn: 'TO_BE_REVIEWED',
      //核算按钮是否可用,true不可用
      selectList:[],//已编辑的数据
      currentPage:'1',//当前页
      showRejectReason:false, //驳回原因弹窗
      pickerOptions: {},
    }
  },
  computed: {
    // 是否可核算
    IS_TO_BE_REVIEWED() {
      return this.curBtn === 'TO_BE_REVIEWED'
    },
  },
  watch: {
    'searchForm.rangeTime'(data) {
      this.searchForm.startTime = (data || [])[0] || ''
      this.searchForm.endTime = (data || [])[1] || ''
    },
  },
  created() {
      this.initData()
    },
  mounted(){
  },
  methods: {
    //根据用气类型id显示用气类型
    useGasTypeNameFormat(useGasTypeId) {
      return this.useGasTypeList.find((item) => item.id === useGasTypeId)?.useGasTypeName || ''
    },
    // 初始化数据
    async initData() {
      if (this.useGasTypeId?.length > 0) {
        this.searchForm.useGasTypeIds = this.useGasTypeId
      }
      await this.getListData()
    },
    //获取调价补差列表数据          
    async getListData(){
      return new Promise((resolve) => {
          this.listLoading = true
          page(this.searchForm, { current: this.queryParams.current, size: this.queryParams.size }).then((result)=>{
              const { isSuccess, data } = result.data
              if (isSuccess) {
                const { total, records } = data
                this.total = total
                this.list = records
                resolve(records)
              } else {
                resolve(false)
              }
          }).catch(() => (resolve(false))).finally(() => (this.listLoading = false))
      })
    },
    //查询
    queryListData() {
      this.getListData()
    },

    //批量核算
    saveCaculate(row) {
      this.btnLoading = true
      return new Promise(resolve => {
        caculate(this.multipleSelection)
          .then(result => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
              this.$message.success('修改成功', 'success')
              this.getListData()
              resolve(true)
            } else {
              resolve(false)
            }
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.btnLoading = false))
      })
    },
    //审核
    examineData() {
      this.btnLoading = true
      return new Promise(resolve => {
        examine(this.multipleSelection)
          .then(result => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
              this.$message.success('提交成功')
              this.getListData()
              resolve(true)
            } else {
              resolve(false)
            }
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.btnLoading = false))
      })
    },
    //撤回
    withdrawData() {
      this.btnLoading = true
      return new Promise(resolve => {
        withdraw(this.multipleSelection)
          .then(result => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
              this.$message.success('提交成功')
              this.getListData()
              resolve(true)
            } else {
              resolve(false)
            }
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.btnLoading = false))
      })
    },
    //驳回原因
    rejectData(){
      this.rejectedMsg = ''
      this.showRejectReason = true;
    },
    //驳回
    submitReject() {
      this.multipleSelection.map((item) => {
        item.reviewObjection = this.rejectedMsg
      })
        const cloneData = cloneDeep(this.multipleSelection)
        return new Promise(resolve => {
          reject(cloneData)
            .then(result => {
              const { isSuccess, data } = result.data
              if (isSuccess) {
                this.$message.success('提交成功')
                this.showRejectReason = false
                this.getListData()
                resolve(true)
              } else {
                resolve(false)
              }
            })
            .catch(() => {
              resolve(false)
            })
        })
    },
    //撤销收费
    withdrawChargeData() {
      this.btnLoading = true
      return new Promise(resolve => {
        withdrawCharge(this.multipleSelection)
          .then(result => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
              this.$message.success('提交成功')
              this.getListData()
              resolve(true)
            } else {
              resolve(false)
            }
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.btnLoading = false))
      })
    },
    // 审核、收费状态
    changeProcessStatus(status,code) {
      this.searchForm.compensationState = status;
      this.curBtn = code
      this.getListData()
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    //获取当前页
    handleCurrentChange(val){
      this.currentPage = val;
    },
    //上一步
    preStep() {
      this.$emit('change-step', true)
    },
    dialogClose(){
      this.showRejectReason = false
    },
    
    // '补差量验证
    validateCompensationGas(value, showMsg = true) {
      if (!positiveNumberReg.test(value) || +value <= 0) {
        showMsg && this.$message.error('补差量必须大于0')
        return false
      }
      return true
    },

    // 判断哪些输入值不需要进行验证
    checkNotValidateValue(value) {
      return isNull(value) || isUndefined(value) || value === ''
    },

    // 补差价格验证
    validateCompensationPrice(value, showMsg = true) {
      if (!this.checkNotValidateValue(value) && !numberReg.test(value)) {
        showMsg && this.$message.error('补差价格必须是数字')
        return false
      }
      return true
    },

    // 计算补差金额
    calcCompensationMoney(row, fillValue = true) {
      const { compensationPrice, compensationGas, compensationMoney } = row
      const currentCompensationMoney = BN.toFixed(BN.times(compensationGas, compensationPrice), 2)
      if (!this.checkNotValidateValue(compensationPrice) && fillValue && +currentCompensationMoney!== +compensationMoney){
        row.compensationMoney = currentCompensationMoney
      }
      return currentCompensationMoney
    },

    // 设置多选框是否选中
    setRowSelection(row, selected) {
      this.$refs[this.listRef]?.toggleRowSelection(row, selected)
    },

    // 补差量失去焦点
    handleCompensationGasBlur(row) {
      const { compensationGas, compensationPrice } = row
      let flag = false
      if (this.validateCompensationGas(compensationGas) && this.validateCompensationPrice(compensationPrice, false)) {
        this.calcCompensationMoney(row)
        flag = true
      }
      this.setRowSelection(row, flag)
    },

    // 补差价格失去焦点
    handleCompensationPriceBlur(row) {
      const { compensationGas, compensationPrice } = row
      let flag = false
      if (this.validateCompensationPrice(compensationPrice) && this.validateCompensationGas(compensationGas, false)) {
        this.calcCompensationMoney(row)
        flag = true
      }
      this.setRowSelection(row, flag)
    },

  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}

// 设置表格头部背景
::v-deep .el-table th {
  background-color: #f5f7fa !important;
}
//修改分页符样式
::v-deep .el-pagination{
    padding:15px !important
}
::v-deep .el-pagination__rightwrapper{
    float:left;
  }

.width30{
  width: 40% !important;
}
.butGroup{
  // margin-bottom:15px;
  overflow: hidden;
}
.tableDelete {
  margin-top: 15px;
  // border-top: 1px solid #eee;
  // padding: 15px;
  // text-align: right;
  overflow: hidden;

  b {
    float: left;
  }

  // .el-button {

  // }
}

.el-table {
  border: 1px solid #ccc;
}

.jh-text {
  .el-form-item {
    width: calc(100% / 5);
    margin-bottom: 10px;
  }
}
.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  float: right;
}
</style>
