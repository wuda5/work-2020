<!-- 表具档案 -->
<template>
  <div v-loading="loading" class="form-page MeterInfo-form-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" :inline="true" label-position="top" class="qc-form disabled-form clearfix">
      <!-- 气表厂家 -->
      <el-form-item :label="$t('meterInfo.gasMeterFactoryName')" prop="gasMeterFactoryId">
        <el-select v-model="form.gasMeterFactoryId" name="gasMeterFactoryId" :disabled="iotMeterReadonly" filterable clearable :placeholder="`${$t('meterInfo.gasMeterFactoryName')}`" @change="handleChangeFactory">
          <el-option v-for="(item, index) in factoryList" :key="index" :value="item.id" :label="item.gasMeterFactoryName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表版号 -->
      <el-form-item :label="$t('meterInfo.gasMeterVersionName')" prop="gasMeterVersionId">
        <el-select v-model="form.gasMeterVersionId" name="gasMeterVersionId" :disabled="iotMeterReadonly" filterable clearable :placeholder="`${$t('meterInfo.gasMeterVersionName')}`" @change="handleChangeVersion">
          <el-option v-for="(item, index) in versionList" :key="index" :value="item.id" :label="item.gasMeterVersionName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表型号 -->
      <el-form-item :label="$t('meterInfo.gasMeterModelName')" prop="gasMeterModelId">
        <el-select v-model="form.gasMeterModelId" name="gasMeterModelId" :disabled="iotMeterReadonly" filterable clearable :placeholder="`${$t('meterInfo.gasMeterModelName')}`" @change="handleChangeModel">
          <el-option v-for="(item, index) in modelList" :key="index" :value="item.id" :label="item.modelName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表类型 -->
      <el-form-item :label="$t('meterInfo.gasMeterTypeCode')" prop="orderSourceName">
        <!-- <el-select v-model="form.gasMeterTypeCode" name="gasMeterTypeCode" disabled filterable clearable :placeholder="`${$t('meterInfo.gasMeterTypeCode')}`" @change="handleChangeGasMeterType">
          <el-option v-for="(value, key) in gasMeterTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select> -->
        <el-input v-model="gasMeterTypeMap[form.orderSourceName]" name="gasMeterTypeCode" disabled clearable placeholder="--"></el-input>
      </el-form-item>
      <!-- 表身号 -->
      <el-form-item v-if="isNormalForm" :label="$t('meterInfo.gasMeterNumber')" prop="gasMeterNumber" :rules="gasMeterNumberRules">
        <el-input v-model.trim="form.gasMeterNumber" name="gasMeterNumber" :disabled="iotMeterReadonly" clearable :placeholder="$t('meterInfo.gasMeterNumber')"></el-input>
      </el-form-item>
      <!-- 表底数 -->
      <el-form-item :label="$t('meterInfo.gasMeterBase')" prop="gasMeterBase">
        <qc-number-input v-model="form.gasMeterBase" name="gasMeterBase" :precision="2" :min="0" :placeholder="$t('meterInfo.gasMeterBase')"></qc-number-input>
      </el-form-item>
      <!-- 远程业务标志 -->
      <!-- <el-form-item v-if="IS_INTERNET_GASMETER(form)" :label="$t('meterInfo.remoteServiceFlag')" prop="remoteServiceFlag">
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select v-model="form.remoteServiceFlag" name="remoteServiceFlag" collapse-tags filterable multiple clearable :placeholder="`${$t('meterInfo.remoteServiceFlag')}`" @change="handleChangeRemoteServiceFlag">
              <el-option v-for="(value, key) in remoteServiceFlagMap" :key="key" :value="key" :label="value"></el-option>
            </el-select>
          </el-col>
          <el-col style="width: auto">
            <el-button type="primary" size="mini" @click.native="handleSelectAllRemoteServiceFlag">全选</el-button>
          </el-col>
        </el-row>
      </el-form-item> -->
      <!-- 结算类型 -->
      <!-- <el-form-item :label="$t('meterInfo.settlementType')" prop="settlementType">
        <el-select v-model="form.settlementType" name="settlementType" filterable clearable :placeholder="`${$t('meterInfo.settlementType')}`">
          <el-option v-for="(value, key) in settlementTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item> -->
      <!-- 结算模式 -->
      <!-- <el-form-item :label="$t('meterInfo.settlementMode')" prop="settlementMode">
        <el-select v-model="form.settlementMode" name="settlementMode" filterable clearable :placeholder="`${$t('meterInfo.settlementMode')}`">
          <el-option v-for="(value, key) in settlementModeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item> -->
      <!-- 收费类型 -->
      <!-- <el-form-item :label="$t('meterInfo.chargeType')" prop="chargeType">
        <el-select v-model="form.chargeType" name="chargeType" filterable clearable :placeholder="`${$t('meterInfo.chargeType')}`">
          <el-option v-for="(value, key) in chargeTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item> -->
      <!-- 通气方向 -->
      <el-form-item :label="$t('meterInfo.direction')" prop="direction">
        <el-select v-model="form.direction" name="direction" filterable clearable :placeholder="`${$t('meterInfo.direction')}`">
          <el-option v-for="(value, key) in directionMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 购买时间 -->
      <el-form-item prop="buyTime" :label="$t('meterInfo.buyTime')">
        <el-date-picker v-model="form.buyTime" type="date" value-format="yyyy-MM-dd" name="buyTime" :placeholder="$t('meterInfo.buyTime')"></el-date-picker>
      </el-form-item>
      <!-- 防盗扣编号 -->
      <el-form-item prop="safeCode" :label="$t('meterInfo.safeCode')">
        <el-input v-model="form.safeCode" name="safeCode" clearable :placeholder="$t('meterInfo.safeCode')"></el-input>
      </el-form-item>
      <!-- 检定时间 -->
      <el-form-item prop="checkTime" :label="$t('meterInfo.checkTime')">
        <el-date-picker v-model="form.checkTime" type="date" value-format="yyyy-MM-dd" name="checkTime" :placeholder="$t('meterInfo.checkTime')"></el-date-picker>
      </el-form-item>
      <!-- 检定人 -->
      <el-form-item prop="checkUser" :label="$t('meterInfo.checkUser')">
        <el-input v-model="form.checkUser" name="checkUser" clearable :placeholder="$t('meterInfo.checkUser')"></el-input>
      </el-form-item>
      <!-- 备注 -->
      <el-form-item prop="remark" :label="$t('meterInfo.remark')" class="remark-form-item">
        <el-input v-model="form.remark" name="remark" clearable :placeholder="$t('meterInfo.remark')"></el-input>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView && !isScanCodeForm" label=" " class="save-btn-box fr text-right">
        <el-button type="primary" name="savepreferential" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, isObjectLike } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import meterMixin from '@/mixins/meter'
import { formStatusField } from '@/enums/form'
import { dataStatusField } from '@/enums/common'
import { meterStatusField, diretionField } from '@/enums/meterInfo'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { positiveNumberReg, numberAndLetterReg } from '@/utils/reg'
import { meterFormFieldsMap } from '@/lang/zh/modules/meterInfo'
import { initQueryParams } from '@/utils/commons'
import { parseTime } from '@/utils/index'
import { arrayColumn, arrayCombine } from '@/utils/array'
import { saveData, getFactoryListData, getVersionListData, getModelListData } from '@/api/meterInfo/index'

export default {
  name: 'MeterInfoForm',
  components: {

  },
  filters: {},
  mixins: [commonMixin, formMixin, meterMixin],
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
    // 表单类型(1: 增加和编辑表单；2：扫码新增表单)
    type: {
      type: Number,
      default: 1
    },
  },
  data() {
    return {
      form: this.setInitForm(),
      // 表单验证规则
      formRules: {
        gasMeterFactoryId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterFactoryName')}`, trigger: 'change' }
        ],
        gasMeterFactoryName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterFactoryName')}`, trigger: 'change' }
        ],
        gasMeterVersionId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterVersionName')}`, trigger: 'change' }
        ],
        gasMeterVersionName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterVersionName')}`, trigger: 'change' }
        ],
        gasMeterModelId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterModelName')}`, trigger: 'change' }
        ],
        gasMeterModelName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterModelName')}`, trigger: 'change' }
        ],
        gasMeterTypeCode: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterTypeCode')}`, trigger: 'change' }
        ],
        direction: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.direction')}`, trigger: 'change' }
        ],
        // gasMeterNumber: [
        //   // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterNumber')}`, trigger: 'blur' }
        // ],
        buyTime: [
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.buyTime')}`, trigger: 'change' },
        ],
        // safeCode: [
        //   { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.safeCode')}`, trigger: 'blur' }
        // ],
        checkTime: [
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.checkTime')}`, trigger: 'change' },
        ],
        checkUser: [
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.checkUser')}`, trigger: 'blur' }
        ],
        settlementMode: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.settlementMode')}`, trigger: 'change' }
        ],
        settlementType: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.settlementType')}`, trigger: 'change' }
        ],
        chargeType: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.chargeType')}`, trigger: 'change' }
        ],
        remoteServiceFlag: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.remoteServiceFlag')}`, trigger: 'change' }
        ],
        gasMeterBase: [
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterBase')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('positiveNumberHint'), trigger: 'blur'  },
        ],
      },
      factoryList: [], // 气表厂家列表
      versionList: [], // 气表版号列表
      modelList: [], // 气表型号列表
    }
  },
  computed: {
    // 进气方向map
    directionMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.VENTILATION_DIRECTION)
    },
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
    // 结算模式map
    settlementModeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SETTLEMENT_MODE)
    },
    // 结算类型map
    settlementTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SETTLEMENT_TYPE)
    },
    // 收费类型map
    chargeTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.CHARGE_TYPE)
    },
    // 远程业务标志map
    remoteServiceFlagMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.REMOTE_SERVICE_FLAG)
    },

    // 是否是普通表单
    isNormalForm() {
      return this.type === 1
    },

    // 是否是扫码入库表单
    isScanCodeForm() {
      return this.type === 2
    },
    // 设置表身号的验证规则
    gasMeterNumberRules() {
      const rules = [{}]
      this.$refs[this.formRef]?.clearValidate('gasMeterNumber')
      if (this.IS_INTERNET_GASMETER(this.form)) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterNumber')}`, trigger: 'blur' })
      }
      rules.push({ pattern: numberAndLetterReg, message: `${this.$t('meterInfo.gasMeterNumberHint')}`, trigger: 'blur' })
      return rules
    },
    // 针对物联网某些数据不能编辑，只读
    iotMeterReadonly() {
      return this.IS_INTERNET_GASMETER(this.formData) && this.isEdit
    },

  },
  watch: {
    id: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
    formData: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
  },
  created() {
    this.initData()
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

    // 初始化表单数据
    setInitForm () {
      return {
        ...arrayCombine(Object.keys(meterFormFieldsMap), new Array(Object.keys(meterFormFieldsMap).length).fill('')),
        id: '',
        gasMeterBase: 0,
        direction: diretionField.LEFT_IN,
        dataStatus: meterStatusField.YJD,
      }
    },

    // 初始化监听的表单数据
    async initFormData() {
      this.loading = true
      await this.getFactoryList()
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
          const cloneFormData = cloneDeep(this.formData)
          try {
            cloneFormData.remoteServiceFlag = JSON.parse(cloneFormData.remoteServiceFlag).map((item) => item.code)
          } catch (error) {
            cloneFormData.remoteServiceFlag = []
          }
          data = cloneFormData
        }
      }
      this.setFormStatus(data)
      await this.generateFormData(data)
      const { gasMeterFactoryId, gasMeterVersionId } = this.form
      if (gasMeterFactoryId) {
        await this.getVersionList({ companyId: gasMeterFactoryId })
      }
      if (gasMeterVersionId) {
        await this.getModelList({ gasMeterVersionId: gasMeterVersionId })
      }
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
    
    // 保存数据
    saveFormData(data = null) {
      if (!data) {
        data = this.form
      }
      const cloneData = cloneDeep(data)
      cloneData.remoteServiceFlag = JSON.stringify((data.remoteServiceFlag || []).map((value) => ({ code: value, name: this.remoteServiceFlagMap[value]})))
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        saveData(this.isEdit ? cloneData : [cloneData], data?.id || '').then((result) => {
          // console.log('saveresult', result)
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

    // 获取气表厂家
    async getFactoryList() {
      if (this.factoryList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getFactoryListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.factoryList = data
           // 如果只有一条数据，默认赋值
           if (data.length === 1) {
             this.form.gasMeterFactoryName = data[0]?.gasMeterFactoryName ?? null
             this.form.gasMeterFactoryId = data[0]?.id ?? null
             this.$nextTick(() => {
               this.getVersionList({ companyId: this.form.gasMeterFactoryId })
             })
           }
         }
         resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取气表版号
    async getVersionList(params = {}) {
      this.loading = true
      return new Promise((resolve) => {
        getVersionListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, versionState: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.versionList = data
           // 如果只有一条数据，默认赋值
           if (data.length === 1) {
              this.form.gasMeterVersionId = data[0]?.id || null
              this.form.gasMeterVersionName = data[0]?.gasMeterVersionName || null
              this.form.orderSourceName = data[0]?.orderSourceName || null
              this.form.amountMark = data[0]?.amountMark || null
              this.$nextTick(() => {
                this.getModelList({ gasMeterVersionId: this.form.gasMeterVersionId })
              })
           }
         }
         resolve(isSuccess)
        })
        .catch(() => {
          resolve(false)
        })
        .finally(() => (this.loading = false))
      })
    },
    
    // 获取气表型号
    async getModelList(params = {}) {
      this.loading = true
      return new Promise((resolve) => {
        getModelListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.modelList = data
           // 如果只有一条数据，默认赋值
           if (data.length === 1) {
              this.form.gasMeterModelId = data[0]?.id || null
              this.form.gasMeterModelName = data[0]?.modelName || null
           }
         }
         resolve(isSuccess)
        })
        .catch(() => {
          resolve(false)
        })
        .finally(() => (this.loading = false))
      })
    },

    // 气表厂家发生变化, 清空气表版号信息，查找厂家名称赋值
    async handleChangeFactory(value) {
      this.form.gasMeterVersionId = null
      this.form.gasMeterVersionName = null
      this.versionList = []
      this.modelList = []
      const factory = this.factoryList.find((item) => item.id === value)
      if (factory) {
        this.form.gasMeterFactoryName = factory?.gasMeterFactoryName || null
        await this.getVersionList({ companyId: factory?.id })
      }
    },

    // 气表版号发生变化, 清空气表型号信息，查找版号名称赋值, 清空远程标志选择
    async handleChangeVersion(value) {
      this.form.gasMeterModelId = null
      this.form.gasMeterModelName = null
      this.form.remoteServiceFlag = null
      this.modelList = []
      const version = this.versionList.find((item) => item.id === value)
      if (version) {
        this.form.gasMeterVersionName = version?.gasMeterVersionName || null
        this.form.orderSourceName = version?.orderSourceName || null
        this.form.amountMark = version?.amountMark || null
        if (this.IS_INTERNET_GASMETER(this.form)) {
          this.form.remoteServiceFlag = Object.keys(this.remoteServiceFlagMap)
        }
        await this.getModelList({ gasMeterVersionId: version?.id })
      }
    },

    // 气表型号发生变化，查找型号名称赋值
    handleChangeModel(value) {
      const model = this.modelList.find((item) => item.id === value)
      if (model) {
        this.form.gasMeterModelName = model?.modelName || null
      }
    },

    // 气表类型发生变化
    handleChangeGasMeterType(value) {
      this.form.gasMeterTypeName = this.gasMeterTypeMap[value] ?? null
    },

    // 远程业务标志发生变化
    handleChangeRemoteServiceFlag(value) {

    },

    // 设置表身号的验证规则
    setGasMeterNumberRules() {
      const rules = [{}]
      this.$refs[this.formRef]?.clearValidate('gasMeterNumber')
      if (this.IS_INTERNET_GASMETER(this.form)) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterNumber')}`, trigger: 'blur' })
      }
      return rules
    },

    // 设置气表型号的验证规则
    setGasMeterModelRules() {
      const rules = []
      // if (this.IS_INTERNET_GASMETER(this.form)) {
      //   rules.push({ required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterModelName')}`, trigger: 'change' })
      // }
      return rules
    },

    // 远程标志全选
    handleSelectAllRemoteServiceFlag() {
      this.form.remoteServiceFlag = Object.keys(this.remoteServiceFlagMap)
    }
  }
}
</script>

<style scoped lang="scss">
  .remark-form-item {
    width: calc(100% / 3 * 1);
  }
</style>
