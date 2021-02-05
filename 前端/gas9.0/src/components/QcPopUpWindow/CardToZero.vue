<!-- 卡清零 -->
<template>
  <div>
    <p class="tips redFont">卡清零之后不可撤销，确认清零？</p>
    <div class="btnBox">
      <el-button type="primary">取消</el-button>
      <el-button type="primary">确认</el-button>
    </div>
  </div>
</template>
<script>
export default {
  name: 'CardToZero',
  data() {
    return {}
  },
  computed: {},
  methods: {}
}
</script>
<style lang="scss" scoped>
  @import "~@/styles/variables";
  .tips {
    margin: 20px 15px 30px;
  }
  .btnBox {
    margin-bottom: 20px;
  }
</style>
