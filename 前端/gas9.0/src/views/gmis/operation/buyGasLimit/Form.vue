<!-- 购气限制配置表单 -->
<template>
  <div v-loading="loading" class="form-page BuyGasLimit-form-page">
    <!-- 表单区域 -->
    <el-form
      :ref="formRef"
      :model="form"
      :rules="formRules"
      label-position="top"
      inline
      class="qc-form clearfix"
    >
      <!-- 限购名称 -->
      <el-form-item prop="limitName" :label="$t('operation.buyGasLimit.limitName')">
        <el-input
          v-model="form.limitName"
          name="limitName"
          :placeholder="$t('operation.buyGasLimit.limitName')"
        ></el-input>
      </el-form-item>
      <!-- 用气类型 -->
      <el-form-item :label="$t('operation.buyGasLimit.useGasTypeName')" prop="useGasTypeId">
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select
              v-model="form.useGasTypeId"
              name="useGasTypeId"
              collapse-tags
              clearable
              multiple
              filterable
              :placeholder="`${$t('selectHint')}${$t('operation.buyGasLimit.useGasTypeName')}`"
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
      <!-- 限制类型 -->
      <el-form-item :label="$t('operation.buyGasLimit.limitType')" prop="limitType">
        <el-select
          v-model.number="form.limitType"
          name="limitType"
          :placeholder="`${$t('selectHint')}${$t('operation.buyGasLimit.limitType')}`"
        >
          <el-option
            v-for="(value, key) in limitTypeMap"
            :key="key"
            :value="+key"
            :label="value"
          ></el-option>
        </el-select>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 限制方式 -->
      <el-form-item
        v-if="isAdd"
        :label="$t('operation.buyGasLimit.selectType')"
        prop="selectType"
        class="radio-group-item selectType-form-item"
      >
        <el-radio-group v-model.number="form.selectType">
          <el-radio
            v-for="(value, key) in selectTypeMap"
            :key="key"
            name="selectType"
            :label="+key"
            >{{ value }}</el-radio>
        </el-radio-group>
      </el-form-item>
      <div class="clearfix"></div>
      <!-- 限制方式不同。表单显示内容不一样 -->
      <template v-if="isEdit || form.selectType === 1">
        <!-- 启用时间 -->
        <el-form-item
          key="startTime2"
          prop="startTime"
          :label="$t('operation.buyGasLimit.startTime')"
        >
          <el-date-picker
            v-model="form.startTime"
            type="date"
            value-format="yyyy-MM-dd"
            :picker-options="startTimePickerOptions"
            name="startTime"
            :placeholder="$t('operation.buyGasLimit.startTime')"
          ></el-date-picker>
        </el-form-item>
        <!-- 结束时间 -->
        <el-form-item key="endTime" prop="endTime" :label="$t('operation.buyGasLimit.endTime')">
          <el-date-picker
            v-model="form.endTime"
            type="date"
            value-format="yyyy-MM-dd"
            :picker-options="startTimePickerOptions"
            name="endTime"
            :placeholder="$t('operation.buyGasLimit.endTime')"
          ></el-date-picker>
        </el-form-item>
      </template>
      <template v-else>
        <!-- 启用时间 -->
        <el-form-item
          key="startTime"
          prop="startTime"
          :label="$t('operation.buyGasLimit.startTime')"
        >
          <el-date-picker
            v-model="form.startTime"
            type="month"
            value-format="yyyy-MM-dd"
            :picker-options="startTimePickerOptions"
            name="startTime"
            :placeholder="$t('operation.buyGasLimit.startTime')"
          ></el-date-picker>
        </el-form-item>
        <!-- 周期 -->
        <el-form-item key="cycle" :label="$t('operation.buyGasLimit.cycle')" prop="cycle">
          <el-select
            v-model.number="form.cycle"
            name="cycle"
            :placeholder="`${$t('operation.buyGasLimit.cycle')}`"
          >
            <el-option
              v-for="(value, key) in cycles"
              :key="key"
              :value="+value"
              :label="`${value}个月`"
            ></el-option>
          </el-select>
        </el-form-item>
        <!-- 重复次数 -->
        <el-form-item prop="cycleNum" :label="$t('operation.buyGasLimit.cycleNum')">
          <el-input
            v-model.number="form.cycleNum"
            type="number"
            name="cycleNum"
            :placeholder="$t('operation.buyGasLimit.cycleNum')"
          ></el-input>
        </el-form-item>
      </template>
      <div class="clearfix"></div>
      <!-- 最大充值气量 -->
      <el-form-item prop="maxChargeGas" :label="$t('operation.buyGasLimit.maxChargeGas')">
        <el-input
          v-model="form.maxChargeGas"
          type="number"
          name="maxChargeGas"
          :placeholder="$t('operation.buyGasLimit.maxChargeGas')"
        ></el-input>
      </el-form-item>
      <!-- 最大充值金额 -->
      <el-form-item prop="maxChargeMoney" :label="$t('operation.buyGasLimit.maxChargeMoney')">
        <el-input
          v-model="form.maxChargeMoney"
          type="number"
          name="maxChargeMoney"
          :placeholder="$t('operation.buyGasLimit.maxChargeMoney')"
        ></el-input>
      </el-form-item>
      <!-- 是否启用 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox
          v-model="form.dataStatus"
          name="dataStatus"
          :true-label="useStatusField.ENABLE"
          :false-label="useStatusField.DISABLE"
          >{{ $t('operation.buyGasLimit.dataStatusLabel') }}</el-checkbox>
      </el-form-item>
      <!-- 操作按钮 -->
      <el-form-item v-if="!onlyView" label="" class="save-btn-box text-right">
        <el-button
          type="primary"
          name="savebuyGasLimit"
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
import { dataStatusField, deleteStatusField, useStatusField } from '@/enums/common'
import { limitTypeMap, selectTypeMap } from '@/enums/buyGasLimit'
import { buyGasLimitFormFieldsMap } from '@/lang/zh/modules/operation/buyGasLimit'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg } from '@/utils/reg'
import { initQueryParams } from '@/utils/commons'
import { saveData } from '@/api/operation/buyGasLimit'
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  name: 'BuyGasLimitForm',
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
    this.limitTypeMap = limitTypeMap
    this.useStatusField = useStatusField
    this.selectTypeMap = selectTypeMap
    // 周期数组
    this.cycles = Array.from({ length: 12 }, (v, k) => k + 1)
    return {
      initForm: {
        ...arrayCombine(
          Object.keys(buyGasLimitFormFieldsMap),
          new Array(Object.keys(buyGasLimitFormFieldsMap).length).fill('')
        ),
        id: '',
        selectType: 0,
        cycle: this.cycles[0],
        cycleNum: 1,
        limitType: 1,
        dataStatus: dataStatusField.VALID,
      },
      // 表单验证规则
      formRules: {
        limitName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.limitName')}`,
            trigger: 'blur',
          },
        ],
        useGasTypeId: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.buyGasLimit.useGasTypeName')}`,
            trigger: 'change',
          },
        ],
        limitType: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.buyGasLimit.limitType')}`,
            trigger: 'change',
          },
        ],
        selectType: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.buyGasLimit.selectType')}`,
            trigger: 'change',
          },
        ],
        cycleNum: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.cycleNum')}`,
            trigger: 'blur',
          },
          {
            type: 'integer',
            min: 1,
            message: this.$t('operation.buyGasLimit.cycleNumNumberHint'),
            trigger: 'blur',
          },
        ],
        cycle: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('operation.buyGasLimit.cycle')}`,
            trigger: 'change',
          },
        ],
        startTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.startTime')}`,
            trigger: 'change',
          },
          // 自定义验证启用时间
          {
            validator: (rule, value) => {
              const endTime = this.form.endTime
              const selectType = this.form.selectType
              if ((selectType === 1 || this.form.id) && +new Date(endTime) <= +new Date(value)) {
                return Promise.reject(this.$t('operation.buyGasLimit.startTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        endTime: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.endTime')}`,
            trigger: 'change',
          },
          // 自定义验证结束时间
          {
            validator: (rule, value) => {
              const startTime = this.form.startTime
              const selectType = this.form.selectType
              if ((selectType === 1 || this.form.id) && +new Date(value) <= +new Date(startTime)) {
                return Promise.reject(this.$t('operation.buyGasLimit.endTimeCompareHint'))
              }
              return Promise.resolve()
            },
            trigger: 'blur',
          },
        ],
        maxChargeGas: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.maxChargeGas')}`,
            trigger: 'blur',
          },
          {
            pattern: positiveNumberReg,
            message: this.$t('operation.buyGasLimit.maxChargeGasNumberHint'),
          },
        ],
        maxChargeMoney: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('operation.buyGasLimit.maxChargeMoney')}`,
            trigger: 'blur',
          },
          {
            pattern: positiveNumberReg,
            message: this.$t('operation.buyGasLimit.maxChargeMoneyNumberHint'),
          },
        ],
      },
      useGasTypeList: [], // 用气类型列表
      // 日期选择器特有选项
      startTimePickerOptions: {
        // 禁用状态设置
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
    // 表单useGasTypeId字段监听
    'form.useGasTypeId': {
      handler(value) {
        let useGasTypeName = []
        if (value && value.length > 0) {
          value.forEach(v => {
            if (this.useGasTypeMap[v]) {
              useGasTypeName.push(this.useGasTypeMap[v])
            }
          })
        }
        if (useGasTypeName.length > 0) {
          this.form.useGasTypeName = useGasTypeName
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
    // 初始化数据
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
          cloneFormData.useGasTypeId = JSON.parse(cloneFormData.useGasTypeId)
          cloneFormData.useGasTypeName = JSON.parse(cloneFormData.useGasTypeName)
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
      cloneData.useGasTypeId = JSON.stringify(cloneData.useGasTypeId)
      cloneData.useGasTypeName = JSON.stringify(cloneData.useGasTypeName)
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
      this.form.useGasTypeId = Object.keys(this.useGasTypeMap)
    },
  },
}
</script>

<style scoped lang="scss">
  .qc-form {
    ::v-deep {
      .selectType-form-item {
        width: 100%;
      }
    }
    .save-btn-box {
      float: right;
      margin-top: 10px;
    }
  }
</style>
