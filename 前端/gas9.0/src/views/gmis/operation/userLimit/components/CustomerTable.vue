<template>
  <div class=" customer-table-page">
    <!-- 列表搜索块 -->
    <search-box class="search-box">
      <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
        <el-form-item v-if="!isLimit">
          <el-checkbox v-model="searchForm.blackListed">黑名单</el-checkbox>
        </el-form-item>
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input v-model="searchForm.customerChargeNo" clearable :placeholder="$t('operation.userLimit.customerChargeNo')">
          </el-input>
        </el-form-item>
        <!-- 客户编号 -->
        <!-- <el-form-item label="" prop="customerCode">
          <el-input v-model="searchForm.customerCode" clearable :placeholder="$t('operation.userLimit.customerCode')">
          </el-input>
        </el-form-item> -->
        <!-- 表身号 -->
        <el-form-item label="" prop="gasMeterNumber">
          <el-input v-model="searchForm.gasMeterNumber" clearable :placeholder="$t('operation.userLimit.gasMeterNumber')">
          </el-input>
        </el-form-item>
        <!-- 气表编号 -->
        <!-- <el-form-item label="" prop="gasCode">
          <el-input v-model="searchForm.gasCode" clearable :placeholder="$t('operation.userLimit.gasCode')">
          </el-input>
        </el-form-item> -->
        <el-form-item label="" prop="customerName">
          <el-input v-model="searchForm.customerName" clearable :placeholder="$t('operation.userLimit.customerName')">
          </el-input>
        </el-form-item>
        <!-- 联系电话 -->
        <el-form-item label="" prop="telphone">
          <el-input v-model="searchForm.telphone" clearable :placeholder="$t('operation.userLimit.telphone')">
          </el-input>
        </el-form-item>
        <el-form-item label="" prop="streetId">
          <el-select v-model="searchForm.streetId" clearable filterable :placeholder="$t('operation.userLimit.streetName')">
            <el-option v-for="(value, key) in streetMap" :key="key" :value="key" :label="value"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="" prop="communityId">
          <el-select v-model="searchForm.communityId" clearable filterable :placeholder="$t('operation.userLimit.communityName')">
            <el-option v-for="(item, index) in communityList" :key="index" :value="item.id" :label="item.communityName"></el-option>
          </el-select>
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item label="" prop="moreGasMeterAddress">
          <el-input v-model="searchForm.moreGasMeterAddress" clearable :placeholder="$t('operation.userLimit.moreGasMeterAddress')">
          </el-input>
        </el-form-item>
        <el-form-item label="" prop="">
          <el-button type="primary" name="userLimit-search" :disabled="!isOperation" icon="el-icon-search" class="search-btn userLimit-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
          <el-button type="warning" name="userLimit-search" :disabled="!isOperation" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
        </el-form-item>
      </el-form>
    </search-box>
    <el-divider></el-divider>
    <search-box class="operation-box">
      <div slot="left" class="">
        <div class="table-title">{{ isLimit ? $t('operation.userLimit.customerLimitTitle') : $t('operation.userLimit.customerTitle') }}</div>
      </div>
      <div v-if="isOperation" slot="right" class="operation-btn-box">
        <template v-if="isLimit">
          <el-button v-has-permission="['userLimit:add']" class="show-customer-dialog-btn" name="show-customer-dialog-btn" type="success" @click.native="showCustomerDialog()">{{ $t('operation.userLimit.add') }}</el-button>
          <el-button v-has-permission="['userLimit:remove']" class="batch-remove-limit-btn" name="batch-remove-limit-btn" type="danger" @click.native="handleBatchRemoveLimitCustomer()">{{ $t('operation.userLimit.batchRemoveLimitBtn') }}</el-button>
          <el-button v-has-permission="['userLimit:export']" class="export-limit-customer-btn" name="export-limit-customer-btn" type="primary" @click.native="handleExportLimitCustomer()">{{ $t('operation.userLimit.export') }}</el-button>
        </template>
        <template v-else>
          <el-button v-has-permission="['userLimit:add']" class="batch-add-limit-btn" name="batch-add-limit-btn" type="success" @click.native="handleBatchAddLimitCustomer()">{{ $t('operation.userLimit.batchAddLimitBtn') }}</el-button>
        </template>
      </div>
    </search-box>
    <!--数据-->
    <el-table
      :ref="listRef"
      v-loading="listLoading"
      stripe
      border
      :data="list"
      tooltip-effect="dark"
      @row-click="handleRowClick"
      @selection-change="handleSelectionChange"
    >
      <el-table-column
        type="selection"
      >
      </el-table-column>
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <!-- 缴费编号 -->
      <el-table-column
        prop="customerChargeNo"
        :label="$t('operation.userLimit.customerChargeNo')"
        show-overflow-tooltip
      >
      </el-table-column>
      <!-- 客户编号 -->
      <!-- <el-table-column
        prop="customerCode"
        :label="$t('operation.userLimit.customerCode')"
        show-overflow-tooltip
      >
      </el-table-column> -->
      <!-- 客户姓名 -->
      <el-table-column
        prop="customerName"
        :label="$t('operation.userLimit.customerName')"
        width="80"
      >
      </el-table-column>
      <!-- 联系电话 -->
      <el-table-column 
        :label="$t('operation.userLimit.telphone')" 
        prop="telphone"
      >
      </el-table-column>
      <!-- 用气类型 -->
      <el-table-column 
        :label="$t('operation.userLimit.useGasTypeName')" 
        prop="useGasTypeName"
      >
      </el-table-column>
      <!-- 气表表身号 -->
      <el-table-column 
        :label="$t('operation.userLimit.gasMeterNumber')" 
        prop="gasMeterNumber"
        show-overflow-tooltip
      >
      </el-table-column>
      <!-- 气表编号 -->
      <!-- <el-table-column 
        :label="$t('operation.userLimit.gasCode')" 
        prop="gasCode"
        show-overflow-tooltip
      >
      </el-table-column> -->
      <!-- 气表厂家 -->
      <el-table-column 
        :label="$t('operation.userLimit.gasMeterFactoryName')" 
        prop="gasMeterFactoryName"
      >
      </el-table-column>
      <!-- 黑名单 -->
      <el-table-column 
        v-if="!isLimit"
        label="是否黑名单" 
      >
        <template slot-scope="{row}">
          {{ row.blackListed === 1 ? '是' : '否' }}
        </template>
      </el-table-column>
      <!-- 气表版号 -->
      <el-table-column 
        :label="$t('operation.userLimit.gasMeterVersionName')" 
        prop="gasMeterVersionName"
      >
      </el-table-column>
      <!-- 安装地址 -->
      <el-table-column
        prop="moreGasMeterAddress"
        :label="$t('operation.userLimit.moreGasMeterAddress')"
        show-overflow-tooltip
      >
      </el-table-column>
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="100"
      >
        <template #default="{ row }">
          <template v-if="isLimit">
            <el-button v-has-permission="['userLimit:remove']" type="primary" name="row-remove-limit" @click.native="handleRemoveLimitCustomer(row)">{{ $t('operation.userLimit.removeLimitBtn') }}</el-button>
          </template>
          <template v-else>
            <el-button v-has-permission="['userLimit:add']" type="primary" name="row-add-limit" @click.native="handleAddLimitCustomer(row)">{{ $t('operation.userLimit.addLimitBtn') }}</el-button>
          </template>
        </template>
      </el-table-column>
      <template v-if="!isOperation" #empty>
        <b class="text-danger">{{ $t('operation.userLimit.selectBuyGasLimitHint') }}</b>
      </template>
    </el-table>
    <!--分页-->
    <pagination
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      :total="+total"
      @pagination="handleGetList"
    />

    <!-- 客户列表表格弹窗 -->
    <el-dialog
      width="80%"
      :title="$t('operation.userLimit.add')"
      :visible="formDialogVisible"
      @close="formDialogVisible = false"
    >
      <customer-table v-if="isOperation && isLimit && showCustomerTable" key="customerTable" class="customer-dialog-table" :buy-gas-limit-data="buyGasLimitData" :is-limit="!isLimit" @add-success="handleAddLimitCustomerSuccess"></customer-table>
    </el-dialog>
  </div>
</template>

<script>
import { isEmpty } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs, param } from '@/utils/index'
import { arrayCombine, arrayColumn } from '@/utils/array'
import { formStatusField } from '@/enums/form'
import { deleteStatusField, dataStatusMap, dataStatusField } from '@/enums/common'
import { getCustomerList, getStreetList, getCommunityList, addCustomerLimit, removeCustomerLimit } from '@/api/operation/userLimit'
import { customerSearchFormFieldsMap } from '@/lang/zh/modules/operation/userLimit'

export default {
  name: 'CustomerTable',
  components: {

  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {
    // 限购配置信息
    buyGasLimitData: {
      type: [Object],
      required: false,
      default: () => (null)
    },
    // 是否是限制客户列表
    isLimit: {
      type: Boolean,
      default: true
    }
  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        ...arrayCombine(Object.keys(customerSearchFormFieldsMap), new Array(Object.keys(customerSearchFormFieldsMap).length).fill(null)),
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID,
        blackListed: false
      },
      communityList: [], // 小区(村、xx路)列表
      streetList: [], // 街道(乡镇)列表
      showCustomerTable: false, // 是否显示客户列表组件
    }
  },
  computed: {
    // 街道(乡镇)列表映射
    streetMap() {
      const result = {}
      this.streetList.forEach((item) => {
        const { id, streetName, areaName, cityName, provinceName } = item
        result[id] = `${streetName}(${provinceName}/${cityName}/${areaName})`
      })
      return result
    },
    // 判断是否可以操作
    isOperation() {
      return !isEmpty(this.buyGasLimitData)
    }
  },
  watch: {
    // 监听限购配置信息数据变化
    buyGasLimitData: {
      handler(data) {
        // 如果是限购客户列表，则获取限购客户列表
        if (this.isLimit) {
          this.showCustomerTable = false
          this.initWatchData()
        }
      },
      immediate: false
    },
    // 监听是否是限购客户列表，不是则获取客户列表
    isLimit: {
      handler(data) {
        if (!data) {
          this.initWatchData()
        }
      },
      immediate: true
    }
  },
  created() {
    this.initData()
    this.initWatchData()
  },
  mounted() {

  },
  destroyed() {
    // console.log('组件销毁')
    this.communityList = []
    this.streetList = []
  },
  methods: {
    async initData() {
      this.getCommunityListData()
      this.getStreetListData()
    },
    async initWatchData() {
      await this.getList()
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        const isLimit = this.isLimit
        this.listLoading = true
        params = this.generateQueryParams(params)
        const generateParams = {
          pageNo: params.current,
          pageSize: params.size,
          ...params.model
        }
        generateParams.blackListed = this.searchForm.blackListed === true ? 1 : null
        if (isLimit) {
          generateParams.limitId = this.buyGasLimitData.id

        } else {
          generateParams.useGasTypeId = JSON.parse(this.buyGasLimitData.useGasTypeId)
        }
        getCustomerList(generateParams, this.isLimit).then((result) => {
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

    // 获取小区(村、xx路)街道(乡镇)列表
    async getStreetListData(params = {}) {
      return new Promise((resolve) => {
        getStreetList(this.initQueryParams({ size: 10000, dataStatus: dataStatusField.VALID })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.streetList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取小区(村、xx路)列表
    async getCommunityListData(params = {}) {
      return new Promise((resolve) => {
        getCommunityList(this.initQueryParams({ size: 10000, dataStatus: dataStatusField.VALID })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.communityList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    // 打开客户列表弹出框
    showCustomerDialog() {
      this.showCustomerTable = true
      this.formDialogVisible = true
    },

    // 保存增加限购客户数据
    async saveAddCustomerLimitData(data) {
      this.listLoading = true
      return new Promise((resolve) => {
        addCustomerLimit(data).then((result) => {
          this.listLoading = false
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.$message.success(this.$t('operation.userLimit.addLimitSuccess'))
            // 刷新客户列表
            this.handleSearch()
            // 新增限购客户向父组件传递事件
            this.$emit('add-success', data)
            resolve(data)
          } else {
            resolve(false)
          }
        }).catch(() => {
          this.listLoading = false
          resolve(false)
        })
      })
    },

    // 保存移出限购客户数据
    async saveRemoveCustomerLimitData(data) {
      this.listLoading = true
      return new Promise((resolve) => {
        // console.log(data)
        removeCustomerLimit({ 'ids[]': data }).then((result) => {
          this.listLoading = false
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.$message.success(this.$t('operation.userLimit.removeLimitSuccess'))
            // 刷新限购客户列表
            this.handleSearch()
            // 销毁客户列表组件，使其数据能够重新加载
            this.showCustomerTable = false
            resolve(data)
          } else {
            resolve(false)
          }
        }).catch(() => {
          this.listLoading = false
          resolve(false)
        })
      })
    },

    // 批量移出限购客户
    async handleBatchRemoveLimitCustomer() {
      const multipleSelection = this.multipleSelection
      if (multipleSelection.length < 1) {
        this.$message.error(this.$t('operation.userLimit.batchRemoveLimitHint'))
        return
      }
      await this.saveRemoveCustomerLimitData(multipleSelection.map((item) => item.id))
    },

    // 单个移出限购客户
    async handleRemoveLimitCustomer(row) {
      console.log(row)
      await this.saveRemoveCustomerLimitData([row.id])
    },

    // 导出限购客户
    handleExportLimitCustomer() {
      this.$message.info('导出功能后面统一开发，先延后。')
    },

    // 批量添加客户
    async handleBatchAddLimitCustomer() {
      const multipleSelection = this.multipleSelection
      if (multipleSelection.length < 1) {
        this.$message.error(this.$t('operation.userLimit.batchAddLimitHint'))
        return
      }
      await this.saveAddCustomerLimitData(multipleSelection.map((item) => ({ customerCode: item.customerCode, gasMeterCode: item.gasCode, limitId: this.buyGasLimitData.id })))
    },

    // 单个添加客户
    async handleAddLimitCustomer(row) {
      await this.saveAddCustomerLimitData([{ customerCode: row.customerCode, gasMeterCode: row.gasCode, limitId: this.buyGasLimitData.id }])
    },

    // 子组件 添加限购客户成功后的回调
    handleAddLimitCustomerSuccess(data) {
      // 关闭选择客户类型弹框
      this.handleSearch()
      this.formDialogVisible = false
    }
  }
}
</script>

<style scoped lang="scss">
  .customer-table-page {
    ::v-deep {
      .el-divider {
        margin: 8px 0 12px;
      }
    }
  }
  ::v-deep {
    .customer-dialog-table {
      padding: 10px;
    }
  }
</style>
