<!--回访登记-->
<template>
  <el-card shadow="never" class="no-border">
    <el-form label-position="top" :model="form" class="jh-text buka">
      <el-form-item label="满意度" class="width100">
        <el-select v-model="form.satisfaction" clearable placeholder="请选择">
          <el-option
            label="非常满意"
            value="1"
          />
          <el-option
            label="很满意"
            value="2"
          />
          <el-option
            label="满意"
            value="3"
          />
          <el-option
            label="不满意"
            value="4"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="意见" class="width100" style="margin-top: 15px">
        <el-input v-model="form.opinion" type="textarea" />
      </el-form-item>
      <div class="clearfix"></div>
      <br>
      <div class="btnBox">
        <el-button type="primary" class="fr">登记</el-button>
      </div>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'ReturnVisit',
  data() {
    return {
      form: {
        satisfaction: '',
        opinion: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body{
  padding: 0;
}
</style>
