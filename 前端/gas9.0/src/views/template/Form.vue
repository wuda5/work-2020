<template>
  <div v-loading="loading" class="form-page -form-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" :inline="true" label-position="top" class="qc-form clearfix">

    </el-form>
  </div>
</template>

<script>
import { isEmpty, isObjectLike, cloneDeep, isUndefined, isEqual } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField } from '@/enums/common'
import { formFieldsMap } from '@/lang/zh/modules/system/iot'
import { arrayCombine } from '@/utils/array'
import { saveUseGasType } from '@/api/operation/gasPrice'

export default {
  name: 'Form',
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
    return {
      form: this.setInitForm(),
      // 表单验证规则
      formRules: {
      },
    }
  },
  computed: {

  },
  watch: {
    id: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
    formData: {
      handler(value, oldValue) {
        if (!isEqual(oldValue, value)) {
          this.initFormData()
        }
      },
      immediate: false
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
    // 初始化表单数据
    setInitForm () {
      return {
        ...arrayCombine(Object.keys(formFieldsMap), new Array(Object.keys(formFieldsMap).length).fill('')),
        dataStatus: dataStatusField.VALID
      }
    },
    // 初始化数据
    async initData() {
    },

    // 初始化监听的表单数据
    async initFormData() {
      this.loading = true
      this.setFormData()
      this.loading = false
    },

    // 设置表单数据
    async setFormData(data) {
      this.loading = true
      // 生成最终的表单数据源， 有可能是从prop传入，也有可能是父组件直接调用该方法传入
      if (!isObjectLike(data)) {
        if (this.id) {
          data = await this.getFormDataById(this.id)
        } else if (!isEmpty(this.formData)) {
          data = this.formData
        }
      }
      this.setFormStatus(data)
      await this.generateFormData(data)
      this.loading = false
    },

    // 设置表单状态
    setFormStatus (data) {
      let formStatus = formStatusField.ADD
      if (!isEmpty(data) && data.id) {
        formStatus = formStatusField.EDIT
      }
      this.formStatus = formStatus
    },

    // 获取表单数据通过porp id
    async getFormDataById(id) {
      return new Promise((resolve) => {
        // 这里通过接口获取数据，resolve返回
        resolve(true)
      })
    },

    // 生成最终的表单数据
    async generateFormData (data) {
      if (!isEmpty(data)) {
        this.resetForm(data)
      } else {
        this.resetForm()
      }
    },

    // 对获取的表单数据进行过滤
    filterFormData(formData, initFormData) {
      const cloneInitFormData = cloneDeep(initFormData || (this.setInitForm?.() || (this.initForm || {})))
      const cloneFormData = cloneDeep(formData)
      for(const key in cloneInitFormData) {
        const value = cloneFormData[key]
        if (!isUndefined(value)) {
          cloneInitFormData[key] = value
        }
      }
      // console.log('cloneInitFormData', cloneInitFormData)
      return cloneInitFormData
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
        saveUseGasType(data, data?.id || '').then((result) => {
          console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm(this.formData)
            }
            resolve(data || true)
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
            // 传递保存成功时间回父级组件
            this.$emit('success', saveResult)
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

</style>
