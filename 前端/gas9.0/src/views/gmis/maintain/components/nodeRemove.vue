<!-- 拆除节点 -->
<template>
  <el-card shadow="never" class="no-border">
    <el-form label-position="top" :model="fromData" class="jh-text meterInfo">
      <el-form-item label="节点编号">
        <p>{{fromData[1]}}</p>
      </el-form-item>
      <el-form-item label="节点名称">
        <p>{{fromData[2]}}</p>
      </el-form-item>
      <el-form-item label="节点类型">
        <p>{{fromData[3]}}</p>
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item label="拆除原因" class="width100">
        <el-input v-model="fromData[4]" rows="3" type="textarea" />
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item label="" style="float: right">
        <el-button type="primary" class="width100">拆除</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'NodeRemove',
  data() {
    return {
      // 收费表单
      fromData: {
        1: 'CD1001',
        2: '模范街节点',
        3: '调压箱',
        4: ''
      }

    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body{
  padding: 10px;
}
.jh-text {
  .el-form-item {
    margin-bottom: 10px;
  }
}
</style>
