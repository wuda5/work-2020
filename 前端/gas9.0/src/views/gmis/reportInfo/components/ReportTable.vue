<!--
 * @Description: 每日上报表格
 * @Author: lingw
 * @Date: 2021-02-02 08:48:54
 * @LastEditors: lingw
 * @LastEditTime: 2021-02-02 13:59:18
-->
<template>
  <div>
    <el-table
      :data="reportList.records"
      style="width: 100%"
    >
      <el-table-column
        prop="customerChargeNo"
        label="缴费编号"
        width="120"
      >
      </el-table-column>
      <el-table-column
        prop="customerName"
        label="客户姓名"
        show-overflow-tooltip
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.customerName | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="gasMeterNumber"
        label="表身号"
        width="180"
        show-overflow-tooltip
      >
        <template slot-scope="{ row }">
          {{ row.gasMeterNumber | emptyFilter }}
        </template>
      </el-table-column>
        <el-table-column
        prop="customerPhone"
        label="联系电话"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.customerPhone | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="installAddress"
        label="安装地址"
        show-overflow-tooltip
        min-width="240"
      >
        <template slot-scope="{ row }">
          {{ row.installAddress | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="versionName"
        label="气表版号"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.versionName | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="totalUseGas"
        label="累计用气量"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.totalUseGas | emptyFilter }}
        </template>
      </el-table-column>
        <el-table-column
        prop="gasMeterBalance"
        label="气表余额"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.gasMeterBalance | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="meterType === 1"
        prop="dayUse1"
        label="近1天上报"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.dayUse1 | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="meterType === 1"
        prop="dayUse2"
        label="近2天上报"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.dayUse2 | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="meterType === 1"
        prop="dayUse3"
        label="近3天上报"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.dayUse3 | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="meterType === 1"
        prop="dayUse4"
        label="近4天上报"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.dayUse4 | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        v-if="meterType === 1"
        prop="dayUse5"
        label="近5天上报"
        width="120"
      >
        <template slot-scope="{ row }">
          {{ row.dayUse5 | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="valveState"
        label="阀状态"
        width="80"
      >
        <template slot-scope="{ row }">
          <span v-if="row.valveState == null">--</span>
          <el-tag v-else :type="row.valveState === 1 ? 'success' : 'danger'">
            {{ row.valveState === 1 ? '开启' : '关闭' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="freezingTime"
        label="抄表日期"
        width="180"
      >
        <template slot-scope="{ row }">
          {{ row.freezingTime | emptyFilter }}
        </template>
      </el-table-column>
      <el-table-column
        prop="uploadTime"
        label="上报日期"
        width="180"
      >
        <template slot-scope="{ row }">
          {{ row.uploadTime | emptyFilter }}
        </template>
      </el-table-column>
    </el-table>
    <!--分页-->
    <pagination
      :page="+reportList.current"
      :limit="+reportList.size"
      :total="+reportList.total"
      @pagination="handleGetList"
    />
  </div>
</template>
<script>
export default {
  filters: {
    emptyFilter(val) {
      return val ?? '--'
    }
  },
  props: {
    reportList: {
      type: Object,
      default: () => ({
        records: [],
        current: 1,
        size: 10,
        total: 0,
      })
    },
    meterType: {
      type: Number,
      default: 0
    }
  },
  methods: {
    handleGetList(params) {
      this.$emit('pagination', params)
    }
  }
}
</script>