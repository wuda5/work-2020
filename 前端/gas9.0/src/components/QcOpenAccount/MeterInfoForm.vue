<!-- 表具档案 -->
<template>
  <div v-loading="loading" class="form-page MeterInfoForm-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" :inline="true" label-position="top" class="qc-form disabled-form meterinfo-form clearfix">
      <!-- 缴费编号 -->
      <el-form-item v-if="!+openCustomerPrefix" :label="$t('meterInfo.customerChargeNo')" prop="customerChargeNo">
        <el-input v-model="form.customerChargeNo" name="customerChargeNo" :disabled="!isOpenAccountForm" clearable :placeholder="$t('meterInfo.customerChargeNo')"></el-input>
      </el-form-item>
      <!-- 气表编号 -->
      <!-- <el-form-item :label="$t('meterInfo.gasCode')" prop="gasCode" class="gasCode-form-item">
        <el-tooltip v-if="form.gasCode" :content="form.gasCode" placement="bottom">
          <el-input v-model="form.gasCode" name="gasCode" clearable disabled :placeholder="$t('meterInfo.gasCode')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="form.gasCode" name="gasCode" clearable disabled :placeholder="$t('meterInfo.gasCode')"></el-input>
      </el-form-item> -->
      <!-- 报装编号 -->
      <el-form-item :label="$t('meterInfo.installNumber')" prop="installNumber">
        <el-input v-model="form.installNumber" name="installNumber" :disabled="!isOpenAccountForm" clearable :placeholder="$t('meterInfo.installNumber')"></el-input>
      </el-form-item>
      <!-- 气表厂家 -->
      <el-form-item :label="$t('meterInfo.gasMeterFactoryName')" prop="gasMeterFactoryId">
        <el-select v-model="form.gasMeterFactoryId" name="gasMeterFactoryId" :disabled="!isOpenAccountForm || isEdit" filterable clearable :placeholder="`${$t('meterInfo.gasMeterFactoryName')}`" @change="handleChangeFactory">
          <el-option v-for="(item, index) in factoryList" :key="index" :value="item.id" :label="item.gasMeterFactoryName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表版号 -->
      <el-form-item :label="$t('meterInfo.gasMeterVersionName')" prop="gasMeterVersionId">
        <el-select v-model="form.gasMeterVersionId" name="gasMeterVersionId" :disabled="!isOpenAccountForm || isEdit" filterable clearable :placeholder="`${$t('meterInfo.gasMeterVersionName')}`" @change="handleChangeVersion">
          <el-option v-for="(item, index) in versionList" :key="index" :value="item.id" :label="item.gasMeterVersionName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表型号 -->
      <el-form-item :label="$t('meterInfo.gasMeterModelName')" prop="gasMeterModelId">
        <el-select v-model="form.gasMeterModelId" name="gasMeterModelId" :disabled="!isOpenAccountForm || isEdit" filterable clearable :placeholder="`${$t('meterInfo.gasMeterModelName')}`" @change="handleChangeModel">
          <el-option v-for="(item, index) in modelList" :key="index" :value="item.id" :label="item.modelName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气表类型 -->
      <template>
        <el-tooltip v-if="form.orderSourceName" :content="gasMeterTypeMap[form.orderSourceName]" placement="bottom">
          <el-form-item :label="$t('meterInfo.gasMeterTypeCode')" prop="orderSourceName">
            <el-input v-model="gasMeterTypeMap[form.orderSourceName]" name="gasMeterTypeCode" disabled clearable placeholder="--"></el-input>
          </el-form-item>
        </el-tooltip>
        <el-form-item v-else :label="$t('meterInfo.gasMeterTypeCode')" prop="orderSourceName">
          <el-input v-model="gasMeterTypeMap[form.orderSourceName]" name="gasMeterTypeCode" disabled clearable placeholder="--"></el-input>
        </el-form-item>
      </template>
      <!-- 表身号 -->
      <el-form-item :label="$t('meterInfo.gasMeterNumber')" prop="gasMeterNumber" :rules="setGasMeterNumberRules()">
        <el-input v-model.trim="form.gasMeterNumber" name="gasMeterNumber" :disabled="(!isOpenAccountForm && IS_INTERNET_GASMETER(form)) || isEdit" clearable :placeholder="$t('meterInfo.gasMeterNumber')"></el-input>
      </el-form-item>
      <!-- 远程业务标志 -->
      <!-- <el-form-item v-if="IS_INTERNET_GASMETER(form)" :label="$t('meterInfo.remoteServiceFlag')" prop="remoteServiceFlag" class="remoteServiceFlag-form-item">
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
      <!-- 通气方向 -->
      <el-form-item :label="$t('meterInfo.direction')" prop="direction">
        <el-select v-model="form.direction" name="direction" filterable clearable :placeholder="`${$t('meterInfo.direction')}`">
          <el-option v-for="(value, key) in directionMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 用气类型 -->
      <el-form-item :label="$t('meterInfo.useGasTypeName')" prop="useGasTypeName">
        <el-select v-model="form.useGasTypeName" name="useGasTypeName" :disabled="!isOpenAccountForm" filterable clearable :placeholder="$t('meterInfo.useGasTypeName')" @change="handleUseGasTypeChange">
          <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.useGasTypeName" />
        </el-select>
      </el-form-item>
      <!-- 省市区 -->
      <template>
        <el-tooltip v-if="form.regionName" :content="form.regionName" placement="bottom">
          <el-form-item :label="$t('meterInfo.region')" prop="region" class="region-form-item">
            <el-cascader v-model="form.region" name="region" :options="regionCascadeList" :props="regionCascadeLProps" filterable clearable :placeholder="`${$t('selectHint')}${$t('meterInfo.region')}`" @change="handleRegionChange"></el-cascader>
          </el-form-item>
        </el-tooltip>
        <el-form-item v-else :label="$t('meterInfo.region')" prop="region" class="region-form-item">
          <el-cascader v-model="form.region" name="region" :options="regionCascadeList" :props="regionCascadeLProps" filterable clearable :placeholder="`${$t('selectHint')}${$t('meterInfo.region')}`" @change="handleRegionChange"></el-cascader>
        </el-form-item>
      </template>
      <!-- 街道(乡镇)名称 -->
      <el-form-item :label="$t('meterInfo.streetName')" prop="streetName">
        <el-select v-model="form.streetId" name="streetId" clearable :placeholder="$t('meterInfo.streetName')" @change="handleStreetChange">
          <el-option v-for="(item, index) in streetList" :key="index" :label="item.streetName" :value="item.id" />
        </el-select>
      </el-form-item>
      <!-- 小区(村、xx路) -->
      <el-form-item :label="$t('meterInfo.communityName')" prop="communityName">
        <el-select v-model="form.communityId" name="communityId" clearable :placeholder="$t('meterInfo.communityName')" @change="handleCommunityChange">
          <el-option v-for="(item, index) in communityList" :key="index" :label="item.communityName" :value="item.id" />
        </el-select>
      </el-form-item>
      <!-- 安装地址 -->
      <el-form-item prop="gasMeterAddress" :label="$t('meterInfo.gasMeterAddress')" class="gasMeterAddress-form-item" style="width: calc(100% / 7 * 2);">
        <el-input v-model="form.gasMeterAddress" name="gasMeterAddress" clearable :placeholder="$t('meterInfo.gasMeterAddress')" @blur="handleGasMeterAddressBlur">
          <el-button slot="append" type="success" @click="selectGasMeterAddressDialogVisible = true">{{ $t('meterInfo.selectGasMeterAddress') }}</el-button>
        </el-input>
      </el-form-item>
      <!-- 气表底数 -->
      <el-form-item :label="$t('meterInfo.gasMeterBase')" prop="gasMeterBase" :rules="setGasMeterBaseRules()">
        <qc-number-input v-model="form.gasMeterBase" name="gasMeterBase" :precision="2" :min="0" :placeholder="$t('meterInfo.gasMeterBase')" :disabled="!isOpenAccountForm"></qc-number-input>
      </el-form-item>
      <!-- 使用人口 -->
      <el-form-item prop="population" :label="$t('meterInfo.population')">
        <qc-number-input v-model="form.population" name="population" :precision="0" :min="1" :placeholder="$t('meterInfo.population')"></qc-number-input>
      </el-form-item>
      <!-- 调压箱号 -->
      <!-- <el-form-item prop="nodeNumber" :label="$t('meterInfo.nodeNumber')">
        <el-input v-model="form.nodeNumber" name="nodeNumber" clearable :placeholder="$t('meterInfo.nodeNumber')"></el-input>
      </el-form-item> -->
      <!-- 通气状态 -->
      <el-form-item v-if="!isOpenAccountForm" :label="$t('meterInfo.ventilateStatus')" prop="ventilateStatus">
        <el-select v-model.number="form.ventilateStatus" name="ventilateStatus" clearable :disabled="!isOpenAccountForm" :placeholder="$t('meterInfo.ventilateStatus')">
          <el-option v-for="(value, key) in ventilateStatusMap" :key="key" :label="value" :value="+key" />
        </el-select>
      </el-form-item>
      <!-- 通气人 -->
      <el-form-item v-if="!isOpenAccountForm" :label="$t('meterInfo.ventilateUserName')" prop="ventilateUserName">
        <el-select v-model.number="form.ventilateUserName" name="ventilateUserName" :disabled="!isOpenAccountForm" filterable remote :remote-method="handleSearchVentilateUser" :loading="ventilateUserListLoading" clearable :placeholder="isOpenAccountForm ? $t('searchPlaceholder') : ''" @change="handleVentilateUserChange">
          <el-option v-for="(item, index) in ventilateUserList" :key="index" :label="item.name" :value="item.name" />
        </el-select>
      </el-form-item>
      <!-- 通气时间 -->
      <el-form-item v-if="!isOpenAccountForm" prop="ventilateTime" :label="$t('meterInfo.ventilateTime')">
        <el-date-picker v-model="form.ventilateTime" type="date" :disabled="!isOpenAccountForm" value-format="yyyy-MM-dd" name="ventilateTime" :placeholder="$t('meterInfo.ventilateTime')"></el-date-picker>
      </el-form-item>
      <!-- 安检人 -->
      <el-form-item v-if="!isOpenAccountForm" :label="$t('meterInfo.securityUserName')" prop="securityUserName">
        <el-select v-model.number="form.securityUserName" :disabled="!isOpenAccountForm" name="securityUserName" filterable remote :remote-method="handleSearchSecurityUser" :loading="securityUserListLoading" clearable :placeholder="isOpenAccountForm ? $t('searchPlaceholder') : ''" @change="handleSecurityUserChange">
          <el-option v-for="(item, index) in securityUserList" :key="index" :label="item.name" :value="item.name" />
        </el-select>
      </el-form-item>
      <!-- 经度 -->
      <el-form-item prop="longitude" :label="$t('meterInfo.longitude')">
        <el-input v-model="form.longitude" type="number" name="longitude" clearable :placeholder="$t('meterInfo.longitude')"></el-input>
      </el-form-item>
      <!-- 维度 -->
      <el-form-item prop="latitude" :label="$t('meterInfo.latitude')">
        <el-input v-model="form.latitude" type="number" name="latitude" clearable :placeholder="$t('meterInfo.latitude')"></el-input>
      </el-form-item>
      <!-- 重置 -->
      <el-form-item v-if="showResetBtn" label=" " class="reset-btn-box text-right">
        <el-button
          type="warning"
          name="resetMeterInfo"
          :loading="submitLoading"
          :disabled="submitLoading"
          class="reset-btn"
          @click="handleReset()"
        >{{ $t('reset') }}</el-button>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button type="primary" name="openAccount" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isOpenAccountForm ? $t('customerInfo.openAccount') : (isAdd ? $t('add') : $t('save')) }}</el-button>
      </el-form-item>
    </el-form>
    
    <!-- 选择安装地址 -->
    <el-dialog
      width="60%"
      :title="$t('meterInfo.selectGasMeterAddress')"
      :visible.sync="selectGasMeterAddressDialogVisible"
      data-key="selectGasMeterAddressDialogVisible"
      :close-on-click-modal="false"
      :append-to-body="true"
      @close="selectGasMeterAddressDialogVisible = false"
    >
      <select-gas-meter-address v-if="selectGasMeterAddressDialogVisible" :meter-data="form" @success="handleSelectAddressSuccess"></select-gas-meter-address>
    </el-dialog>

    <!-- 百度地图控件 -->
    <baidu-map hidden ak="gixRA2mYVFj5U5LI5wcvVqKp" @ready="handleMapReady"></baidu-map>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, isUndefined, isEqual } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import baiduMapMixin from '@/mixins/baiduMap'
import meterMixin from '@/mixins/meter'
import { formStatusField } from '@/enums/form'
import { dataStatusField } from '@/enums/common'
import { meterStatusField, diretionField, ventilateStatusMap } from '@/enums/meterInfo'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { gasMeterFormFieldsMap } from '@/lang/zh/modules/meterInfo'
import { initQueryParams } from '@/utils/commons'
import { numberReg, positiveNumberReg, numberAndLetterReg } from '@/utils/reg'
import { arrayCombine, flatToNest } from '@/utils/array'
import { saveData, getStreetList, getCommunityList, getFactoryListData, getVersionListData, getModelListData } from '@/api/meterInfo/index'
import { getValidRegionList } from '@/api/operation/community'
import { getUseGasTypeList, OpenAccount } from '@/api/userInfo/index'
import userApi from '@/api/User'
import sysFunctionApi from '@/api/system/sysFunction'
import SelectGasMeterAddress from './SelectGasMeterAddress.vue'

export default {
  name: 'MeterInfoForm',
  components: {
    SelectGasMeterAddress,
  },
  filters: {},
  mixins: [commonMixin, formMixin, baiduMapMixin, meterMixin],
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
    // 客户信息
    customerData: {
      type: Object,
      default: () => ({})
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false
    },
    // 保存类型 1. 开户
    type: {
      type: Number,
      default: 1
    },

    // 是否显示重置按钮
    showResetBtn: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    this.ventilateStatusMap = ventilateStatusMap
    return {
      loading: true,
      initForm: {
        ...arrayCombine(Object.keys(gasMeterFormFieldsMap), new Array(Object.keys(gasMeterFormFieldsMap).length).fill('')),
        id: '',
        dataStatus: meterStatusField.DTQ,
        region: [],
        gasMeterBase: 0,
        direction: diretionField.LEFT_IN,
        regionName: null, // 区域显示全称
      },
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
          // { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterTypeCode')}`, trigger: 'change' }
        ],
        direction: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.direction')}`, trigger: 'change' }
        ],
        gasMeterNumber: {},
        useGasTypeName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.useGasTypeName')}`, trigger: 'change' },
        ],
        region: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.region')}`, trigger: 'change' },
        ],
        streetId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.streetName')}`, trigger: 'change' },
        ],
        streetName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.streetName')}`, trigger: 'change' },
        ],
        communityId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.communityName')}`, trigger: 'change' },
        ],
        communityName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.communityName')}`, trigger: 'change' },
        ],
        gasMeterAddress: [
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterAddress')}`, trigger: 'blur' },
        ],
        moreGasMeterAddress: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.moreGasMeterAddress')}`, trigger: 'blur' },
        ],
        population: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.population')}`, trigger: 'blur' },
          // { type: 'integer', min: 1, max: 10, message: `${this.$t('meterInfo.populationPositiveIntegerHint')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('meterInfo.populationPositiveIntegerHint')}`, trigger: 'blur' },
        ],
        longitude: [
          { pattern: numberReg, message: `${this.$t('numberHint')}`, trigger: 'blur' },
        ],
        latitude: [
          { pattern: numberReg, message: `${this.$t('numberHint')}`, trigger: 'blur' },
        ],
        gasMeterBase: [
          {},
          // { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterBase')}`, trigger: 'blur' },
          // { pattern: positiveNumberReg, message: this.$t('positiveNumberHint'), trigger: 'blur'  },
        ],
        customerChargeNo: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.customerChargeNo')}`, trigger: 'blur' },
        ],
      },
      useGasTypeList: [], // 用气类型列表
      regionList: [], // 地区列表
      streetList: [], // 街道列表
      communityList: [], // 小区列表
      // 地区级联数据配置
      regionCascadeLProps: {
        value: 'code'
      },
      selectGasMeterAddressDialogVisible: false, // 选择安装地址弹出框标识
      userList: [], // 所有有效用户
      ventilateUserList: [], // 供选择的通气员
      ventilateUserListLoading: false, // 供选择的通气员数据加载状态
      securityUserList: [], // 供选择的安检人
      securityUserListLoading: false, // 供选择的安检人数据加载状态
      factoryList: [], // 气表厂家列表
      versionList: [], // 气表版号列表
      modelList: [], // 气表型号列表
      openCustomerPrefix: 0, // 缴费编号是否人工录入。默认是
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
    // 远程业务标志map
    remoteServiceFlagMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.REMOTE_SERVICE_FLAG)
    },
    // 省市区级联列表
    regionCascadeList() {
      if (this.regionList && this.regionList.length > 0) {
        return flatToNest(this.regionList, { defaultParentIdValue: '0' })
      } else {
        return []
      }
    },
    // 开户操作
    isOpenAccountForm() {
      return this.type === 1
    },
    // 是否气表底数是必填项
    isRequriedGasMeterBase() {
      return this.form?.radix
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
      handler(value, oldValue) {
        // console.log('value', isEqual(oldValue, value))
        this.initFormData(isEqual(oldValue, value))
      },
      immediate: false
    },
    customerData: {
      handler(value) {
        // this.initFormData()
      },
      immediate: false
    },
    // 监听完整安装地址
    'form.moreGasMeterAddress': {
      async handler(value) {
        if (value) {
          await this.calcGis(value)
        } else {
          this.form.longitude = null
          this.form.latitude = null
        }
      },
      immediate: false,
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
      // this.loading = true
      this.setFormStatus()
      // 获取厂家列表
      await this.getFactoryList()
      // 获取有效用气类型
      await this.getValidUseGasTypeList()
      // 获取有效用户
      await this.getValidUserList()
      // 获取省市区列表
       await this.getRegionListData()
      // 获取缴费编号配置
      await this.getChargeNoConfig()
      await this.getFormData(false)
      this.loading = false
    },

    // 初始化监听的表单数据
    async initFormData(isEqualForm) {
      this.loading = true
      this.setFormStatus()
      await this.getFormData(isEqualForm)
      setTimeout(async () => {
        this.loading = false
      }, 500)
    },

    // 获取表单数据
    getFormData(isEqualForm) {
      return new Promise(async (resolve) => {
        if (this.id) {
          // 请求api获取表单数据
          this.resetForm()
          resolve(true)
        } else if(!isEmpty(this.formData) || !isEmpty(this.customerData)) {
          const newData = this.filterFormData(this.formData)
          // console.log('newData', newData)
          const { gasMeterFactoryId, gasMeterVersionId, gasMeterModelId } = newData
          // 赋值远程标志
          try {
            newData.remoteServiceFlag = JSON.parse(newData.remoteServiceFlag).map((item) => item.code)
          } catch (error) {
            newData.remoteServiceFlag = []
          }

          const { customerChargeNo } = this.form
          // 赋值用户已经输入的缴费编号
          if (customerChargeNo) {
            newData.customerChargeNo = this.form.customerChargeNo
          }

          this.resetForm(newData)
          // prop传入的不是相同表单则走一下操作
          if (!isEqualForm) {
            // console.log('isEqualForm', isEqualForm)
            // 厂家名称赋值并获取版号列表
            if (gasMeterFactoryId) {
              await this.handleChangeFactory(gasMeterFactoryId, false)
            }
            // 版号名称赋值并获取版号列表
            if (gasMeterVersionId) {
              await this.handleChangeVersion(gasMeterVersionId, false)
            }
            // 型号名称赋值
            if (gasMeterModelId) {
              await this.handleChangeModel(gasMeterModelId)
            }
            await this.getAddressAboutData(newData)
          }
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },

    // 获取安装地址相关的数据赋值和下拉列表
    async getAddressAboutData(formData) {
      const { provinceCode, cityCode, areaCode, communityId, streetId } = formData
      // 省市区名字赋值并获取街道列表
      if (provinceCode && cityCode && areaCode) {
        const region = [provinceCode, cityCode, areaCode]
        this.form.region = region
        await this.handleRegionChange(region, false)
      }
      // 街道名称赋值并获取小区列表
      if (streetId) {
        await this.handleStreetChange(streetId, false)
      }
      // 小区名称赋值并组装完整地址
      if (communityId) {
        await this.handleCommunityChange(communityId)
      }
    },

    // 对获取的表单数据进行过滤
    filterFormData(formData, initFormData) {
      const cloneInitFormData = cloneDeep(initFormData || this.initForm)
      // const cloneFormData = { ...cloneDeep(this.customerData), ...cloneDeep(formData) }
      const cloneFormData = { ...cloneDeep(formData) }
      for(const key in cloneInitFormData) {
        const value = cloneFormData[key]
        if (!isUndefined(value)) {
          cloneInitFormData[key] = value
        }
      }
      // console.log('cloneInitFormData', cloneInitFormData)
      return cloneInitFormData
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
    saveOpenAccountData(data = null) {
      if (!data) {
        data = this.form
      }
      const cloneData = cloneDeep(data)
      // 远程业务标志
      cloneData.remoteServiceFlag = JSON.stringify((data.remoteServiceFlag || []).map((value) => ({ code: value, name: this.remoteServiceFlagMap[value]})))
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        OpenAccount(cloneData, data?.customerCode ?? null).then((result) => {
          // console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 开户成功客户列表和表具列表清空
            resolve(this.form)
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

    // 保存编辑数据
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
            resolve(data ?? this.form)
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
      return new Promise((resolve) => {
        // 开户
        if (this.isOpenAccountForm) {
          // const { customerCode } = this.customerData || {}
          // const { id, gasCode } = this.form
          // if (!customerCode) {
          //   this.$message.error(this.$t('meterInfo.selectCustomer'))
          //   resolve(false)
          //   return
          // }
          // if (!id || !gasCode) {
          //   this.$message.error(this.$t('meterInfo.selectMeter'))
          //   resolve(false)
          //   return
          // }
        }
        this.$refs[this.formRef].validate(async(valid) => {
          if (valid) {
            let saveResult
            let msg
            // 开户
            if (this.isOpenAccountForm) {
              saveResult = await this.saveOpenAccountData()
              msg = this.$t('meterInfo.openAccountSuccess')
            } else { // 编辑
              saveResult = await this.saveFormData()
              msg = this.$t('saveSuccess')
            }
            if (saveResult) {
              this.$message.success(msg)
              // 传递保存成功时间回父级组件
              this.$emit('success', saveResult)
            }
            resolve(saveResult)
            // return Promise.resolve(saveResult)
          } else {
            this.$message.error(this.$t('validateError'))
            resolve(false)
            // return Promise.resolve(false)
          }
        })
      })
    },
    
    // 验证表单信息,返回表单数据
    validateForm() {
      return new Promise((resolve) => {
        this.$refs[this.formRef]?.validate((valid) => {
          const cloneData = cloneDeep(this.form)
          if (!valid) {
            this.$message.error('请核对填写的表具信息是否有误！')
          } else {
            cloneData.remoteServiceFlag = JSON.stringify((this.form.remoteServiceFlag || []).map((value) => ({ code: value, name: this.remoteServiceFlagMap[value]})))
          }
          resolve(valid ? cloneData : false)
        })
      })
    },

    // 重置表单
    handleReset() {
      // this.$refs[this.formRef]?.resetFields()
      this.resetForm()
      this.$emit('update:formData', {})
    },

    // 获取缴费编号配置项
    getChargeNoConfig() {
      return new Promise((resolve) => {
        sysFunctionApi.getOne({ item: 'openCustomerPrefix' })
        .then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.openCustomerPrefix = data
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
      })
    },

    // 获取用气类型列表
    getValidUseGasTypeList() {
      if (this.useGasTypeList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
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

    // 获取地区数据
    async getRegionListData() {
      if(this.regionList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getValidRegionList().then((result) => {
          // console.log(result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.regionList = data
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取有效街道列表
    getValidStreetList(params = {}, autoFill = true) {
      return new Promise((resolve) => {
        this.loading = true
        getStreetList(initQueryParams({ model: { dataStatus: dataStatusField.VALID, ...params }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.streetList = records
            // 如果只有一条数据，默认赋值
            if (autoFill && records.length === 1) {
              const firstData = records[0]
              Object.assign(this.form, { streetId: firstData.id, streetName: firstData.streetName })
              this.$nextTick(() => {
                this.getValidCommunityList({
                  streetId: firstData.id
                })
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
          resolve(false)
        })
      })
    },

    // 获取有效小区列表
    getValidCommunityList(params = {}, autoFill = true) {
      return new Promise((resolve) => {
        this.loading = true
        getCommunityList(initQueryParams({ model: { dataStatus: dataStatusField.VALID, ...params }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.communityList = records
            // 如果只有一条数据，默认赋值
            if (autoFill && records.length === 1) {
              const firstData = records[0]
              Object.assign(this.form, { communityId: firstData.id, communityName: firstData.communityName })
              this.$nextTick(() => {
                // 组装地址
                this.generateFullGasMeterAddress()
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
          resolve(false)
        })
      })
    },

    // 用气类型选择变化
    handleUseGasTypeChange(value) {
      const useGasType = this.useGasTypeList.find((item) => item.useGasTypeName === value)
      this.form.useGasTypeId = useGasType?.id ?? null
    },

    // 通过region code查找region信息
    findRegionNameByCode(code) {
      const region = this.regionList.find((region) => region.code === code)
      return region ? region.label : ''
    },

    // 省市区选择改变
    async handleRegionChange(value, reset = true) {
      // console.log(value)
      // 置空小区和街道
      if (reset) {
        this.form.streetId = null
        this.form.streetName = null
        this.form.communityId = null
        this.form.communityName = null
        this.form.regionName = null
      }
      if (value.length > 0) {
        const provinceCode = value[0] ?? null
        const cityCode = value[1] ?? null
        const areaCode = value[2] ?? null
        const provinceName = this.findRegionNameByCode(provinceCode)
        const cityName = this.findRegionNameByCode(cityCode)
        const areaName = this.findRegionNameByCode(areaCode)
        this.form.regionName = `${provinceName}/${cityName}/${areaName}`
        // 名字赋值
        Object.assign(this.form, { provinceCode, provinceName , cityCode, cityName, areaCode, areaName })
        await this.getValidStreetList({
          provinceCode,
          cityCode,
          areaCode,
        }, reset)
      }
    },

    // 街道选择发生变化
    async handleStreetChange(value, reset = true) {
      // 小区信息置空
      if (reset) {
        this.form.communityId = ''
        this.form.communityName = ''
      }
      const street = this.streetList.find((item) => item.id === value)
      const streetId = street?.id ?? null
      const streetName = street?.streetName ?? null
      this.form.streetName = streetName
      if (streetId) {
        await this.getValidCommunityList({
          streetId
        }, reset)
      }
    },

    // 小区选择发生变化
    handleCommunityChange(value) {
      const community = this.communityList.find((item) => item.id === value)
      const communityId = community?.id ?? null
      const communityName = community?.communityName ?? null
      this.form.communityName = communityName
      if (value) {
        // 组装地址
        this.generateFullGasMeterAddress()
      }
    },

    // 选择地址成功
    handleSelectAddressSuccess(data) {
      // console.log(data)
      const { region, provinceCode, provinceName, cityCode, cityName, areaCode, areaName, streetId, streetName, communityId, communityName, moreDetailAddress, fullAddress } = data
      Object.assign(this.form, { region, provinceCode, provinceName, cityCode, cityName, areaCode, areaName, streetId, streetName, communityId, communityName, gasMeterAddress: moreDetailAddress, moreGasMeterAddress: fullAddress })
      this.$nextTick(async () => {
        await this.getAddressAboutData(data)
        this.$refs[this.formRef]?.clearValidate('gasMeterAddress')
        this.selectGasMeterAddressDialogVisible = false
      })
    },

    // 选择通气人发生变化
    handleVentilateUserChange(value) {
      const user = this.userList.find((item) => item.name === value)
      this.form.ventilateUserId = user?.id ?? null
    },

    // 选择安全发生变化
    handleSecurityUserChange(value) {
      const user = this.userList.find((item) => item.name === value)
      this.form.securityUserId = user?.id ?? null
    },

    // 获取用户列表
    getValidUserList() {
      if (this.userList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        userApi.page(initQueryParams({
          model: {
            dataStatus: dataStatusField.VALID
          },
          size: 10000,
        })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.userList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    handleSearchUserList(keyword) {
      return this.userList.filter((item) => item.name.includes(keyword.trim()))
    },

    // 输入名字搜索数据
    handleSearchVentilateUser(value) {
      if (value !== '') {
        this.ventilateUserListLoading = true
        setTimeout(() => {
          this.ventilateUserListLoading = false
          this.ventilateUserList = this.handleSearchUserList(value)
        }, 200)
      }
    },

    // 输入名字搜索数据
    handleSearchSecurityUser(value) {
      if (value !== '') {
        this.securityUserListLoading = true
        setTimeout(() => {
          this.securityUserListLoading = false
          this.securityUserList = this.handleSearchUserList(value)
        }, 200)
      }
    },
    
    // 获取气表厂家
    async getFactoryList(params = {}, autoFill = true) {
      if (this.factoryList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getFactoryListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.factoryList = data
           // 如果只有一条数据，默认赋值
           if (autoFill && data.length === 1) {
            const firstData = data[0]
            Object.assign(this.form, { gasMeterFactoryId: firstData.id, gasMeterFactoryName: firstData.gasMeterFactoryName })
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
    async getVersionList(params = {}, autoFill = true) {
      this.loading = true
      return new Promise((resolve) => {
        getVersionListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, versionState: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.versionList = data
           // 如果只有一条数据，默认赋值
           if (autoFill && data.length === 1) {
              const firstData = data[0]
              Object.assign(this.form, { gasMeterVersionId: firstData.id, gasMeterVersionName: firstData.gasMeterVersionName, orderSourceName: firstData.orderSourceName, amountMark: firstData.amountMark, radix: firstData.radix })
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
    async getModelList(params = {}, autoFill = true) {
      this.loading = true
      return new Promise((resolve) => {
        getModelListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.modelList = data
           // 如果只有一条数据，默认赋值
           if (autoFill && data.length === 1) {
              const firstData = data[0]
              Object.assign(this.form, { gasMeterModelId: firstData.id, gasMeterModelName: firstData.modelName })
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
    async handleChangeFactory(value, reset = true) {
      if (reset) {
        this.form.gasMeterVersionId = null
        this.form.gasMeterVersionName = null
        this.versionList = []
        this.modelList = []
      }
      const factory = this.factoryList.find((item) => item.id === value)
      if (factory) {
        this.form.gasMeterFactoryName = factory?.gasMeterFactoryName || null
        await this.getVersionList({ companyId: factory?.id }, reset)
      }
    },

    // 气表版号发生变化, 清空气表型号信息，查找版号名称赋值, 清空远程标志选择
    async handleChangeVersion(value, reset = true) {
      if (reset) {
        this.form.gasMeterModelId = null
        this.form.gasMeterModelName = null
        this.form.remoteServiceFlag = null
      }
      this.modelList = []
      const version = this.versionList.find((item) => item.id === value)
      if (version) {
        this.form.gasMeterVersionName = version?.gasMeterVersionName || null
        this.form.orderSourceName = version?.orderSourceName || null
        this.form.amountMark = version?.amountMark || null
        this.form.radix = version?.radix || null
        if (this.IS_INTERNET_GASMETER(this.form)) {
          this.form.remoteServiceFlag = Object.keys(this.remoteServiceFlagMap)
        }
        await this.getModelList({ gasMeterVersionId: version?.id }, reset)
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

    // 拼接完整地址并且进行GIS计算
    async generateFullGasMeterAddress() {
      const { provinceName, cityName, areaName, streetName, communityName, gasMeterAddress } = this.form
      let moreGasMeterAddress = ''
      if (provinceName) {
        moreGasMeterAddress += provinceName
      }
      if (cityName) {
        moreGasMeterAddress += cityName
      }
      if (areaName) {
        moreGasMeterAddress += areaName
      }
      if (streetName) {
        moreGasMeterAddress += streetName
      }
      if (communityName) {
        moreGasMeterAddress += communityName
      }
      if (gasMeterAddress) {
        moreGasMeterAddress += gasMeterAddress
      }
      this.form.moreGasMeterAddress = moreGasMeterAddress
      await this.calcGis(this.form.moreGasMeterAddress)
      return this.form.moreGasMeterAddress
    },

    // 计算地址GIS并赋值
    async calcGis(address) {
      const point = await this.getPoint(address, 'xxx')
      this.form.longitude = point?.lng
      this.form.latitude = point?.lat
      return Promise.resolve(true)
    },

    // 安装地址输入失去焦点
    async handleGasMeterAddressBlur() {
      const { gasMeterAddress } = this.form
      this.generateFullGasMeterAddress()
      // if (gasMeterAddress) {
      // }
    },

    // 设置表身号的验证规则
    setGasMeterNumberRules() {
      const rules = [{}]
      this.$refs[this.formRef]?.clearValidate('gasMeterNumber')
      if (this.IS_INTERNET_GASMETER(this.form)) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterNumber')}`, trigger: 'blur' })
      }
      rules.push({ pattern: numberAndLetterReg, message: `${this.$t('meterInfo.gasMeterNumberHint')}`, trigger: 'blur' })
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

    // 设置气表底数的验证规则
    setGasMeterBaseRules() {
      const rules = []
      if (this.isRequriedGasMeterBase) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('meterInfo.gasMeterBase')}`, trigger: 'blur' })
      }
      rules.push({ pattern: positiveNumberReg, message: this.$t('positiveNumberHint'), trigger: 'blur'  })
      return rules
    },

    // 用气类型全选
    handleSelectAllRemoteServiceFlag() {
      this.form.remoteServiceFlag = Object.keys(this.remoteServiceFlagMap)
    }
  }
}
</script>

<style scoped lang="scss">
  .MeterInfoForm-page {
    .qc-form {
      ::v-deep {
        .el-form-item {
          width: calc(100% / 7);
        }
        .region-form-item {
          .el-cascader {
            width: 100%;
          }
        }
        .remoteServiceFlag-form-item {
          width: calc(100% / 7 * 2);
        }
        .gasMeterAddress-form-item {
          .el-input-group__append {
            border-color: $primary;
            background-color: $primary;
            color: white;
          }
        }
        .reset-btn {
          width: 100%;
        }
      }
    }
  }
</style>
