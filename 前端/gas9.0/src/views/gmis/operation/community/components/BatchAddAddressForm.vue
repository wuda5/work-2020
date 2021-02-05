<!-- 批量建址表单 -->
<template>
  <div v-loading="loading" class="form-page BatchAddAddressForm-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" class="qc-form clearfix" label-position="top" :inline="true">
      <!-- 省市区 -->
      <el-form-item :label="$t('operation.community.region')" prop="region">
        <el-input :value="region" disabled name="region" :placeholder="$t('operation.community.region')"></el-input>
      </el-form-item>
      <!-- 街道名称 -->
      <el-form-item :label="$t('operation.community.batchAddAddress.streetName')" prop="streetId">
        <el-input :value="formData.streetName" disabled name="streetId" :placeholder="$t('operation.community.batchAddAddress.streetName')"></el-input>
      </el-form-item>
      <!-- 小区名称 -->
      <el-form-item :label="$t('operation.community.batchAddAddress.communityName')" prop="communityName">
        <el-select v-model="form.communityName" name="communityName" clearable filterable allow-create :placeholder="$t('operation.community.batchAddAddress.communityName')" @change="handleCommunityChange">
          <el-option v-for="(item, index) in allCommunityList" :key="index" :value="item.communityName" :label="item.communityName"></el-option>
        </el-select>
      </el-form-item>
      <!-- 是否批量录入调压箱 -->
      <el-form-item label=" " prop="nodeFlag" class="checkbox-item">
        <el-checkbox v-model="form.nodeFlag" name="nodeFlag" :true-label="dataStatusField.VALID" :false-label="dataStatusField.INVALID" @change="handleNodeFlagChange">{{ $t('operation.community.batchAddAddress.nodeFlag') }}</el-checkbox>
      </el-form-item>
      <!-- 根据调压箱建址信息 -->
      <template v-if="form.nodeFlag">
        <!-- 总调压箱数 -->
        <el-form-item :label="$t('operation.community.batchAddAddress.nodeCount')" prop="nodeCount">
          <el-input v-model.number="form.nodeCount" type="number" name="nodeCount" :placeholder="$t('operation.community.batchAddAddress.nodeCount')" clearable>
          </el-input>
        </el-form-item>
      </template>
      <!-- 批量小区规则建址信息 -->
      <template v-else>
        <!-- 栋数 -->
        <el-form-item :label="$t('operation.community.batchAddAddress.building')" prop="building">
          <el-input v-model.number="form.building" type="number" name="building" :placeholder="$t('operation.community.batchAddAddress.building')" clearable>
            <span slot="append">{{ $t('operation.community.batchAddAddress.building') }}</span>
          </el-input>
        </el-form-item>
        <!-- 单元数 -->
        <el-form-item :label="$t('operation.community.batchAddAddress.unit')" prop="unit">
          <el-input v-model.number="form.unit" type="number" name="unit" :placeholder="$t('operation.community.batchAddAddress.unit')" clearable>
            <span slot="append">{{ $t('operation.community.batchAddAddress.unit') }}</span>
          </el-input>
        </el-form-item>
        <!-- 楼层数 -->
        <el-form-item :label="$t('operation.community.batchAddAddress.storey')" prop="storey">
          <el-input v-model.number="form.storey" type="number" name="storey" :placeholder="$t('operation.community.batchAddAddress.storey')" clearable>
            <span slot="append">{{ $t('operation.community.batchAddAddress.storeyAppend') }}</span>
          </el-input>
        </el-form-item>
        <!-- 每层户数 -->
        <el-form-item :label="$t('operation.community.batchAddAddress.households')" prop="households">
          <el-input v-model.number="form.households" type="number" name="households" :placeholder="$t('operation.community.batchAddAddress.households')" clearable>
            <span slot="append">{{ $t('operation.community.batchAddAddress.householdsAppend') }}</span>
          </el-input>
        </el-form-item>
      </template>
      <!-- 保存 -->
      <el-form-item :label="form.nodeFlag ? ' ' : ''" class="save-btn-box" :class="{ fr: !form.nodeFlag }">
        <el-button type="primary" name="saveCommunityName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { addressTypeField } from '@/enums/community'
import { batchAddAddressFormFieldsMap } from '@/lang/zh/modules/operation/community'
import { arrayCombine } from '@/utils/array'
import { initQueryParams } from '@/utils/commons'
import { batchAddAddress, getCommunityList } from '@/api/operation/community'

export default {
  name: 'BatchAddAddressForm',
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
    this.dataStatusField = dataStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(batchAddAddressFormFieldsMap), new Array(Object.keys(batchAddAddressFormFieldsMap).length).fill('')),
        id: '',
        flag: addressTypeField.CITY,
        dataStatus: dataStatusField.VALID,
        unit: 1,
        nodeFlag: dataStatusField.INVALID
      },
      // 表单验证规则
      formRules: {
        communityName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.communityName')}`, trigger: 'change' }
        ],
        communityId: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.communityName')}`, trigger: 'change' }
        ],
        building: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.building')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('invalidInputValue')}`, trigger: 'blur' }
        ],
        unit: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.unit')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('invalidInputValue')}`, trigger: 'blur' }
        ],
        households: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.households')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('invalidInputValue')}`, trigger: 'blur' }
        ],
        storey: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.storey')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('invalidInputValue')}`, trigger: 'blur' }
        ],
        nodeCount: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.batchAddAddress.nodeCount')}`, trigger: 'blur' },
          { type: 'integer', min: 1, message: `${this.$t('invalidInputValue')}`, trigger: 'blur' }
        ],
      },
      allCommunityList: [], //有效小区(村、xx路)列表
    }
  },
  computed: {
    // 省市区
    region() {
      return `${this.formData.provinceName} ${this.formData.cityName} ${this.formData.areaName}`
    },
  },
  watch: {
    id: {
      handler(value) {
        this.initData()
      },
      immediate: false
    },
    formData: {
      handler(value) {
        this.initData()
      },
      immediate: false
    }
  },
  async created() {
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
      await this.getAllCommunityList()
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

    // 获取所有的小区(村、xx路)列表
    getAllCommunityList() {
      return new Promise((resolve) => {
        getCommunityList(initQueryParams({ size: 10000, model: { streetId: this.formData.streetId } })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.allCommunityList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
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
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        batchAddAddress(data).then((result) => {
          // console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm()
            }
            resolve(data || true)
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
            // 传递保存成功时间回父级组件
            this.$emit('success', saveResult, this.isAdd)
            // 重新拉取小区选择
            // await this.getAllCommunityList()
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

    // 是否批量录入调压箱号
    handleNodeFlagChange(value) {
      // console.log('value', value)
      this.$refs[this.formRef]?.clearValidate()
      this.form.flag = value ? addressTypeField.COUNTRY : addressTypeField.CITY
    },

    // 小区选择发生变化
    handleCommunityChange(value) {
      const community = this.allCommunityList.find((item) => item.communityName === value)
      this.form.communityId = community?.id ?? null
    },
  }
}
</script>

<style scoped lang="scss">
  .BatchAddAddressForm-page {
    ::v-deep {
      .save-btn-box {
      }
      .save-btn {
      }
      .qc-form {
        .el-form-item {
          width: calc(100% / 4);
        }
      }
    }
  }
</style>
