<!-- 开户可选择的客户档案列表 -->
<template>
  <div class="customerList-container">
    <el-card shadow="never no-border">
      <div slot="header">
        <span class="card-title">{{ $t('customerInfo.detailsTitle') }}</span>
      </div>
      <!--搜索区域-->
      <search-box class="search-box operation-box">
        <el-form :ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
          <!-- 客户编号 -->
          <!-- <el-form-item label="" prop="customerCode">
            <el-input v-model="queryParams.model.customerCode" name="customerCode" clearable :placeholder="$t('customerInfo.customerCode')" />
          </el-form-item> -->
          <!-- 客户名称 -->
          <el-form-item label="" prop="customerName" style="width: 120px">
            <el-input v-model="queryParams.model.customerName" name="customerName" clearable :placeholder="$t('customerInfo.customerName')" />
          </el-form-item>
          <!-- 联系电话 -->
          <el-form-item label="" prop="telphone" style="width: 140px">
            <el-input v-model="queryParams.model.telphone" name="telphone" clearable :placeholder="$t('customerInfo.telphone')" />
          </el-form-item>
          <!-- 客户类型 -->
          <el-form-item label="" prop="customerTypeCode">
            <el-select v-model="queryParams.model.customerTypeCode" name="customerTypeCode" clearable :placeholder="$t('customerInfo.customerTypeCode')">
              <el-option v-for="(value, key) in userTypeMap" :key="key" :label="value" :value="key" />
            </el-select>
          </el-form-item>
          <el-form-item label="" prop="" style="marginLeft: 10px">
            <el-button type="primary" name="userInfo-search" icon="el-icon-search" :disabled="listLoading" class="search-btn userInfo-search" @click="getList()">{{ $t('search') }}</el-button>
            <el-button type="warning" name="userInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click="handleResetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
          </el-form-item>
        </el-form>
      </search-box>
      
      <!--客户列表-->
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
          <!-- 客户编号 -->
          <!-- <el-table-column
            prop="customerCode"
            :label="$t('customerInfo.customerCode')"
            width="160"
            show-overflow-tooltip
          /> -->
          <el-table-column prop="customerName" label="客户姓名" />
          <!-- 身份证号码 -->
          <el-table-column prop="idCard" label="身份证号码" show-overflow-tooltip />

          <!-- 联系电话 -->
          <el-table-column prop="telphone" label="联系电话" />
          <!-- 客户类型 -->
          <el-table-column prop="customerTypeName" label="客户类型" />
          <!-- 安装地址 -->
          <el-table-column
            prop="contactAddress"
            label="安装地址"
            width="150"
            show-overflow-tooltip
          />
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
import { customerStatusField } from '@/enums/customerInfo'
import { dictionaryCodeMap } from '@/enums/dictionary'
import customerInfoApi from '@/api/userInfo/index'

export default {
  name: 'CustomerList',
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
            customerCode: null,
            customerName: null,
            telphone: null,
            customerTypeCode: null,
            customerStatus: customerStatusField.VALID,
          }
        }),
      })
    }
  },
  computed: {
    // 客户类型枚举
    userTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.USER_TYPE)
    },
    // 是否没有输入客户搜索条件
    isEmptySearch() {
      let flag = true
      for (const value of Object.values(this.queryParams.model)) {
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
  methods: {
    async initData() {

    },

    // 获取客户列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        customerInfoApi.page(this.generateQueryParams({}))
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
    }
  }
}
</script>

<style scoped lang="scss">

</style>
