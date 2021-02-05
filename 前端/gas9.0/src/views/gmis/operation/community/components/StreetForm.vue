<!-- 街道(乡镇)表单 -->
<template>
  <div v-loading="loading" class="form-page street-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" class="qc-form clearfix" label-position="top" :inline="true">
      <!-- 省市区 -->
      <el-form-item :label="$t('operation.community.region')" prop="region" class="region-form-item">
        <el-cascader v-model="form.region" name="region" :options="regionCascadeList" :props="regionCascadeLProps" filterable :placeholder="`${$t('selectHint')}${$t('operation.community.region')}`" @change.native="handleRegionChange"></el-cascader>
      </el-form-item>
      <!-- 街道(乡镇)名称 -->
      <el-form-item :label="$t('operation.community.streetName')" prop="streetName">
        <el-input v-model.trim="form.streetName" name="streetName" :placeholder="$t('operation.community.streetName')" clearable></el-input>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item label="" class="save-btn-box fr" style="marginTop: 10px">
        <el-button type="primary" name="saveStreetName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
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
import { streetFormFieldsMap } from '@/lang/zh/modules/operation/community'
import { arrayCombine, flatToNest } from '@/utils/array'
import { getRegionList, saveStreet } from '@/api/operation/community'

export default {
  name: 'StreetForm',
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
    return {
      initForm: {
        ...arrayCombine(Object.keys(streetFormFieldsMap), new Array(Object.keys(streetFormFieldsMap).length).fill('')),
        id: '',
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        region: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.region')}`, trigger: 'change' },
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.region')}`, trigger: 'blur' }
        ],
        streetName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.streetName')}`, trigger: 'blur' }
        ]
      },
      // 地区级联数据配置
      regionCascadeLProps: {
        value: 'code'
      },
      regionList: [] // 地区列表
    }
  },
  computed: {
    // 省市区级联列表
    regionCascadeList() {
      if (this.regionList && this.regionList.length > 0) {
        return flatToNest(this.regionList, { defaultParentIdValue: '0' })
      } else {
        return []
      }
    }
  },
  watch: {
    id: {
      handler(value) {
        this.initData()
      },
      immediate: false
    },
    formData: {
      handler(data) {
        this.initData()
      },
      immediate: false
    },
    // 监听地区数据，查找对应的省市区
    'form.region': {
      handler(region){
        const { regionList } = this
        let 
          provinceCode = '', 
          provinceName = '',
          cityCode = '', 
          cityName = '', 
          areaCode = '', 
          areaName = ''
        // console.log('region', region)
        if (Array.isArray(region)) {
          provinceCode = region[0] || ''
          cityCode = region[1] || ''
          areaCode = region[2] || ''
          if (provinceCode) {
            provinceName = this.findRegionNameByCode(provinceCode)
          }
          if (cityCode) {
            cityName = this.findRegionNameByCode(cityCode)
          }
          if (areaCode) {
            areaName = this.findRegionNameByCode(areaCode)
          }
        }
        Object.assign(this.form, { provinceCode, provinceName, cityCode, cityName, areaCode, areaName })
      }
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
    // 初始化数据
    async initData() {
      if(!this.loading) {
        this.loading = true
        this.setFormStatus()
        await this.getRegionListData()
        await this.getFormData()
        this.loading = false
      }
    },

    // 获取表单数据
    async getFormData() {
      return new Promise((resolve) => {
        if (this.id) {
          // 请求api获取表单数据
          this.resetForm()
          resolve(true)
        } else if(!isEmpty(this.formData)) {
          this.setRegionValue()
          this.resetForm(this.formData)
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },

    // 设置region值
    setRegionValue() {
      const { provinceCode, cityCode, areaCode } = this.formData
      if (provinceCode && cityCode && areaCode) {
        this.formData.region = [provinceCode, cityCode, areaCode]
      }
    },

    // 获取地区数据
    async getRegionListData() {
      if(this.regionList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getRegionList().then((result) => {
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

    // 通过region code查找region信息
    findRegionNameByCode(code) {
      const region = this.regionList.find((region) => region.code === code)
      return region ? region.label : ''
    },

    // 设置表单状态
    setFormStatus() {
      let formStatus = formStatusField.ADD
      if (this.id || (!isEmpty(this.formData) && this.formData.id)) {
        formStatus = formStatusField.EDIT
      }
      this.formStatus = formStatus
    },

    // 省市区选择改变
    handleRegionChange(value) {
      // console.log(value)
    },

    // 保存数据
    savFormData(data = null) {
      if (!data) {
        data = this.form
      }
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        saveStreet(data, data?.id || '').then((result) => {
          // console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm()
            }
            // 传递保存成功时间回父级组件
            this.$emit('success', data, this.isAdd)
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
          const saveResult = await this.savFormData()
          if (saveResult) {
            this.$message.success(this.$t('saveSuccess'))
          }
        } else {
          this.$message.error(this.$t('validateError'))
        }
      })
    }
  }
}
</script>

<style scoped lang="scss">
  .qc-form {
    ::v-deep {
      .el-form-item {
        width: 40%;
      }
      .region-form-item {
        width: 60%;
        .el-cascader {
          width: 100%;
        }
      }
    }
  }
</style>
