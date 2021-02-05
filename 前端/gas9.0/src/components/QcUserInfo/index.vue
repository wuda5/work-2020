<!--客户信息-->
<template>
  <div>
    <!-- card -->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">客户信息</span>
        <el-button class="view-more" type="text" @click="viewMore">查看更多 ></el-button>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="客户编号">
          <p>{{ myData.userNum || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="客户名称">
          <p>{{ myData.userName || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="客户电话">
          <p>{{ myData.phone || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="客户类型">
          <p>{{ myData.userTpye || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="用气类型">
          <p>{{ myData.gasType || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="开户时间">
          <p>{{ myData.time || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="账户余额">
          <p>{{ myData.restMoney || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="地址">
          <p>{{ myData.addr || emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'UserInfo',
  props: {
    myData: {
      type: Object,
      default: function () {
        return {}
      },
    },
  },
  data() {
    return {
      emptyStr: '------',
      showMore: false,
    }
  },
  methods: {
    viewMore() {
      // todo: 跳转地址
    },
  },
}
</script>

<style lang="scss" scoped>
</style>

