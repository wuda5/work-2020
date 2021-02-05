<template>
  <search-box>
    <el-input v-model="searchCondition.customerCode" clearable placeholder="客户编号" />
    <el-input v-model="searchCondition.customerName" clearable placeholder="客户名称" />
    <el-input v-model="searchCondition.telphone" clearable placeholder="联系电话" />
    <el-select v-model="searchCondition.customerTypeCode" clearable placeholder="客户类型">
      <el-option label="居民" value="0" />
      <el-option label="非居民" value="1" />
    </el-select>
    <el-select v-model="searchCondition.useGasTypeId" clearable placeholder="用气类型">
      <el-option label="民用" value="0" />
      <el-option label="哈哈" value="1" />
      <el-option label="哈哈2" value="2" />
    </el-select>
    <el-input v-model="searchCondition.gasCode" clearable placeholder="气表编号" />
    <el-input v-model="searchCondition.moreGasMeterAddress" clearable placeholder="安装地址" />
    <el-button type="primary" :loading="searchLoading" @click="handleSearch">查询</el-button>
    <el-button type="success" :loading="readCarLoading" @click="readCar">读卡</el-button>
  </search-box>
</template>

<script>
import Api from '@/api/card/index'

export default {
  name: 'DailyWorkSearchBox',
  props: {
    searchCondition: Object,
    search: Function,
    searchLoading: Boolean,
    readCarLoading: Boolean,
  },
  data() {
    return {}
  },
  methods: {
    handleSearch() {
      this.$parent.setLoading('searchLoading',true)
      this.search()
    },
    async readCar() {
      this.$parent.setLoading('readCarLoading',true)
      Api.readCar(this.search)
    },
  },
}
</script>

<style>
</style>