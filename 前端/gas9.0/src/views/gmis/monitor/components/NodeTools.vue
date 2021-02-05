<!--
 * @Descripttion: 节点信息
 * @Author: lingw
 * @Date: 2020-10-19 17:00:07
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 13:24:21
-->
<template>
  <div>
    <el-card shadow="never" class="no-border" style="margin-top: 10px">
      <div slot="header">
        <span class="card-title">节点信息</span>
        <el-button class="view-more" type="text" @click="viewMore">查看更多 ></el-button>
      </div>
      <el-form v-model="nodeInfo" label-position="top" class="jh-text">
        <el-form-item label="温度">
          <p>{{ nodeInfo.lineStatus | emptyStr }} (℃)</p>
        </el-form-item>
        <el-form-item label="压力">
          <p>{{ nodeInfo.lastDate | emptyStr }} (Pa)</p>
        </el-form-item>
        <el-form-item label="异常">
          <p>{{ nodeInfo.lastDate | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="阀门">
          <p>{{ nodeInfo.lastDate | emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>
    <el-dialog
      title="节点详情"
      :visible.sync="showMore"
      width="30%"
      :modal="false"
    >
      <el-form v-model="nodeInfo" label-position="top" class="jh-text">
        <el-form-item label="节点状态">
          <p>{{ nodeInfo.status | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="工况流量">
          <p>{{ nodeInfo.meterNo | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="标准流量">
          <p>{{ nodeInfo.meterType | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="瞬时流量">
          <p>{{ nodeInfo.meterCompany | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="日用气量">
          <p>{{ nodeInfo.alarm | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="月用气量">
          <p>{{ nodeInfo.alarm | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="年用气量">
          <p>{{ nodeInfo.alarm | emptyStr }} (M2/h)</p>
        </el-form-item>
        <el-form-item label="温度">
          <p>{{ nodeInfo.lineStatus | emptyStr }} (℃)</p>
        </el-form-item>
        <el-form-item label="压力">
          <p>{{ nodeInfo.lastDate | emptyStr }} (Pa)</p>
        </el-form-item>
        <el-form-item label="异常">
          <p>{{ nodeInfo.lastDate | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="阀门">
          <p>{{ nodeInfo.lastDate | emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
export default {
  props: {
    nodeInfo: {
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
</style>
