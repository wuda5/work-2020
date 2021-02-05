<!--预开户-->
<template>
  <el-card shadow="never" class="no-border">
    <el-form label-position="top" :model="securityForm" class="jh-text meterInfo">
      <el-form-item label="计划时间">
        <el-time-picker v-model="securityForm.time"></el-time-picker>
      </el-form-item>
      <el-form-item label="安检员">
        <el-select v-model="securityForm.name" clearable placeholder="请选择">
          <el-option
            label="张三"
            value="1"
          />
          <el-option
            label="李四"
            value="2"
          />
          <el-option
            label="谢幺妹"
            value="3"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="安检内容" class="width100">
        <el-select v-model="securityForm.content" multiple clearable placeholder="请选择">
          <el-option
            label="不通气"
            value="1"
          />
          <el-option
            label="管道"
            value="2"
          />
          <el-option
            label="通气检查"
            value="3"
          />
        </el-select>
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item label="  " style="float: right">
        <el-button type="primary" class="width100">生成安检单</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'SecurityCheck',
  data() {
    return {
      securityForm: {
        time: '',
        name: '',
        content: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}
</style>
