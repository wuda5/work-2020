<!-- 阶梯方案（备份） -->
<template>
  <div v-loading="loading" class="form-page price-form-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" :inline="true" class="qc-form clearfix price-form">
      <!-- 阶梯单价和气量 -->
      <template v-for="(ladder, index) in form.ladders">
        <el-form-item :key="ladder.price.key" :prop="`ladders[${index}].price.value`" :label="ladder.price.label" :rules="setLadderPriceRules(ladder.price, index)">
          <el-input v-model="ladder.price.value" type="number" :name="ladder.price.field" :placeholder="ladder.price.label"></el-input>
        </el-form-item>
        <el-form-item :key="ladder.gas.key" :prop="`ladders[${index}].gas.value`" :label="ladder.gas.label" :rules="setLadderGasRules(ladder.gas, index)">
          <el-input v-model="ladder.gas.value" type="number" :name="ladder.gas.field" :placeholder="ladder.gas.label"></el-input>
        </el-form-item>
      </template>
      <el-form-item prop="compensationPrice" :label="$t('operation.gasPrice.compensationPrice')">
        <el-input v-model="form.compensationPrice" type="number" name="compensationPrice" :placeholder="$t('operation.gasPrice.compensationPrice')"></el-input>
      </el-form-item>
      <el-form-item prop="startTime" :label="$t('operation.gasPrice.startTime')">
        <el-date-picker v-model="form.startTime" value-format="yyyy-MM-dd" name="startTime" :placeholder="$t('operation.gasPrice.startTime')"></el-date-picker>
      </el-form-item>
      <el-form-item prop="startMonth" :label="$t('operation.gasPrice.startMonth')">
        <el-select v-model.number="form.startMonth" name="startMonth" :placeholder="$t('operation.gasPrice.startMonth')">
          <el-option v-for="(value, index) in startMonths" :key="index" :label="`${value}月`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="settlementDay" :label="$t('operation.gasPrice.settlementDay')">
        <el-select v-model.number="form.settlementDay" name="settlementDay" :placeholder="$t('operation.gasPrice.settlementDay')">
          <el-option v-for="(value, index) in settlementDays" :key="index" :label="`${value}日`" :value="+value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="cycle" :label="$t('operation.gasPrice.cycle')">
        <el-select v-model.number="form.cycle" name="cycle" :placeholder="$t('operation.gasPrice.cycle')">
          <el-option v-for="(value, key) in cycleMap" :key="key" :label="value" :value="+key"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label=" " prop="priceChangeIsClear" class="checkbox-item">
        <el-checkbox v-model="form.priceChangeIsClear" name="priceChangeIsClear" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.gasPrice.priceChangeIsClear') }}</el-checkbox>
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item v-if="!onlyView" label="" class="save-btn-box text-right fr">
        <el-button type="primary" name="savePriceName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { priceFormFieldsMap } from '@/lang/zh/modules/operation/gasPrice'
import { numberToChinese } from '@/utils/index'
import { arrayCombine } from '@/utils/array'
import { positiveNumberReg, positiveIntegerReg } from '@/utils/reg'
import { savePrice } from '@/api/operation/gasPrice'

const ladderNumer = 7 // 价格阶梯数量，预留7阶

export default {
  name: 'PriceForm',
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
  data() {
    // 结算日数组
    this.settlementDays = Array.from({ length: 28 }, (v, k) => k + 1)
    // 起始月数组
    this.startMonths = Array.from({ length: 12 }, (v, k) => k + 1)
    // 周期数组
    // this.cycles = [1, 2, 3, 4, 6, 12]
    this.cycleMap = {
      1: '1个月',
      2: '2个月',
      3: '3个月',
      4: '4个月',
      6: '6个月',
      12: '1年',
    }
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(priceFormFieldsMap), new Array(Object.keys(priceFormFieldsMap).length).fill('')),
        id: '',
        settlementDay: this.settlementDays[0],
        startMonth: this.startMonths[0],
        cycle: 12,
        ladders: new Array(ladderNumer).fill('').map((v, k) => ({ gas: { value: v, key: `gas${k + 1}`, field: `gas${k + 1}`, label: numberToChinese(k + 1) + this.$t('operation.gasPrice.ladderGas') }, price: { value: v, key: `price${k + 1}`, field: `price${k + 1}`, label: numberToChinese(k + 1) + this.$t('operation.gasPrice.ladderPrice') } })),
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        compensationPrice: [
          { pattern: positiveNumberReg, message: this.$t('operation.gasPrice.compensationPriceNumberHint'), trigger: 'blur'  },
        ],
        startTime: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.startTime')}`, trigger: 'blur' }
        ],
        settlementDay: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.settlementDay')}`, trigger: 'change' }
        ],
        startMonth: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.startMonth')}`, trigger: 'change' }
        ],
        cycle: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.gasPrice.cycle')}`, trigger: 'change' }
        ],
      },
    }
  },
  computed: {

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
    }
  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
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
          this.resetForm(this.generateFormData(this.formData))
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

    // 重新生成标准的表单数据 
    generateFormData(data) {
      const deepCloneData = cloneDeep(data)
      const ladders = []
      for (let i = 1; i <= ladderNumer; i++) {
        ladders.push({ gas: { value: deepCloneData[`gas${i}`], key: `gas${i}`, field: `gas${i}`, label: numberToChinese(i) + this.$t('operation.gasPrice.ladderGas') }, price: { value: deepCloneData[`price${i}`], key: `price${i}`, field: `price${i}`, label: numberToChinese(i) + this.$t('operation.gasPrice.ladderPrice') } })
      }
      deepCloneData.ladders = ladders
      return deepCloneData
    },

    // 解析表单数据转换成api保存参数 
    analysisFormData(data) {
      const deepCloneData = cloneDeep(data)
      const ladders = deepCloneData.ladders || []
      ladders.forEach((ladder, index) => {
        const { price, gas } = ladder
        deepCloneData[price.field] = price.value
        deepCloneData[gas.field] = gas.value
      })
      delete deepCloneData.ladders
      // console.log('deepCloneData', deepCloneData)
      return deepCloneData
    },

    // 保存数据
    saveFormData(data = null) {
      if (!data) {
        data = this.form
      }
      data = this.analysisFormData(data)
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        savePrice(data, data?.id || '').then((result) => {
          console.log('saveresult', result)
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

    // 取消保存
    handleCancel() {
      this.$emit('cancel')
    },

    // 设置阶梯价格表单验证规则
    setLadderPriceRules(priceInfo, index) {
      // console.log(priceInfo)
      // console.log(index)
      const { label, value } = priceInfo
      const rules = []
      rules.push({ pattern: positiveNumberReg, range: { min: 0 }, message: `${label}必须是正数` })
      if (index === 0) {
        rules.push({ required: true, message: `${label}不能为空。`, trigger: 'blur' })
      } else {
        // 如果对应的阶梯气量不为空，那么阶梯单价也不能为空
        const currentGasValue = this.form.ladders[index]?.gas?.value || ''
        if (currentGasValue && !value) {
          rules.push({ required: true, message: `${label}不能为空。`, trigger: 'blur' })
        }
      }
      return rules
    },

    // 设置阶梯气量表单验证规则
    setLadderGasRules(gasInfo, index) {
      const { label, value } = gasInfo
      const rules = []
      rules.push({ pattern: positiveNumberReg, message: `${label}必须是正数`, trigger: 'blur'  })
      if (index === 0) {
        rules.push({ required: true, message: `${label}不能为空。`, trigger: 'blur' })
      } else {
        // 如果对应的阶梯单价不为空，那么阶梯气量也不能为空
        const currentPriceValue = this.form.ladders[index]?.price?.value || ''
        if (currentPriceValue && !value) {
          rules.push({ required: true, message: `${label}不能为空。`, trigger: 'blur' })
        }
        // 查找上一个阶梯信息
        const lastLadder = this.form.ladders[index - 1] || {}
        const lastGasValue = +(lastLadder?.gas?.value || '')
        const lastGasLable = lastLadder?.gas?.label || ''
        // 查找下一个阶梯信息
        const nextLadder = this.form.ladders[index + 1] || {}
        const nextGasValue = +(nextLadder?.gas?.value || '')
        const nextGasLable = nextLadder?.gas?.label || ''
        // 如果当前的下一个阶梯的气量不为空或者当前阶梯气量不为空，则都需要当前气量需要和上一级阶梯气量比较
        if (nextGasValue || value) {
          // 如果下一阶气量不为空，则当前阶梯气量必填
          if (!value) {
            rules.push({ required: true, message: `${label}不能为空。`, trigger: 'blur' })
          } else {
            // 如果当前阶梯比上一个阶梯的气量低，则报错
            if (lastGasValue >= +value) {
              // console.log(value, index)
              // this.$message.error(`${label}必须大于${lastGasLable}`)
              rules.push({ validator: (rule, value, callback, source, options) => {
                return Promise.reject(`${label}必须大于${lastGasLable}`)
              }, trigger: 'blur' })
            }
          }
        }
      }
      return rules
    }
  }
}
</script>

<style scoped lang="scss">
  .price-form {
    ::v-deep {
      .el-form-item {
        width: calc(100% / 2);
      }
    }
    .save-btn-box {
      margin-top: 10px;
    }
  }
</style>
