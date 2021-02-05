<!--
 * @Description: 安装列表
 * @Author: lingw
 * @Date: 2020-11-27 13:08:41
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 15:14:29
-->
<template>
 <div>
   <el-table
      :data="installList"
      tooltip-effect="dark"
      style="width: 100%"
      :border="false"
      :highlight-current-row="true"
      :height="242"
    >
      <el-table-column
        label="序号"
        type="index"
        width="45"
      />
      <el-table-column
        label="报装编号"
        show-overflow-tooltip
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.installNumber | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="街道(乡镇)名称"
        width="160"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.streetName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="小区(村)名称"
        show-overflow-tooltip
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.communityName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="安装地址"
        show-overflow-tooltip
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.addressDetail | filterEmpty }}
        </span>
      </el-table-column><el-table-column
        label="厂家名称"
        show-overflow-tooltip
        width="160"
      >
        <span slot-scope="{row}">
          {{ row.gasMeterFactoryName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="气表型号名称"
        width="120"
      >
        <span slot-scope="{row}">
          {{ row.gasMeterModelName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="气表编号"
        width="120"
      >
        <span slot-scope="{row}">
          {{ row.gasMeterCode | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="版号名称"
        width="140"
        show-overflow-tooltip
      >
        <span slot-scope="{row}">
          {{ row.gasMeterVersionName | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="调压箱编号"
        width="120"
      >
        <span slot-scope="{row}">
          {{ row.surgeTankNumber | filterEmpty }}
        </span>
      </el-table-column>
      <el-table-column
        label="用气类型名称"
        width="140"
      >
        <span slot-scope="{row}">
          {{ row.useGasTypeName | filterEmpty }}
        </span>
      </el-table-column>
    </el-table>
 </div>
</template>

<script>
export default {
  name: 'InstallList',
  filters: {
    filterEmpty(val) {
      return val || '--'
    }
  },
  props: {
    installList: {
      type: Array,
      default: () => {
        return []
      }
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
