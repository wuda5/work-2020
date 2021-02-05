<!--滞纳金表单（备份）-->
<template>
  <div v-loading="loading" class="form-page late-fee-form-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" class="qc-form clearfix late-fee-form clearfix">
      <el-form-item prop="activationTime" :label="$t('operation.gasPrice.activationTime')">
        <el-date-picker v-model="form.activationTime" value-format="yyyy-MM-dd" name="activationTime" :placeholder="$t('operation.gasPrice.activationTime')"></el-date-picker>
      </el-form-item>
      <el-form-item prop="executeMonth" :label="$t('operation.gasPrice.executeMonth')">
        <el-select v-model.number="form.executeMonth" name="executeMonth" :placeholder="$t('operation.gasPrice.executeMonth')">
          <el-option v-for="(value, index) in executeMonths" :key="index" :label="`${value}个月后`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="executeDay" :label="$t('operation.gasPrice.executeDay')">
        <el-select v-model.number="form.executeDay" name="executeDay" :placeholder="$t('operation.gasPrice.executeDay')">
          <el-option v-for="(value, index) in executeDays" :key="index" :label="`${value}号`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="rate" :label="$t('operation.gasPrice.rateLabel')">
        <el-input v-model.number="form.rate" type="number" name="rate" :placeholder="$t('operation.gasPrice.rate')">
          <!-- <template solt="append">%</template> -->
          <template slot="append">%</template>
        </el-input>
      </el-form-item>
      <el-form-item label=" " prop="compoundInterest" class="checkbox-item">
        <el-checkbox v-model="form.compoundInterest" name="compoundInterest" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.gasPrice.compoundInterest') }}</el-checkbox>
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item label=" " prop="principalCap" class="checkbox-item">
        <el-checkbox v-model="form.principalCap" name="principalCap" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.gasPrice.principalCap') }}</el-checkbox>
      </el-form-item>
      <el-form-item prop="fixedCap" :label="$t('operation.gasPrice.fixedCap')">
        <el-input v-model.number="form.fixedCap" type="number" name="fixedCap" :placeholder="$t('operation.gasPrice.fixedCap')">
        </el-input>
      </el-form-item>
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button type="primary" name="savePriceName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { lateFeeFieldsMap } from '@/lang/zh/modules/operation/gasPrice'
import { arrayCombine } from '@/utils/array'
import { positiveNumberReg } from '@/utils/reg'
import { saveLateFee } from '@/api/operation/gasPrice'

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
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        activationTime: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.activationTime')}`, trigger: 'blur' }
        ],
        rate: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.rate')}`, trigger: 'blur' },
          { type: 'number',  min: 0, message: this.$t('operation.gasPrice.rateNumberHint'), trigger: 'blur'  },
        ],
        executeMonth: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.executeMonth')}`, trigger: 'change' }
        ],
        executeDay: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.executeDay')}`, trigger: 'change' }
        ],
        fixedCap: [
          { type: 'number',  min: 0, message: this.$t('operation.gasPrice.fixedCapNumberHint'), trigger: 'blur'  },
          { 
            validator: (rule, value) => {
              const principalCap = this.form.principalCap
              if (principalCap !== useStatusField.ENABLE && !value) {
                return Promise.reject(`${this.$t('inputHint')}${this.$t('operation.gasPrice.fixedCapLable')}`)
              }
              return Promise.resolve()
            }, 
            trigger: 'blur' 
          }
        ],
      },
    }
  },
  computed: {

  },
  watch: {
    id: {
      handler(value) {
        this.initData()
      },
      immediate: true
    },
    formData: {
      handler(value) {
        this.initData()
      },
      immediate: true
    }
  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {
      this.loading = true
      this.setFormStatus()
      await this.getFormData()
      this.loading = false
    },

    // 获取表单数据
    async getFormData() {
      return new Promise((resolve) => {
        if (this.id) {
          // 请求api获取表单数据
          this.resetForm()
          resolve(true)
        } else if(!isEmpty(this.formData)) {
          this.resetForm(this.formData)
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
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        saveLateFee(data, data?.id || '').then((result) => {
          console.log('saveresult', result)
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
    }
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
        width: calc(100% / 3);
        float: left;
        padding: 0 10px;
        margin-bottom: 10px;
        .el-select {
          width: 100%;
        }
      }
      .el-date-editor {
        width: 100%;
      }
    }
    .save-btn-box {
      float: right;
      margin-top: -2px;
      .save-btn {
        width: 100%;
        padding: 8px 15px;
      }
    }
  }
</style>
