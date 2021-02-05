<!-- 电子发票平台配置表单 -->
<template>
  <div v-loading="loading" class="form-page iot-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" inline class="qc-form clearfix">
      <!-- 电子发票平台名称	 -->
      <el-form-item prop="platCode" :label="$t('system.invoice.platName')">
        <el-select v-model="form.platCode" name="platCode" filterable clearable :placeholder="`${$t('system.invoice.platName')}`" @change="handleChangePlat">
          <el-option v-for="(value, key) in platMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
        <!-- <el-input v-model="form.platName" name="platName" :placeholder="$t('system.invoice.platName')" /> -->
      </el-form-item>
      <!-- 联系人	 -->
      <el-form-item prop="contacts" :label="$t('system.invoice.contacts')">
        <el-input v-model="form.contacts" name="contacts" :placeholder="$t('system.invoice.contacts')" />
      </el-form-item>
      <!-- 联系电话 -->
      <el-form-item prop="telephone" :label="$t('system.invoice.telephone')">
        <el-input v-model="form.telephone" name="telephone" :placeholder="$t('system.invoice.telephone')" />
      </el-form-item>
      <!-- openId	 -->
      <el-form-item prop="openId" :label="$t('system.invoice.openId')">
        <el-input v-model="form.openId" name="openId" :placeholder="$t('system.invoice.openId')" />
      </el-form-item>
      <!-- appSecret -->
      <el-form-item prop="appSecret" :label="$t('system.invoice.appSecret')">
        <el-input v-model="form.appSecret" name="appSecret" :placeholder="$t('system.invoice.appSecret')" />
      </el-form-item>
      <!-- 请求路径 -->
      <el-form-item prop="url" :label="$t('system.invoice.url')">
        <el-input v-model="form.url" type="url" name="url" :placeholder="$t('system.invoice.url')" />
      </el-form-item>
      <template v-if="IS_RUI_HONG">
        <!-- 证书别名 -->
        <el-form-item prop="keyStoreAlias" :label="$t('system.invoice.keyStoreAlias')">
          <el-input v-model="form.keyStoreAlias" name="keyStoreAlias" :placeholder="$t('system.invoice.keyStoreAlias')" />
        </el-form-item>
        <!-- 证书密码 -->
        <el-form-item prop="keyStorePwd" :label="$t('system.invoice.keyStorePwd')">
          <el-input v-model="form.keyStorePwd" name="keyStorePwd" :placeholder="$t('system.invoice.keyStorePwd')" />
        </el-form-item>
        <!-- 文件上传 -->
        <el-form-item prop="file" :label="$t('system.invoice.file')" :rules="setFileRules" class="file-form-item">
          <ul v-if="form.fileUrl" class="el-upload-list el-upload-list--text">
            <li tabindex="0" class="el-upload-list__item is-success">
              <a :href="form.fileUrl" class="el-upload-list__item-name" title="点击下载"><i class="el-icon-document"></i>{{ form.fileName }}</a>
              <label class="el-upload-list__item-status-label">
                <i class="el-icon-upload-success el-icon-circle-check"></i>
              </label>
            </li>
          </ul>
          <el-upload class="upload-file-box" :http-request="customerHttpRequest" :before-remove="handleBeforeRemove" drag action="https://jsonplaceholder.typicode.com/posts/">
            <i class="el-icon-upload"></i>
            <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
            <!-- <template v-slot:tip>
              <div class="el-upload__tip hint-text">只能上传jpg/png文件，且不超过500kb</div>
            </template> -->
          </el-upload>
        </el-form-item>
      </template>
      <!-- 其它参数 -->
      <el-form-item prop="otherParam" :label="$t('system.invoice.otherParamLabel')" class="remark-form-item">
        <el-input v-model.trim="form.otherParam" type="textarea" name="otherParam" :placeholder="$t('system.invoice.otherParam')" :autosize="{ minRows: 3 }" />
        <p class="hint-text">
          {{ $t('system.invoice.otherParamHint') }}<a href="http://www.bejson.com/" target="_blank">http://www.bejson.com/</a>
        </p>
      </el-form-item>
      <!-- 操作按钮 -->
      <el-form-item v-if="!onlyView" label="" class="save-btn-box fr ">
        <el-button type="primary" name="saveIot" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, isObjectLike } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField, deleteStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary' 
import { invoiceField } from '@/enums/invoice' 
import { formFieldsMap } from '@/lang/zh/modules/system/invoice'
import { deepClone, parseTime } from '@/utils/index'
import { phoneReg } from '@/utils/reg'
import { isJSON } from '@/utils/my-validate'
import { arrayCombine, arrayColumn } from '@/utils/array'
import invoiceApi from '@/api/system/invoice'

export default {
  name: 'InvoiceForm',
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
  data () {
    this.useStatusField = useStatusField
    return {
      form: this.setInitForm(),
      // 表单验证规则
      formRules: {
        platName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.platName')}`, trigger: 'blur' }
        ],
        appSecret: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.appSecret')}`, trigger: 'blur' }
        ],
        contacts: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.contacts')}`, trigger: 'blur' }
        ],
        openId: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.openId')}`, trigger: 'blur' }
        ],
        telephone: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.telephone')}`, trigger: 'blur' },
          { pattern: phoneReg, message: `${this.$t('inputHint')}${this.$t('system.invoice.telephoneHint')}`, trigger: 'blur' }
        ],
        url: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.url')}`, trigger: 'blur' },
          { type: 'url', message: `${this.$t('inputHint')}${this.$t('system.invoice.urlHint')}`, trigger: 'blur' }
        ],
        otherParam: [
          { validator: (rule, value) => {
            if (value) {
              if (!isJSON(value)) {
                return Promise.reject(this.$t('system.invoice.otherParamErrorHint'))
              }
            }
            return Promise.resolve(true)
          }, trigger: 'blur' }
        ],
        // file: [
        //   { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.fileHint')}`, trigger: 'blur' },
        // ],
        keyStoreAlias: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.keyStoreAlias')}`, trigger: 'blur' },
        ],
        keyStorePwd: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.invoice.keyStorePwd')}`, trigger: 'blur' },
        ],
      },
    }
  },
  computed: {
     // 气表类型映射
    platMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.E_INVOICE_PLAT)
    },

    // 是否是瑞宏发票平台
    IS_RUI_HONG() {
      return invoiceField.RUI_HONG === this.form.platCode
    },

    // 设置文件字段验证规则
    setFileRules() {
      const rules = []
      // 先清空文件验证信息
      this.$refs[this.formRef]?.clearValidate('file')
      const { platCode, fileUrl } = this.form
      if (this.IS_RUI_HONG) {
        if (!fileUrl) {
          rules.push(
            { required: true, message: `${this.$t('system.invoice.fileHint')}`, trigger: 'blur' }
          )
        }
      }
      return rules
    },
  },
  watch: {
    id: {
      handler (value) {
        this.initData()
      },
      immediate: false
    },
    formData: {
      handler (value) {
        this.initData()
      },
      immediate: false
    }
  },
  async created () {
    this.initData()
  },
  mounted () {

  },
  destroyed () {
  },
  methods: {
    // 初始化表单数据
    setInitForm () {
      return {
        ...arrayCombine(Object.keys(formFieldsMap), new Array(Object.keys(formFieldsMap).length).fill('')),
        dataStatus: dataStatusField.VALID,
        deleteStatus: deleteStatusField.DELETE_INVALID,
      }
    },

    // 初始化数据
    async initData () {
      this.loading = true
      this.setFormData()
      this.loading = false
    },

    // 设置表单数据
    async setFormData (data) {
      this.loading = true
      // 生成最终的表单数据源， 有可能是从prop传入，也有可能是父组件直接调用该方法传入
      if (!isObjectLike(data)) {
        if (this.id) {
          data = await this.getFormDataById(this.id)
        } else if (!isEmpty(this.formData)) {
          const cloneFormData = deepClone(this.formData)
          cloneFormData.keyStoreAlias = cloneFormData.keyStore?.keyStoreAlias
          cloneFormData.keyStorePwd = cloneFormData.keyStore?.keyStorePwd
          cloneFormData.fileName = cloneFormData.keyStore?.keyStoreName
          cloneFormData.fileUrl = cloneFormData.keyStore?.keyStorePath
          data = cloneFormData
        }
      }
      this.setFormStatus(data)
      await this.getFormData(data)
      this.loading = false
    },

    // 获取表单数据通过porp id
    async getFormDataById (id) {
      return new Promise((resolve) => {
        // 这里通过接口获取数据，resolve返回
        resolve(true)
      })
    },

    // 获取表单数据
    async getFormData (data) {
      if (!isEmpty(data)) {
        this.resetForm(data)
      } else {
        this.resetForm()
      }
    },

    // 设置表单状态
    setFormStatus (data) {
      let formStatus = formStatusField.ADD
      if (!isEmpty(data) && data.id) {
        formStatus = formStatusField.EDIT
      }
      this.formStatus = formStatus
    },

    // 保存数据
    saveFormData (data = null) {
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
        invoiceApi.saveWithFile(cloneData).then((result) => {
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
    handleSubmit () {
      this.$refs[this.formRef].validate(async (valid) => {
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

    // 平台发生变化
    handleChangePlat(value) {
      this.form.platName = this.platMap[value]
    },

    customerHttpRequest(uploadOptions) {
      // console.log(uploadOptions)
      this.form.file = uploadOptions?.file
      this.$refs[this.formRef]?.clearValidate('file')
    },

    handleBeforeRemove(file, fileList) {
      // console.log(file, fileList)
      this.form.file = null
    }
  }
}
</script>

<style scoped lang="scss">
  .qc-form  {
    ::v-deep {
      .el-form-item {
        &.remark-form-item {
          width: 100%;
        }
      }
      .file-form-item {
        width: 100%;
        .el-upload {
          width: 100%;
        }
        .el-upload-dragger {
          width: 100%;
        }
      }
    }
    .save-btn-box {
      float: right;
      margin-top: 10px;
    }
  }
</style>
