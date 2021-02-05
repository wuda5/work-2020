<!--
 * @Description: 设计方案界面
 * @Author: lingw
 * @Date: 2020-11-17 15:22:17
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 15:23:12
-->
<template>
 <div>
   <el-form ref="form" :model="form" :rules="rules" class="jh-text" label-position="top">
     <el-form-item label="设计人" prop="designUser">
        <el-select v-model="form.designUserInfo" value-key="designUser">
          <el-option v-for="user in workerList" :key="user.designUser" :label="user.designUserName" :value="user">
        </el-option>
      </el-select>
     </el-form-item>
     <el-form-item label="预算报价" prop="budget">
      <el-input v-model="form.budget" type="number" />
     </el-form-item>
     <el-form-item label="施工工期" prop="workload">
      <el-input v-model="form.workload" />
     </el-form-item>
     <el-form-item label="备注">
      <el-input v-model="form.remark" />
     </el-form-item>
   </el-form>
   <div>
     <span>附件</span>
      <upload :file-list="fileList" @success="handleImgSuccess" />
   </div>
   <div style="text-align: right;">
    <el-button :loading="loading" style="margin-top: 8px;" type="primary" @click="handleSubmit">
      提交
    </el-button>
  </div>
 </div>
</template>

<script>
import db from '@/utils/localstorage';
import Upload from '@/components/CustomUpload'
export default {
  name: 'DesignScheme',
  components: {
    Upload
  },
  props: {
    workerList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      loading: false,
      fileList: [],
      form: {
        designUrl: '',
        designUserInfo: {
          designUserName: '',
          designUser: ''
        },
        // budgetTime: '',
        budget: '',
        workload: '',
        remark: ''
      },
      rules: {
        designUserInfo: [
          { required: true, message: '请选择设计人', trigger: 'blur' }
        ],
        budget: [
          { required: true, message: '请输入预算报价', trigger: 'blur' }
        ],
        workload: [
          { required: true, message: '请输入施工工期', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    // 上传成功的回调
    handleImgSuccess(res, file) {
      if (!this.fileList.length) {
        this.form.designUrl = res?.data?.url ?? ''
      } else {
        const cacheImages = this.fileList.map(({ url }) => url)
        this.form.designUrl = cacheImages.join(',') + `,${res?.data?.url ?? ''}`
      }
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = true
          const payload = {
            ...this.form,
            ...this.form.designUserInfo,
          }
          delete payload.designUserInfo
          this.$emit('submit', payload)
        } else {
          return false
        }
      })
    },
    // 重置表单
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
