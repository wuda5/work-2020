<!-- 选择安装地址列表 -->
<template>
  <div v-loading="loading" class="SelectGasMeterAddress-page">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :model="searchForm" :rules="searchFormRules" :inline="true" class="qc-search-form">
        <!-- 省市区 -->
        <el-form-item label="" prop="region" class="region-form-item">
          <el-cascader v-model="searchForm.region" name="region" :options="regionCascadeList" :props="regionCascadeLProps" clearable filterable :placeholder="`${$t('selectHint')}${$t('operation.community.region')}`" @change="handleRegionChange"></el-cascader>
        </el-form-item>
        <!-- 街道(乡镇)名称 -->
        <el-form-item label="" prop="streetName">
          <el-select v-model="searchForm.streetName" name="streetName" clearable :placeholder="$t('operation.community.streetName')" @change="handleStreetChange">
            <el-option v-for="(item, index) in streetList" :key="index" :label="item.streetName" :value="item.streetName" />
          </el-select>
        </el-form-item>
        <!-- 小区(村、xx路) -->
        <el-form-item label="" prop="communityName">
          <el-select v-model="searchForm.communityName" name="communityName" clearable :placeholder="$t('operation.community.communityName')" @change="handleCommunityChange">
            <el-option v-for="(item, index) in communityList" :key="index" :label="item.communityName" :value="item.communityName" />
          </el-select>
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item prop="moreDetailAddress" label="" class="moreDetailAddress-form-item">
          <el-input v-model="searchForm.moreDetailAddress" name="moreDetailAddress" clearable :placeholder="$t('operation.community.moreDetailAddress')"></el-input>
        </el-form-item>
        <el-form-item label="" prop="" style="marginLeft: 10px">
          <el-button type="primary" name="userInfo-search" icon="el-icon-search" class="search-btn userInfo-search" @click="handleSearch">{{ $t('search') }}</el-button>
          <el-button type="warning" name="userInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click="handleResetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
        </el-form-item>
      </el-form>
    </search-box>
    <!-- 数据列表区域 -->
    <div class="table-box">
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        border
        :data="list"
        tooltip-effect="dark"
      >
        <!-- 索引 -->
        <el-table-column
          type="index"
          :label="$t('table.index')"
        >
        </el-table-column>
        <!-- 详细地址 -->
        <el-table-column
          :label="$t('operation.community.moreDetailAddress')"
          prop="moreDetailAddress"
          show-overflow-tooltip
        >
          <template #default="{ row }">
            {{ generateFullAddress(row) }}
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column
          fixed="right"
          :label="$t('table.operation')"
          width="100"
        >
          <template #default="{ row }">
            <el-button type="primary" name="row-edit" @click.stop="handleUseAddress(row)">{{ $t('table.use') }}</el-button>
          </template>
        </el-table-column>
        <template #empty>
          <b class="text-danger">{{ $t('operation.community.searchEmptyText') }}</b>
        </template>
      </el-table>
      <!--分页-->
      <pagination
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="handleGetList"
      />
    </div>
  </div>
</template>

<script>
import { cloneDeep, merge, pick } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { dataStatusField, deleteStatusField } from '@/enums/common'
import { getDetailsAddressList, getStreetList, getCommunityList, getValidRegionList } from '@/api/operation/community'
import { flatToNest } from '@/utils/array'

export default {
  name: 'SelectGasMeterAddress',
  components: {

  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {
    // 表具信息
    meterData: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      ...this.initListData({
        queryParams: this.initQueryParams({
          model: {
            dataStatus: dataStatusField.VALID,
            deleteStatus: deleteStatusField.DELETE_INVALID
          }
        }),
      }),
      searchForm: {
        region: [],
        provinceCode: null,
        provinceName: null,
        cityCode: null,
        cityName: null,
        areaCode: null,
        areaName: null,
        streetId: null,
        streetName: null,
        communityId: null,
        communityName: null,
        moreDetailAddress: null
      },
      searchFormRules: {
        region: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.region')}`, trigger: 'change' },
        ],
        streetId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.streetName')}`, trigger: 'change' },
        ],
        streetName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.streetName')}`, trigger: 'change' },
        ],
        communityId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.communityName')}`, trigger: 'change' },
        ],
        communityName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('operation.community.communityName')}`, trigger: 'change' },
        ],
      },
      regionList: [], // 地区列表
      streetList: [], // 街道列表
      communityList: [], // 小区列表
      // 地区级联数据配置
      regionCascadeLProps: {
        value: 'code'
      },
    }
  },
  computed: {
    // 省市区级联列表
    regionCascadeList() {
      if (this.regionList && this.regionList.length > 0) {
        return flatToNest(this.regionList, { defaultParentIdValue: '0' })
      } else {
        return []
      }
    }
  },
  watch: {
    // 监听小区数据变化
    'meterData.communityId': {
      handler(value) {
        // console.log('小区id发生变化', value)
        this.initData(value)
      },
      immediate: false,
    },
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
      // console.log('initData')
      const { communityId, streetId, provinceCode, cityCode, areaCode } = this.meterData
      this.loading = true
      this.searchForm = { ...cloneDeep(this.searchForm), ...pick(this.meterData, Object.keys(this.searchForm)) }
      // 获取区域列表
      await this.getRegionListData()
      // 获取街道列表
      if (provinceCode && cityCode && areaCode) {
        await this.getValidStreetList({
          provinceCode,
          cityCode,
          areaCode,
        })
      }
      // 获取小区列表
      if (streetId) {
        await this.getValidCommunityList({
          streetId
        })
      }

      // 有小区id才搜索数据
      if (communityId) {
        await this.handleSearch()
      }
      this.loading = false
    },

    // 获取小区(村、xx路)列表根据街道(乡镇)Id
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getDetailsAddressList(this.generateQueryParams(params)).then((result) => {
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

    // 获取地区数据
    async getRegionListData() {
      if(this.regionList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        getValidRegionList().then((result) => {
          // console.log(result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.regionList = data
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取有效街道列表
    getValidStreetList(params = {}) {
      return new Promise((resolve) => {
        this.loading = true
        getStreetList(this.initQueryParams({ model: { dataStatus: dataStatusField.VALID, ...params }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.streetList = records
            // 如果只有一条数据，默认赋值
            if (records.length === 1) {
              const firstData = records[0]
              Object.assign(this.searchForm, { streetId: firstData.id, streetName: firstData.streetName })
              this.$nextTick(() => {
                this.getValidCommunityList({
                  streetId: firstData.id
                })
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
          resolve(false)
        })
      })
    },

    // 获取有效街道列表
    getValidCommunityList(params = {}) {
      return new Promise((resolve) => {
        this.loading = true
        getCommunityList(this.initQueryParams({ model: { dataStatus: dataStatusField.VALID, ...params }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.communityList = records
            // 如果只有一条数据，默认赋值
            if (records.length === 1) {
              const firstData = records[0]
              Object.assign(this.form, { communityId: firstData.id, communityName: firstData.communityName })
              this.$nextTick(() => {
                // 搜索数据
                this.getList()
              })
            }
            resolve(records)
          } else {
            resolve(false)
          }
          this.loading = false
        }).catch(() => {
          this.loading = false
          resolve(false)
        })
      })
    },

    // 通过region code查找region信息
    findRegionNameByCode(code) {
      const region = this.regionList.find((region) => region.code === code)
      return region ? region.label : ''
    },

    // 省市区选择改变
    async handleRegionChange(value) {
      // console.log('value', value)
      // 置空街道和小区
      this.searchForm.streetId = null
      this.searchForm.streetName = null
      this.searchForm.communityId = null
      this.searchForm.communityName = null
      // 重置列表
      this.handleResetSearch(false)
      if (value.length > 0) {
        const provinceCode = value[0] ?? null
        const cityCode = value[1] ?? null
        const areaCode = value[2] ?? null
        // 名字赋值
        Object.assign(this.searchForm, { provinceCode, provinceName: this.findRegionNameByCode(provinceCode), cityCode, cityName: this.findRegionNameByCode(cityCode), areaCode, areaName: this.findRegionNameByCode(areaCode) })
        await this.getValidStreetList({
          provinceCode,
          cityCode,
          areaCode,
        })
      }
    },

    // 街道选择发生变化
    async handleStreetChange(value) {
      // 小区信息置空
      this.searchForm.communityId = ''
      this.searchForm.communityName = ''
      // 重置列表
      this.handleResetSearch(false)
      const street = this.streetList.find((item) => item.streetName === value)
      const streetId = street?.id ?? null
      this.searchForm.streetId = streetId
      if (streetId) {
        await this.getValidCommunityList({
          streetId
        })
      }
    },

    // 小区选择发生变化
    handleCommunityChange(value) {
      const community = this.communityList.find((item) => item.communityName === value)
      this.searchForm.communityId = community?.id ?? null
      if (value) {
        this.$nextTick(() => {
          // 搜索数据
          this.getList()
        })
      } else {
        // 重置列表
        this.handleResetSearch(false)
      }
    },

    // 选择使用地址
    handleUseAddress(row) {
      this.$emit('success', merge(cloneDeep(this.searchForm), cloneDeep(row), { fullAddress: this.generateFullAddress(row) }))
    },

    // 搜索筛选
    handleSearch() {
      this.$refs[this.searchFormRef]?.validate(async(valid) => {
        if (valid) {
          this.getList()
        } else {
          this.$message.error(this.$t('searchvalidateError'))
        }
      })
    },

    // 重置筛选条件
    handleResetSearch(resetForm = true) {
      resetForm && this.$refs[this.searchFormRef]?.resetFields?.()
      // 重置分页
      this.queryParams.current = 1
      this.total = 0
      this.$nextTick(() => {
        this.list = []
      })
    },

    // 生成完整地址
    generateFullAddress(row) {
      const searchForm = this.searchForm
      return `${searchForm.provinceName}${searchForm.cityName}${searchForm.areaName}${searchForm.streetName}${searchForm.communityName}${row.moreDetailAddress}`
    }
  }
}
</script>

<style scoped lang="scss">
  .SelectGasMeterAddress-page {
    ::v-deep {
      .qc-search-form {
        .el-form-item {
          margin-bottom: 18px;
        }
      }
    }
  }
</style>
