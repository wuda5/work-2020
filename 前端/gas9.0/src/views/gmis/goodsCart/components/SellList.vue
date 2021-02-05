<!--
 * @Description: 销售列表
 * @Author: lingw
 * @Date: 2020-10-23 15:21:54
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 15:26:28
-->
<template>
  <div>
    <el-table
      ref="multipleTable"
      :data="sellList"
      tooltip-effect="dark"
      style="width: 100%; border: 1px solid #eee"
      :border="false"
      highlight-current-row
      :height="230"
    >
      <el-table-column
        type="selection"
        width="45"
      />
      <el-table-column
        prop="userID"
        label="类型"
        width="80"
      />
      <el-table-column
        prop="name"
        label="数量"
        width="80"
      />
      <el-table-column
        prop="tel"
        label="单价"
        width="100"
      />
      <el-table-column
        prop="userType"
        label="品牌"
        width="80"
      />
      <el-table-column
        prop="gasType"
        label="型号"
      />
    </el-table>
    <Pagination
      layout="prev, pager, next"
      :page="2"
      :limit="2"
      :total="4"
    />
    <div class="charge-footer">
      <span>合计数量：<em class="charge-footer-total">2</em></span>
      <span>合计金额：<em class="charge-footer-mount">120</em></span>
      <el-button type="danger" @click="handleChargeVisible">收费</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SellList',
  props: {
    sellList: {
      type: Array,
      default() {
        return []
      }
    }
  },
  methods: {
    handleChargeVisible() {
      this.$emit('charge-click')
    }
  }
}
</script>

<style lang='scss' scoped>
  .charge-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 14px;
    background: #F7F7F7;
    border-radius: 6px;
    width: 100%;
    height: 60px;
    line-height: 60px;
    padding: 0 12px;
    margin-top: 6px;
    .charge-footer-mount, .charge-footer-total {
      font-weight: bold;
      font-size: 16px;
    }
    .charge-footer-mount {
      color: #ED57B1;
    }
    .charge-footer-total {
      color: #2B2B2B;
    }
  }
</style>
