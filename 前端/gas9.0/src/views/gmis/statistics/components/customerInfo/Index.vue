<!-- 客户信息看板-->
<template>
  <div class="tabBox">
    <!-- search -->
    <search-box>
      <div slot="right">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="yyyy-MM-dd"
        />
        <el-button type="primary" plain @click="sureTime">确认</el-button>
      </div>
    </search-box>

    <!-- 客户分类统计 -->
    <customer-classify
      :props-data="propsData"
    />

    <!-- 客户增量统计  -->
    <customer-increment
      :props-data="propsData"
    />

    <!-- 保险购买分类统计  经会议讨论 不要该模块了 -->
    <!--<customer-insurance
      v-if="false"
      :props-data="propsData"
    />-->

    <!-- 限购统计 -->
    <customer-limit
      :props-data="propsData"
    />

  </div>
</template>
<script>
import customerClassify from './components/customerClassify' // 客户分类统计
import customerIncrement from './components/customerIncrement' // 客户增量统计
import customerInsurance from './components/customerInsurance' // 保险购买分类统计
import customerLimit from './components/customerLimit' // 限购统计

export default {
  name: 'kb3',
  components: {
    customerClassify,
    customerIncrement,
    customerInsurance,
    customerLimit
  },
  data() {
    return {
      dateRange: [],
      timeRange: []
    }
  },
  computed: {
    propsData() {
      return {
        orgId: this.$store.state.statistics.org,
        timeRange:this.timeRange
      }
    }
  },

  methods: {
    // 点击确认时才请求数据
    sureTime() {
      this.timeRange = this.dateRange
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
