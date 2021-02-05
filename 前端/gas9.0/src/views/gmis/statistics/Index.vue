<!-- 统计模块 -->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <tree-select
        v-model="curOrg"
        :clear-value-text="$t('common.clear')"
        :multiple="false"
        :searchable="true"
        :clearable="true"
        :options="recursiveFunction(orgData)"
        placeholder="选择组织"
        no-results-text="无查询结果"
        class="selectBox"
        @select="orgChange"
      />

      <el-row :gutter="15">
        <el-col :span="24" class="tabTop">
          <el-tabs v-model="activeName" @tab-click="tabsChange">
            <el-tab-pane label="业绩看板" name="1">
              <performance v-if="activeName === '1'" />
            </el-tab-pane>
            <!-- <el-tab-pane label="网表状态看板" name="2">
              <net-status v-if="activeName==='2'" />
            </el-tab-pane> -->
            <el-tab-pane label="售气收费看板" name="3">
              <sale-and-charge v-if="activeName === '3'" />
            </el-tab-pane>
            <el-tab-pane label="客户信息看板" name="4">
              <customer-info v-if="activeName === '4'" />
            </el-tab-pane>
          </el-tabs>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import TreeSelect from '@riophae/vue-treeselect' // 组织
import '@riophae/vue-treeselect/dist/vue-treeselect.css'

import Performance from './components/performance/Index.vue' // 业绩看板
import NetStatus from './components/netStatus/Index.vue' // 网表状态看板
import SaleAndCharge from './components/saleAndCharge/Index.vue' // 售气收费看板
import CustomerInfo from './components/customerInfo/Index.vue' // 客户信息看板
import StatisticApi from '@/api/statistics'
export default {
  name: 'Tj',
  components: {
    TreeSelect,
    Performance, //业绩看板
    NetStatus, // 网表状态看板
    SaleAndCharge, // 售气收费看板
    CustomerInfo, // 客户信息看板
  },
  data() {
    return {
      activeName: '1', // tabsActiveName
      orgData: [],
      curOrg: [],
    }
  },
  watch: {},
  created() {},
  mounted() {
    this.getOrgList()
  },
  methods: {
    // 获取系统所有的机构
    async getOrgList() {
      const {
        data: { data },
      } = await StatisticApi.getOrgList()
      if (data) {
        this.orgData = data
        this.curOrg = data[0].id
      } else {
        this.orgData = []
      }
    },
    tabsChange(tab, event) {
      this.$store.commit('statistics/changeTabName', tab.name)
    },

    orgChange() {
      this.$store.commit('statistics/changeOrg', this.curOrg)
    },

    loadListOptions({ callback }) {
      callback()
    },
  },
}
</script>

<style lang="scss" scoped>
  .tabTop {
    position: relative;
  }

  .selectBox {
    position: absolute;
    width: 300px;
    top: 15px;
    right: 1%;
    z-index: 2;
  }

  ::v-deep {
    .el-range-separator {
      width: 10%;
      padding: 0 !important;
    }

    .el-card {
      margin-top: 15px;
    }

    .searchBox {
      margin-bottom: 0 !important;
    }
  }
</style>
