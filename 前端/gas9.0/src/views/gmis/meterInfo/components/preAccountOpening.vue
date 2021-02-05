<!--预开户-->
<template>
  <el-card shadow="never" class="no-border">
    <el-form label-position="top" class="jh-text meterInfo">
      <el-form-item label="充值金额">
        <el-input v-model="rechargeAmount" />
      </el-form-item>
      <el-form-item label="  ">
        <el-button type="danger" class="width100">充值</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'PreAccountOpening',
  data() {
    return {
      rechargeAmount: 500
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}
</style>
