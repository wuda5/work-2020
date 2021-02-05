<!--限购信息-->
<template>
  <div v-loading="loading" class="info-page BuyGasLimit-page">
    <info-frame>
      <template v-slot:title>
        <div class="subTitle">{{ $t('限购信息') }}</div>
      </template>

      <!-- 列表 -->
      <div class="list frameBody">
        <template v-if="list.length > 0">
          <el-card v-for="(item, index) in list" :key="index" shadow="never" class="listItem"
                   :body-style="{ padding: '0 10px' }">
            <div slot="header">
              <span>
                限制类型：{{ item.limitName || emptyStr }}
              </span>
            </div>
            <el-form ref="form" label-position="top" inline class="qc-form clearfix show-info-form">
              <el-form-item label="最大充值气量">
                <el-input :value="item.maxChargeGas"/>
              </el-form-item>
              <el-form-item label="最大充值金额">
                <el-input :value="item.maxChargeMoney"/>
              </el-form-item>
            </el-form>
          </el-card>
        </template>
        <el-alert v-else title="暂无限购信息" type="warning" show-icon :closable="false"></el-alert>
      </div>

      <!--分页-->
      <template v-slot:page>
        <pagination
          v-if="list.length > 0"
          :page-sizes="[5, 10, 15, 20]"
          :page.sync="queryParams.current"
          :limit.sync="queryParams.size"
          :total="+total"
          layout="total ,prev, next,jumper"
          @pagination="getList"
        />
      </template>
    </info-frame>
  </div>
</template>

<script>
import {isEqual} from 'lodash'
import listMixin from '@/mixins/list'
import tabsApi from '@/api/tabsInfo/index.js'

export default {
  name: 'BuyGasLimit',
  mixins: [listMixin],
  props: {
    // 传递属性对象，包括gasMeterCode，customerCode
    options: Object,
  },
  data() {
    return {
      ...this.initListData({
        queryParams: this.initQueryParams({
          model: {
            meterCode: null,
            customerCode: null,
          }
        })
      }),
      showData: [], // 最终显示的数据
      loading: true, // 页面加载状态
      emptyStr: '--',
      showMore: false
    }
  },
  watch: {
    options: {
      handler(value, oldValue) {
        if (!isEqual(value, oldValue)) {
          this.initData()
        }
      }
    },
  },
  created() {
    this.initData()
  },
  methods: {
    async initData() {
      const {gasMeterCode, customerCode} = this.options
      if (gasMeterCode || customerCode) {
        this.queryParams.model.meterCode = gasMeterCode
        this.queryParams.model.customerCode = customerCode
        await this.getList()
      } else {
        this.total = 0
        this.queryParams.current = 1
        this.list = []
      }
      this.$nextTick(() => {
        this.loading = false
      })
    },

    getList() {
      return new Promise((resolve) => {
        tabsApi.buyGasLimit(this.queryParams).then((response) => {
          const {isSuccess, data} = response.data
          if (isSuccess) {
            this.list = data.records
            this.total = data.total
          }
          resolve(isSuccess)
        })
          .catch(() => (resolve(false)))
      })
    }
  },
}
</script>

<style lang="scss" scoped>
.el-form-item {
  width: 50%;
}

.listItem {
  ::v-deep .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
  }
}
</style>

