<!-- 表具信息 -->
<template>
  <div>
    <el-card shadow="never" class="no-border" style="margin-top: 10px">
      <div slot="header">
        <span class="card-title">表具信息</span>
        <el-button class="view-more" type="text" @click="viewMore">查看更多 ></el-button>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="气表编号">
          <p>{{ myData.meterNo || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="气表类型">
          <p>{{ myData.meterType || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="气表厂家">
          <p>{{ myData.meterCompany || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="气表型号">
          <p>{{ myData.model || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="气表版号">
          <p>{{ myData.version || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="进气方向">
          <p>{{ myData.gasDerection || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="调压箱">
          <p>{{ myData.regulatorBox || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="开户时间">
          <p>{{ myData.accountOpeningTime || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计用气量">
          <p>{{ myData.gasUseTotal || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="周期累计用气量">
          <p>{{ myData.circleUse || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="保险到期时间">
          <p>{{ myData.expiryDateInsurance || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="安装地址">
          <p>{{ myData.addr || emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  props: {
    myData: {
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  data() {
    return {
      emptyStr: '------',
      showMore: false
    }
  },
  methods: {
    viewMore() {
      // todo: 跳转地址
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
