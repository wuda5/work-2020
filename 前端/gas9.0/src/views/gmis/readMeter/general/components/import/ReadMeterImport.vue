<!--抄表导入-->
<template>
  <div class="ReadMeterImport-container">
    <import api="/bizcenter/readmeter/data/readMeterData/import" :options="{ readTime: form.readTime }" :list-fields-map="listFieldsMap" :before-upload="handleBeforeUplaod">
      <template v-slot:top>
        <el-form ref="formRef" :model="form" :rules="formRules" label-position="left" inline class="qc-form disabled-form clearfix">
          <!-- 抄表日期 -->
          <el-form-item prop="readTime" :label="$t('抄表月')">
            <el-date-picker
              v-model="form.readTime"
              type="month"
              placeholder="请先选择抄表年月"
              value-format="yyyy-MM"
              :picker-options="pickerOptions"
            ></el-date-picker>
          </el-form-item>
        </el-form>
      </template>
    </import>
  </div>
</template>

<script>
import Import from '@/components/QcImport/Index.vue'
import { parseTime } from '@/utils/index'

export default {
  name: 'ReadMeterImport',
  components: {
    Import
  },
  data() {
    return {
      form: {
        readTime: null
      },
      listFieldsMap: {
        customerChargeNo: '缴费编号',
        customerName: '客户姓名',
        gasMeterNumber: '表身号',
        gasMeterCode: '气表编号',
        moreGasMeterAddress: '安装地址',
        readMeterUserName: '抄表员',
        recordTime: '抄表时间',
        failValue: '失败原因',
        customerCode: '客户编号',
        currentTotalGas: '当前用气量',
      },
      formRules: {
        readTime: [
          { required: true, message: `请选择抄表月`, trigger: ['change', 'blur'] }
        ],
      },
      // 日期选择配置项
      pickerOptions: {
        disabledDate(date) {
          const nowDate = new Date()
          nowDate.setMonth(nowDate.getMonth() + 1)
          return +new Date(parseTime(nowDate, '{y}-{m}-01 00:00:00')) <= +new Date(date)
        },
      },
    }
  },
  methods: {
    // 上传之前执行操作
    handleBeforeUplaod(file) {
      return new Promise((resolve, reject) => {
        this.$refs.formRef.validate(async (valid) => {
          if (valid) {
            resolve()
          } else {
            this.$message.error('请先选择抄表月')
            reject('请先选择抄表月')
          }
        })
      })
    }
  },
}
</script>
<style lang="scss" scoped>
.ReadMeterImport-container {
  ::v-deep {
    .qc-form {
      padding: 0;
    }
  }
}
</style>
