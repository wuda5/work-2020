<template>
  <div>
    <el-form :model="searchChargeForm" class="jh-text">
      <el-form-item label="姓名" style="width: 220px">
        <el-input
          v-model="searchChargeForm.customerName"
          placeholder="请输入姓名"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item label="证件号" style="width: 220px">
        <el-input v-model="searchChargeForm.identityCardNo" placeholder="请输入证件号" clearable></el-input>
      </el-form-item>
      <el-form-item label="电话号码" style="width: 220px">
        <el-input v-model="searchChargeForm.phone" placeholder="请输入电话号码" clearable></el-input>
      </el-form-item>
      <!-- <el-form-item label="日期" style="width: 220px">
        <el-date-picker
          v-model="searchChargeForm.activeDate"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="yyyy-MM-dd"
        >
        </el-date-picker>
      </el-form-item> -->
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