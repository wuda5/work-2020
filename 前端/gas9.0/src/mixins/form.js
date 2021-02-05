/**
 *  混入一些关于表单的公用功能
 */
import { cloneDeep } from 'lodash'

export default {
  data() {
    return {
      formStatus: 'add', // 表单状态create, edit
      submitLoading: false, // 全局表单提交loading
      formRef: 'formRef',
      // 表单信息
      form: null,
      // 表单验证规则
      formRules: {
      }
    }
  },
  computed: {
    isEdit() {
      return this.formStatus === 'edit'
    },
    isAdd() {
      return this.formStatus === 'add'
    }
  },
  created() {
    // 为了兼容之前在此处给表单赋值的代码
    if (this.initForm) {
      this.form = cloneDeep(this.initForm)
    }
  },
  methods: {
    // 重置表单
    resetForm(form, ref) {
      ref = ref || this.formRef
      // console.log(this.$refs?.[ref])
      this.form = { ...cloneDeep(this.setInitForm?.() ?? (this.initForm ?? {})), ...cloneDeep(form) }
      this.$nextTick(() => {
        this.clearValidate(ref)
      })
      return Promise.resolve(true)
    },
    // 移除表单项的校验结果
    clearValidate(ref) {
      ref = ref || this.formRef
      this.$refs?.[ref]?.clearValidate()
    }
  }
}
