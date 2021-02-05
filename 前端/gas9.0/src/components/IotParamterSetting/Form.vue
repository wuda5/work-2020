
<!-- 物联网参数设置通用表单 -->
<template>
  <div v-loading="loading" class="form-page parameterSetting-form-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" :inline="true" label-position="top" class="qc-form clearfix">
      <div class="form-body">
        <el-card v-for="(item, key) in form" :key="key" shadow="never" :body-style="{ padding: '5px 10px 0px 10px' }" class="paramter-card">
          <div slot="header">
            <span class="card-title">{{ key | parameterName }}</span>
          </div>
          <!-- 单个参数设置表单 -->
          <el-form-item v-for="(paramterValue, paramterKey) in item" :key="`${key}.${paramterKey}`" class="form-item" :label="getParameterOptions(key, paramterKey).formItemAttributes.label" :prop="`${key}.${paramterKey}`" :rules="getParameterOptions(key, paramterKey).formItemAttributes.rules ? getParameterOptions(key, paramterKey).formItemAttributes.rules() : {}">
            <!-- 单选框组 -->
            <template v-if="getParameterOptions(key, paramterKey).type === 'radio'">
              <el-radio-group v-model="item[paramterKey]">
                <el-radio v-for="(radioValue, radioIndex) in getParameterOptions(key, paramterKey).options" :key="radioIndex" :label="radioIndex">{{ radioValue }}</el-radio>
              </el-radio-group>
            </template>
            <!-- 下拉选择输入框 -->
            <template v-else-if="getParameterOptions(key, paramterKey).type === 'select'">
              <el-select v-model="item[paramterKey]" :placeholder="getParameterOptions(key, paramterKey).attributes.placeholder" filterable :name="`${key}-${paramterKey}`">
                <el-option v-for="(selectValue, selectIndex) in getParameterOptions(key, paramterKey).options" :key="selectIndex" :label="selectValue" :value="selectIndex"></el-option>
              </el-select>
            </template>
            <!-- 数字输入框 -->
            <template v-else-if="getParameterOptions(key, paramterKey).type === 'number'">
              <el-input v-model.number="item[paramterKey]" type="number" :placeholder="getParameterOptions(key, paramterKey).attributes.placeholder" :name="paramterKey">
                <template v-if="getParameterOptions(key, paramterKey).prependText" v-slot:prepend>
                  <span>{{ getParameterOptions(key, paramterKey).prependText }}</span>
                </template>
                <template v-if="getParameterOptions(key, paramterKey).appendText" v-slot:append>
                  <span>{{ getParameterOptions(key, paramterKey).appendText }}</span>
                </template>
              </el-input>
            </template>
            <!-- 普通输入框 -->
            <template v-else>
              <el-input v-model="item[paramterKey]" type="text" :placeholder="getParameterOptions(key, paramterKey).attributes.placeholder" :name="paramterKey">
                <template v-if="getParameterOptions(key, paramterKey).prependText" v-slot:prepend>
                  <span>{{ getParameterOptions(key, paramterKey).prependText }}</span>
                </template>
                <template v-if="getParameterOptions(key, paramterKey).appendText" v-slot:append>
                  <span>{{ getParameterOptions(key, paramterKey).appendText }}</span>
                </template>
              </el-input>
            </template>
            <p v-if="getParameterOptions(key, paramterKey).hintText" class="hint-text">{{ getParameterOptions(key, paramterKey).hintText }}</p>
          </el-form-item>
        </el-card>
      </div>
      <el-form-item label="" class="save-btn-box text-right fr">
        <el-button type="primary" name="saveIotParameter" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, isObjectLike, isArray, cloneDeep, isUndefined, isEqual } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField } from '@/enums/common'
import { parameterFormOptions, parameterMap } from '@/enums/parameterSetting'
import { arrayCombine } from '@/utils/array'
import iotParameterSettingApi from '@/api/meterInfo/iotParameterSetting'

export default {
  name: 'IotParameterForm',
  components: {

  },
  filters: {
    parameterName(value) {
      return parameterMap[value]
    },
  },
  mixins: [commonMixin, formMixin],
  props: {
    // 表单数据(可对象可数组)
    formData: {
      type: [Object, Array],
      default: () => ([])
    },
    // 气表版本信息
    version: {
      type: Object,
      required: true,
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false
    },
  },
  data() {
    return {
      form: [],
      // 表单验证规则
      formRules: {
      },
    }
  },
  computed: {
    // 所有的可设置参数
    allParamters() {
      const result = {}
      const cloneParameterFormOptions = cloneDeep(parameterFormOptions)
      for (let key in cloneParameterFormOptions) {
        const versions = cloneParameterFormOptions[key].options?.version ?? []
        if (versions.find((version) => this.version.gasMeterVersionName.toUpperCase().trim().includes(version))) {
          result[key] = cloneParameterFormOptions[key]
        }
      }
      return result
    },

    // 是否通过版号设置
    checkParameterSettingByVersion() {
      return this.result.length === 0
    }
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
    this.initFormData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
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
      data = data || this.formData
      this.loading = true
      const cloneData = cloneDeep(data)
      let generateData = []
      // 生成最终的表单数据源， 有可能是从prop传入，也有可能是父组件直接调用该方法传入
      if (isObjectLike(data)) {
        if (isArray(data) && data.length > 0) {
          generateData = cloneData
        } else if (!isEmpty(data)) {
          generateData = [cloneData]
        }
      }
      // 原数据结果
      this.result = generateData
      // 预留设置表单状态
      // 重组表单数据
      this.form = this.filterFormData(generateData.length === 1 ? generateData[0] : {})
      this.$nextTick(() => {
        this.clearValidate(this.formRef)
      })
      this.loading = false
    },

    // 对获取的表单数据进行过滤, 将当前的参数设置值赋值给需要展示的表单,然后将默认值也赋值给表单绑定, 赋值表单验证规则
    filterFormData(data = {}) {
      const cloneData = cloneDeep(data)
      const allParamters = cloneDeep(this.allParamters)
      const form = {}
      for (const key in allParamters) {
        const currentParamter = cloneData[key]
        form[key] = {}
        let currentParamterFields = {}
        if (currentParamter) {
          try {
            currentParamterFields = JSON.parse(currentParamter)
          } catch (error) {
            console.warn('json解析失败', currentParamter)
          }
        }
        const paramterFields = allParamters[key]?.fields || {}
        for (const paramterField in paramterFields) {
          form[key][paramterField] = isUndefined(currentParamterFields[paramterField]) ? paramterFields[paramterField].defaultValue : currentParamterFields[paramterField]
        }
      }
      console.log('allParamters', allParamters)
      console.log('form', form)
      return form
    },

    // 获取具体参数属性
    getParameterOptions(parameterField, detailsParameterField) {
      return this.allParamters[parameterField]?.fields[detailsParameterField] || {}
    },

    // 根据表身号设置进行保存
    handleSaveDataByGasMeterNumber(data) {
      return new Promise((resolve) => {
        iotParameterSettingApi.saveData(data).then((response) => {
          const { isSuccess, data } = response.data
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 根据版号设置进行保存
    handleSaveDataByVersion(data) {
      return new Promise((resolve) => {
        iotParameterSettingApi.saveDataByVersion(data, { versionId: this.version.id }).then((response) => {
          const { isSuccess, data } = response.data
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 保存表单信息
    handleSubmit() {
      this.$refs[this.formRef].validate(async(valid) => {
        console.log('valid', valid)
        if (valid) {
          this.submitLoading = true
          const generateFormData = {}
          for (const key in this.form) {
            generateFormData[key] = JSON.stringify(this.form[key])
          }
          const generateSaveData = this.result.map((item) => {
            return {
              ...item,
              ...generateFormData
            }
          })
          let saveResult
          if (this.checkParameterSettingByVersion) {
            saveResult = await this.handleSaveDataByVersion(generateFormData)
          } else {
            saveResult = await this.handleSaveDataByGasMeterNumber(generateSaveData)
          }
          this.submitLoading = false
          if (saveResult) {
            this.$message.success(this.$t('参数设置指令已经发送'))
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
  .parameterSetting-form-page {
    ::v-deep {
      .el-form {
        .el-card {
          margin-bottom: 10px;
        }
        .el-form-item {
          width: 25%;
        }
      }
      .form-body {
        max-height:calc(100vh - 255px);
        overflow: scroll;
      }
      .save-btn-box {
        margin-top: 10px;
        margin-bottom: 0;
      }
    }
  }
</style>
