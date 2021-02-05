<!-- 开户可选择的表具档案列表 -->
<template>
  <div v-loading="loading" class="meterList-container">
      <el-card shadow="never">
        <div slot="header">
          <span class="card-title">{{ $t('meterInfo.detailsTitle') }}</span>
        </div>
        <!--搜索区域-->
        <search-box class="search-box">
          <el-form :ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
            <!-- 表身号 -->
            <el-form-item label="" prop="gasMeterNumber">
              <el-input v-model="queryParams.model.gasMeterNumber" name="gasMeterNumber" clearable :placeholder="$t('meterInfo.gasMeterNumber')" style="width: 180px" />
            </el-form-item>
            <!-- 报装编号 -->
            <el-form-item label="" prop="installNumber">
              <el-input v-model="queryParams.model.installNumber" name="installNumber" clearable :placeholder="$t('meterInfo.installNumber')" />
            </el-form-item>
            <!-- 气表厂家 -->
            <el-form-item label="" prop="gasMeterFactoryId">
              <el-select v-model="queryParams.model.gasMeterFactoryId" name="gasMeterFactoryId" clearable filterable :placeholder="$t('meterInfo.gasMeterFactoryId')" @change="handleChangeFactory">
                <el-option v-for="(item, index) in factoryList" :key="index" :value="item.id" :label="item.gasMeterFactoryName"></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表版号 -->
            <el-form-item label="" prop="gasMeterVersionId">
              <el-select v-model="queryParams.model.gasMeterVersionId" name="gasMeterVersionId" clearable filterable :placeholder="$t('meterInfo.gasMeterVersionId')" @change="handleChangeVersion">
                <el-option v-for="(item, index) in versionList" :key="index" :value="item.id" :label="item.gasMeterVersionName"></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表型号 -->
            <el-form-item label="" prop="gasMeterModelId">
              <el-select v-model="queryParams.model.gasMeterModelId" name="gasMeterModelId" clearable filterable :placeholder="$t('meterInfo.gasMeterModelId')">
                <el-option v-for="(item, index) in modelList" :key="index" :value="item.id" :label="item.modelName"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="" prop="" style="marginLeft: 10px">
              <el-button type="primary" name="meterInfo-search" icon="el-icon-search" :disabled="listLoading" class="search-btn meterInfo-search" @click="getList()">{{ $t('search') }}</el-button>
              <el-button type="warning" name="meterInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click="handleResetSearch(searchFormRef, false)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </search-box>

        <!--表具列表-->
        <div class="table-box">
          <el-table
            :ref="listRef"
            v-loading="listLoading"
            :data="list"
            tooltip-effect="dark"
            stripe
            border
            :highlight-current-row="false"
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
            <!-- 操作 -->
            <el-table-column width="80" fixed="right" :label="$t('table.operation')">
              <template #default="{ row }">
                <el-button type="primary" name="row-edit" @click.stop="handleSelectRowInfo(row)">{{ $t('table.use') }}</el-button>
              </template>
            </el-table-column>
            <!-- 空数据展示 -->
            <template #empty>
              <b class="text-danger">{{ $t('table.searchEmptyText') }}</b>
            </template>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            @pagination="getList()"
          />
        </div>
      </el-card>
  </div>
</template>

<script>
import { isNull, isUndefined, merge, isObject } from 'lodash'
import commonMixins from '@/mixins/common'
import listMixin from '@/mixins/list'
import { dataStatusField } from '@/enums/common'
import { meterStatusField } from '@/enums/meterInfo'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { getListData } from '@/api/meterInfo/index'
import { getFactoryListData, getVersionListData, getModelListData } from '@/api/meterInfo/index'

export default {
  name: 'MeterList',
  components: {

  },
  filters: {},
  mixins: [commonMixins, listMixin],
  props: {

  },
  data() {
    return {
      ...this.initListData({
        queryParams: this.initQueryParams({
          model: {
            gasMeterNumber: null,
            installNumber: null,
            gasMeterFactoryId: null,
            gasMeterVersionId: null,
            gasMeterModelId: null,
            // dataStatus: [meterStatusField.YJD, meterStatusField.DAZ, meterStatusField.DKH, meterStatusField.CC, meterStatusField.HB],
            dataStatus: [meterStatusField.YJD, meterStatusField.DAZ, meterStatusField.DKH],
          }
        }),
      }),
      factoryList: [], // 气表厂家列表
      versionList: [], // 气表版号列表
      modelList: [], // 气表型号列表
    }
  },
  computed: {
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  methods: {
    async initData() {
      this.loading = true
      await this.getFactoryList()
      this.loading = false
    },

    // 获取表具列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        const generateParams = merge(this.queryParams.model, { pageNo: this.queryParams.current, pageSize: this.queryParams.size }, params)
        getListData(generateParams)
        .then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
        .finally(() => (this.listLoading = false))
      })
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
      this.queryParams.model.gasMeterVersionId = null
      this.queryParams.model.gasMeterModelId = null
      this.versionList = []
      this.modelList = []
      if (value) {
        await this.getVersionList({ companyId: value })
      }
    },

    // 气表版号发生变化, 清空气表型号信息
    async handleChangeVersion(value) {
      this.queryParams.model.gasMeterModelId = null
      this.modelList = []
       if (value) {
         await this.getModelList({ gasMeterVersionId: value })
       }
    },

    // 选择单个客户
    handleSelectRowInfo(row) {
      this.$emit('select-success', row)
    },

    // 重置表单
    handleResetSearch(ref) {
      this.$refs[ref]?.resetFields?.()
      this.queryParams.current = 1
      this.total = 0
      this.list = []
    },
  }
}
</script>

<style scoped lang="scss">

</style>
