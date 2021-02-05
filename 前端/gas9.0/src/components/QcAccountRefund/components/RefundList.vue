<template>
  <div>
    <el-form ref="form" :model="searchRefundForm" class="jh-text">
      <el-form-item label="姓名" style="width: 220px">
        <el-input
          v-model="searchRefundForm.customerName"
          placeholder="请输入姓名"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item label="证件号" style="width: 220px">
        <el-input
          v-model="searchRefundForm.identityCardNo"
          placeholder="请输入证件号"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item label="电话号码" style="width: 220px">
        <el-input
          v-model="searchRefundForm.phone"
          placeholder="请输入电话号码"
          clearable
        ></el-input>
      </el-form-item>
      <el-form-item label="日期" style="width: 220px">
        <el-date-picker
          v-model="searchRefundForm.activeDate"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="yyyy-MM-dd"
        >
        </el-date-picker>
      </el-form-item>
      <el-button :loading="loading" class="btns" type="primary" @click="chargeSearch"
        >查询</el-button
      >
      <div class="btnGroud">
        <el-button type="primary" plain @click="() => filter('')">全部</el-button>
        <el-button type="primary" plain @click="() => filter('WAITE_AUDIT')">待审核</el-button>
        <el-button type="primary" plain @click="() => filter('NONREFUND')">不予退费</el-button>
        <el-button type="primary" plain @click="() => filter('REFUNDABLE')">可退费</el-button>
        <el-button type="primary" plain @click="() => filter('REFUND_ERR')">退费失败</el-button>
        <el-button type="primary" plain @click="() => filter('REFUNDED')">退费完成</el-button>
      </div>
    </el-form>
    <refund-table
      :refund-list="refundList"
      :search="search"
      @pagination="getRefundList"
      @row-click="handleRowClick1"
    />
  </div>
</template>

<script>
import refundTable from './refundTable'

export default {
  name: 'QcRefundRefundList',
  components: {
    refundTable,
  },
  props: {
    searchRefundForm: Object,
    refundList: Object,
    getRefundList: Function,
    handleRowClick1: Function,
    search: Function,
    filter: Function,
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
.btnGroud {
  width: 100%;
  margin: 10px 0 5px 0;
  button {
    margin-right: 10px;
  }
}
</style>