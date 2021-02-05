<!-- 用气类型表单 -->
<template>
  <div v-loading="loading" class="form-page use-gas-type-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" :inline="true" class="qc-form clearfix use-gas-type-form">
      <!-- 用气类型名称 -->
      <el-form-item :label="$t('operation.gasPrice.useGasTypeName')" prop="useGasTypeName">
        <el-input v-model="form.useGasTypeName" :placeholder="$t('operation.gasPrice.useGasTypeName')" name="useGasTypeName"></el-input>
      </el-form-item>
      <!-- 用气类型 -->
      <!-- <el-form-item :label="$t('operation.gasPrice.userTypeCode')" prop="userTypeCode">
        <el-select v-model="form.userTypeCode" name="userTypeCode" :disabled="isEdit" :placeholder="`${$t('selectHint')}${$t('operation.gasPrice.userTypeCode')}`">
          <el-option v-for="(value, key) in userTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item> -->
      <!-- 燃气类型 -->
      <el-form-item :label="$t('operation.gasPrice.gasType')" prop="gasType">
        <el-select v-model="form.gasType" name="gasType" :disabled="isEdit" :placeholder="`${$t('selectHint')}${$t('operation.gasPrice.gasType')}`">
          <el-option v-for="(value, key) in gasTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 气价类型 -->
      <el-form-item :label="$t('operation.gasPrice.priceType')" prop="priceType">
        <el-select v-model="form.priceType" name="priceType" :disabled="isEdit" :placeholder="`${$t('selectHint')}${$t('operation.gasPrice.priceType')}`">
          <el-option v-for="(value, key) in priceTypeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 最小储蓄量 -->
      <el-form-item :label="$t('operation.gasPrice.minDeposit')" prop="minDeposit">
        <qc-number-input v-model="form.minDeposit" name="minDeposit" :precision="2" clearable :placeholder="$t('operation.gasPrice.minDeposit')"></qc-number-input>
      </el-form-item>
      <!-- 最大储蓄量 -->
      <el-form-item :label="$t('operation.gasPrice.maxDeposit')" prop="maxDeposit">
        <qc-number-input v-model="form.maxDeposit" name="maxDeposit" :precision="2" clearable :placeholder="$t('operation.gasPrice.maxDeposit')"></qc-number-input>
      </el-form-item>
      <!-- 最大充值气量 -->
      <el-form-item :label="$t('operation.gasPrice.maxChargeGas')" prop="maxChargeGas">
        <qc-number-input v-model="form.maxChargeGas" name="maxChargeGas" :precision="2" clearable :placeholder="$t('operation.gasPrice.maxChargeGas')"></qc-number-input>
      </el-form-item>
      <!-- 最大充值金额 -->
      <el-form-item :label="$t('operation.gasPrice.maxChargeMoney')" prop="maxChargeMoney">
        <qc-number-input v-model="form.maxChargeMoney" name="maxChargeMoney" :precision="2" clearable :placeholder="$t('operation.gasPrice.maxChargeMoney')"></qc-number-input>
      </el-form-item>
      <!-- 报警气量 -->
      <el-form-item :label="$t('operation.gasPrice.alarmGas')" prop="alarmGas">
        <qc-number-input v-model="form.alarmGas" name="alarmGas" :precision="2" clearable :placeholder="$t('operation.gasPrice.alarmGas')"></qc-number-input>
      </el-form-item>
      <!-- 一级报警金额 -->
      <el-form-item :label="$t('operation.gasPrice.alarmMoney')" prop="alarmMoney">
        <qc-number-input v-model="form.alarmMoney" name="alarmMoney" :precision="2" clearable :placeholder="$t('operation.gasPrice.alarmMoney')"></qc-number-input>
      </el-form-item>
      <!-- 二级报警金额 -->
      <el-form-item :label="$t('operation.gasPrice.alarmMoneyTwo')" prop="alarmMoneyTwo">
        <qc-number-input v-model="form.alarmMoneyTwo" name="alarmMoneyTwo" :precision="2" clearable :placeholder="$t('operation.gasPrice.alarmMoneyTwo')"></qc-number-input>
      </el-form-item>
      <template v-if="!IS_FIXED_PRICE">
        <!-- <div class="clearfix"></div> -->
        <!-- 启用开户按月递减 -->
        <el-form-item label=" " prop="openDecrement" class="checkbox-item">
          <el-checkbox v-model="form.openDecrement" name="openDecrement" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE" @change="handleOpenDecrementChange">{{ $t('operation.gasPrice.openDecrement') }}</el-checkbox>
        </el-form-item>
        <!-- 递减量 -->
        <el-form-item :label="$t('operation.gasPrice.decrement')" prop="decrement">
          <el-input v-model="form.decrement" type="number" name="decrement" clearable :placeholder="$t('operation.gasPrice.decrement')"></el-input>
        </el-form-item>
        <div class="clearfix"></div>
        <!-- 启用人口递增 -->
        <el-form-item label=" " prop="populationGrowth" class="checkbox-item">
          <el-checkbox v-model="form.populationGrowth" name="populationGrowth" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE" @change="handlePopulationGrowthChange">{{ $t('operation.gasPrice.populationGrowth') }}</el-checkbox>
        </el-form-item>
        <!-- 启用人口递增展示表单字段 -->
        <!-- <template v-if="isPopulationGrowth"> -->
        <template>
          <!-- 人口基数 -->
          <el-form-item :label="$t('operation.gasPrice.populationBase')" prop="populationBase">
            <el-input v-model.number="form.populationBase" type="number" clearable name="populationBase" :placeholder="$t('operation.gasPrice.populationBase')"></el-input>
          </el-form-item>
          <!-- 人口递增量 -->
          <el-form-item :label="$t('operation.gasPrice.populationIncrease')" prop="populationIncrease">
            <el-input v-model="form.populationIncrease" type="number" clearable name="populationIncrease" :placeholder="$t('operation.gasPrice.populationIncrease')"></el-input>
          </el-form-item>
          <!-- <div class="clearfix"></div> -->
        </template>
      </template>
      <!-- 操作 -->
      <!-- <el-form-item :label="IS_FIXED_PRICE ? ' ' : ''" :style="{ marginTop: IS_FIXED_PRICE ? '' : '10px' }" class="save-btn-box text-right fr"> -->
      <el-form-item label=" " class="save-btn-box text-right fr">
        <el-button type="primary" name="saveUseGasTypeName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, isUndefined, isNull } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { priceTypeField } from '@/enums/gasPrice'
import { useGasFormFieldsMap } from '@/lang/zh/modules/operation/gasPrice'
import { arrayCombine } from '@/utils/array'
import { positiveNumberReg, positiveIntegerReg } from '@/utils/reg'
import { saveUseGasType } from '@/api/operation/gasPrice'
import { reject } from '@/api/temporary/priceChange'

export default {
  name: 'UseGasTypeForm',
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
    }
  },
  data() {
    this.useStatusField = useStatusField
    // 报警金额和最大充值金额验证
    const maxChargeMoneyAndMMoneyValidator = (rule, value) => {
      return new Promise((resolve, reject) => {
        const { alarmMoney, alarmMoneyTwo, maxChargeMoney } = this.form
        if (positiveNumberReg.test(maxChargeMoney) && positiveNumberReg.test(alarmMoneyTwo)) {
          if (+alarmMoneyTwo > +maxChargeMoney) {
            reject(this.$t('operation.gasPrice.alarmMoneyandaxChargeMoneyCompareHint'))
          } else {
            this.$refs[this.formRef]?.clearValidate(['maxChargeMoney', 'alarmMoneyTwo'])
            resolve(true)
          }
        } else {
          resolve(true)
        }
      })
    }
    // 报警金额验证
    const alarmMoneyValidator = (rule, value) => {
      return new Promise((resolve, reject) => {
        const { alarmMoney, alarmMoneyTwo } = this.form
        if (positiveNumberReg.test(alarmMoney) && positiveNumberReg.test(alarmMoneyTwo)) {
          if (+alarmMoney >= +alarmMoneyTwo) {
            reject(this.$t('operation.gasPrice.alarmMoneyCompareHint'))
          } else {
            this.$refs[this.formRef]?.clearValidate(['alarmMoney', 'alarmMoneyTwo'])
            resolve(true)
          }
        } else {
          resolve(true)
        }
      })
    }
    return {
      initForm: {
        ...arrayCombine(Object.keys(useGasFormFieldsMap), new Array(Object.keys(useGasFormFieldsMap).length).fill('')),
        id: '',
        // alarmMoney: undefined,
        // alarmMoneyTwo: undefined,
        dataStatus: dataStatusField.VALID,
        openDecrement: useStatusField.DISABLE,
        populationGrowth: useStatusField.DISABLE,
      },
      // 表单验证规则
      formRules: {
        useGasTypeName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.useGasTypeName')}`, trigger: 'blur' },
        ],
        userTypeCode: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.userTypeCode')}`, trigger: 'change' }
        ],
        gasType: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.gasType')}`, trigger: 'change' },
        ],
        priceType: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.priceType')}`, trigger: 'change' },
        ],
        maxChargeGas: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.maxChargeGas')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.maxChargeGasNumberHint'), trigger: 'blur'  },
        ],
        maxChargeMoney: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.maxChargeMoney')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.maxChargeMoneyNumberHint'), trigger: 'blur'  },
          { validator: maxChargeMoneyAndMMoneyValidator, trigger: 'blur' }
        ],
        alarmGas: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.alarmGas')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.alarmGasNumberHint'), trigger: 'blur'  },
        ],
        alarmMoney: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.alarmMoney')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.alarmMoneyNumberHint'), trigger: 'blur'  },
          { validator: alarmMoneyValidator, trigger: 'blur' }
        ],
        alarmMoneyTwo: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.alarmMoneyTwo')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.alarmMoneyTwoNumberHint'), trigger: 'blur'  },
          { validator: maxChargeMoneyAndMMoneyValidator, trigger: 'blur' },
          { validator: alarmMoneyValidator, trigger: 'blur' }
        ],
        decrement: {},
        populationBase: {},
        populationIncrease: {},
        minDeposit: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.minDeposit')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: `${this.$t('operation.gasPrice.minDepositNumberHint')}`, trigger: 'blur' },
        ],
        maxDeposit: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.maxDeposit')}`, trigger: 'blur' },
          { pattern: positiveNumberReg, message: `${this.$t('operation.gasPrice.maxDepositNumberHint')}`, trigger: 'blur' },
          { validator: (rule, value) => {
            const minDeposit = this.form.minDeposit
            if (minDeposit && value && +value <= +minDeposit) {
              return Promise.reject(`${this.$t('operation.gasPrice.depositCompareHint')}`)
            } else {
              return Promise.resolve(true)
            }
          }, trigger: 'blur' },
        ],
      },
    }
  },
  computed: {
    // 用气类型map
    userTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.USER_TYPE)
    },
    // 燃气类型map
    gasTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.GAS_TYPE)
    },
    // 气价类型map
    priceTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.PRICE_TYPE)
    },
    // 是否启用开户按月递减
    isOpenDecrement() {
      return this.form.openDecrement === useStatusField.ENABLE
    },
    // 是否启用人口递增
    isPopulationGrowth() {
      return this.form.populationGrowth === useStatusField.ENABLE
    },
    // 气价类型是固定价格
    IS_FIXED_PRICE() {
      return this.form.priceType === priceTypeField.FIXED_PRICE
    },
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
    },
    'form.userTypeCode': {
      handler(value) {
        this.form.userTypeName = this.userTypeMap[value] || ''
      }
    },
    // 监听启用开户按月递减
    'form.openDecrement': {
      handler(value, oldValue) {
        this.$set(this.formRules, 'decrement', this.setDecrementRules())
      },
      immediate: true,
    },
    // 监听启用人口递增
    'form.populationGrowth': {
      handler(value, oldValue) {
        this.$set(this.formRules, 'populationBase', this.setPopulationBaseRules())
        this.$set(this.formRules, 'populationIncrease', this.setPopulationIncreaseRules())
      },
      immediate: true,
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
        saveUseGasType(data, data?.id || '').then((result) => {
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
    async handleSubmit() {
        console.log('dfasfasgsdg')
      this.$refs[this.formRef].validate(async(valid) => {
        console.log('valid', valid)
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

    // 开户按月递减量字段验证
    setDecrementRules() {
      const rules = []
      if (this.isOpenDecrement) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.decrement')}`, trigger: 'blur' })
        rules.push({ pattern: positiveNumberReg, message: `${this.$t('operation.gasPrice.decrementNumberHint')}`, trigger: 'blur' })
      }
      return rules
    },

    // 人口基数字段验证
    setPopulationBaseRules() {
      const rules = []
      if (this.isPopulationGrowth) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.populationBase')}`, trigger: 'blur' })
        rules.push({ type: 'integer', min: 1, message: `${this.$t('operation.gasPrice.populationBaseNumberHint')}`, trigger: 'blur' })
      }
      return rules
    },

    // 人口递增量字段验证
    setPopulationIncreaseRules() {
      const rules = []
      if (this.isPopulationGrowth) {
        rules.push({ required: true, message: `${this.$t('inputHint')}${this.$t('operation.gasPrice.populationIncrease')}`, trigger: 'blur' })
        rules.push({ pattern: positiveNumberReg, message: `${this.$t('operation.gasPrice.populationIncreaseNumberHint')}`, trigger: 'blur' })
      }
      return rules
    },

    // 启用开户按月递减发生变化
    handleOpenDecrementChange(value) {
      this.$refs[this.formRef]?.clearValidate('decrement')
    },
    // 启用人口递增发生变化
    handlePopulationGrowthChange(value) {
      this.$refs[this.formRef]?.clearValidate(['populationBase', 'populationIncrease'])
    },
  }
}
</script>

<style scoped lang="scss">
  .use-gas-type-form {
    ::v-deep{
      .el-form-item {
        width: calc(100% / 2);
      }
    }
    .save-btn-box {
      // margin-top: 10px;
    }
  }
</style>
