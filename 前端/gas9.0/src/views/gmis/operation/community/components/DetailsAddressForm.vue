<!-- 详细地址表单 -->
<template>
  <div v-loading="loading" class="form-page DetailsAddressForm-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" class="qc-form clearfix" label-position="top" :inline="true">
      <!-- 地址类型 -->
      <el-form-item :label="$t('operation.community.flag')" prop="flag" style="width: 15%">
        <el-select v-model.number="form.flag" name="flag" :placeholder="$t('operation.community.flag')">
          <el-option v-for="(value, key) in addressTypeMap" :key="key" :value="+key" :label="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 栋 -->
      <el-form-item v-if="isCity" :label="$t('operation.community.building')" prop="building" style="width: 16%">
        <el-input v-model.number="form.building" type="number" name="building" :placeholder="$t('operation.community.building')" clearable>
          <span slot="append">{{ $t('operation.community.building') }}</span>
        </el-input>
      </el-form-item>
      <!-- 单元 -->
      <el-form-item v-if="isCity" :label="$t('operation.community.unit')" prop="unit" style="width: 19%">
        <el-input v-model.number="form.unit" type="number" name="unit" :placeholder="$t('operation.community.unit')" clearable>
          <span slot="append">{{ $t('operation.community.unit') }}</span>
        </el-input>
      </el-form-item>
      <!-- 剩余详细地址 -->
      <el-form-item :label="$t('operation.community.detailAddress')" prop="detailAddress" :style="{ width: isCity ? '50%' : '80%' }">
        <el-input v-model.trim="form.detailAddress" name="detailAddress" :placeholder="$t('operation.community.detailAddress')" clearable></el-input>
      </el-form-item>
      <!-- 保存 -->
      <el-form-item label="" class="save-btn-box fr" style="marginTop: 10px">
        <el-button type="primary" name="saveAddressName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { formStatusField } from '@/enums/form'
import { dataStatusField } from '@/enums/common'
import { addressTypeField, addressTypeMap } from '@/enums/community'
import { detailsFormFieldsMap } from '@/lang/zh/modules/operation/community'
import { arrayCombine } from '@/utils/array'
import { initQueryParams } from '@/utils/commons'
import { saveDetailsAddress, getCommunityList } from '@/api/operation/community'

export default {
  name: 'DetailsAddressForm',
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
    this.addressTypeMap = addressTypeMap
    return {
      initForm: {
        ...arrayCombine(Object.keys(detailsFormFieldsMap), new Array(Object.keys(detailsFormFieldsMap).length).fill('')),
        id: '',
        flag: addressTypeField.CITY,
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        flag: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.flag')}`, trigger: 'change' }
        ],
        building: [
          { validator: (rule, value) => {
            if (value !== '' && value !== null) {
              if (value < 1) {
                return Promise.reject(this.$t('invalidInputValue'))
              }
            }
            return Promise.resolve(true)
          }, trigger: 'blur' }
        ],
        unit: [
          { validator: (rule, value) => {
            if (value !== '' && value !== null) {
              if (value < 1) {
                return Promise.reject(this.$t('invalidInputValue'))
              }
            }
            return Promise.resolve(true)
          }, trigger: 'blur' }
        ],
        detailAddress: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.detailAddress')}`, trigger: 'blur' }
        ],
      },
      allCommunityList: [], //有效小区(村、xx路)列表
    }
  },
  computed: {
    // 地址是否是城市类型
    isCity() {
      return this.form.flag === addressTypeField.CITY
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
    await this.getAllCommunityList()
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

    // 获取所有的小区(村、xx路)列表
    getAllCommunityList() {
      return new Promise((resolve) => {
        getCommunityList(initQueryParams({ size: 10000, model: { streetId: this.formData.communityId } })).then((result) => {
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
        saveDetailsAddress(data, data?.id || '').then((result) => {
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
            await this.getAllCommunityList()
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
  .DetailsAddressForm-page {
    ::v-deep {
      .qc-form  {
        .el-form-item  {
          width: calc(100% / 5);
        }
        .save-btn-box {
          width: calc(100% / 3);
        }
        .el-input-group__append {
          padding: 0 5px;
        }
      }
      .save-btn-box {
      }
      .save-btn {
      }
    }
  }
</style>
