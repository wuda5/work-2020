<!--
 * @Description: 上传附件 - 自定义封装组件
 * @Author: lingw
 * @Date: 2020-11-26 09:02:22
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 10:19:26
-->
<template>
 <div>
   <el-upload
    :file-list="fileList"
    :action="action"
    list-type="picture-card"
    :on-preview="handlePictureCardPreview"
    :data="fileOtherData"
    :headers="headers"
    :on-success="handleImgSuccess"
  > 
  <i class="el-icon-plus"></i>
  </el-upload>
  <el-dialog :visible.sync="dialogVisible">
    <img width="100%" :src="dialogImageUrl" alt="">
  </el-dialog>
 </div>
</template>

<script>
import db from '@/utils/localstorage';
export default {
  name: 'CustomUpload',
  props: {
    fileList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      headers: {},
      dialogImageUrl: '',
      dialogVisible: false,
      accept: 'image/jpeg, image/gif, image/png',
      fileOtherData: {
        bizType: 'INSTALL_FILE'
      },
      action: ''
    }
  },
  created() {
    // 解决组件上传图片错误的问题（问题就在于上传地址，使用的是聚合服务的地址）
      let url = ''
      if (process.env.NODE_ENV === 'development') {
        url = process.env.VUE_APP_DEV_REQUEST_DOMAIN_PREFIX + '/bizcenter/sysparam/attachment/attachment/upload'
      } else if (process.env.NODE_ENV === 'production') {
        url = process.env.VUE_APP_PROD_REQUEST_DOMAIN_PREFIX + '/bizcenter/sysparam/attachment/attachment/upload'
      }
      this.headers.token = 'Bearer ' + db.get('TOKEN', '');
      this.headers.tenant = db.get('TENANT', '')
      this.action = url
  },
  methods: {
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    // 上传成功的回调
    handleImgSuccess(res, file) {
      this.$emit('success', res)
    },
  }
}
</script>

<style lang='scss' scoped>

</style>
