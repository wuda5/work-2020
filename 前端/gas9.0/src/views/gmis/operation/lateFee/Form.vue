<!-- 滞纳金表单 -->
<template>
  <div v-loading="loading" class="form-page late-fee-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" inline class="qc-form clearfix late-fee-form clearfix">
      <!-- 滞纳金名称 -->
      <el-form-item :label="$t('operation.lateFee.executeName')" prop="executeName">
        <el-input v-model.trim="form.executeName" :placeholder="$t('operation.lateFee.executeName')">
        </el-input>
      </el-form-item>
      <!-- 用气类型 -->
      <el-form-item prop="useGasTypeId" :label="$t('operation.lateFee.useGasTypeId')">
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select v-model="form.useGasTypeId" name="useGasTypeId" collapse-tags clearable filterable multiple :placeholder="$t('operation.lateFee.useGasTypeId')">
              <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id"></el-option>
            </el-select>
          </el-col>
          <el-col style="width: auto">
            <el-button type="primary" size="mini" @click.native="handleSelectAllUseGasType">全选</el-button>
          </el-col>
        </el-row>
      </el-form-item>
      <!-- 滞纳金执行月 -->
      <el-form-item prop="executeMonth" :label="$t('operation.lateFee.executeMonth')">
        <el-select v-model.number="form.executeMonth" name="executeMonth" :placeholder="$t('operation.lateFee.executeMonth')">
          <el-option v-for="(value, index) in executeMonths" :key="index" :label="`${value}个月后`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 滞纳金执行日 -->
      <el-form-item prop="executeDay" :label="$t('operation.lateFee.executeDay')">
        <el-select v-model.number="form.executeDay" name="executeDay" :placeholder="$t('operation.lateFee.executeDay')">
          <el-option v-for="(value, index) in executeDays" :key="index" :label="`${value}号`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 利率 -->
      <el-form-item prop="rate" :label="$t('operation.lateFee.rateLabel')">
        <qc-number-input v-model="form.rate" name="rate" :precision="2" clearable :placeholder="$t('operation.lateFee.rate')">
          <template slot="append">%</template>
        </qc-number-input>
      </el-form-item>
      <!-- 复利 -->
      <el-form-item label=" " prop="compoundInterest" class="checkbox-item">
        <el-checkbox v-model="form.compoundInterest" name="compoundInterest" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.lateFee.compoundInterest') }}</el-checkbox>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 本金即上线 -->
      <el-form-item label=" " prop="principalCap" class="checkbox-item">
        <el-checkbox v-model="form.principalCap" name="principalCap" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE" @change="handlePrincipalCapChange">{{ $t('operation.lateFee.principalCap') }}</el-checkbox>
      </el-form-item>
      <!-- 固定上限 -->
      <el-form-item prop="fixedCap" :label="$t('operation.lateFee.fixedCap')" :rules="setFixedCapRules">
        <!-- <el-input v-model="form.fixedCap" type="number" name="fixedCap" :placeholder="$t('operation.lateFee.fixedCap')"></el-input> -->
        <qc-number-input v-model="form.fixedCap" name="fixedCap" :precision="2" :disabled="isPrincipalCap" clearable :placeholder="$t('operation.lateFee.fixedCap')"></qc-number-input>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 启用时间 -->
      <el-form-item prop="activationTime" :label="$t('operation.lateFee.activationTime')">
        <el-date-picker v-model="form.activationTime" value-format="yyyy-MM-dd" name="activationTime" :picker-options="startTimePickerOptions" :placeholder="$t('operation.lateFee.activationTime')"></el-date-picker>
      </el-form-item>
      <!-- 数据状态 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox v-model="form.dataStatus" name="dataStatus" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.lateFee.dataStatusLabel') }}</el-checkbox>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button type="primary" name="savePriceName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { lateFeeFieldsMap } from '@/lang/zh/modules/operation/lateFee'
import { initQueryParams } from '@/utils/commons'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg } from '@/utils/reg'
import { saveData, getUseGasTypeList } from '@/api/operation/lateFee'

export default {
  name: 'LateFeeForm',
  components: {

  },
  filters: {},
  mixins: [commonMixin, formMixin],
  props: {
    // 需要修改的表单数据id
    id: {
      type: [String, Number],
      default: ''
    },
    // 表单数据
    formData: {
      type: Object,
      default: () => ({})
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false
    },
  },
  data() {
    // 结算日数组
    this.executeDays = Array.from({ length: 28 }, (v, k) => k + 1)
    // 起始月数组
    this.executeMonths = Array.from({ length: 5 }, (v, k) => k + 1)
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(lateFeeFieldsMap), new Array(Object.keys(lateFeeFieldsMap).length).fill('')),
        id: '',
        executeMonth: this.executeMonths[0],
        executeDay: this.executeDays[0],
        dataStatus: dataStatusField.VALID,
      },
      // 表单验证规则
      formRules: {
        executeName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.lateFee.executeName')}`, trigger: 'blur' }
        ],
        useGasTypeId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.lateFee.useGasTypeId')}`, trigger: 'change' }
        ],
        activationTime: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.lateFee.activationTime')}`, trigger: 'blur' }
        ],
        rate: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.lateFee.rate')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.lateFee.rateNumberHint'), trigger: 'blur'  },
        ],
        executeMonth: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.lateFee.executeMonth')}`, trigger: 'change' }
        ],
        executeDay: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.lateFee.executeDay')}`, trigger: 'change' }
        ],
        // fixedCap: [
        //   { pattern: positiveNumberReg, message: this.$t('operation.lateFee.fixedCapNumberHint'), trigger: 'blur'  },
        //   { 
        //     validator: (rule, value) => {
        //       const principalCap = this.form.principalCap
        //       if (principalCap !== useStatusField.ENABLE && !value) {
        //         return Promise.reject(`${this.$t('inputHint')}${this.$t('operation.lateFee.fixedCapLable')}`)
        //       }
        //       return Promise.resolve()
        //     }, 
        //     trigger: 'blur' 
        //   }
        // ],
      },
      useGasTypeList: [], // 用气类型列表
      // 日期选择器特有属性
      startTimePickerOptions: {
        // 设置禁用状态
        disabledDate(value) {
          return +new Date(value) <= +new Date(parseTime(new Date(), '{y}-{m}-{d} 23:59:59'))
        }
      },
    }
  },
  computed: {
    // 设置固定上限验证规则
    setFixedCapRules() {
      this.$refs?.formRef?.clearValidate('fixedCap')
      const result = [
        { pattern: positiveNumberReg, message: this.$t('operation.lateFee.fixedCapNumberHint'), trigger: 'blur'  },
      ]
      if (!this.isPrincipalCap) {
        result.push({ required: true, message: `${this.$t('inputHint')}${this.$t('operation.lateFee.fixedCapLable')}`, trigger: 'blur' })
      }
      return result
    },
    // 选择了本金即上限
    isPrincipalCap() {
      return +this.form?.principalCap === useStatusField.ENABLE
    },
  },
  watch: {
    id: {
      handler(value) {
        this.initData()
      },
      immediate: false
    },
    formData: {
      handler(value) {
        this.initData()
      },
      immediate: false
    },
    // 本金即上限标志监听
    'form.principalCap': {
      handler(data) {
        if (this.isPrincipalCap) {
          this.form.fixedCap = ''
        }
      },
      immediate: true,
    },
  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    // 初始化数据
    async initData() {
      this.loading = true
      this.setFormStatus()
      this.getUseGasTypeListData()
      await this.getFormData()
      this.loading = false
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

    // 获取表单数据
    async getFormData() {
      return new Promise((resolve) => {
        if (this.id) {
          // 请求api获取表单数据
          this.resetForm()
          resolve(true)
        } else if(!isEmpty(this.formData)) {
          const cloneData = cloneDeep(this.formData)
          cloneData.useGasTypeId = JSON.parse(cloneData.useGasTypeId)
          this.resetForm(cloneData)
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },

    // 设置表单状态
    setFormStatus() {
      let formStatus = formStatusField.ADD
      if (this.id || (!isEmpty(this.formData) && this.formData.id)) {
        formStatus = formStatusField.EDIT
      }
      this.formStatus = formStatus
    },
    // 保存数据
    saveFormData(data = null) {
      if (!data) {
        data = this.form
      }
      const cloneData = cloneDeep(data)
      cloneData.useGasTypeId = JSON.stringify(cloneData.useGasTypeId)
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        console.log('saveData', cloneData)
        saveData(cloneData, data?.id || '').then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm()
            }
            // 传递保存成功时间回父级组件
            this.$emit('success', data)
            resolve(true)
          } else {
            resolve(false)
          }
          this.submitLoading = false
        }).catch(() => {
          resolve(false)
          this.submitLoading = false
        })
      })
    },

    // 保存表单信息
    handleSubmit() {
      this.$refs[this.formRef].validate(async(valid) => {
        if (valid) {
          const saveResult = await this.saveFormData()
          if (saveResult) {
            this.$message.success(this.$t('saveSuccess'))
          }
        } else {
          this.$message.error(this.$t('validateError'))
        }
      })
    },

    // 取消保存
    handleCancel() {
      this.$emit('cancel')
    },

    // 用气类型全选
    handleSelectAllUseGasType() {
      this.form.useGasTypeId = arrayColumn(this.useGasTypeList, 'id')
    },

    handlePrincipalCapChange(value) {
      
    },
  }
}
</script>

<style scoped lang="scss">
  .late-fee-form-page {
    padding: 5px 0 15px;
  }
  .late-fee-form {
    ::v-deep {
      .el-form-item {
        float: none;
        display: inline-block;
      }
      .el-date-editor {
        width: 100%;
      }
    }
    .save-btn-box {
      // float: right;
      // margin-top: -2px;
      // .save-btn {
      //   width: 100%;
      //   padding: 8px 15px;
      // }
    }
  }
</style>
