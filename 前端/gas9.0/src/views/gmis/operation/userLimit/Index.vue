<!-- 限购客户配置 -->
<template>
  <div class="qc-main gas-price-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.userLimit.title') }}</span>
      </div>
      <el-row :gutter="30">
        <el-col :span="5">
          <search-box class="search-box operation-box">
            <div slot="left" class="fl">
              <div class="table-title">{{ $t('operation.userLimit.buyGasLimitTitle') }}</div>
            </div>
            <div slot="right" class="fr operation-btn-box">
            </div>
          </search-box>
          <!--数据-->
          <el-table
            :ref="listRef"
            v-loading="listLoading"
            stripe
            border
            highlight-current-row
            :data="list"
            style="min-height: calc(100vh - 300px)"
            tooltip-effect="dark"
            @row-click="handleRowClick"
          >
            <el-table-column
              type="index"
              :label="$t('table.index')"
            >
            </el-table-column>
            <el-table-column
              prop="limitName"
              :label="$t('operation.userLimit.limitName')"
            >
            </el-table-column>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            layout="total, prev, pager, next"
            @pagination="handleGetList"
          />
        </el-col>
        <el-col :span="19">
          <!-- 客户信息页面 -->
          <customer-page v-if="currentRow" :buy-gas-limit-data="currentRow"></customer-page>
          <no-select v-else :tips="$t('operation.userLimit.selectBuyGasLimitHint')" :top="25" />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { deleteStatusField } from '@/enums/common'
import { getBuyGasLimitData } from '@/api/operation/userLimit'
import CustomerPage from './Customer'
import NoSelect from '@/components/QcNoSelect'

export default {
  name: 'GasPrice',
  components: {
    CustomerPage,
    NoSelect,
  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField
    // this.dictionaryCodeMap = dictionaryCodeMap
    return {
      searchForm: {
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {
      await this.getList()
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getBuyGasLimitData(this.generateQueryParams({ size: 20, ...params})).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            resolve(records)
          } else {
            resolve(false)
          }
          this.listLoading = false
        }).catch(() => {
          resolve(false)
          this.listLoading = false
        })
      })
    },
  }
}
</script>

<style scoped lang="scss">
  .gas-price-page {
    ::v-deep .operation-box {
      margin-bottom: 10px;
    }
  }
</style>
