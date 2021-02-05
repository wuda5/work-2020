<!--安检信息-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">安检信息</div>
    </div>
    <div slot="default" class="frameBody">
      <el-card shadow="never" class="listItem">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="安检员">
            <p>---</p>
          </el-form-item>
          <el-form-item label="安检类型">
            <p>---</p>
          </el-form-item>
          <el-form-item label="最后安检时间">
            <p>---</p>
          </el-form-item>
          <el-form-item label="安检结果">
            <!--<p>正常</p>-->
            <el-tag type="success">---</el-tag>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </info-frame>
</template>
<script>
export default {
  name: 'SafeCheckInfo'
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}
</style>

