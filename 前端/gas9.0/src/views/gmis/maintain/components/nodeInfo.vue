<!--节点信息-->
<template>
  <div>
    <!-- card -->
    <el-card shadow="never" class="no-border" style="height: 690px">
      <div slot="header">
        <span class="card-title">节点信息</span>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="节点编号">
          <p>{{ myData[1] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="节点名称">
          <p>{{ myData[2] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="安装地址">
          <el-tooltip effect="dark" :content="myData[3] || emptyStr" placement="top">
            <p>{{ myData[3] || emptyStr }}</p>
          </el-tooltip>
        </el-form-item>
        <el-form-item label="证件号码类型">
          <el-tooltip effect="dark" :content="myData[4] || emptyStr" placement="top">
            <p>{{ myData[4] || emptyStr }}</p>
          </el-tooltip>
        </el-form-item>
        <el-form-item label="设备厂家">
          <p>{{ myData[5] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="设备型号">
          <p>{{ myData[6] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="管道口径">
          <p>{{ myData[7] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="温度上下限">
          <p>{{ myData[8] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="压力上下限">
          <p>{{ myData[9] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="流量上下限">
          <p>{{ myData[10] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="经度">
          <p>{{ myData[11] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="纬度">
          <p>{{ myData[12] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="报警电话">
          <p>{{ myData[13] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="负责人">
          <p>{{ myData[14] || emptyStr }}</p>
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

