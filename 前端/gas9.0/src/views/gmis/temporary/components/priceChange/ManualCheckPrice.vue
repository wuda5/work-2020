
<!--手动录入调价补差核算-->
<template>
  <div class="ManualCheckPrice-page">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :model="searchForm" inline class="qc-search-form" :rules="formRules">
        <!--时间范围-->
        <el-form-item label="" prop="rangeTime">
            <el-date-picker
                v-model="searchForm.rangeTime"
                type="daterange"
                clearable
                :start-placeholder="$t('核算开始日期')"
                :end-placeholder="$t('核算结束日期')"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd"
            >
            </el-date-picker>
        </el-form-item>
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input
            v-model="searchForm.customerChargeNo"
            clearable
            :placeholder="$t('meterInfo.customerChargeNo')"
          >
          </el-input>
        </el-form-item>
          <!-- 表身号 -->
          <el-form-item>
              <el-input v-model="searchForm.gasMeterNumber" clearable placeholder="表身号" />
          </el-form-item>
          <el-form-item prop="useGasTypeId">
              <el-select v-model="searchForm.useGasTypeId" name="useGasTypeId" collapse-tags clearable filterable placeholder="用气类型">
                  <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id"></el-option>
              </el-select>
          </el-form-item>
          <el-form-item>
              <el-input v-model="searchForm.customerName" clearable placeholder="客户名称" />
          </el-form-item>
          <!-- <el-form-item>
              <el-input v-model="searchForm.gasCode" placeholder="气表编号" />
          </el-form-item> -->
          <el-form-item>
              <el-input v-model="searchForm.moreGasMeterAddress" clearable placeholder="安装地址" />
          </el-form-item>
          <el-form-item>
              <el-button type="primary" class="width100" :loading="btnLoading" :disabled="btnLoading" @click="handleSearch">查询</el-button>
          </el-form-item>
      </el-form>
    </search-box>
    <el-card shadow="never" class="">
        <template v-slot:header>
          <search-box class="search-box">
            <div slot="left"><span class="card-title">表具档案列表</span></div>
            <!-- 操作按钮 -->
            <div slot="right">
              <el-form :ref="searchFormRef" :model="searchForm" inline class="qc-search-form flex-form manual-form" :rules="formRules">
                <!--时间范围-->
                <!-- <el-form-item label="选择核算日期范围" prop="rangeTime">
                    <el-date-picker
                        v-model="searchForm.rangeTime"
                        type="daterange"
                        clearable
                        :start-placeholder="$t('核算开始日期')"
                        :end-placeholder="$t('核算结束日期')"
                        :picker-options="pickerOptions"
                        value-format="yyyy-MM-dd"
                    >
                    </el-date-picker>
                </el-form-item> -->
              </el-form>
              <!-- 批量保存数据 -->
              <!-- <el-button
                type="primary"
                :disabled="btnLoading || multipleSelection.length === 0"
                @click="handleBatchSaveData"
              >
                {{ $t('批量保存数据') }}
              </el-button> -->
            </div>
          </search-box>
        </template>
        <!--核算列表-->
        <div class="tableDelete">
            <el-table
              :ref="listRef"
              v-loading="listLoading"
              :data="list"
              tooltip-effect="dark"
              stripe
              border
              :highlight-current-row="false"
              @selection-change="handleSelectionChange"
            >
              <!-- 多选框 -->
              <el-table-column
                align="center"
                type="selection"
                width="40px"
                :reserve-selection="false"
                :selectable="setSelectable"
              />
              <!-- 序号 -->
              <el-table-column type="index" :label="$t('table.index')"></el-table-column>
              <!-- 缴费编号 -->
              <el-table-column
                prop="customerChargeNo"
                :label="$t('meterInfo.customerChargeNo')"
                show-overflow-tooltip
                width="120"
              >
              </el-table-column>
              <!-- 表身号 -->
              <el-table-column
                prop="gasMeterNumber"
                :label="$t('meterInfo.gasMeterNumber')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <!-- 气表类型 -->
              <el-table-column
                prop="orderSourceName"
                :label="$t('meterInfo.gasMeterTypeName')"
                show-overflow-tooltip
              >
                <template #default="{ row }">
                  {{ gasMeterTypeMap[row.orderSourceName] }}
                </template>
              </el-table-column>
              <el-table-column
                  prop="useGasTypeName"
                  label="用气类型"
              >
              </el-table-column>
              <!-- 气表厂家 -->
              <el-table-column
                prop="gasMeterFactoryName"
                :label="$t('meterInfo.gasMeterFactoryName')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <!-- 气表版号 -->
              <el-table-column
                prop="gasMeterVersionName"
                :label="$t('meterInfo.gasMeterVersionName')"
                show-overflow-tooltip
                width="90"
              >
              </el-table-column>
              <!-- 气表型号 -->
              <el-table-column
                prop="gasMeterModelName"
                :label="$t('meterInfo.gasMeterModelName')"
                show-overflow-tooltip
                width="90"
              >
              </el-table-column>
              <!-- 安装地址 -->
              <el-table-column
                prop="moreGasMeterAddress"
                :label="$t('meterInfo.moreGasMeterAddress')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <el-table-column prop="compensationGas" label="补差量" fixed="right">
                <template slot-scope="{ row, $index }">
                  <qc-number-input v-model="row.compensationGas" class="table-number-input" :precision="0" :min="0" placeholder="" @blur="handleCompensationGasBlur(row, $index)"></qc-number-input>
                </template>
              </el-table-column>
              <el-table-column prop="compensationPrice" label="补差价格" fixed="right">
                  <template slot-scope="{ row, $index }">
                    <qc-number-input v-model="row.compensationPrice" class="table-number-input" :precision="2" placeholder="" @blur="handleCompensationPriceBlur(row, $index)"></qc-number-input>
                </template>
              </el-table-column>
              <el-table-column prop="compensationMoney" label="补差金额" fixed="right" />
            </el-table>
            <!--分页-->
            <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            @pagination="getList()"
            />
            <div class="change-step-box bottom text-right">
                <el-button type="primary" size="medium" class="button" :disabled="btnLoading" :loading="btnLoading" round @click="nextStep()">下一步</el-button>
            </div>
        </div>
    </el-card>
  </div>
</template>

<script>
import { merge, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import meterMixin from '@/mixins/meter'
import { meterStatusField, orderSourceNameField, amountMarkField } from '@/enums/meterInfo'
import { parseTime } from '@/utils/index'
import { positiveNumberReg, numberReg } from '@/utils/reg'
import BN from '@/utils/bigNumber'
import { saveAdjustPriceData, getAdjustPriceMeterListData } from '@/api/temporary/checkPrice'

export default {
  name: 'ManualCheckPrice',
  components: {

  },
  filters: {
  },
  mixins: [commonMixin, listMixin, meterMixin],
  props: {
    // 用气类型列表
    useGasTypeList: Array,
  },
  data() {
    return {
      // 查询条件
      searchForm: {
          rangeTime: [parseTime(Date.now(), '{y}-{m}-01'), parseTime(Date.now(), '{y}-{m}-{d}')],
          checkStartTime: parseTime(Date.now(), '{y}-{m}-01'),
          checkEndTime: parseTime(Date.now(), '{y}-{m}-{d}'),
          useGasTypeId:'',
          customerName:'',
          moreGasMeterAddress:'',
          gasMeterNumber:'',
          customerChargeNo: null, // 缴费编号
          dataStatus: [meterStatusField.YTQ], // 气表状态
          orderSourceName: [orderSourceNameField.IC_RECHARGE, orderSourceNameField.REMOTE_RECHARGE],
          amountMark: amountMarkField.MONEY, // 金额标志
      },
      //表单验算规则
      formRules:{
        rangeTime: [
            { required: true, message: '请选择核算时间范围', trigger: ['blur', 'change'] }
        ],
      },
      pickerOptions: {
        disabledDate(date) {
          return +new Date(date) > +Date.now()
        }
      },
    }
  },
  computed: {

  },
  watch: {
    'searchForm.rangeTime'(data) {
      this.searchForm.checkStartTime = (data || [])[0] || ''
      this.searchForm.checkEndTime = (data || [])[1] || ''
    },
  },
  created() {
    // this.initData()
  },
  mounted() {

  },
  activated() {
    // console.log('ManualCheckPrice被激活了')
    this.getList()
  },
  destroyed() {

  },
  methods: {
    async initData() {
       await this.getList()
    },
    // 获取列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        params = merge({pageNo: this.queryParams.current, pageSize: this.queryParams.size}, this.searchForm, params)
        getAdjustPriceMeterListData(params).then((result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            const {total, records} = data
            records.forEach((item) => {
              Object.assign(item, { compensationGas: null, compensationPrice: null, compensationMoney: null })
            })
            this.total = total
            this.list = records
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => (this.listLoading = false))
      })
    },
    
    //下一步跳到审核页面
    async nextStep(){
      const saveResult = await this.handleBatchSaveData()
      if (saveResult) {
        this.$emit('change-step', false);
      }
    },

    // '补差量验证
    validateCompensationGas(value, showMsg = true) {
      if (!positiveNumberReg.test(value) || +value <= 0) {
        showMsg && this.$message.error('补差量必须大于0')
        return false
      }
      return true
    },

    // 补差价格验证
    validateCompensationPrice(value, showMsg = true) {
      if (!numberReg.test(value)) {
        showMsg && this.$message.error('补差价格必须是数字')
        return false
      }
      return true
    },

    // 计算补差金额
    calcCompensationMoney(row, fillValue = true) {
      const { compensationPrice, compensationGas, compensationMoney } = row
      const currentCompensationMoney = BN.toFixed(BN.times(compensationGas, compensationPrice), 2)
      if (fillValue && +currentCompensationMoney!== +compensationMoney){
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

    // 设置该行多选框是否可以选择
    setSelectable(row, index) {
      const { compensationPrice, compensationGas, compensationMoney } = row
      return this.validateCompensationPrice(compensationPrice, false) && this.validateCompensationGas(compensationGas, false) && +compensationMoney === +this.calcCompensationMoney(row, false)
    },

    // 批量保存核算数据
    handleBatchSaveData() {
      if (this.multipleSelection.length === 0) {
        return true
      }
      return new Promise((resolve) => {
        this.$refs[this.searchFormRef].validate((valid) => {
          if (valid) {
            this.btnLoading = true
            const cloneData = cloneDeep(this.multipleSelection)
            saveAdjustPriceData(cloneData.map((item) => {
              return {
                ...item,
                checkStartTime: this.searchForm.checkStartTime,
                checkEndTime: this.searchForm.checkEndTime,
              }
            })).then((response) => {
              const { isSuccess } = response.data
              if (isSuccess) {
                this.$message.success('核算数据保存成功')
              }
              resolve(isSuccess)
            })
            .catch(() => (resolve(false)))
            .finally(() => (this.btnLoading = false))
          } else {
            this.$message.error(this.$t('请先选择核算时间范围'))
            resolve(false)
          }
        })
      })
    },

    handleSearch() {
      this.$refs[this.searchFormRef].validate((valid) => {
        if (valid) {
          this.getList()
        } else {
          this.$message.error(this.$t('validateError'))
        }
      })
    },
  }
}
</script>

<style scoped lang="scss">
    .ManualCheckPrice-page {
        ::v-deep {
            .el-form-item {
                margin-bottom: 18px;
            }
            .manual-form {
              .el-form-item {
                margin-bottom: 0;
              }
            }
            .el-table {
              .el-input__inner {
                padding: 0 5px;
              }
            }
        }
    }
</style>
