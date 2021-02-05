<!--全局右侧信息框 框架-->
<template>
  <div class="infoFrame">
    <slot name="title"></slot>
    <slot name="default"></slot>
    <slot name="page"></slot>
  </div>
</template>
<script>
export default {
  name: 'InfoFrame'
}
</script>
<style lang="scss" scoped>
.subTitle {
  display: block;
  overflow: hidden;
  border-bottom: 1px solid #eee;
  padding-bottom: 36px;
  margin-bottom: 15px;
}
::v-deep .el-pagination__jump{
  margin-left: 5px;
}
::v-deep .pagination-container{
  border-top: 1px solid #eee;
  padding: 0;
}
::v-deep .el-pagination{
  padding: 0;
  text-align: center;
}
</style>

