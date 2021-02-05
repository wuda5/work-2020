<!--
 * @Descripttion: 表具信息
 * @Author: lingw
 * @Date: 2020-10-16 10:19:07
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 13:32:22
-->
<template>
  <div>
    <el-card shadow="never" class="no-border" style="margin-top: 10px">
      <div slot="header">
        <span class="card-title">表具信息</span>
        <el-button class="view-more" type="text" @click="viewMore">查看更多 ></el-button>
      </div>
      <el-form v-model="meterInfo" label-position="top" class="jh-text">
        <el-form-item label="气表编号">
          <p>{{ meterInfo.meterNo | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="告警">
          <p>{{ meterInfo.meterType | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="阀门状态">
          <p>{{ meterInfo.meterCompany | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="在线状态">
          <p>{{ meterInfo.lineStatus | emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>
    <el-dialog
      title="表具详情"
      :visible.sync="showMore"
      width="30%"
      :modal="false"
    >
      <el-form v-model="meterInfo" label-position="top" class="jh-text">
        <el-form-item label="气表编号">
          <p>{{ meterInfo.meterNo | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="告警">
          <p>{{ meterInfo.meterType | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="阀门状态">
          <p>{{ meterInfo.meterCompany | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="外接报警器">
          <p>{{ meterInfo.alarm | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="在线状态">
          <p>{{ meterInfo.lineStatus | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="安检信息">
          <p>{{ meterInfo.security | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="抄表情况">
          <p>{{ meterInfo.copy | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="年用气情况">
          <p>{{ meterInfo.yeargas | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="最近抄表时间">
          <p>{{ meterInfo.lastDate | emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
export default {
  props: {
    meterInfo: {
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  data() {
    return {
      showMore: false
    }
  },
  methods: {
    viewMore() {
      // todo: 跳转地址
      this.showMore = true
    }
  }
}
</script>

<style lang="scss" scoped>
  .card-title {
    font-size: 16px;
    font-weight: 600;
  }
</style>
