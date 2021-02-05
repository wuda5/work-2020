<!-- 全局搜索栏 | 表头布局 -->
<template>
  <div class="searchBox">
    <div>
      <slot></slot>
    </div>
    <div class="left">
      <slot name="left"></slot>
    </div>
    <div class="right">
      <slot name="right"></slot>
    </div>
    <div class="clearfix"></div>
  </div>
</template>
<script>
export default {
  name: 'SearchBox',
}
</script>

<style lang="scss" scoped>
  .searchBox {
    margin-bottom: 10px;
    z-index: 100;
    clear: both;

    // 设置常用的样式，主要调整间距
    ::v-deep .el-input,
    .el-select,
    .el-button,
    .el-date-picker {
      margin: 0 4px;
      width: 130px;
    }
    .el-button {
      width: auto;
    }
    // 解决 el-select 下套用el-input
    ::v-deep .el-select .el-input {
      margin: 0 !important;
    }

    //
    .left {
      float: left;
      text-align: left;
    }
    .right {
      float: right;
      text-align: right;
    }

    ::v-deep .vue-treeselect {
      width: 200px;
      display: inline-block;
      vertical-align: bottom;
    }
  }
</style>

