
<!-- 物联网表重新注册 -->
<template>
  <div class="RegisterAgain-container">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input
            v-model="searchForm.customerChargeNo"
            clearable
            :placeholder="$t('meterInfo.customerChargeNo')"
          >
          </el-input>
        </el-form-item>
        <!-- 气表编号 -->
        <!-- <el-form-item label="" prop="gasCode">
          <el-input v-model="searchForm.gasCode" clearable :placeholder="$t('meterInfo.gasCode')">
          </el-input>
        </el-form-item> -->
        <!-- 气表表号 -->
        <el-form-item label="" prop="gasMeterNumber">
          <el-input
            v-model="searchForm.gasMeterNumber"
            clearable
            :placeholder="$t('meterInfo.gasMeterNumber')"
          >
          </el-input>
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item label="" prop="gasMeterAddress">
          <el-input
            v-model="searchForm.gasMeterAddress"
            clearable
            :placeholder="$t('meterInfo.gasMeterAddress')"
          >
          </el-input>
        </el-form-item>
        <el-form-item label="" prop="" style="marginleft: 10px">
          <el-button
            type="primary"
            name="meterInfo-search"
            icon="el-icon-search"
            class="search-btn meterInfo-search"
            @click.native="handleSearch"
          >{{ $t('search') }}
          </el-button>
          <el-button
            type="warning"
            name="meterInfo-search"
            icon="el-icon-refresh-left"
            class="search-reset-btn"
            @click.native="resetSearch(searchFormRef)"
          >{{ $t('reset') }}
          </el-button>
        </el-form-item>
      </el-form>
    </search-box>
      <!-- 档案列表 -->
      <el-card shadow="never" class="workHeight">
        <template v-slot:header>
          <search-box>
            <div slot="left"><span class="card-title">已拆除物联网表具档案列表</span></div>
            <!-- 操作按钮 -->
            <div slot="right">
              <!-- 批量重新注册 -->
              <el-button
                type="primary"
                :disabled="btnLoading || multipleSelection.length === 0"
                @click="handleBatchRegisterAgain"
              >
                {{ $t('批量重新注册') }}
              </el-button>
            </div>
          </search-box>
        </template>

        <div class="clearfix"></div>
        <el-table
          :ref="listRef"
          v-loading="listLoading"
          :data="list"
          tooltip-effect="dark"
          stripe
          border
          :highlight-current-row="false"
          @selection-change="handleSelectionChange"
        >
          <!-- 多选框 -->
          <el-table-column
            align="center"
            type="selection"
            width="40px"
            :reserve-selection="false"
          />
          <!-- 序号 -->
          <el-table-column type="index" :label="$t('table.index')"></el-table-column>
          <!-- 缴费编号 -->
          <el-table-column
            prop="customerChargeNo"
            :label="$t('meterInfo.customerChargeNo')"
            show-overflow-tooltip
            width="120"
          >
          </el-table-column>
          <!-- 气表编号 -->
          <!-- <el-table-column prop="gasCode" :label="$t('meterInfo.gasCode')" width="180">
          </el-table-column> -->
          <!-- 表身号 -->
          <el-table-column
            prop="gasMeterNumber"
            :label="$t('meterInfo.gasMeterNumber')"
            show-overflow-tooltip
            width="150"
          >
          </el-table-column>
          <!-- 报装编号	 -->
          <el-table-column prop="installNumber" :label="$t('meterInfo.installNumber')">
          </el-table-column>
          <!-- 气表类型 -->
          <el-table-column
            prop="orderSourceName"
            :label="$t('meterInfo.gasMeterTypeName')"
            show-overflow-tooltip
          >
            <template #default="{ row }">
              {{ gasMeterTypeMap[row.orderSourceName] }}
            </template>
          </el-table-column>
          <!-- 气表厂家 -->
          <el-table-column
            prop="gasMeterFactoryName"
            :label="$t('meterInfo.gasMeterFactoryName')"
            show-overflow-tooltip
            width="150"
          >
          </el-table-column>
          <!-- 气表版号 -->
          <el-table-column
            prop="gasMeterVersionName"
            :label="$t('meterInfo.gasMeterVersionName')"
            show-overflow-tooltip
            width="90"
          >
          </el-table-column>
          <!-- 气表型号 -->
          <el-table-column
            prop="gasMeterModelName"
            :label="$t('meterInfo.gasMeterModelName')"
            show-overflow-tooltip
            width="90"
          >
          </el-table-column>
          <!-- 安装地址 -->
          <el-table-column
            prop="moreGasMeterAddress"
            :label="$t('meterInfo.gasMeterAddress')"
            show-overflow-tooltip
            width="150"
          >
          </el-table-column>
          <!-- 气表状态 -->
          <!-- <el-table-column prop="dataStatus" :label="$t('meterInfo.dataStatus')" width="100" fixed="right">
            <template #default="{ row }">
              {{ meterStatusMap[+row.dataStatus] }}
            </template>
          </el-table-column> -->
          <!-- 操作 -->
          <el-table-column fixed="right" :label="$t('table.operation')" width="100">
            <template #default="{ row }">
              <!-- 重新注册 -->
              <el-button
                type="primary"
                name="row-edit"
                :disabled="btnLoading"
                @click="handleRegisterAgain(row)"
              >{{ $t('重新注册') }}
              </el-button>
            </template>
          </el-table-column>
        </el-table>
        <!--分页-->
        <pagination
          :page.sync="queryParams.current"
          :limit.sync="queryParams.size"
          :total="+total"
          @pagination="getList()"
        />
      </el-card>
  </div>
</template>

<script>
import { merge } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import meterMixin from '@/mixins/meter'
import { meterStatusField, orderSourceNameField } from '@/enums/meterInfo'
import { getListData, batchRegisterAgain } from '@/api/meterInfo/index'

export default {
  name: 'RegisterAgain',
  components: {

  },
  filters: {},
  mixins: [commonMixin, listMixin, meterMixin],
  props: {

  },
  data() {
    return {
      searchForm: {
        gasCode: null, // 气表编号
        gasMeterNumber: null, // 气表表号
        customerChargeNo: null, // 缴费编号
        gasMeterAddress: null, // 安装地址
        dataStatus: [meterStatusField.CC], // 气表状态
        orderSourceName: [orderSourceNameField.REMOTE_READMETER, orderSourceNameField.CENTER_RECHARGE, orderSourceNameField.REMOTE_RECHARGE],
      },
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
    // 初始化数据
    async initData() {
      await this.getList()

    },
    // 获取列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        params = merge({pageNo: this.queryParams.current, pageSize: this.queryParams.size}, this.searchForm, params)
        getListData(params).then((result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            const {total, records} = data
            this.total = total
            this.list = records
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => (this.listLoading = false))
      })
    },

    handleSaveData(data = []) {
      this.btnLoading = true
      return new Promise((resolve) => {
        batchRegisterAgain(data)
        .then((response) => {
          const { isSuccess } = response.data
          if (isSuccess) {
            this.$message.success('物联网重新注册操作成功')
            this.resetSearch(this.searchFormRef)
            this.$emit('success')
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
        .finally(() => (this.btnLoading = false))
      })
    },

    // 批量重新注册
    async handleBatchRegisterAgain() {
      await this.handleSaveData(this.multipleSelection)
    },

    // 单个重新注册
    async handleRegisterAgain(row) {
      await this.handleSaveData([row])
    },
  }
}
</script>

<style scoped lang="scss">

</style>
