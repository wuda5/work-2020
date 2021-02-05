<!--
 * @Description: 工单流程
 * @Author: lingw
 * @Date: 2020-10-22 13:53:56
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-22 14:34:37
-->

<template>
  <div>
    <!-- card -->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">工单流程</span>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="报装类型">
          <p>{{ workInfo.type | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="紧急程度">
          <p>{{ workInfo.emergency | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="工单状态">
          <p>{{ workInfo.status | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="联系电话">
          <p>{{ workInfo.phone | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="送货人">
          <p>{{ workInfo.sendMan | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="送货时间">
          <p>{{ workInfo.sendTime | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="安装人">
          <p>{{ workInfo.installMan | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="安装时间">
          <p>{{ workInfo.installTime | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="工单备注">
          <p>{{ workInfo.remark | emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'UserInfo',
  props: {
    workInfo: {
      type: Object,
      default: function () {
        return {}
      }
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

