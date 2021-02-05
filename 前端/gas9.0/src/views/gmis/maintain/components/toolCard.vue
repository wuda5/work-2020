<!-- 工具卡制作 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="chargeForm" class="jh-text">

        <el-form-item label="安检内容" class="width100">
          <el-input v-model="chargeForm.content" type="textarea" rows="3" placeholder="请输入终止原因" />
        </el-form-item>
        <div class="clearfix"></div>
        <br>
        <div class="btnBox">
          <el-button type="primary" class="fr">终止</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'ToolCard',
  data() {
    return {
      businessInfo: {
        1: '233',
        2: '350',
        3: '2',
        4: '0',
        5: '2',
        6: '20',
        7: '50',
        8: '20',
        9: '2020.2.31'
      },
      // 收费表单
      chargeForm: {
        content: ''
      }
    }
  },
  computed: {},
  methods: {}
}
</script>
<style lang="scss" scoped>
::v-deep .el-card__body{
  padding: 0;
}
</style>

