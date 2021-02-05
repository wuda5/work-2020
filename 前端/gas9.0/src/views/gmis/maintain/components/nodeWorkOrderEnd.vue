<!-- 安检-结单 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="chargeForm" class="jh-text buka">
        <el-form-item label="处理结果" class="width100">
          <el-select v-model="chargeForm.ret" clearable placeholder="请选择">
            <el-option
              label="完成"
              value="1"
            />
            <el-option
              label="待完成"
              value="2"
            />
            <el-option
              label="无法完成"
              value="3"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" class="width100">
          <el-input v-model="chargeForm.content" rows="3" type="textarea"/>
        </el-form-item>
        <div class="clearfix"></div>
        <div class="btnBox">
          <el-button type="primary" class="fr">结单</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'NodeWorkOrderEnd',
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
        ret: '',
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

