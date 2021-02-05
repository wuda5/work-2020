<!-- 赠送减免活动表单 -->
<template>
  <div v-loading="loading" class="form-page preferential-form-page">
    <el-form
      :ref="formRef"
      :model="form"
      :rules="formRules"
      label-position="top"
      inline
      class="qc-form clearfix preferential-form"
    >
      <!-- 活动名称 -->
      <el-form-item prop="activityName" :label="$t('operation.preferential.activityName')">
        <el-input
          v-model="form.activityName"
          clearable
          name="activityName"
          :placeholder="$t('operation.preferential.activityName')"
        ></el-input>
      </el-form-item>
      <!-- 活动场景 -->
      <el-form-item :label="$t('operation.preferential.activityScene')" prop="activityScene">
        <el-select
          v-model="form.activityScene"
          name="activityScene"
          filterable
          :placeholder="`${$t('selectHint')}${$t('operation.preferential.activityScene')}`"
        >
          <el-option
            v-for="(value, key) in activitySceneMap"
            :key="key"
            :value="key"
            :label="value"
          ></el-option>
        </el-select>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 用气类型 -->
      <el-form-item
        v-if="IS_RECHARGE_GIVE"
        :label="$t('operation.preferential.useGasTypes')"
        prop="useGasTypes"
        style="width: 100%"
      >
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select
              v-model="form.useGasTypes"
              name="useGasTypes"
              :collapse-tags="false"
              clearable
              filterable
              multiple
              :placeholder="`${$t('selectHint')}${$t('operation.preferential.useGasTypes')}`"
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
      <!-- 赠送气量 -->
      <el-form-item
        v-if="IS_RECHARGE_GIVE"
        prop="giveGas"
        :label="$t('operation.preferential.giveGas')"
      >
        <el-input
          v-model="form.giveGas"
          type="number"
          name="giveGas"
          clearable
          :placeholder="$t('operation.preferential.giveGas')"
        ></el-input>
      </el-form-item>
      <!-- 活动金额组合表单 -->
      <el-form-item
        prop="activityMoney"
        :label="activityMoneyLabel"
        class="activityMoney-form-item"
        :rules="setActivityMoneyRules"
      >
        <el-input
          v-model="form.activityMoney"
          type="number"
          name="activityMoney"
          clearable
          :placeholder="activityMoneyLabel"
          :disabled="IS_BGDJE"
        >
          <!-- 活动金额方式 -->
          <el-select
            slot="prepend"
            v-model="form.activityMoneyType"
            name="activityMoneyType"
            :placeholder="`${$t('selectHint')}${$t('operation.preferential.activityMoneyType')}`"
          >
            <el-option
              v-for="(value, key) in selectActivityMoneyTypeMap"
              :key="key"
              :value="key"
              :label="value"
            ></el-option>
          </el-select>
          <template v-if="IS_BFBJE" slot="append">%</template>
        </el-input>
      </el-form-item>
      <div class="clearfix"></div>

      <!-- 启用时间 -->
      <el-form-item prop="startTime" :label="$t('operation.preferential.startTime')">
        <el-date-picker
          v-model="form.startTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="startTime"
          :placeholder="$t('operation.preferential.startTime')"
        ></el-date-picker>
      </el-form-item>
      <!-- 结束时间 -->
      <el-form-item prop="endTime" :label="$t('operation.preferential.endTime')">
        <el-date-picker
          v-model="form.endTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="endTime"
          :placeholder="$t('operation.preferential.endTime')"
        ></el-date-picker>
      </el-form-item>

      <div class="clearfix"></div>
      <!-- 是否启用 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox
          v-model="form.dataStatus"
          name="dataStatus"
          :true-label="useStatusField.ENABLE"
          :false-label="useStatusField.DISABLE"
        >{{ $t('operation.preferential.dataStatusLabel') }}</el-checkbox>
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
import { isEmpty, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { activityMoneyTypeField, activitySceneField } from '@/enums/preferential'
import { dataStatusField, deleteStatusField, useStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { preferentialFormFieldsMap } from '@/lang/zh/modules/operation/preferential'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg, positiveIntegerReg } from '@/utils/reg'
import { initQueryParams } from '@/utils/commons'
import { saveData } from '@/api/operation/preferential'
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  name: 'PreferentialForm',
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
          Object.keys(preferentialFormFieldsMap),
          new Array(Object.keys(preferentialFormFieldsMap).length).fill('')
        ),
        id: '',
        useGasTypes: [],
        activityMoneyType: activityMoneyTypeField.GDJE,
        dataStatus: dataStatusField.VALID,
      },
      // 表单验证规则
      formRules: {
        activityName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.activityName')}`,
            trigger: 'blur',
          },
        ],
        useGasTypes: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.useGasTypes')}`,
            trigger: 'change',
          },
        ],
        activityScene: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.activityScene')}`,
            trigger: 'change',
          },
        ],
        activityMoneyType: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t(
              'operation.preferential.activityMoneyType'
            )}`,
            trigger: 'change',
          },
        ],
        // activityMoney: [
        //   { required: true, message: `${this.$t('inputHint')}${this.$t('operation.preferential.activityMoney')}`, trigger: 'blur' },
        //   { pattern: positiveNumberReg, message: this.$t('operation.preferential.activityMoneyNumberHint') },
        // ],
        startTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.startTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const endTime = this.form.endTime
              if (+new Date(endTime) < +new Date(value)) {
                return Promise.reject(this.$t('operation.preferential.startTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        endTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.endTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const startTime = this.form.startTime
              if (+new Date(value) < +new Date(startTime)) {
                return Promise.reject(this.$t('operation.preferential.endTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        activityPercent: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.activityPercent')}`,
            trigger: 'blur',
          },
          {
            pattern: positiveNumberReg,
            message: this.$t('operation.preferential.activityPercentNumberHint'),
          },
        ],
        giveGas: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.giveGas')}`,
            trigger: 'blur',
          },
          {
            pattern: positiveNumberReg,
            message: this.$t('operation.preferential.giveGasNumberHint'),
          },
        ],
      },
      useGasTypeList: [], // 用气类型列表
      // 日期选择器特有属性
      startTimePickerOptions: {
        // 设置禁用状态
        disabledDate(value) {
          return +new Date(value) <= +new Date(parseTime(new Date(), '{y}-{m}-{d} 23:59:59'))
        },
      },
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
    // 设置活动金额验证规则
    setActivityMoneyRules() {
      const result = []
      // 设置验证规则前先清除验证验证规则
      this.$refs?.formRef?.clearValidate('activityMoney')
      if (!this.IS_BGDJE) {
        result.push({
          required: true,
          message: `${this.$t('inputHint')}${this.$t('operation.preferential.activityMoney')}`,
          trigger: 'blur',
        })
        // 百分比金额只能正整数，固定金额数字
        if (this.IS_BFBJE) {
          result.push({
            pattern: positiveIntegerReg,
            message: this.$t('operation.preferential.activityMoneyIntegerHint'),
            trigger: 'blur',
          })
        } else if (this.IS_GDJE) {
          result.push({
            pattern: positiveNumberReg,
            message: this.$t('operation.preferential.activityMoneyNumberHint'),
            trigger: 'blur',
          })
        }
      }
      return result
    },
    // 活动金额表单label
    activityMoneyLabel() {
      let result = 'activityMoneyLabel'
      if (this.IS_CHARGE_DE) {
        result = 'derateMoneyLabel'
      }
      return this.$t(`operation.preferential.${result}`)
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
    // 监听活动金额方式
    'form.activityMoneyType': {
      handler(value) {
        this.form.activityMoney = null
      },
    },
    // 监听活动场景
    'form.activityScene': {
      handler(value) {
        if (
          value === activitySceneField.CHARGE_DE &&
          this.form.activityMoneyType === activityMoneyTypeField.BFBJE
        ) {
          this.form.activityMoneyType = ''
          this.form.activityMoney = ''
        }
      },
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
          // cloneFormData.useGasTypes = JSON.parse(cloneFormData.useGasTypes)?.use_gas_type_id ?? []
          cloneFormData.useGasTypes = arrayColumn(
            JSON.parse(cloneFormData.useGasTypes),
            'use_gas_type_id'
          )
          // 组装不同金额方式传递的数据
          if (cloneFormData.activityMoneyType === activityMoneyTypeField.BFBJE) {
            cloneFormData.activityMoney = cloneFormData.activityPercent
          }
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
        })
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
      // 组装不同金额方式传递的数据
      if (this.IS_BFBJE) {
        cloneData.activityPercent = data.activityMoney
        cloneData.activityMoney = ''
      } else if (this.IS_GDJE) {
        cloneData.activityPercent = ''
      } else if (this.IS_BGDJE) {
        cloneData.activityMoney = ''
        cloneData.activityPercent = ''
      }
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
