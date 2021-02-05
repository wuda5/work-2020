<!-- 临时综合 头部搜索 -->
<template>
  <search-box>
    <el-input v-model.trim="searchCondition.customerChargeNo" clearable placeholder="缴费编号" />
    <el-input v-model.trim="searchCondition.gasMeterNumber" clearable placeholder="表身号" />
    <el-input v-model.trim="searchCondition.customerName" clearable placeholder="客户名称" />
    <el-input v-model.trim="searchCondition.telphone" clearable placeholder="联系电话" />
    <el-input v-model.trim="searchCondition.moreGasMeterAddress" clearable placeholder="安装地址" />
    <el-button type="primary" :loading="searchLoading" @click="handleSearch">查询</el-button>
    <!-- v-has-permission="['dailyWork:readCard']" -->
    <el-button type="success" :loading="readCarLoading" @click="readCar"> 读卡 </el-button>
  </search-box>
</template>

<script>
import CardApi from '@/api/card/index'

export default {
  name: 'Search',
  props: {
    useGasType: Array,
    searchCondition: Object,
    search: Function,
    searchDefault: Function,
    searchLoading: Boolean,
    readCarLoading: Boolean,
    resetSearchCondition: Function,
  },
  data() {
    return {}
  },
  methods: {
    handleSearch() {
      this.searchCondition.pageNo = 1
      this.$parent.setLoading('searchLoading', true)
      this.search()
    },
    async readCar() {
      // debugger
      // console.log(this.searchDefault)
      this.resetSearchCondition && this.resetSearchCondition()
      this.$parent.setLoading('readCarLoading', true)
      const res = await CardApi.readCar(this.searchDefault, () => {
        this.$parent.setLoading('readCarLoading', false)
      })
    },
  },
}
</script>

<style lang="scss" scoped>
::v-deep .el-input {
  width: 200px !important;
}
</style>
