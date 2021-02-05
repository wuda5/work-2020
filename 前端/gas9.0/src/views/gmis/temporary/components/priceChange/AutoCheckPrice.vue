
<!--自动调价补差核算-->
<template>
  <div class="autoCheckPrice-page">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :model="searchForm" inline class="qc-search-form" :rules="formRules">
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
          <el-form-item prop="useGasTypeId">
              <el-select v-model="searchForm.useGasTypeId" name="useGasTypeId" collapse-tags clearable filterable placeholder="用气类型">
                  <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id"></el-option>
              </el-select>
          </el-form-item>
          <el-form-item>
              <el-input v-model="searchForm.customerName" placeholder="客户名称" />
          </el-form-item>
          <!-- 表身号 -->
          <el-form-item>
              <el-input v-model="searchForm.gasMeterNumber" placeholder="表身号" />
          </el-form-item>
          <!-- <el-form-item>
              <el-input v-model="searchForm.gasCode" placeholder="气表编号" />
          </el-form-item> -->
          <el-form-item>
              <el-input v-model="searchForm.moreGasMeterAddress" placeholder="安装地址" />
          </el-form-item>
          <el-form-item>
              <el-button type="primary" class="width100" :loading="btnLoading" :disabled="btnLoading" @click="handleAdjustPriceData">生成核算</el-button>
          </el-form-item>
      </el-form>
    </search-box>
    
    <el-card shadow="never" class="">
        <template v-slot:header>
          <search-box class="search-box">
            <div slot="left"><span class="card-title">核算记录列表</span></div>
          </search-box>
        </template>
        <!--核算列表-->
        <div class="tableDelete">
            <el-table
                ref="listRef"
                v-loading="listLoading"
                :data="list"
                tooltip-effect="dark"
                style="width: 100%"
                stripe
                @selection-change="handleSelectionChange"
            >
                <el-table-column
                    type="selection"
                    width="55"
                    :selectable="setSelectable"
                />
                <el-table-column
                    type="index"
                    label="序号"
                />
                <el-table-column
                    label="开始时间"
                    prop="startTime"
                />
                <el-table-column
                    prop="endTime"
                    label="结束时间"
                />
                <el-table-column
                    prop="useGasTypeId"
                    label="用气类型"
                >
                    <template #default="scope">
                        {{ useGasTypeNameFormat(scope.row.useGasTypeId) }} 
                    </template>
                </el-table-column>
                <el-table-column
                    prop="accountingTime"
                    label="核算时间"
                />
                <el-table-column
                    prop="dataStatus"
                    label="核算状态"
                >
                    <template #default="scope">
                        {{ scope.row.dataStatus | dataStatusFormat }}
                    </template>
                </el-table-column>
                <!-- 操作 -->
                <el-table-column
                    fixed="right"
                    label="操作"
                    width="100"
                >
                    <template #default="{ row }">
                        <el-button v-if="row.dataStatus==2" type="primary" name="row-edit" @click.native="retry(row)">重试</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!--分页-->
            <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            @pagination="getList()"
            />
            <div class="change-step-box bottom text-right">
                <el-button type="primary" size="medium" class="button" round @click="nextStep()">下一步</el-button>
            </div>
        </div>
    </el-card>
  </div>
</template>

<script>
import { uniq } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { getListData, adjustPriceData,retryCaculation } from '@/api/temporary/checkPrice'
import { parseTime } from '@/utils/index'

export default {
  name: 'AutoCheckPrice',
  components: {

  },
  filters: {
    dataStatusFormat(value) {
      return +value === 0 ? '核算中' : +value === 1?'核算完成':'核算失败'
    },
  },
  mixins: [commonMixin, listMixin],
  props: {
    // 用气类型列表
    useGasTypeList: Array,
  },
  data() {
    return {
      // 查询条件
      searchForm: {
          rangeTime: [parseTime(Date.now(), '{y}-{m}-01'), parseTime(Date.now(), '{y}-{m}-{d}')],
          startTime: parseTime(Date.now(), '{y}-{m}-01'),
          endTime: parseTime(Date.now(), '{y}-{m}-{d}'),
          useGasTypeId:'',
          customerName:'',
          gasCode:'',
          moreGasMeterAddress:'',
          gasMeterNumber:'',
      },
      //表单验算规则
      formRules:{
          rangeTime: [
              { required: true, message: '请选择时间范围', trigger: 'blur' }
          ],
          useGasTypeId: [
              { required: true, message: '用气类型不能为空', trigger: 'change' }
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
      this.searchForm.startTime = (data || [])[0] || ''
      this.searchForm.endTime = (data || [])[1] || ''
    },
  },
  created() {
    // this.initData()
  },
  mounted() {

  },
  activated() {
    // console.log('AutoCheckPrice被激活了')
    this.getList()
  },
  destroyed() {

  },
  methods: {
    async initData() {
       await this.getList()
    },
    async getList(params = {}) {
       return new Promise((resolve) => {
          return new Promise((resolve) => {
              this.listLoading = true
              getListData(this.initQueryParams({ size: this.queryParams.size, current: this.queryParams.current })).then((result) => {
              const { isSuccess, data } = result.data
              if (isSuccess) {
                  const { total, records } = data
                  this.total = total
                  this.list = records
                  resolve(records)
              } else {
                  resolve(false)
              }
              }).catch(() => {
                resolve(false)
              }).finally(() => {
                this.listLoading = false
              })
          })
       })
    },
    
    //生成核算
    handleAdjustPriceData(){
        this.$refs[this.searchFormRef].validate(async(valid) => {
            if (valid) {
                this.btnLoading = true
                adjustPriceData(this.searchForm).then((result) => {
                  const { isSuccess, data } = result.data
                  if (isSuccess) {
                    this.$message.success('核算生成成功')
                    // 重置筛选条件
                    this.$refs[this.searchFormRef].resetFields()
                    this.getList()
                    this.$emit('success')
                  }
                }).catch(() => {
                }).finally(() => {
                  this.btnLoading = false
                })
            } else {
            this.$message.error(this.$t('validateError'))
            }
        })
    },

    //下一步跳到审核页面
    nextStep(){
        this.$emit('change-step', false, uniq(this.multipleSelection.map((item) => item.useGasTypeId)));
    },

    //根据用气类型id显示用气类型
    useGasTypeNameFormat(useGasTypeId){
      return this.useGasTypeList.find((item) => item.id === useGasTypeId)?.useGasTypeName || ''
    },
    //核算失败，重试
    retry(row){
        return new Promise((resolve) => {
            retryCaculation(row).then((result) => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
                this.$message.success('核算生成成功')
                this.getList()
                resolve(true)
            } else {
                this.$message.error(this.$t('validateError'))
                resolve(false)
            }
            }).catch(() => {
            resolve(false)
            })
        })
    },

    // 设置多选框是否禁用
    setSelectable(row, index) {
        return row.dataStatus === 1
    },
  }
}
</script>

<style scoped lang="scss">
    .autoCheckPrice-page {
        ::v-deep {
            .el-form-item {
                margin-bottom: 18px;
            }
        }
    }
</style>
