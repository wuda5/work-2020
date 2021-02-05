<!--运行维护 顶部搜索-->
<template>
  <el-form :inline="true" :model="searchCondition" class="search">
    <el-form-item label="">
      <el-input v-model="searchCondition[1]" placeholder="节点编号" />
    </el-form-item>
    <el-form-item label="">
      <el-input v-model="searchCondition[2]" placeholder="节点名称" />
    </el-form-item>
    <el-form-item label="">
      <el-input v-model="searchCondition[3]" placeholder="安装地址" />
    </el-form-item>
    <el-form-item label="">
      <el-select v-model="searchCondition[4]" placeholder="设备厂家" clearable>
        <el-option label="居民" value="0" />
        <el-option label="非居民" value="1" />
      </el-select>
    </el-form-item>
    <el-form-item label="">
      <el-select v-model="searchCondition[5]" placeholder="设备型号" clearable>
        <el-option label="民用" value="0" />
        <el-option label="哈哈" value="1" />
        <el-option label="哈哈2" value="2" />
      </el-select>
    </el-form-item>
    <el-button type="primary" @click="search">查询</el-button>
  </el-form>
</template>
<script>
export default {
  name: 'QcTopSearch',
  data() {
    return {
      searchCondition: {
        1: '',
        2: '',
        3: '',
        4: '',
        5: ''
      }
    }
  },
  methods: {
    search() {
      this.$emit('search', this.searchCondition)
    }
  }
}
</script>

<style lang="scss" scoped>
  @import "~@/styles/variables.scss";
  /* search */
  .search {
    margin-bottom: -15px;

    .el-form-item {
      width: 180px;
      margin-right: 0;
    }

    .el-button {
      margin-left: 0;
    }
  }
</style>

