<!-- 物联网表列表 -->
<template>
  <div class="iotList-container">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :rules="searchFormRules" :model="queryParams.model" :inline="true" class="qc-search-form">
        <!-- 气表版号 -->
        <el-form-item label="" prop="gasMeterVersionId">
          <el-select v-model="queryParams.model.gasMeterVersionId" name="gasMeterVersionId" filterable :placeholder="$t('meterInfo.gasMeterVersionId')">
            <el-option v-for="(item, index) in versionList" :key="index" :value="item.id" :label="item.gasMeterVersionName"></el-option>
          </el-select>
        </el-form-item>
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input
            v-model="queryParams.model.customerChargeNo"
            clearable
            :placeholder="$t('meterInfo.customerChargeNo')"
          >
          </el-input>
        </el-form-item>
        <!-- 气表表号 -->
        <el-form-item label="" prop="gasMeterNumber">
          <el-input
            v-model="queryParams.model.gasMeterNumber"
            clearable
            :placeholder="$t('meterInfo.gasMeterNumber')"
          >
          </el-input>
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item label="" prop="gasMeterAddress">
          <el-input
            v-model="queryParams.model.gasMeterAddress"
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
            @click.native="resetSearch(searchFormRef, true)"
          >{{ $t('reset') }}
          </el-button>
        </el-form-item>
      </el-form>
    </search-box>
      <!-- 档案列表 -->
      <el-card shadow="never" class="workHeight">
        <template v-slot:header>
          <search-box>
            <div slot="left"><span class="card-title">物联网表具档案列表</span></div>
            <!-- 操作按钮 -->
            <div slot="right">
              <!-- 批量参数设置 -->
              <el-button
                type="primary"
                :disabled="btnLoading || multipleSelection.length === 0"
                @click="handleBatchIotParamterSetting()"
              >
                {{ $t('批量参数设置') }}
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
          <el-table-column prop="dataStatus" :label="$t('meterInfo.dataStatus')" width="100" fixed="right">
            <template #default="{ row }">
              {{ meterStatusMap[+row.dataStatus] }}
            </template>
          </el-table-column>
          <!-- 操作 -->
          <el-table-column fixed="right" :label="$t('table.operation')" width="110">
            <template #default="{ row }">
              <!-- 参数设置 -->
              <el-button
                type="primary"
                name="row-edit"
                :disabled="btnLoading"
                @click="handleIotParamterSetting(row)"
              >{{ $t('参数设置') }}
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
      
      <!-- 参数设置表单弹窗 -->
      <el-dialog
        width="850px"
        :title="$t('参数设置')"
        :visible.sync="formDialogVisible"
        data-key="formDialogVisible"
        append-to-body
        @close="formDialogVisible = false"
      >
        <parameter-setting-form v-if="formDialogVisible" :form-data="iotParamterData" :version="version" @success="handleSaveParameterSuccess" />
      </el-dialog>
  </div>
</template>

<script>
import { merge } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import meterMixin from '@/mixins/meter'
import { dataStatusField } from '@/enums/common'
import { meterStatusField, orderSourceNameField, meterFactoryField } from '@/enums/meterInfo'
import { checkParameterSetting } from '@/enums/parameterSetting'
import { getVersionListData } from '@/api/meterInfo/index'
import iotParameterSettingApi from '@/api/meterInfo/iotParameterSetting'
import { getListData, batchRegisterAgain } from '@/api/meterInfo/index'

import ParameterSettingForm from './Form.vue'

const iotMeters = [orderSourceNameField.REMOTE_READMETER, orderSourceNameField.CENTER_RECHARGE, orderSourceNameField.REMOTE_RECHARGE]

export default {
  name: 'IotList',
  components: {
    ParameterSettingForm
  },
  filters: {},
  mixins: [commonMixin, listMixin, meterMixin],
  props: {

  },
  data() {
    return {
      ...this.initListData({
        queryParams: this.initQueryParams({
          model: {
            customerChargeNo: null, // 缴费编号
            gasMeterNumber: null,
            gasMeterVersionId: null,
            orderSourceName: iotMeters,
            moreGasMeterAddress: null,
            // dataStatus: [meterStatusField.DKH, meterStatusField.DTQ, meterStatusField.YTQ],
          }
        }),
        searchFormRules: {
          gasMeterVersionId: [
            { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterVersionName')}`, trigger: ['change', 'blur'] }
          ],
        },
      }),
      versionList: [], // 气表版号列表
      iotParamterData: {},
    }
  },
  computed: {
    // 气表版号信息
    version() {
      return this.versionList.find((item) => item.id === this.queryParams.model.gasMeterVersionId) ?? {}
    }
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
      await this.getVersionList()
      // await this.getList()
      this.handleSearch()

    },
    // 获取列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        const generateParams = merge(this.queryParams.model, { pageNo: this.queryParams.current, pageSize: this.queryParams.size }, params)
        getListData(generateParams).then(async (result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            const {total, records} = data
            const iotParamterData =  await this.getIotParamterData(records.map((item) => item.gasMeterNumber))
            if (iotParamterData && iotParamterData.length > 0) {
              records.forEach((meter) => {
                const findIotParamterData = iotParamterData.find((item) => item.gasMeterNumber === meter.gasMeterNumber)
                if (findIotParamterData) {
                  meter.iotParamterData = findIotParamterData
                }
              })
            }
            this.total = total
            this.list = records
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => (this.listLoading = false))
      })
    },

    // 获取当前表具列表参数设置记录
    getIotParamterData(data) {
      return new Promise((resolve) => {
        iotParameterSettingApi.getIotDeviceParams(data).then((result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            resolve(data)
          } else {
            resolve([])
          }
        }).catch(() => {
          resolve([])
        })
      })
    },

    // 获取气表版号
    async getVersionList(params = {}) {
      return new Promise((resolve) => {
        getVersionListData({ companyCode: meterFactoryField.QC, dataStatus: dataStatusField.VALID, gasMeterFactoryStatus: dataStatusField.VALID, versionState: dataStatusField.VALID, orderSourceName: iotMeters.join(','), ...params }).then((response) => {
         const { isSuccess, data } = response.data
         if (isSuccess) {
           // 过滤只能进行参数设置的版号
           this.versionList = data.filter((item) => {
             return checkParameterSetting(item.gasMeterVersionName)
           })
           this.queryParams.model.gasMeterVersionId = this.versionList[0]?.id ?? null
         }
         resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 根据查询条件筛选数据
    handleSearch() {
      this.$refs[this.searchFormRef]?.validate((valid) => {
        if (!valid) {
          this.$message.error('请先选择气表版号！')
        } else {
          this.getList()
        }
      })
    },

    // 打开参数设置弹框
    showFormDialog(data) {
      // 组装数据
      this.iotParamterData = data.map((item) => {
        return {
          ...item.iotParamterData || {},
          gasMeterNumber: item.gasMeterNumber
        }
      })
      this.$nextTick(() => {
        this.formDialogVisible = true
      })
    },

    // 单个参数设置
    handleIotParamterSetting(row) {
      this.showFormDialog([row])
    },

    // 批量参数设置
    handleBatchIotParamterSetting() {
      this.showFormDialog(this.multipleSelection)
    },

    // 保存参数设置成功
    handleSaveParameterSuccess() {
      this.handleSearch()
      this.formDialogVisible = false
    }
  }
}
</script>

<style scoped lang="scss">
  .iotList-container {
    ::v-deep {
      .search-box {
        .el-form-item {
          margin-bottom: 18px;
        }
      }
    }
  }
</style>
