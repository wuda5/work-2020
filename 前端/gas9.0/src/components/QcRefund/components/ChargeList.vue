<template>
  <div>
    <el-form :model="searchChargeForm" class="jh-text">
      <el-form-item label="客户缴费编号" style="width: 220px">
        <el-input
          v-model="searchChargeForm.customerChargeNo"
          placeholder="请输入编号"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item label="缴费单号" style="width: 220px">
        <el-input v-model="searchChargeForm.chargeNo" placeholder="请输入编号" clearable></el-input>
      </el-form-item>
      <el-form-item label="日期" style="width: 220px">
        <el-date-picker
          v-model="searchChargeForm.activeDate"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="yyyy-MM-dd"
        >
        </el-date-picker>
      </el-form-item>
      <el-button :loading="loading" class="btns" type="primary" @click="chargeSearch">
        查询
      </el-button>
    </el-form>
    <charge-table
      :charge-list="chargeList"
      @pagination="getChargeList"
      @row-click="handleRowClick"
    />
  </div>
</template>

<script>
import chargeTable from './chargeTable'

export default {
  name: 'QcRefundChargeList',
  components: {
    chargeTable,
  },
  props: {
    searchChargeForm: Object,
    chargeList: Object,
    getChargeList: Function,
    handleRowClick: Function,
    search: Function,
  },
  data() {
    return {
      loading: false,
    }
  },
  methods: {
    async chargeSearch() {
      this.loading = true
      await this.search()
    },
    closeLoading() {
      this.loading = false
    },
  },
}
</script>

<style lang="scss" scoped>
.btns {
  height: 28px;
  margin-top: 28px;
}
</style>