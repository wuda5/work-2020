<!--
 * @Description: 安检信息
 * @Author: lingw
 * @Date: 2020-11-24 16:23:22
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-24 16:32:23
-->
<!--安检信息-->
<template>
  <el-card
    class="no-border"
  >
    <div slot="header">
      <span class="card-title">安检信息</span>
    </div>
    <div>
      <el-card shadow="never" class="listItem">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="安检员">
            <p>{{ securityInfo.securityCheckUserName | filterEmpty }}</p>
          </el-form-item>
          <el-form-item label="最后安检时间">
            <p>{{ securityInfo.securityCheckTime | filterEmpty }}</p>
          </el-form-item>
          <el-form-item label="安检结果">
            <!--<p>正常</p>-->
            <p>{{ securityInfo.securityCheckResult | filterStatus }}</p>
          </el-form-item>
          <el-form-item label="备注">
            <p>{{ securityInfo.remark | filterEmpty }}</p>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </el-card>
</template>
<script>
export default {
  name: 'SecurityCheckInfo',
  filters: {
    filterEmpty(val) {
      return val ?? '--'
    },
    filterStatus(val) {
      return val === 1 ? '已处理' : '未处理'
    }
  },
  props: {
    securityInfo: {
      type: Object,
      default: () => {
        return {}
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  ::v-deep .el-card__body {
    padding: 10px;
  }
</style>

