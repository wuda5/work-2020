<!--
 * @Description: 燃气商店 - 搜索
 * @Author: lingw
 * @Date: 2020-10-22 11:43:03
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-22 11:44:13
-->

<template>
  <el-form :inline="true" :model="searchCondition" class="search">
    <el-form-item label="">
      <el-input v-model="searchCondition.userName" placeholder="客户名称" />
    </el-form-item>
    <el-form-item label="">
      <el-input v-model="searchCondition.phone" placeholder="联系电话" />
    </el-form-item>
    <el-form-item label="">
      <el-input v-model="searchCondition.meterNo" placeholder="气表编号" />
    </el-form-item>
    <el-form-item label="">
      <el-input v-model="searchCondition.addr" placeholder="安装地址" />
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
        userName: '',
        phone: '',
        meterNo: '',
        addr: ''
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
      width: 120px;
      margin-right: 0;
    }

    .el-button {
      margin-left: 0;
    }
  }
</style>

