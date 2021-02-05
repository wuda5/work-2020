<!--气表状态-->
<template>
  <el-card
    class="no-border"
  >
    <div slot="header">
      <span class="card-title">气表状态</span>
      <!--<el-button class="view-more" type="text">查看更多 ></el-button>-->
    </div>
    <div>
      <el-card shadow="never" class="listItem">
        <el-form label-position="top" class="jh-text">
          <el-form-item label="累计用气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="周期累计用气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="阀状态">
            <p>---</p>
          </el-form-item>
          <el-form-item label="报警器">
            <p>---</p>
          </el-form-item>
          <el-form-item label="当前阶梯">
            <p>---</p>
          </el-form-item>
          <el-form-item label="当前价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="更新时间">
            <p>---</p>
          </el-form-item>
          <el-form-item label="气表余额">
            <p>---</p>
          </el-form-item>
          <el-form-item label="异常信息">
            <p>---</p>
          </el-form-item>
          <div class="clearfix"></div>
          <el-form-item label="1阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="1阶价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="2阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="2阶价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="3阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="3阶价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="4阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="4阶价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="5阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="5阶价格">
            <p>---</p>
          </el-form-item>
          <el-form-item label="6阶气量">
            <p>---</p>
          </el-form-item>
          <el-form-item label="6阶价格">
            <p>---</p>
          </el-form-item>

        </el-form>
      </el-card>
    </div>
  </el-card>
</template>
<script>
export default {
  name: 'MeterState'
}
</script>

<style lang="scss" scoped>
  .el-form-item {
    width: 50%;
  }

  .listItem {
    ::v-deep .el-card__header {
      font-size: 12px;
      line-height: 20px;
    }

    ::v-deep .el-card__body {
      padding: 10px;
    }
  }
</style>

