<!-- 安检-派单 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="chargeForm" class="jh-text buka">
        <el-form-item label="接单人" class="width100">
          <el-select v-model="chargeForm.name" clearable placeholder="请选择">
            <el-option
              label="张三"
              value="1"
            />
            <el-option
              label="杨家兵"
              value="2"
            />
            <el-option
              label="李宁"
              value="3"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="工单内容" class="width100">
          <el-input v-model="chargeForm.content" type="textarea" rows="5" placeholder="请输入工单内容" />
        </el-form-item>
        <div class="clearfix"></div>
        <br>
        <div class="btnBox">
          <el-button type="primary" class="fr">派单</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'SendOrder',
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
        data: '',
        name: '',
        content: ''
      }
    }
  },
  computed: {},
  methods: {}
}
</script>
<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 0;
}
</style>

