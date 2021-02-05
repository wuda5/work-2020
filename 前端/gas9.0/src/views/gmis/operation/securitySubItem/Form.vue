<!-- 安检子项表单 -->
<template>
  <div v-loading="loading" class="form-page security-subItem-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" label-position="top" inline class="qc-form clearfix security-subItem-form clearfix">
      <!-- 子项名称 -->
      <el-form-item :label="$t('operation.securitySubItem.name')" prop="name">
        <el-input v-model="form.name" :placeholder="$t('operation.securitySubItem.name')">
        </el-input>
      </el-form-item>
      <!-- 隐患级别 -->
      <el-form-item prop="dangerLevel" :label="$t('operation.securitySubItem.dangerLevel')">
        <el-select v-model="form.dangerLevel" name="dangerLevel" :placeholder="$t('operation.securitySubItem.dangerLevel')">
          <el-option v-for="(item, index) in dangerLevels" :key="index" :label="item.label" :value="item.value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 安检项名称 -->
      <el-form-item prop="securityName" :label="$t('operation.securitySubItem.securityName')">
        <el-select v-model="form.securityName" name="securityName" :placeholder="$t('operation.securitySubItem.securityName')" @change="selectHandle">
          <el-option v-for="(value, index) in securityNames" :key="index" :label="value" :value="value"></el-option>
        </el-select>
      </el-form-item>
      <!-- 安检项编码 -->
      <el-form-item prop="securityCode" :label="$t('operation.securitySubItem.securityCode')">
        <el-input v-model="form.securityCode" :placeholder="$t('operation.securitySubItem.securityCode')" disabled></el-input>
      </el-form-item>
      
      <!-- 数据状态 -->
      <el-form-item label=" " prop="dataStatus" class="checkbox-item">
        <el-checkbox v-model="form.dataStatus" name="dataStatus" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE">{{ $t('operation.securitySubItem.dataStatusLabel') }}</el-checkbox>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button type="primary" name="savePriceName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isEmpty, cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { formStatusField } from '@/enums/form'
import { dataStatusField, useStatusField } from '@/enums/common'
import { securitySubItemFieldsMap } from '@/lang/zh/modules/operation/securitySubItem'
import { initQueryParams } from '@/utils/commons'
import { parseTime } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { positiveNumberReg } from '@/utils/reg'
import {  saveData } from '@/api/operation/securitySubItem'

export default {
  name: 'SecuritySubItemForm',
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
    },
  },
  data() {
    this.useStatusField = useStatusField
    return {
      initForm: {
        ...arrayCombine(Object.keys(securitySubItemFieldsMap), new Array(Object.keys(securitySubItemFieldsMap).length).fill('')),
        id: '',
        dataStatus: dataStatusField.VALID,
        securityName:'',
      },
      // 表单验证规则
      formRules: {
        
      },
      // 设置禁用状态
      disabledDate(value) {
          return +new Date(value) <= +new Date(parseTime(new Date(), '{y}-{m}-{d} 23:59:59'))
      },
      dangerLevels:[{
        label:'重度事故隐患',
        value:0
      },{
        label:'一般事故隐患',
        value:1
      },{
        label:'中度事故隐患',
        value:2
      }]
    }
  },
  computed: {
    //安检项名称
    securityNames(){
      // console.log(this.dictMap[dictionaryCodeMap.SECURITY_TYPE])
      return this.dictMap[dictionaryCodeMap.SECURITY_TYPE]
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
      handler(value) {
        this.initData()
      },
      immediate: false
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
          const cloneData = cloneDeep(this.formData)
          this.resetForm(cloneData)
          resolve(true)
        } else {
          this.resetForm()
          resolve(true)
        }
      })
    },
    //安检项名称对应的编码处理
    selectHandle(){
      for (let key in this.dictMap[dictionaryCodeMap.SECURITY_TYPE]){
        if(this.form.securityName == this.dictMap[dictionaryCodeMap.SECURITY_TYPE][key]){
          this.form.securityCode = key
        }
      }
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
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        saveData(cloneData, data?.id || '').then((result) => {
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
  }
}
</script>

<style scoped lang="scss">
  .security-subItem-form-page {
    padding: 5px 0 15px;
  }
  .security-subItem-form {
    ::v-deep {
      .el-form-item {
        float: none;
        display: inline-block;
      }
      .el-date-editor {
        width: 100%;
      }
    }
    // .save-btn-box {
      // float: right;
      // margin-top: -2px;
      // .save-btn {
      //   width: 100%;
      //   padding: 8px 15px;
      // }
    // }
  }
</style>
