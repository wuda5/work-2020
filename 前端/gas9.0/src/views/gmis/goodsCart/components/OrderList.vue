<!--
 * @Description: 订单列表
 * @Author: lingw
 * @Date: 2020-10-23 14:59:58
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 15:19:09
-->
<template>
  <div>
    <!-- 快捷操作 -->
    <div class="butGroup fr" style="margin: -10px 0 10px 0 ">
      <el-button type="primary" plain>待送货</el-button>
      <el-button type="primary" plain>待安装</el-button>
      <el-button type="primary" plain>待结单</el-button>
      <el-button type="primary" plain>全部</el-button>
    </div>
    <div class="clearfix"></div>
    <el-table
      ref="multipleTable"
      :data="orderList"
      tooltip-effect="dark"
      style="width: 100%; border: 1px solid #eee"
      :border="false"
      :highlight-current-row="true"
      :height="200"
    >
      <el-table-column
        type="selection"
        width="45"
      />
      <el-table-column
        prop="userID"
        label="订单编号"
        width="80"
      />
      <el-table-column
        prop="name"
        label="姓名"
        width="80"
      />
      <el-table-column
        prop="tel"
        label="电话"
        width="100"
      />
      <el-table-column
        prop="userType"
        label="地址"
        width="80"
      />
      <el-table-column
        prop="gasType"
        label="数量"
        width="80"
      />
      <el-table-column
        prop="meterNo"
        label="金额"
        width="140"
      />
      <el-table-column
        prop="pressBoxNo"
        label="时间"
      />

      <el-table-column
        prop="company"
        label="状态"
      />
    </el-table>
    <Pagination
      layout="prev, pager, next"
      :page="2"
      :limit="2"
      :total="4"
    />
  </div>
</template>

<script>
export default {
  name: 'OrderList',
  props: {
    orderList: {
      type: Array,
      default() {
        return []
      }
    }
  },
  methods: {
  }
}
</script>

<style lang='scss' scoped>

</style>
