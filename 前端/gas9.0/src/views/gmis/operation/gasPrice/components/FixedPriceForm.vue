<!-- 固定价格表单 -->
<template>
  <div v-loading="loading" class="form-page price-form-page FixedPriceForm-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" :inline="true" class="qc-form disabled-form clearfix price-form">
      <!-- 有效时间 -->
      <el-form-item prop="startTime" :label="$t('operation.gasPrice.startTime')">
        <el-date-picker v-model="form.startTime" value-format="yyyy-MM-dd" name="startTime" :disabled="disabled" :picker-options="startTimePickerOptions" :placeholder="$t('operation.gasPrice.startTime')"></el-date-picker>
      </el-form-item>
      <!-- 结束时间 -->
      <el-form-item v-if="onlyView" prop="endTime" :label="$t('operation.gasPrice.endTime')">
        <el-date-picker v-model="form.endTime" value-format="yyyy-MM-dd" name="endTime" :disabled="disabled" :placeholder="$t('operation.gasPrice.endTime')"></el-date-picker>
      </el-form-item>
      <!-- 固定价格 -->
      <el-form-item prop="fixedPrice" :label="$t('operation.gasPrice.fixedPrice')">
        <qc-number-input v-model="form.fixedPrice" name="fixedPrice" clearable :disabled="disabled" :precision="4" :min="0" :placeholder="$t('operation.gasPrice.fixedPrice')"></qc-number-input>
      </el-form-item>
      <!-- 补差价格 -->
      <!-- <el-form-item prop="compensationPrice" :label="$t('operation.gasPrice.compensationPrice')">
        <el-input v-model="form.compensationPrice" type="number" name="compensationPrice" :disabled="disabled" clearable :placeholder="$t('operation.gasPrice.compensationPrice')"></el-input>
      </el-form-item> -->
      <!-- 是否清零 -->
      <!-- <el-form-item label=" " prop="priceChangeIsClear" class="checkbox-item">
        <el-checkbox v-model="form.priceChangeIsClear" name="priceChangeIsClear" :disabled="disabled" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.gasPrice.priceChangeIsClear') }}</el-checkbox>
      </el-form-item> -->
      <!-- <div class="clearfix"></div> -->
      <!-- 保存 -->
      <el-form-item v-if="!onlyView" label="" class="save-btn-box text-right fr">
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
import { priceFormFieldsMap } from '@/lang/zh/modules/operation/gasPrice'
import { parseTime } from '@/utils/index'
import { arrayCombine } from '@/utils/array'
import { positiveNumberReg } from '@/utils/reg'
import { saveFixedPrice } from '@/api/operation/gasPrice'

export default {
  name: 'FixedPriceForm',
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
    }
  },
  data() {
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(priceFormFieldsMap), new Array(Object.keys(priceFormFieldsMap).length).fill('')),
        id: '',
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        startTime: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.startTime')}`, trigger: 'blur' },
        ],
        fixedPrice: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.fixedPrice')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.fixedPriceNumberHint'), trigger: 'blur'  },
        ],
        //调价可以调高调低，会存在收费和退费，补差价格不能只是正数
        // compensationPrice: [
        //   { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.compensationPriceNumberHint'), trigger: 'blur'  },
        // ],
      },
      // 日期选择器设置属性
      startTimePickerOptions: {
        // 设置禁用状态
        disabledDate(value) {
          return +new Date(value) < +new Date(`${parseTime(new Date(), '{y}-{m}-{d}')} 00:00:00`)
        }
      },
    }
  },
  computed: {
    // 通用表单是否禁用
    disabled() {
      return this.onlyView
    }
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
    // 初始化数据
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
        saveFixedPrice(data, data?.id || '').then((result) => {
          // console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm(this.formData)
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
  }
}
</script>

<style scoped lang="scss">
  .price-form {
    ::v-deep {
      .el-form-item {
        width: calc(100% / 2);
      }
    }
    .save-btn-box {
      margin-top: 10px;
    }
  }
</style>
