<!--
 * @Description: 安检 - 新增 头部搜索
 * @Author: lingw
 * @Date: 2020-11-19 13:40:13
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-19 13:42:36
-->
<template>
  <search-box>
    <el-input v-model.trim="searchCondition.customerCode" clearable placeholder="客户编号" />
    <el-input v-model.trim="searchCondition.customerName" clearable placeholder="客户名称" />
    <el-input v-model.trim="searchCondition.telphone" clearable placeholder="联系电话" />
    <el-select v-model="searchCondition.customerTypeCode" clearable placeholder="客户类型">
      <el-option
        v-for="item in dict.USER_TYPE"
        :key="item.id"
        :label="item.name"
        :value="item.code"
      />
    </el-select>
    <el-select v-model="searchCondition.useGasTypeId" clearable placeholder="用气类型">
      <el-option
        v-for="item in useGasType"
        :key="item.id"
        :label="item.useGasTypeName"
        :value="item.id"
      />
    </el-select>
    <el-input v-model.trim="searchCondition.gasCode" clearable placeholder="气表编号" />
    <el-input v-model.trim="searchCondition.moreGasMeterAddress" clearable placeholder="安装地址" />
    <el-button type="primary" :loading="searchLoading" @click="handleSearch">查询</el-button>
  </search-box>
</template>

<script>
export default {
  name: 'Search',
  props: {
    useGasType: Array,
    searchCondition: Object,
    search: Function,
    searchLoading: Boolean,
  },
  methods: {
    handleSearch() {
      this.search()
    }
  },
}
</script>
