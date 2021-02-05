<!-- 开户组件,同一页面包括整个数据 -->
<template>
  <div v-loading="loading" class="OpenAccount-page">
    <!-- 客户信息区域 -->
    <section class="s1">
      <el-card shadow="never no-border">
        <div slot="header">
          <span class="card-title">{{ $t('customerInfo.detailsTitle') }}</span>
        </div>
        <!--搜索区域-->
        <search-box class="search-box operation-box">
          <el-form :ref="customerTable.searchFormRef" :model="customerTable.searchForm" :inline="true" class="qc-search-form">
            <!-- 客户编号 -->
            <!-- <el-form-item label="" prop="customerCode">
              <el-input v-model="customerTable.searchForm.customerCode" name="customerCode" clearable :placeholder="$t('customerInfo.customerCode')" />
            </el-form-item> -->
            <!-- 客户名称 -->
            <el-form-item label="" prop="customerName" style="width: 120px">
              <el-input v-model="customerTable.searchForm.customerName" name="customerName" clearable :placeholder="$t('customerInfo.customerName')" />
            </el-form-item>
            <!-- 联系电话 -->
            <el-form-item label="" prop="telphone" style="width: 140px">
              <el-input v-model="customerTable.searchForm.telphone" name="telphone" clearable :placeholder="$t('customerInfo.telphone')" />
            </el-form-item>
            <!-- 客户类型 -->
            <el-form-item label="" prop="customerTypeCode">
              <el-select v-model="customerTable.searchForm.customerTypeCode" name="customerTypeCode" clearable :placeholder="$t('customerInfo.customerTypeCode')">
                <el-option v-for="(value, key) in userTypeMap" :key="key" :label="value" :value="key" />
              </el-select>
            </el-form-item>
            <el-form-item label="" prop="" style="marginLeft: 10px">
              <el-button type="primary" name="userInfo-search" icon="el-icon-search" :disabled="isEmptyCustomerSearch || customerTable.listLoading" class="search-btn userInfo-search" @click="handleCustomerSearch()">{{ $t('search') }}</el-button>
              <el-button type="warning" name="userInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click="handleResetCustomerSearch(customerTable.searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </search-box>
        
        <!--客户列表-->
        <div class="table-box">
          <el-table
            :ref="customerTable.listRef"
            v-loading="customerTable.listLoading"
            :data="customerTable.list"
            tooltip-effect="dark"
            stripe
            border
            :highlight-current-row="true"
            @row-click="handleCustomerRowClick"
          >
            <!-- 客户编号 -->
            <!-- <el-table-column
              prop="customerCode"
              :label="$t('customerInfo.customerCode')"
              width="160"
              show-overflow-tooltip
            /> -->
            <!-- 客户姓名 -->
            <el-table-column
              prop="customerName"
              :label="$t('customerInfo.customerName')"
              show-overflow-tooltip
            />
            <!-- 证件类型 -->
            <el-table-column
              prop="idTypeName"
              :label="$t('customerInfo.idTypeName')"
            />
            <!-- 证件号码 -->
            <el-table-column
              prop="idNumber"
              :label="$t('customerInfo.idNumber')"
              width="180"
              show-overflow-tooltip
            />
            <!-- 联系电话 -->
            <el-table-column
              prop="telphone"
              :label="$t('customerInfo.telphone')"
              width="100"
              show-overflow-tooltip
            />
            <!-- 客户类型 -->
            <el-table-column
              prop="customerTypeName"
              :label="$t('customerInfo.customerTypeName')"
            />
            <!-- 安装地址 -->
            <el-table-column
              prop="contactAddress"
              :label="$t('customerInfo.contactAddress')"
              width="230"
              show-overflow-tooltip
            />
            <!-- 空数据展示 -->
            <template #empty>
              <b class="text-danger">{{ $t('table.searchEmptyText') }}</b>
            </template>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="customerTable.queryParams.current"
            :limit.sync="customerTable.queryParams.size"
            :total="+customerTable.total"
            @pagination="handleGetCustomerList"
          />
        </div>
        <!-- 客户档案表单区域 -->
        <customer-info-form ref="customerInfoFormRef" :only-view="false" :form-data="customerTable.currentRow"></customer-info-form>
      </el-card>
    </section>
    <!-- 表具信息区域 -->
    <section class="s1 meter-section">
      <el-card shadow="never">
        <div slot="header">
          <span class="card-title">{{ $t('meterInfo.detailsTitle') }}</span>
        </div>
        <!--搜索区域-->
        <search-box class="search-box">
          <el-form :ref="meterTable.searchFormRef" :model="meterTable.searchForm" :inline="true" class="qc-search-form">
            <!-- 表身号 -->
            <el-form-item label="" prop="gasMeterNumber">
              <el-input v-model="meterTable.searchForm.gasMeterNumber" name="gasMeterNumber" clearable :placeholder="$t('meterInfo.gasMeterNumber')" style="width: 180px" />
            </el-form-item>
            <!-- 报装编号 -->
            <el-form-item label="" prop="installNumber">
              <el-input v-model="meterTable.searchForm.installNumber" name="installNumber" clearable :placeholder="$t('meterInfo.installNumber')" />
            </el-form-item>
            <!-- 气表厂家 -->
            <el-form-item label="" prop="gasMeterFactoryId">
              <el-select v-model="meterTable.searchForm.gasMeterFactoryId" name="gasMeterFactoryId" clearable :placeholder="$t('meterInfo.gasMeterFactoryId')" @change="handleChangeFactory">
                <el-option v-for="(item, index) in factoryList" :key="index" :value="item.id" :label="item.gasMeterFactoryName"></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表版号 -->
            <el-form-item label="" prop="gasMeterVersionId">
              <el-select v-model="meterTable.searchForm.gasMeterVersionId" name="gasMeterVersionId" clearable :placeholder="$t('meterInfo.gasMeterVersionId')" @change="handleChangeVersion">
                <el-option v-for="(item, index) in versionList" :key="index" :value="item.id" :label="item.gasMeterVersionName"></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表型号 -->
            <el-form-item label="" prop="gasMeterModelId">
              <el-select v-model="meterTable.searchForm.gasMeterModelId" name="gasMeterModelId" clearable :placeholder="$t('meterInfo.gasMeterModelId')">
                <el-option v-for="(item, index) in modelList" :key="index" :value="item.id" :label="item.modelName"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="" prop="" style="marginLeft: 10px">
              <el-button type="primary" name="meterInfo-search" icon="el-icon-search" :disabled="isEmptyMeterSearch || meterTable.listLoading" class="search-btn meterInfo-search" @click="handleMeterSearch()">{{ $t('search') }}</el-button>
              <el-button type="warning" name="meterInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click="handleResetMeterSearch(meterTable.searchFormRef, false)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </search-box>

        <!--表具列表-->
        <div class="table-box">
          <el-table
            :ref="meterTable.listRef"
            v-loading="meterTable.listLoading"
            :data="meterTable.list"
            tooltip-effect="dark"
            stripe
            border
            :highlight-current-row="true"
            @row-click="handleMeterRowClick"
          >
            <!-- 气表编号 -->
            <!-- <el-table-column
              prop="gasCode"
              :label="$t('meterInfo.gasCode')"
              show-overflow-tooltip
              width="160"
            >
            </el-table-column> -->
            <!-- 表身号 -->
            <el-table-column
              prop="gasMeterNumber"
              :label="$t('meterInfo.gasMeterNumber')"
              show-overflow-tooltip
            >
            </el-table-column>
            <!-- 报装编号	 -->
            <el-table-column
              prop="installNumber"
              :label="$t('meterInfo.installNumber')"
            >
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
            <!-- 空数据展示 -->
            <template #empty>
              <b class="text-danger">{{ $t('table.searchEmptyText') }}</b>
            </template>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="meterTable.queryParams.pageNo"
            :limit.sync="meterTable.queryParams.pageSize"
            :total="+meterTable.total"
            @pagination="handleGetMeterList"
          />
        </div>
        <!-- 表具档案表单区域 -->
        <meter-info-form ref="meterInfoFormRef" :form-data="meterTable.currentRow" :customer-data="customerTable.currentRow" ::only-view="true" @success="handleOpenAccountSuccess"></meter-info-form>
      </el-card>
    </section>
  </div>
</template>

<script>
import { isNull, isUndefined, merge, isObject } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import formMixin from '@/mixins/form'
import { dataStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { customerStatusField } from '@/enums/customerInfo'
import { meterStatusField } from '@/enums/meterInfo'
import customerInfoApi, { saveInfoAndOpenAccount } from '@/api/userInfo/index'
import { getFactoryListData, getVersionListData, getModelListData } from '@/api/meterInfo/index'
import { getListData } from '@/api/meterInfo/index'
import CustomerInfoForm from '@/views/gmis/userInfo/components/editUserInfo.vue'
import MeterInfoForm from './MeterInfoForm.vue'

export default {
  name: 'QcOpenAccount',
  components: {
    CustomerInfoForm,
    MeterInfoForm
  },
  filters: {},
  mixins: [commonMixin, listMixin, formMixin],
  props: {

  },
  data() {
    return {
      // 客户信息相关的
      customerTable: this.initListData({
        listRef: 'customerTableRef',
        searchFormRef: 'customerSearchFormRef',
        searchForm: {
          customerCode: null,
          customerName: null,
          telphone: null,
          customerTypeCode: null,
        },
        queryParams: this.initQueryParams({
          model: { 
            customerStatus: customerStatusField.VALID,
          }, 
          size: 5, 
          sort: 'createTime'
        })
      }),
      // 表具信息相关的
      meterTable: this.initListData({
        listRef: 'meterTableRef',
        searchForm: {
          gasMeterNumber: null,
          installNumber: null,
          gasMeterFactoryId: null,
          gasMeterVersionId: null,
          gasMeterModelId: null,
        },
        searchFormRef: 'meterSearchFormRef',
        queryParams: {
          pageNo: 1,
          pageSize: 5,
          dataStatus: [meterStatusField.YJD, meterStatusField.DAZ, meterStatusField.DKH]
        },
      }, false),
      factoryList: [], // 气表厂家列表
      versionList: [], // 气表版号列表
      modelList: [], // 气表型号列表
    }
  },
  computed: {
    // 客户类型枚举
    userTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.USER_TYPE)
    },
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },

    // 是否没有输入客户搜索条件
    isEmptyCustomerSearch() {
      let flag = true
      for (const value of Object.values(this.customerTable.searchForm)) {
        if (!isNull(value) && !isUndefined(value)) {
          flag = false
          break
        }
      }
      return flag
    },

    // 是否没有输入表具搜索条件
    isEmptyMeterSearch() {
      let flag = true
      for (const value of Object.values(this.meterTable.searchForm)) {
        if (!isNull(value) && !isUndefined(value)) {
          flag = false
          break
        }
      }
      return flag
    },
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
      this.loading = true
      await this.getFactoryList()
      this.loading = false
      //  await this.getList()

    },
    // 获取客户列表
    async getCustomerList(params = {}) {
      return new Promise((resolve) => {
        this.customerTable.listLoading = true
        customerInfoApi.page(this.generateQueryParams({}, this.customerTable)).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.customerTable.total = total
            this.customerTable.list = records
            // 如果只有一条数据，默认赋值给客户表单显示
            if (records.length === 1) {
              this.$nextTick(() => {
                this.$refs[this.customerTable.listRef]?.setCurrentRow(records[0])
                this.customerTable.currentRow = records[0]
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.customerTable.listLoading = false
        }).catch(() => {
          resolve(false)
          this.customerTable.listLoading = false
        })
      })
    },
    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },

    // 搜索客户信息
    handleCustomerSearch() {
      // 重新获取列表数据 清空选中，清空单击表格行
      this.customerTable.currentRow = null
      this.customerTable.isRowClick = false
      this.getCustomerList()
      this.$nextTick(function() {
      })
    },

    // 重置客户搜索条件
    handleResetCustomerSearch() {
      const listParams = this.customerTable
      const ref = listParams.searchFormRef
      // console.log(ref, this.$refs[ref])
      this.$refs[ref]?.resetFields?.()
      listParams.queryParams.current = 1
      listParams.total = 0
      listParams.list = []
      // 重置客户表单
      this.$refs.customerInfoFormRef?.handleReset()
      // this.handleCustomerSearch()
    },

    // 客户信息分页回调事件
    handleGetCustomerList() {
      this.getCustomerList()
    },

    // 单击客户列表行
    handleCustomerRowClick(row) {
      this.customerTable.currentRow = row
      this.customerTable.isRowClick = true
    },

    // 获取表具列表
    async getMeterList(params = {}) {
      return new Promise((resolve) => {
        this.meterTable.listLoading = true
        params = merge(this.meterTable.queryParams, this.meterTable.searchForm, params)
        getListData(params).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.meterTable.total = total
            this.meterTable.list = records
            // 如果只有一条数据，默认赋值给表具表单显示
            if (records.length === 1) {
              this.$nextTick(() => {
                this.$refs[this.meterTable.listRef].setCurrentRow(records[0])
                this.meterTable.currentRow = records[0]
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.meterTable.listLoading = false
        }).catch(() => {
          resolve(false)
          this.meterTable.listLoading = false
        })
      })
    },

    // 搜索表具信息
    handleMeterSearch() {
      // 重新获取列表数据 清空选中，清空单击表格行
      this.meterTable.currentRow = null
      this.meterTable.isRowClick = false
      this.getMeterList()
      this.$nextTick(function() {
      })
    },

    // 重置客户搜索条件
    handleResetMeterSearch() {
      const listParams = this.meterTable
      const ref = listParams.searchFormRef
      // console.log(ref, this.$refs[ref])
      this.$refs[ref]?.resetFields?.()
      listParams.queryParams.current = 1
      listParams.total = 0
      listParams.list = []
      // 重置表单
      this.$refs.meterInfoFormRef?.handleReset()
      // this.handleMeterSearch()
    },

    // 单击表具列表行
    handleMeterRowClick(row) {
      this.meterTable.currentRow = row
      this.meterTable.isRowClick = true
    },

    // 表具信息分页回调事件
    handleGetMeterList() {
      this.getMeterList()
    },

    // 获取气表厂家
    async getFactoryList() {
      if (this.factoryList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getFactoryListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.factoryList = data
         }
         resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取气表版号
    async getVersionList(params = {}) {
      return new Promise((resolve) => {
        getVersionListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, versionState: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.versionList = data
         }
         resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },
    
    // 获取气表型号
    async getModelList(params = {}) {
      return new Promise((resolve) => {
        getModelListData({ dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           this.modelList = data
         }
         resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 气表厂家发生变化, 清空气表版号信息
    async handleChangeFactory(value) {
      this.meterTable.searchForm.gasMeterVersionId = null
      this.meterTable.searchForm.gasMeterModelId = null
      this.versionList = []
      this.modelList = []
      if (value) {
        await this.getVersionList({ companyId: value })
      }
    },

    // 气表版号发生变化, 清空气表型号信息
    async handleChangeVersion(value) {
      this.meterTable.searchForm.gasMeterModelId = null
      this.modelList = []
       if (value) {
         await this.getModelList({ gasMeterVersionId: value })
       }
    },

    // 开户成功回调
    handleOpenAccountSuccess(data) {
      // 刷新客户和表具列表
      this.handleCustomerSearch()
      this.handleMeterSearch()
      // 成功给父组件回调事件
      this.$emit('success', data)
    },

    // 验证开户信息是否全部正确, 返回气表信息和客户信息
    async validateOpenAccount() {
      // 验证客户信息
      const customerValidateResult = await this.$refs.customerInfoFormRef?.validateForm()
      // console.log('customerValidateResult', customerValidateResult)
      if (!customerValidateResult) {
        return Promise.resolve(false)
      }
      // 验证表具信息
      const meterValidateResult = await this.$refs.meterInfoFormRef?.validateForm()
      // console.log('meterValidateResult', meterValidateResult)
      if (!meterValidateResult) {
        return Promise.resolve(false)
      }
      
      return Promise.resolve( {
        customer: customerValidateResult,
        gasMeter: meterValidateResult
      })
    },
    // 验证信息并开户保存
    async handleSaveOpenAccountInfo() {
      const result = await this.validateOpenAccount()
      // console.log(result)
      return new Promise((resolve) => {
        if (result) {
          result.chargeNo = result.gasMeter?.customerChargeNo
          saveInfoAndOpenAccount(result).then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              this.$message.success('开户信息保存成功')
            }
            resolve(isSuccess ? isObject(data) ? data : result : false)
          })
        } else {
          resolve(false)
        }
      })
    },
  }
}
</script>

<style scoped lang="scss">
  .OpenAccount-page {
    ::v-deep {
      >section {
        margin-bottom: 15px;
      }
      .el-card {
        .el-card__body {
          padding: 15px;
        }
      }
      .qc-form {
        padding: 0;
        .el-form-item {
          margin-bottom: 10px !important;
        }
      }
      .userinfo-form {
        .el-form-item {
          // width: calc(100% / 6) !important;
          // &.idCard-form-item {
          // width: calc(100% / 6 * 2) !important;
          // }
          // &.contactAddress-form-item {
          // width: calc(100% / 6 * 2) !important;
          // }
        }
      }
      .customerCode-form-item {
        display: none;
      }
      .meterinfo-form {
        
      }
      .gasCode-form-item {
        display: none;
      }
    }
  }
</style>
