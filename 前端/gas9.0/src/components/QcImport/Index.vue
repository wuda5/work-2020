<!--通用导入组件-->
<template>
  <div class="qc-import-container">
    <!-- 顶部需要添加的内容插槽 -->
    <slot name="top"></slot>
    <!-- 上传文件区域 -->
    <el-upload ref="uploadRef" v-loading="uploadLoading" :element-loading-text="$t('import.loadingText')" class="upload-box upload-meter" :class="{ disabled: uploadLoading }" :disabled="uploadLoading" :show-file-list="true" drag :action="uploadAction" :headers="uploadHeaders" :data="uploadData" accept=".xlsx, .xls" :before-upload="handleBeforeUpload" :on-progress="handleProgress" :on-success="handleUploadSuccess" :on-error="handleUploadError">
      <i class="el-icon-upload" />
      <div class="el-upload__text">{{ $t('import.uploadDes1') }}<em>{{ $t('import.uploadDes2') }}</em></div>
      <div slot="tip" class="el-upload__tip upload-hint-box">{{ $t('import.uploadHint') }}</div>
    </el-upload>

    <!-- 上传结果插槽 -->
    <slot :result="uploadResult || {}">
      <!-- 上传验证失败提示 -->
      <el-alert v-if="uploadResult" class="result-alert" :type="alertType" title="" show-icon :closable="false">
        <template v-slot:title>
          导入数据共计<span class="total">{{ errorNum + successNum }}</span>条，其中成功<span class="success">{{ successNum }}条</span>，失败<span class="error">{{ errorNum }}条</span>
        </template>
      </el-alert>
    </slot>

    <!-- 上传错误数据列表插槽 -->
    <slot :resultList="uploadResult || {}">
        <!--扎帐信息-->
        <el-card v-if="errorNum > 0" shadow="never" class="no-border">
          <div slot="header">
            <span class="card-title">错误数据列表</span>
            <el-button type="primary" class="fr" @click="handleExportErrorData">导出错误数据</el-button>
          </div>
          <!-- 错误数据列表区域 -->
          <el-table
            ref="listRef"
            v-loading="loading"
            :data="uploadResult.failData"
            tooltip-effect="dark"
            style="width: 100%"
            :border="false"
            stripe
            :highlight-current-row="false"
          >
            <!-- 序列号 -->
            <el-table-column type="index" :label="$t('table.index')" />
            <el-table-column v-for="(value, key) in uploadResult.failData[0]" :key="key" :prop="key" :label="listFieldsMap[key] || key" show-overflow-tooltip />
          </el-table>
        </el-card>
    </slot>
  </div>
</template>

<script>
import { merge } from 'lodash'
import commonMixins from '@/mixins/common'
import { importMeterInfo } from '@/api/meterInfo/index'
import { fileStreamDownload } from '@/api/File'
import { awaitToJs } from '@/utils/index.js'
import { validURL } from '@/utils/my-validate'
import { getBaseUrl, generateRequestConfig } from '@/utils/api'

export default {
  name: 'QcImport',
  components: {

  },
  filters: {},
  mixins: [commonMixins],
  props: {
    // 上传接口地址
    api: {
      type: String,
      required: true,
    },
    // 设置上传的请求头部
    headers: {
      type: Object,
      default: () => ({}),
    },
    // 上传时附带的额外参数
    options: {
      type: Object,
      default: () => ({}),
    },
    // 上传之前进行的操作, 返回值为Promise对象
    beforeUpload: Function,
    // 数据列表显示字段名映射 { id: '索引', age: '年龄' }
    listFieldsMap: {
      type: Object,
      default: () => ({
      })
    },
  },
  data() {
    return {
      file: {},
      uploadLoading: false,
      link: null,
      uploadResult: null, // 上传结果
    }
  },
  computed: {
    // 全部导入失败的数据
    errorNum() {
      return +(this.uploadResult?.fail || 0)
    },
    // 是否全部成功导入
    successNum() {
      return +(this.uploadResult?.success || 0)
    },
    // 设置alert type
    alertType() {
      let result = 'warning'
      if (this.errorNum > 0 && this.successNum === 0) {
        result = 'error'
      } else if (this.successNum > 0 && this.errorNum === 0) {
        result = 'success'
      }
      return result
    },
    // 导出url
    exportUrl() {
      const url = this.uploadResult?.errUrl
      return validURL(url) ? url : null
    },
    // 上传的地址
    uploadAction() {
      return `${getBaseUrl()}${this.api}`
    },
    // 设置上传的请求头部
    uploadHeaders() {
      return merge(generateRequestConfig()?.headers ?? {}, this.headers)
    },
    // 上传时附带的额外参数
    uploadData() {
      return merge({}, this.options)
    },
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

    // 上传之前进行的判断
    async handleBeforeUpload(file) {
      console.log(file)
      this.uploadLoading = true
      return new Promise((resolve, reject) => {
        if (this.beforeUpload) {
          this.beforeUpload(file)
          .then((result) => {
            resolve(true)
          })
          .catch(() => {
            this.uploadLoading = false
            reject(false)
          })
        } else {
          resolve(true)
        }
      })
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
        this.$message.success(this.$t('import.success'))
        // 清空文件列表
        this.$refs?.uploadRef?.clearFiles()
        this.uploadResult = data
        // 父组件回调
        this.$emit('success', data)
        // 清空link
        this.link = null
        this.file = {}
        if (this.errorNum > 0) {
          if (this.exportUrl) {
            this.handleExportErrorData()
            // window.location.href = this.exportUrl
          }
        }
        // 导入成功回调父组件
        this.$emit('success')
      } else {
        this.$message.error(msg)
      }
    },

    // 上传失败
    handleUploadError(err, file, fileList) {
      // console.log(err)
      // console.log(file)
      // console.log(fileList)
      this.uploadLoading = false
      this.$message({
        message: err.message,
        type: 'error'
      })
      // 父组件回调
      this.$emit('error')
    },

    // 导出错误数据
    handleExportErrorData() {
      fileStreamDownload(this.exportUrl, {}, {
        method: 'get'
      }, {
        name: '导入错误数据列表.xls'
      })
      // window.location.href = this.exportUrl
    }
  }
}
</script>

<style scoped lang="scss">
  .qc-import-container {
    ::v-deep {
      .result-alert {
        margin: 15px 0;
      }
    }
  }
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

