<!-- 导入安装结果EXCEL -->
<template>
  <div class="ImportUserInfo-page">
    <!-- 上传文件区域 -->
    <el-upload ref="uploadRef" v-loading="uploadLoading" :element-loading-text="$t('import.loadingText')" class="upload-box upload-customer" :class="{ disabled: uploadLoading }" :disabled="uploadLoading" :show-file-list="true" drag :action="action" :headers="headers" :data="{}" accept=".xlsx, .xls" :before-upload="handleBeforeUpload" :on-progress="handleProgress" :on-success="handleUploadSuccess" :on-error="handleUploadError">
      <i class="el-icon-upload" />
      <div class="el-upload__text">{{ $t('meterInfo.uploadDes1') }}<em>{{ $t('meterInfo.uploadDes2') }}</em></div>
      <div slot="tip" class="el-upload__tip upload-hint-box">{{ $t('meterInfo.uploadHint') }}</div>
    </el-upload>
    <!-- 上传验证失败提示 -->
    <transition name="el-zoom-in-center">
      <el-alert v-show="link" style="marginTop: 15px" type="error" title="" show-icon :closable="false">
        <template v-slot:title>
          {{ $t('import.errorHint') }}
          <el-link :href="link" type="primary">{{ $t('import.download') }}</el-link>
        </template>
      </el-alert>
    </transition>
  </div>
</template>

<script>
import commonMixins from '@/mixins/common'
import customerInfoApi from '@/api/userInfo/index'
import { validURL } from '@/utils/my-validate'
import { getBaseUrl, generateRequestConfig } from '@/utils/api'

export default {
  name: 'UploadInstallFIle',
  mixins: [commonMixins],
  data() {
    return {
      action: `${getBaseUrl()}/bizcenter/install/details/importInstallDetail`,
      headers: generateRequestConfig()?.headers ?? {},
      file: {},
      uploadLoading: false,
      link: null,
    }
  },
  methods: {
    // 上传之前进行的判断
    handleBeforeUpload(file) {
      console.log(file)
      this.uploadLoading = true
      return true
    },

    // 文件上传时的钩子
    handleProgress(event, file, fileList) {
      console.log(event, file, fileList)
    },

    // 上传模组文件成功
    handleUploadSuccess(response, file, fileList) {
      console.log(response)
      this.uploadLoading = false
      const { isSuccess, data, msg } = response
      if (isSuccess) {
        this.$message.success(this.$t('customerInfo.importSuccess'))
        // 清空文件列表
        this.$refs?.uploadRef?.clearFiles()
        // 清空link
        this.link = null
        this.file = {}
        // 导入成功回调父组件
        this.$emit('success')
      } else {
        this.$message.error(msg)
        if (validURL(data)) {
          this.file = file
          this.link = data
          window.location.href = data
        }
      }
    },

    // 上传失败
    handleUploadError(err, file, fileList) {
      this.uploadLoading = false
      this.$message({
        message: err.message,
        type: 'error'
      })
    },

    // 自定义上传实现
    handleCustomerUpload(data) {
      const formData = new FormData()
      formData.append('file', data.file)
      const importLoading = this.$loading({
        lock: true,
        text: this.$t('customerInfo.importLoading'),
      })
      customerInfoApi.importCustomerInfo(formData).then((result) => {
        importLoading.close()
        const { isSuccess, data, msg } = result.data
        const resultData = result.data.data
        if (isSuccess) {
          this.$message.success(this.$t('customerInfo.importSuccess'))
          // 清空文件列表
          this.$refs?.uploadRef?.clearFiles()
          // 清空link
          this.link = null
          this.file = {}
          // 导入成功回调父组件
          this.$emit('success')
        } else {
          this.$message.error(msg)
          if (validURL(resultData)) {
            this.link = resultData
            this.file = data.file
            window.location.href = resultData
          }
        }
      }).catch(() => {
        importLoading.close()
      })
    }
  }
}
</script>

<style scoped lang="scss">
  .upload-box {
    ::v-deep {
      .el-upload {
        display: block;
        width: 100%;
        .el-upload-dragger {
          width: inherit;
        }
      }
      .upload-hint-box {
        font-size: 12px;
        color: $warning;
        text-align: left;
        margin-top: 7px;
      }
      .el-upload-list {
        position: relative;
        height: auto;
        width: auto;
        border: none;
      }
    }
    &.disabled {
      ::v-deep {
        .el-upload {
          * {
            cursor: not-allowed !important;
          }
        }
      }
    }
  }
</style>
