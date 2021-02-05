<!--
 * @Description: 录入验收资料
 * @Author: lingw
 * @Date: 2020-11-18 09:33:53
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 11:34:31
-->
<template>
 <div>
   <el-form ref="form" :model="form" :rules="rules" label-position="top">
    <el-form-item label="验收意见" prop="acceptSuggest">
      <el-radio-group v-model="form.acceptSuggest">
        <el-radio label="1">通过</el-radio>
        <el-radio label="0">不通过</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="验证结论">
      <el-input v-model="form.resultText" type="textarea" :rows="2"></el-input>
    </el-form-item>
  </el-form>
  <div>
     <span>附件</span>
      <upload :file-list="fileList" @success="handleImgSuccess" />
   </div>
  <div style="text-align: right;">
    <el-button :loading="loading" type="primary" @click="handleSubmit">
      提交
    </el-button>
  </div>
 </div>
</template>

<script>
import Upload from '@/components/CustomUpload'
export default {
  name: 'AcceptDetail',
  components: {
    Upload
  },
  data () {
    return {
      loading: false,
      fileList: [],
      form: {
        acceptSuggest: '0',
        resultText: '',
        acceptUrl: ''
      },
      rules: {
        acceptSuggest: [
          { reuqired: true, message: '请选择是否验收通过' }
        ]
      }
    }
  },
  methods: {
    // 提交安装资料
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = true
          const payload = {
            ...this.form,
            acceptSuggest: this.form.acceptSuggest === '1'
          }
          this.$emit('submit', payload)
        } else {
          return false
        }
      })
    },
    // 上传成功的回调
    handleImgSuccess(res, file) {
      if (!this.fileList.length) {
        this.form.acceptUrl = res?.data?.url ?? ''
      } else {
        const cacheImages = this.fileList.map(({ url }) => url)
        if (cacheImages.length > 1) {
          this.form.acceptUrl = cacheImages.join(',') + `,${res?.data?.url ?? ''}`
        } else {
          this.form.acceptUrl = `${res?.data?.url ?? ''}`
        }
      }
    },
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
