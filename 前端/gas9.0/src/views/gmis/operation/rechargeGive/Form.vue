<!-- 充值赠送活动表单 -->
<template>
  <div v-loading="loading" class="form-page rechargeGiveForm-page">
    <el-form
      :ref="formRef"
      :model="form"
      :rules="formRules"
      label-position="top"
      inline
      class="qc-form clearfix rechargeGive-form"
    >
      <!-- 活动名称 -->
      <el-form-item prop="activityName" :label="$t('operation.preferential.rechargeGive.activityName')">
        <el-input
          v-model="form.activityName"
          clearable
          name="activityName"
          :placeholder="$t('operation.preferential.rechargeGive.activityName')"
        ></el-input>
      </el-form-item>
      <!-- 用气类型 -->
      <el-form-item
        :label="$t('operation.preferential.rechargeGive.useGasTypes')"
        prop="useGasTypes"
      >
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select
              v-model="form.useGasTypes"
              name="useGasTypes"
              :collapse-tags="true"
              clearable
              filterable
              multiple
              :placeholder="`${$t('selectHint')}${$t('operation.preferential.rechargeGive.useGasTypes')}`"
            >
              <el-option
                v-for="(value, key) in useGasTypeMap"
                :key="key"
                :value="key"
                :label="value"
              ></el-option>
            </el-select>
          </el-col>
          <el-col style="width: auto">
            <el-button type="primary" size="mini" @click.native="handleSelectAllUseGasType">全选</el-button>
          </el-col>
        </el-row>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 赠送方式 -->
      <el-form-item :label="$t('operation.preferential.rechargeGive.activityMoneyTypeLabel')" prop="activityMoneyType">
        <el-select
          v-model="form.activityMoneyType"
          name="activityMoneyType"
          :placeholder="`${$t('selectHint')}${$t('operation.preferential.rechargeGive.activityMoneyTypeLabel')}`"
          @change="handleActivityMoneyTypeChange"
        >
          <el-option
            v-for="(value, key) in selectActivityMoneyTypeMap"
            :key="key"
            :value="key"
            :label="value"
          ></el-option>
        </el-select>
      </el-form-item>
      <!-- 赠送比例 -->
      <el-form-item
        prop="activityPercent"
        :label="$t('operation.preferential.rechargeGive.activityPercentLabel')"
        :rules="setActivityPercentRules"
        class="activityMoney-form-item"
      >
        <qc-number-input v-model="form.activityPercent" name="activityPercent" :precision="2" clearable :disabled="!IS_BFBJE" :placeholder="$t('operation.preferential.rechargeGive.activityPercent')">
          <template slot="append">%</template>
        </qc-number-input>
      </el-form-item>
      <!-- 赠送金额 -->
      <el-form-item
        prop="activityMoney"
        :label="$t('operation.preferential.rechargeGive.activityMoneyLabel')"
        class="activityMoney-form-item"
        :rules="setActivityMoneyRules"
      >
        <qc-number-input v-model="form.activityMoney" name="activityMoney" :precision="2" clearable :disabled="!IS_GDJE" :placeholder="$t('operation.preferential.rechargeGive.activityMoneyLabel')"></qc-number-input>
        <!-- <p v-if="IS_GDJE" class="hint-text">{{ $t('赠送金额范围') }}0~{{ maxActivityMoney }}</p> -->
      </el-form-item>
      <!-- 赠送气量 -->
      <el-form-item
        prop="giveGas"
        :label="$t('operation.preferential.rechargeGive.giveGas')"
        :rules="setGiveGasRules"
      >
        <qc-number-input v-model="form.giveGas" name="giveGas" :precision="2" clearable :disabled="!IS_GDJE" :placeholder="$t('operation.preferential.rechargeGive.giveGas')"></qc-number-input>
        <!-- <p v-if="IS_GDJE" class="hint-text">{{ $t('赠送气量范围') }}0~{{ maxGiveGas }}</p> -->
      </el-form-item>

      <!-- 启用时间 -->
      <el-form-item prop="startTime" :label="$t('operation.preferential.rechargeGive.startTime')">
        <el-date-picker
          v-model="form.startTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="startTime"
          :placeholder="$t('operation.preferential.rechargeGive.startTime')"
        ></el-date-picker>
      </el-form-item>
      <!-- 结束时间 -->
      <el-form-item prop="endTime" :label="$t('operation.preferential.rechargeGive.endTime')">
        <el-date-picker
          v-model="form.endTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="endTime"
          :placeholder="$t('operation.preferential.rechargeGive.endTime')"
        ></el-date-picker>
      </el-form-item>
      <!-- 是否启用 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox
          v-model="form.dataStatus"
          name="dataStatus"
          :true-label="useStatusField.ENABLE"
          :false-label="useStatusField.DISABLE"
        >{{ $t('operation.preferential.rechargeGive.dataStatusLabel') }}</el-checkbox>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button
          type="primary"
          name="savepreferential"
          :loading="submitLoading"
          :disabled="submitLoading"
          class="save-btn"
          @click.native="handleSubmit"
        >{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep, isNull } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { activityMoneyTypeField, activitySceneField } from '@/enums/preferential'
import { dataStatusField, deleteStatusField, useStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { rechargeGiveFormFieldsMap } from '@/lang/zh/modules/operation/preferential'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg, positiveIntegerReg } from '@/utils/reg'
import { initQueryParams } from '@/utils/commons'
import { saveData } from '@/api/operation/preferential'
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  name: 'RechargeGiveForm',
  components: {},
  filters: {},
  mixins: [commonMixin, formMixin],
  props: {
    // 需要修改的表单数据id
    id: {
      type: [String, Number],
      default: '',
    },
    // 表单数据
    formData: {
      type: Object,
      default: () => ({}),
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(
          Object.keys(rechargeGiveFormFieldsMap),
          new Array(Object.keys(rechargeGiveFormFieldsMap).length).fill('')
        ),
        id: '',
        useGasTypes: [],
        activityScene: activitySceneField.RECHARGE_GIVE,
        activityMoneyType: activityMoneyTypeField.GDJE,
        dataStatus: dataStatusField.VALID,
      },
      // 表单验证规则
      formRules: {
        activityName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.activityName')}`,
            trigger: 'blur',
          },
        ],
        useGasTypes: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.rechargeGive.useGasTypes')}`,
            trigger: 'change',
          },
        ],
        activityScene: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.rechargeGive.activityScene')}`,
            trigger: 'change',
          },
        ],
        activityMoneyType: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t(
              'operation.preferential.rechargeGive.activityMoneyType'
            )}`,
            trigger: 'change',
          },
        ],
        // activityMoney: [
        //   { required: true, message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.activityMoney')}`, trigger: 'blur' },
        //   { pattern: positiveNumberReg, message: this.$t('operation.preferential.rechargeGive.activityMoneyNumberHint') },
        // ],
        startTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.startTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const endTime = this.form.endTime
              if (+new Date(endTime) < +new Date(value)) {
                return Promise.reject(this.$t('operation.preferential.rechargeGive.startTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        endTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.endTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const startTime = this.form.startTime
              if (+new Date(value) < +new Date(startTime)) {
                return Promise.reject(this.$t('operation.preferential.rechargeGive.endTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        // activityPercent: [
        //   {
        //     required: true,
        //     message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.activityPercent')}`,
        //     trigger: 'blur',
        //   },
        //   {
        //     pattern: positiveNumberReg,
        //     message: this.$t('operation.preferential.rechargeGive.activityPercentNumberHint'),
        //   },
        // ],
        // giveGas: [
        //   {
        //     required: true,
        //     message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.giveGas')}`,
        //     trigger: 'blur',
        //   },
        //   {
        //     pattern: positiveNumberReg,
        //     message: this.$t('operation.preferential.rechargeGive.giveGasNumberHint'),
        //   },
        // ],
      },
      useGasTypeList: [], // 用气类型列表
      // 日期选择器特有属性
      startTimePickerOptions: {
        // 设置禁用状态
        disabledDate(value) {
          return +new Date(value) < +new Date(parseTime(new Date(), '{y}-{m}-{d} 00:00:00'))
        },
      },
      maxActivityMoney: 100000, // 最大活动金额
      maxGiveGas: 65535, // 最大赠送气量
    }
  },
  computed: {
    // 用气类型map
    useGasTypeMap() {
      return arrayColumn(this.useGasTypeList, 'useGasTypeName', 'id')
    },
    // 活动场景map
    activitySceneMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ACTIVITY_SCENE)
    },
    // 活动金额方式map
    activityMoneyTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.MONEY_METHOD)
    },
    // 用于选择的活动金额方式map
    selectActivityMoneyTypeMap() {
      const cloneActivityMoneyType = cloneDeep(this.activityMoneyTypeMap)
      if (this.IS_CHARGE_DE) {
        delete cloneActivityMoneyType[activityMoneyTypeField.BFBJE]
      } else if (this.IS_RECHARGE_GIVE) {
        delete cloneActivityMoneyType[activityMoneyTypeField.BGDJE]
      }
      return cloneActivityMoneyType
    },
    // 是否是充值场景
    IS_RECHARGE_GIVE() {
      return this.form.activityScene === activitySceneField.RECHARGE_GIVE
    },
    // 是否是缴费减免场景
    IS_CHARGE_DE() {
      return this.form.activityScene === activitySceneField.CHARGE_DE
    },
    // 是否是百分比活动金额方式
    IS_BFBJE() {
      return this.form.activityMoneyType === activityMoneyTypeField.BFBJE
    },
    // 是否是固定金额活动金额方式
    IS_GDJE() {
      return this.form.activityMoneyType === activityMoneyTypeField.GDJE
    },
    // 是否是不固定金额活动金额方式
    IS_BGDJE() {
      return this.form.activityMoneyType === activityMoneyTypeField.BGDJE
    },
    // 设置赠送比例验证规则
    setActivityPercentRules() {
      const result = []
      // 设置验证规则前先清除验证验证规则
      this.$refs?.formRef?.clearValidate('activityPercent')
      const { activityMoney, giveGas, activityScene } = this.form
      if (this.IS_BFBJE) {
        result.push({
          required: true,
          message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.activityPercent')}`,
          trigger: 'blur',
        })
      }
      result.push({
        pattern: positiveNumberReg,
        message:this.$t('operation.preferential.rechargeGive.activityPercentNumberHint'),
        trigger: 'blur',
      })
      return result
    },
    // 设置赠送金额验证规则
    setActivityMoneyRules() {
      const result = []
      // 设置验证规则前先清除验证验证规则
      this.$refs?.formRef?.clearValidate('activityMoney')
      const { activityMoney, giveGas } = this.form
      if (this.IS_GDJE && !positiveNumberReg.test(giveGas)) {
        result.push({
          required: true,
          message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.activityMoneyLabel')}`,
          trigger: 'blur',
        })
      }
      result.push({
        pattern: positiveNumberReg,
        message: this.$t('operation.preferential.rechargeGive.activityMoneyNumberHint'),
        trigger: 'blur',
      })
      return result
    },
    // 设置赠送气量验证规则
    setGiveGasRules() {
      const result = []
      // 设置验证规则前先清除验证验证规则
      this.$refs?.formRef?.clearValidate('giveGas')
      const { activityMoney, giveGas } = this.form
      if (this.IS_GDJE && !positiveNumberReg.test(activityMoney)) {
        result.push({
          required: true,
          message: `${this.$t('inputHint')}${this.$t('operation.preferential.rechargeGive.giveGas')}`,
          trigger: 'blur',
        })
      }
      result.push({
        pattern: positiveNumberReg,
        message: this.$t('operation.preferential.rechargeGive.giveGasNumberHint'),
        trigger: 'blur',
      })
      return result
    },
  },
  watch: {
    id: {
      handler(value) {
        this.initData()
      },
      immediate: false,
    },
    formData: {
      handler(value) {
        this.initData()
      },
      immediate: false,
    },
  },
  created() {
    this.initData()
  },
  mounted() {},
  destroyed() {
    this.useGasTypeList = []
  },
  methods: {
    //初始化数据
    async initData() {
      this.loading = true
      this.setFormStatus()
      // 获取用气类型列表
      this.useGasTypeList.length === 0 && this.getUseGasTypeListData()
      await this.getFormData()
      this.loading = false
    },

    // 获取表单数据
    async getFormData() {
      return new Promise(resolve => {
        if (this.id) {
          // 请求api获取表单数据
          this.resetForm()
          resolve(true)
        } else if (!isEmpty(this.formData)) {
          const cloneFormData = cloneDeep(this.formData)
          let useGasTypes = []
          try {
            useGasTypes = JSON.parse(cloneFormData.useGasTypes)
          } catch (error) {
            console.warn('解析用气类型json字符串出错，原字符串为：', cloneFormData.useGasTypes)
          }
          cloneFormData.useGasTypes = arrayColumn(useGasTypes, 'use_gas_type_id')
          // console.log('cloneFormData', cloneFormData)
          this.resetForm(cloneFormData)
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },

    // 获取用气类型列表
    async getUseGasTypeListData(params = {}) {
      return new Promise(resolve => {
        // 获取全部的数据
        getUseGasTypeList(
          initQueryParams({ size: 1000, model: { dataStatus: dataStatusField.VALID } })
        ).then(result => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.useGasTypeList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {})
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
      // cloneData.useGasTypes = JSON.stringify({
      //   use_gas_type_id: data.useGasTypes,
      //   use_gas_type_name: cloneData.useGasTypes.map((value) => this.useGasTypeMap[value])
      // })
      cloneData.useGasTypes = JSON.stringify(
        cloneData.useGasTypes.map(value => ({
          use_gas_type_id: value,
          use_gas_type_name: this.useGasTypeMap[value],
        }))
      )
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise(resolve => {
        this.submitLoading = true
        saveData(cloneData, data?.id || '')
          .then(result => {
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
          })
          .catch(() => {
            resolve(false)
            this.submitLoading = false
          })
      })
    },

    // 保存表单信息
    handleSubmit() {
      this.$refs[this.formRef].validate(async valid => {
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

    // 用气类型全选
    handleSelectAllUseGasType() {
      this.form.useGasTypes = Object.keys(this.useGasTypeMap)
    },

    // 赠送方式改变
    handleActivityMoneyTypeChange(value) {
      if (this.IS_GDJE) {
        this.form.activityPercent = null
      } else if (this.IS_BFBJE) {
        this.form.activityMoney = null
        this.form.giveGas = null
      } else {
        this.form.activityPercent = null
        this.form.activityMoney = null
        this.form.giveGas = null
      }
    }
  },
}
</script>

<style scoped lang="scss">
  .qc-form {
    ::v-deep {
      .el-form-item {
        width: calc(100% / 2);
        &.activityMoney-form-item {
          // width: 100%;
          .el-select {
            display: inline-block;
            margin: -10px -20px;
            width: auto;
            overflow: visible;
          }
          .el-input-group__prepend {
            min-width: 90px;
          }
          &.is-error {
            .el-input-group__prepend {
              border-color: $danger;
            }
            .el-input-group__append {
              border-color: $danger;
            }
          }
          .el-input-group {
            &.is-disabled {
              .el-input-group__prepend {
                .el-input__inner {
                  cursor: pointer;
                }
                .el-input__icon {
                  cursor: pointer;
                }
              }
            }
          }
        }
      }
      .selectType-form-item {
        width: 100%;
      }
    }
  }
</style>
