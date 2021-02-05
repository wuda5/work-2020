<!-- 退费 -->
<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="申请列表" name="first">申请列表</el-tab-pane>
    <el-tab-pane label="审批列表" name="second">审批列表</el-tab-pane>
  </el-tabs>
  </div>
</template>

<script>

export default {
    data() {
      return {
        activeName: 'second'
      };
    },
    methods: {
      handleClick(tab, event) {
        console.log(tab, event);
      }
    }
  };
</script>

<style lang="scss" scoped>
  .el-form-item {
    width: 20%;
  }
</style>
