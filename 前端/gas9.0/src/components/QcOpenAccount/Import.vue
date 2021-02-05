<!-- 导入开户 -->
<template>
  <div class="ImportOpenAccount-page">
    <!-- 上传文件区域 -->
    <el-upload ref="uploadRef" v-loading="uploadLoading" class="upload-box" :class="{ disabled: uploadLoading }" :disabled="uploadLoading" :show-file-list="true" :action="action" :headers="headers" drag :auto-upload="true" accept=".xlsx, .xls" :before-upload="handleBeforeUpload" :on-change="handleFileChange" :on-progress="handleProgress" :on-success="handleUploadSuccess" :on-error="handleUploadError">
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
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { validURL } from '@/utils/my-validate'
import { getBaseUrl, generateRequestConfig } from '@/utils/api'
import { getImportOpenAccountData, importOpenAccount } from '@/api/userInfo/index'
import { importDataStatusfilters, dataStatusClassMap, importDataStatusMap } from '@/enums/common'

export default {
  name: 'ImportOpenAccount',
  components: {

  },
  filters: {
    importDataStatusFormat(value) {
      return importDataStatusMap[+value]
    },
    importDataStatusClassFormat(value) {
      return dataStatusClassMap[+value]
    },
  },
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.importDataStatusfilters = importDataStatusfilters
    return {
      action: `${getBaseUrl()}/bizcenter/tempCounter/importBackJson`,
      headers: generateRequestConfig()?.headers ?? {},
      uploadLoading: false,
      showImportData: false, // 是否展示导入数据，
      file: {}, // 上传的文件信息
      link: null,
    }
  },
  computed: {

  },
  watch: {

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
       await this.getData()
    },
    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },

    // 获取导入列表数据列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getImportOpenAccountData(this.generateQueryParams(params)).then((result) => {
          this.listLoading = false
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            resolve(records)
          } else {
            this.listLoading = false
            resolve(false)
          }
        })
      })
    },

    // 上传之前进行的判断
    handleBeforeUpload(file) {
      console.log(file)
      this.uploadLoading = true
      return true
    },

    //文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用
    handleFileChange(file, fileList) {
      console.log(file, fileList)
      this.file = file.raw
    },

    // 开始上传
    handleUpload() {
      this.$refs.uploadRef.submit()
    },

    // 文件上传时的钩子
    handleProgress(event, file, fileList) {
      console.log(event)
    },

    // 上传模组文件成功
    handleUploadSuccess(response, file, fileList) {
      console.log(response)
      this.uploadLoading = false
      const { isSuccess, data, msg } = response
      if (isSuccess) {
        this.$message.success(this.$t('customerInfo.importOpenAccountSuccess'))
        // 清空上传文件
        this.$refs?.uploadRef?.clearFiles()
        // 清空link
        this.link = null
        this.file = {}
        // 导入成功回调父组件
        this.$emit('success', data)
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
      console.log('上传失败')
      console.log(err, file, fileList)
      this.uploadLoading = false
      this.$message({
        message: err.message,
        type: 'error'
      })
    },

    // 自定义上传实现
    handleCustomerUpload(data) {
      console.log(data)
      const formData = new FormData()
      formData.append('file', data.file)
      const importLoading = this.$loading({
        lock: true,
        text: this.$t('customerInfo.importOpenAccountLoading'),
      })
      this.uploadLoading = true
      importOpenAccount(formData).then((result) => {
        console.log('result', result)
        importLoading.close()
        this.uploadLoading = false
        const { isSuccess, msg } = result.data
        const resultData = result.data.data
        if (isSuccess) {
          this.showImportData = true
          this.$message.success(this.$t('customerInfo.importOpenAccountSuccess'))
          // 清空上传文件
          this.$refs?.uploadRef?.clearFiles()
          // 清空当前文件
          this.file = {}
          // 清空link
          this.link = null
          this.file = {}

          // 获取导入开户的数据
          this.getList()
          // 导入成功回调父组件
          this.$emit('success')
        } else {
          this.$message.error(msg)
          if (validURL(resultData)) {
            this.file = data.file
            this.link = resultData
            window.location.href = resultData
          }
        }
      }).catch(() => {
        importLoading.close()
        this.uploadLoading = false
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
        overflow: inherit;
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
