<!-- tabs 表具入库信息 -->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">入库信息</div>
    </div>
    <div slot="default" class="frameBody">
      <el-card shadow="never" class="listItem">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="气表厂家">
            <p>---</p>
          </el-form-item>
          <el-form-item label="气表版号">
            <p>---</p>
          </el-form-item>
          <el-form-item label="通气方向">
            <p>---</p>
          </el-form-item>
          <el-form-item label="气表编号">
            <p>---</p>
          </el-form-item>
          <el-form-item label="购买时间">
            <p>---</p>
          </el-form-item>
          <el-form-item label="防盗扣编号">
            <p>---</p>
          </el-form-item>
          <el-form-item label="检定时间">
            <p>---</p>
          </el-form-item>

          <el-form-item label="检定人">
            <p>---</p>
          </el-form-item>
          <el-form-item label="备注">
            <p>---</p>
          </el-form-item></el-form>
      </el-card>
    </div>
  </info-frame>
</template>

<script>
export default {
name: "ToStoreInfo"
}
</script>

<style scoped>

</style>
