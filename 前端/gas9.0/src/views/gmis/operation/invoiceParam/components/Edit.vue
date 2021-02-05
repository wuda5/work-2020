<!-- 开票参数添加和编辑 -->
<template>
  <div v-loading="loading" class="form-page invoice-param-page">
    <el-form ref="formRef" :model="form" :rules="rules" label-position="right" label-width="100px" class="jh-text">
      <!-- 销方名称 -->
      <el-form-item :label="$t('operation.invoiceParam.name')" prop="name">
        <el-input v-model="form.name" />
      </el-form-item>
      <!-- 销方电话 -->
      <el-form-item :label="$t('operation.invoiceParam.telephone')" prop="telephone">
        <el-input v-model="form.telephone" type="number" />
      </el-form-item>
      <!-- 销方地址 -->
      <el-form-item :label="$t('operation.invoiceParam.address')" prop="address">
        <el-input v-model="form.address" />
      </el-form-item>
      <!-- 账号等级 -->
      <el-form-item :label="$t('operation.invoiceParam.accountLevel')" prop="accountLevel">
        <el-select v-model="form.accountLevel" name="accountLevel" filterable>
          <el-option
            v-for="(item,index) in accountLevel"
            :key="index"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 销方银行账号 -->
      <el-form-item :label="$t('operation.invoiceParam.bankAccount')" prop="bankAccount">
        <el-input v-model="form.bankAccount" type="number" />
      </el-form-item>
      <!-- 销方开户行名称 -->
      <el-form-item :label="$t('operation.invoiceParam.bankName')" prop="bankName">
        <el-input v-model="form.bankName" />
      </el-form-item>
      <!-- 销方纳税人编号 -->
      <el-form-item :label="$t('operation.invoiceParam.taxpayerNo')" prop="taxpayerNo">
        <el-input v-model="form.taxpayerNo" />
      </el-form-item>
      <!-- 是否启用 -->
      <el-form-item label=" " prop="invoiceStatus" class="checkbox-item">
        <el-checkbox v-model="form.invoiceStatus" name="invoiceStatus" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.invoiceParam.invoiceStatusLabel') }}</el-checkbox>
      </el-form-item>
      <!-- 备注 -->
      <el-form-item :label="$t('operation.invoiceParam.remark')" prop="remark">
        <el-input v-model="form.remark" type="textarea" :autosize="{ minRows: 1, maxRows: 3}" />
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button type="primary" name="invoiceParam" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
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
import { invoiceParamFieldsMap } from '@/lang/zh/modules/operation/invoiceParam'
import { initQueryParams } from '@/utils/commons'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { saveInvoiceParam } from '@/api/operation/invoiceParam'

export default {
  name: 'InvoiceParamEdit',
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
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(invoiceParamFieldsMap), new Array(Object.keys(invoiceParamFieldsMap).length).fill('')),
        id: '',
        dataStatus: dataStatusField.VALID,
      },
      screenWidth: 0,
      width: this.initWidth(),
      // form:{},
      accountLevel:[{
        label:'总公司',
        value:0
      },{
        label:'分公司',
        value:1
      }],
      // 设置禁用状态
      disabledDate(value) {
          return +new Date(value) <= +new Date(parseTime(new Date(), '{y}-{m}-{d} 23:59:59'))
      },
      //表单的验证规则
      rules: {
        name: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        telephone: [
          { required: true, message: '请输入电话号码', trigger: 'blur' },
          {  max: 11, message: '请输入正确的电话号码', trigger: 'blur' }
        ],
        address: [
          { required: true, message: '请输入详细地址', trigger: 'blur' }
        ],
        accountLevel: [
          { required: true, message: '请选择账号等级', trigger: 'change' }
        ],
        bankAccount: [
          { required: true, message: '请输入银行账号', trigger: 'blur' }
        ],
        bankName: [
          { required: true, message: '请输入开户行名称', trigger: 'blur' }
        ],
        taxpayerNo: [
          { required: true, message: '请输入纳税人编号', trigger: 'blur' }
        ],
        remark: [
          { required: true, message: '请输入备注', trigger: 'blur' }
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
      immediate: false
    },
    formData: {
      handler(value) {
        this.initData()
      },
      immediate: false
    }
  },
  created(){
    this.initData()
  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }

  },
  methods: {
    /**
     * 对弹框进行初始化操作--根据屏幕分辩率动态修改弹窗的宽度
     */
    initWidth() {
      this.screenWidth = document.body.clientWidth
      return this.screenWidth < 991 ? '90%' : '40%'
    },
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
          const cloneData = cloneDeep(this.formData)
          cloneData.accountLevel = JSON.parse(cloneData.accountLevel)
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
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        saveInvoiceParam(cloneData, data?.id || '').then((result) => {
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
  },
}
</script>
<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 2);
    margin-bottom: 15px;
  }
}
</style>
