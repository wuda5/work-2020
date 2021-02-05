<!-- 缴费减免活动表单 -->
<template>
  <div v-loading="loading" class="form-page feeReduceForm-page">
    <el-form
      :ref="formRef"
      :model="form"
      :rules="formRules"
      label-position="top"
      inline
      class="qc-form clearfix feeReduce-form"
    >
      <!-- 活动名称 -->
      <el-form-item prop="activityName" :label="$t('operation.preferential.feeReduce.activityName')">
        <el-input
          v-model="form.activityName"
          clearable
          name="activityName"
          :placeholder="$t('operation.preferential.feeReduce.activityName')"
        ></el-input>
      </el-form-item>
      <!-- 收费场景 -->
      <el-form-item :label="$t('operation.preferential.feeReduce.tollItemScene')" prop="tollItemScene">
        <el-select
          v-model="form.tollItemScene"
          name="tollItemScene"
          :placeholder="`${$t('selectHint')}${$t('operation.preferential.feeReduce.tollItemScene')}`"
          @change="handleTollItemSceneChange"
        >
          <el-option
            v-for="(value, key) in tollItemSceneMap"
            :key="key"
            :value="key"
            :label="value"
          ></el-option>
        </el-select>
      </el-form-item>
      <!-- 收费项 -->
      <el-form-item :label="$t('operation.preferential.feeReduce.tollItemName')" prop="tollItemName">
        <el-select
          v-model="form.tollItemName"
          name="tollItemName"
          :placeholder="`${$t('selectHint')}${$t('operation.preferential.feeReduce.tollItemName')}`"
          @change="handleTollItemChange"
        >
          <el-option
            v-for="(item, index) in tollItemList"
            :key="index"
            :value="item.itemName"
            :label="item.itemName"
          ></el-option>
        </el-select>
      </el-form-item>
      <!-- 减免金额组合表单 -->
      <el-form-item
        prop="activityMoney"
        :label="$t('operation.preferential.feeReduce.activityMoneyLabel')"
        class="activityMoney-form-item"
        :rules="setActivityMoneyRules"
      >
        <qc-number-input v-model="form.activityMoney" name="activityMoney" :precision="2" clearable :disabled="IS_BGDJE" :placeholder="IS_BGDJE ? '' : $t('operation.preferential.feeReduce.activityMoneyLabel')">
          <!-- 活动金额方式 -->
          <el-select
            slot="prepend"
            v-model="form.activityMoneyType"
            name="activityMoneyType"
            :placeholder="`${$t('selectHint')}${$t('operation.preferential.feeReduce.activityMoneyTypeLabel')}`"
            @change="handleActivityMoneyTypeChange"
          >
            <el-option
              v-for="(value, key) in selectActivityMoneyTypeMap"
              :key="key"
              :value="key"
              :label="value"
            ></el-option>
          </el-select>
          <template v-if="IS_BFBJE" slot="append">%</template>
        </qc-number-input>
        <p v-if="IS_GDJE && currentTollItem" class="hint-text">{{ $t('operation.preferential.feeReduce.activityMoneyInputHint') }}0~{{ +currentTollItem.money || maxActivityMoney }}</p>
      </el-form-item>

      <!-- 启用时间 -->
      <el-form-item prop="startTime" :label="$t('operation.preferential.feeReduce.startTime')">
        <el-date-picker
          v-model="form.startTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="startTime"
          :placeholder="$t('operation.preferential.feeReduce.startTime')"
        ></el-date-picker>
      </el-form-item>
      <!-- 结束时间 -->
      <el-form-item prop="endTime" :label="$t('operation.preferential.feeReduce.endTime')">
        <el-date-picker
          v-model="form.endTime"
          type="date"
          value-format="yyyy-MM-dd"
          :picker-options="startTimePickerOptions"
          name="endTime"
          :placeholder="$t('operation.preferential.feeReduce.endTime')"
        ></el-date-picker>
      </el-form-item>
      <!-- 是否启用 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox
          v-model="form.dataStatus"
          name="dataStatus"
          :true-label="useStatusField.ENABLE"
          :false-label="useStatusField.DISABLE"
        >{{ $t('operation.preferential.feeReduce.dataStatusLabel') }}</el-checkbox>
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
import { feeReduceFormFieldsMap } from '@/lang/zh/modules/operation/preferential'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg, positiveIntegerReg, numberReg } from '@/utils/reg'
import { initQueryParams } from '@/utils/commons'
import { saveData } from '@/api/operation/preferential'
import apiChargeConfig from '@/api/system/chargeConfig'
import { getUseGasTypeList } from '@/api/operation/gasPrice'
import { maxMoney } from '@/settings'

export default {
  name: 'FeeReduceForm',
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
          Object.keys(feeReduceFormFieldsMap),
          new Array(Object.keys(feeReduceFormFieldsMap).length).fill('')
        ),
        id: '',
        useGasTypes: [],
        activityScene: activitySceneField.CHARGE_DE,
        activityMoneyType: activityMoneyTypeField.GDJE,
        dataStatus: dataStatusField.VALID,
      },
      // 表单验证规则
      formRules: {
        activityName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.feeReduce.activityName')}`,
            trigger: 'blur',
          },
        ],
        useGasTypes: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.feeReduce.useGasTypes')}`,
            trigger: 'change',
          },
        ],
        activityScene: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.feeReduce.activityScene')}`,
            trigger: 'change',
          },
        ],
        tollItemScene: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.feeReduce.tollItemScene')}`,
            trigger: 'change',
          },
        ],
        tollItemId: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.feeReduce.tollItemName')}`,
            trigger: 'change',
          },
        ],
        tollItemName: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.preferential.feeReduce.tollItemName')}`,
            trigger: 'change',
          },
        ],
        activityMoneyType: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t(
              'operation.preferential.feeReduce.activityMoneyType'
            )}`,
            trigger: 'change',
          },
        ],
        // activityMoney: [
        //   { required: true, message: `${this.$t('inputHint')}${this.$t('operation.preferential.feeReduce.activityMoney')}`, trigger: 'blur' },
        //   { pattern: positiveNumberReg, message: this.$t('operation.preferential.feeReduce.activityMoneyNumberHint') },
        // ],
        startTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.feeReduce.startTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const endTime = this.form.endTime
              if (+new Date(endTime) < +new Date(value)) {
                return Promise.reject(this.$t('operation.preferential.feeReduce.startTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        endTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.preferential.feeReduce.endTime')}`,
            trigger: 'change',
          },
          {
            validator: (rule, value) => {
              const startTime = this.form.startTime
              if (+new Date(value) < +new Date(startTime)) {
                return Promise.reject(this.$t('operation.preferential.feeReduce.endTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
      },
      tollItemList: [], // 收费项列表
      // 日期选择器特有属性
      startTimePickerOptions: {
        // 设置禁用状态
        disabledDate(value) {
          return +new Date(value) < +new Date(parseTime(new Date(), '{y}-{m}-{d} 00:00:00'))
        },
      },
      currentTollItem: null, // 当前选择的收费项
      maxActivityMoney: maxMoney, // 最大活动金额
    }
  },
  computed: {
    // 活动场景map
    activitySceneMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ACTIVITY_SCENE)
    },
    // 活动金额方式map
    activityMoneyTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.MONEY_METHOD)
    },

    // 收费场景map
    tollItemSceneMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SCENES)
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
    // 设置减免金额验证规则
    setActivityMoneyRules() {
      const result = []
      // 设置验证规则前先清除验证验证规则
      this.$refs?.formRef?.clearValidate('activityMoney')
      const { activityMoney } = this.form
      const { money } = this.currentTollItem ?? {}
      if (!this.IS_BGDJE) {
        result.push({
          required: true,
          message: `${this.$t('inputHint')}${this.$t('operation.preferential.feeReduce.activityMoneyLabel')}`,
          trigger: 'blur',
        })
        // 百分比金额只能正整数，固定金额数字
        if (this.IS_BFBJE) {
          result.push({
            pattern: positiveIntegerReg,
            message: this.$t('operation.preferential.feeReduce.activityMoneyIntegerHint'),
            trigger: 'blur',
          })
        } else if (this.IS_GDJE) {
          // result.push({
          //   pattern: positiveNumberReg,
          //   message: this.$t('operation.preferential.feeReduce.activityMoneyNumberHint'),
          //   trigger: 'blur',
          // })
          //   console.log(money, activityMoney, +activityMoney > +money)
          // if (positiveNumberReg.test(money) && positiveNumberReg.test(activityMoney) && +activityMoney > +money) {
          //   }
          result.push({
            validator: (rule, value) => {
              return new Promise((resolve, reject) => {
                if (!positiveNumberReg.test(value)) {
                  reject(this.$t('operation.preferential.feeReduce.activityMoneyNumberHint'))
                } else {
                  if (positiveNumberReg.test(money)  && +value > (+money || this.maxActivityMoney)) {
                    reject(this.$t('operation.preferential.feeReduce.activityMoneyValidHint'))
                  }
                }
                resolve(true)
              })
            },
            // message: this.$t('operation.preferential.feeReduce.activityMoneyValidHint'),
            trigger: 'blur',
          })
        }
      }
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
        // this.initData()
      },
      immediate: false,
    },
  },
  created() {
    this.initData()
  },
  mounted() {},
  destroyed() {
    this.tollItemList = []
  },
  methods: {
    //初始化数据
    async initData() {
      this.loading = true
      this.setFormStatus()
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
          const { tollItemScene, tollItemId } = cloneFormData
          // console.log('cloneFormData', cloneFormData)
          this.resetForm(cloneFormData)
          // 初始化默认加载收费项列表
          this.tollItemList = []
          if (tollItemScene) {
            this.getTollItemListData().then((result) => {
              if (result && result.length > 0) {
                this.currentTollItem = result.find((item) => item.tollItemId === this.tollItemId) ?? null
              }
            })
          }
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },

    // 获取收费项配置列表
    async getTollItemListData(params = {}) {
      return new Promise(resolve => {
        // 获取全部的数据
        this.loading = true
        apiChargeConfig.page(
          initQueryParams({ size: 10000, model: { dataStatus: dataStatusField.VALID, sceneCode: this.form.tollItemScene } })
        ).then(result => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.tollItemList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        }).finally(() => {
          this.loading = false
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
          })
          .catch(() => {
            resolve(false)
          }).finally(() => {
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

    // 收费场景改变
    handleTollItemSceneChange(value) {
      this.form.tollItemId = null
      this.form.tollItemName = null
      this.getTollItemListData()
    },

    // 收费项改变
    handleTollItemChange(value) {
      const tollItem = this.tollItemList.find((item) => item.itemName === value)
      this.currentTollItem = tollItem ?? null
      if (tollItem) {
        Object.assign(this.form, { tollItemId: tollItem.id, activityMoneyType: tollItem.moneyMethod, activityMoney: null })
      }
    },

    // 减免方式改变
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
