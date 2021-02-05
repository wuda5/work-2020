<!-- 小区(村、xx路)表单 -->
<template>
  <div v-loading="loading" class="form-page community-form-page">
    <!-- 表单区域 -->
    <el-form :ref="formRef" :model="form" :rules="formRules" class="qc-form clearfix" label-position="top" :inline="true">
      <!-- 小区(村、xx路)名称 -->
      <el-form-item :label="$t('operation.community.communityName')" prop="communityName">
        <el-input v-model.trim="form.communityName" name="communityName" :placeholder="$t('operation.community.communityName')" clearable></el-input>
      </el-form-item>
      <!-- 保存 -->
      <el-form-item label=" " class="save-btn-box">
        <el-button type="primary" name="saveCommunityName" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ isAdd ? $t('add') : $t('save') }}</el-button>
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
import { communityFormFieldsMap } from '@/lang/zh/modules/operation/community'
import { arrayCombine } from '@/utils/array'
import { initQueryParams } from '@/utils/commons'
import { saveCommunity, getCommunityList } from '@/api/operation/community'

export default {
  name: 'CommunityForm',
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
        ...arrayCombine(Object.keys(communityFormFieldsMap), new Array(Object.keys(communityFormFieldsMap).length).fill('')),
        id: '',
        dataStatus: dataStatusField.VALID
      },
      // 表单验证规则
      formRules: {
        communityName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.communityName')}`, trigger: 'blur' }
        ],
        communityAddress: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('operation.community.communityAddress')}`, trigger: 'blur' }
        ]
      },
      allCommunityList: [], //有效小区(村、xx路)列表
    }
  },
  computed: {

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
        saveCommunity(data, data?.id || '').then((result) => {
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
    }
  }
}
</script>

<style scoped lang="scss">
  .community-form-page {
    ::v-deep {
      .save-btn-box {
      }
      .save-btn {
      }
      .qc-form {
        .el-form-item {
          width: calc(100% / 2);
        }
      }
    }
  }
</style>
