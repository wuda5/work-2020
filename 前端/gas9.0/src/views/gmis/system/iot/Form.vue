<!-- 厂家网关配置表单 -->
<template>
  <div v-loading="loading" class="form-page iot-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" inline class="qc-form disabled-form clearfix">
      <!-- 厂家名称 -->
      <el-form-item prop="factoryName" :label="$t('system.iot.factoryName')">
        <el-select v-model="form.factoryName" name="factoryName" :placeholder="$t('system.iot.factoryName')" filterable clearable @change="handleFactoryChange">
          <el-option v-for="(item, index) in factoryList" :key="index" :label="item.gasMeterFactoryName" :value="item.gasMeterFactoryName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 厂家编码	 -->
      <el-form-item prop="factoryCode" :label="$t('system.iot.factoryCode')">
        <el-input v-model="form.factoryCode" name="factoryCode" disabled :placeholder="$t('system.iot.factoryCode')" />
      </el-form-item>
      <!-- 唯一标志	 -->
      <el-form-item prop="domainId" :label="$t('system.iot.domainId')">
        <el-input v-model="form.domainId" name="domainId" :placeholder="$t('system.iot.domainId')" />
      </el-form-item>
      <!-- 网关名称 -->
      <el-form-item prop="gatewayName" :label="$t('system.iot.gatewayName')">
        <el-input v-model="form.gatewayName" name="gatewayName" :placeholder="$t('system.iot.gatewayName')" />
      </el-form-item>
      <!-- 网关地址 -->
      <el-form-item prop="gatewayUrl" :label="$t('system.iot.gatewayUrl')">
        <el-input v-model="form.gatewayUrl" type="url" name="gatewayUrl" :placeholder="$t('system.iot.gatewayUrl')" />
      </el-form-item>
      <!-- 网关版本 -->
      <el-form-item prop="gatewayVersion" :label="$t('system.iot.gatewayVersion')">
        <el-input v-model="form.gatewayVersion" name="gatewayVersion" :placeholder="$t('system.iot.gatewayVersion')" />
      </el-form-item>
      <!-- appId	 -->
      <el-form-item prop="appId" :label="$t('system.iot.appId')">
        <el-input v-model="form.appId" name="appId" :placeholder="$t('system.iot.appId')" />
      </el-form-item>
      <!-- appSecret -->
      <el-form-item prop="appSecret" :label="$t('system.iot.appSecret')">
        <el-input v-model="form.appSecret" name="appSecret" :placeholder="$t('system.iot.appSecret')" />
      </el-form-item>
      <!-- 通知地址 -->
      <el-form-item prop="noticeUrl" :label="$t('system.iot.noticeUrl')">
        <el-input v-model="form.noticeUrl" type="url" name="noticeUrl" :placeholder="$t('system.iot.noticeUrl')" />
      </el-form-item>
      <!-- 通知类型 -->
      <el-form-item prop="noticeType" :label="$t('system.iot.noticeType')">
        <el-select v-model="form.noticeType" name="noticeType" :placeholder="$t('system.iot.noticeType')" filterable clearable>
          <el-option v-for="(value, key) in noticeTypeMap" :key="key" :label="value" :value="key"></el-option>
        </el-select>
      </el-form-item>
      <!-- 通知缓存天数 -->
      <!-- <el-form-item prop="noticeCacheDay" :label="$t('system.iot.')">
        <el-input v-model.number="form.noticeCacheDay" type="number" name="noticeCacheDay" :placeholder="$t('system.iot.')">
          <template v-slot:append>天</template>
        </el-input>
      </el-form-item> -->
      <!-- 备注 -->
      <el-form-item prop="remark" :label="$t('system.iot.remark')" class="remark-form-item">
        <el-input v-model="form.remark" name="remark" :placeholder="$t('system.iot.remark')" />
      </el-form-item>
      <!-- licence -->
      <div class="clearfix"></div>
      <el-form-item prop="licence" :label="$t('system.iot.licence')" class="licence-form-item">
        <el-input v-model="form.licence" type="textarea" name="licence" :placeholder="$t('system.iot.licence')" :autosize="{ minRows: 3 }" />
      </el-form-item>
      <!-- 操作按钮 -->
      <el-form-item v-if="!onlyView" label="" class="save-btn-box text-right">
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
import { formFieldsMap } from '@/lang/zh/modules/system/iot'
import { parseTime } from '@/utils/index'
import { positiveNumberReg } from '@/utils/reg'
import { arrayCombine, arrayColumn } from '@/utils/array'
import iotApi from '@/api/system/iot'
import versionApi from '@/api/system/gasMeterVersion'

export default {
  name: 'IotForm',
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
        domainId: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.iot.domainId')}`, trigger: 'blur' }
        ],
        factoryCode: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.iot.factoryCode')}`, trigger: 'change' }
        ],
        factoryName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('system.iot.factoryName')}`, trigger: 'change' }
        ],
        gatewayName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.iot.gatewayName')}`, trigger: 'blur' }
        ],
        gatewayUrl: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.iot.gatewayUrl')}`, trigger: 'blur' },
          { type: 'url', message: `${this.$t('inputHint')}${this.$t('system.iot.gatewayUrlHint')}`, trigger: 'blur' }
        ],
        noticeUrl: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('system.iot.noticeUrl')}`, trigger: 'blur' },
          { type: 'url', message: `${this.$t('inputHint')}${this.$t('system.iot.noticeUrlHint')}`, trigger: 'blur' }
        ],
        noticeType: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('system.iot.noticeType')}`, trigger: 'change' }
        ],
      },
      factoryList: [],
    }
  },
  computed: {
    // 通知类型map
    noticeTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.NOTICE_TYPE)
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
    await this.getFactoryList()
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
        dataStatus: dataStatusField.VALID
      }
    },

    // 初始化数据
    async initData () {
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
      this.getFormData(data)
      this.loading = false
    },

    // 获取表单数据通过porp id
    async getFormDataById(id) {
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
        iotApi.save(cloneData, data?.id || '').then((result) => {
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

    // 获取厂家有效列表
    getFactoryList(params = {}) {
      return new Promise((resolve) => {
        versionApi.queryGasProduct({
          deleteStatus: deleteStatusField.DELETE_INVALID,
          gasMeterFactoryStatus: dataStatusField.VALID,
        })
        .then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.factoryList = data
          }
          resolve(isSuccess)
        })
        .catch(() => {
          resolve(false)
        })
      })
    },

    // 厂家选择发生变化
    handleFactoryChange(value) {
      const factory = this.factoryList.find((item) => item.gasMeterFactoryName === value)
      this.form.factoryCode = factory?.gasMeterFactoryCode ?? null
    }
  }
}
</script>

<style scoped lang="scss">
  .qc-form  {
    ::v-deep {
      .el-form-item {
        &.remark-form-item {
          width: calc(100% / 3 * 2);
        }
        &.licence-form-item {
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
