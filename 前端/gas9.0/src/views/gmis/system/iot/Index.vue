<!-- 厂家网关配置 -->
<template>
  <div class="qc-main app-container iot-page">
    <el-card shadow="never" class="no-border">
      <template v-slot:header>
        <span class="card-title">{{ $t('system.iot.title') }}</span>
      </template>
      <!--搜索-->
      <search-box>
        <template v-slot:left>
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <el-form-item label="">
              <!--厂家名称-->
              <el-input
                v-model="queryParams.model.factoryName"
                :placeholder="$t('system.iot.factoryName')"
                class="filter-item search-item"
              />
            </el-form-item>
            <!-- 搜索操作 -->
            <el-form-item label="">
              <el-button type="primary" name="iot-search" icon="el-icon-search" class="search-btn 
              iot-search" @click="handleSearch"
>{{ $t('search') }}</el-button>
              <el-button type="warning" name="iot-search" icon="el-icon-refresh-left" class="search-reset-btn" @click="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </template>
        <template v-slot:right>
          <!--添加-->
          <el-button v-has-permission="['iot:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog()">{{ $t('add') }}</el-button>
        </template>
      </search-box>

      <!--数据列表-->
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        border
        :highlight-current-row="false"
        :data="list"
        tooltip-effect="dark"
        @filter-change="filterChange"
      >
        <!-- 厂家名称	-->
        <el-table-column
          :label="$t('system.iot.factoryName')"
          :show-overflow-tooltip="true"
          prop="factoryName"
          width="100px"
        />
        <!--厂家编码-->
        <el-table-column
          :label="$t('system.iot.factoryCode')"
          :show-overflow-tooltip="true"
          prop="factoryCode"
        />
        <!--appId-->
        <el-table-column
          :label="$t('system.iot.appId')"
          :show-overflow-tooltip="true"
          prop="appId"
        />
        <!--appSecret-->
        <el-table-column
          :label="$t('system.iot.appSecret')"
          :show-overflow-tooltip="true"
          prop="appSecret"
        />
        <!--domainId-->
        <el-table-column
          :label="$t('system.iot.domainId')"
          :show-overflow-tooltip="true"
          prop="domainId"
          width="90px"
        />
        <!--网关名称-->
        <el-table-column
          :label="$t('system.iot.gatewayName')"
          :show-overflow-tooltip="true"
          width="120px"
          prop="gatewayName"
        />
        <!--网关地址-->
        <el-table-column
          :label="$t('system.iot.gatewayUrl')"
          :show-overflow-tooltip="true"
          prop="gatewayUrl"
        />
        <!--网关版本-->
        <el-table-column
          :label="$t('system.iot.gatewayVersion')"
          :show-overflow-tooltip="true"
          prop="gatewayVersion"
        />
        <!--通知地址-->
        <el-table-column
          :label="$t('system.iot.noticeType')"
          :show-overflow-tooltip="true"
          prop="noticeType"
        >
          <template #default="{ row }">
            {{ noticeTypeMap[row.noticeType] }}
          </template>
        </el-table-column>
        <!--通知类型-->
        <el-table-column
          :label="$t('system.iot.noticeUrl')"
          :show-overflow-tooltip="true"
          prop="noticeUrl"
        />
        <!--通知缓存天数-->
        <!-- <el-table-column
          label="system.iot.noticeCacheDay"
          :show-overflow-tooltip="true"
          prop="noticeCacheDay"
        /> -->
        <!-- 状态 -->
        <el-table-column
          :label="$t('system.iot.dataStatus')"
          prop="dataStatus"
          width="140"
          column-key="dataStatus"
          :filter-multiple="false"
          :filters="dataStatusfilters"
        >
          <template #default="scope">
            <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['iot:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
            <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['iot:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
              <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
              <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
            </el-radio-group>
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column
          fixed="right"
          :label="$t('table.operation')"
          width="100"
        >
          <template #default="{ row }">
            <el-button v-has-permission="['iot:edit']" type="primary" name="row-edit" @click="showFormDialog('edit', row)">{{ $t('edit') }}</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!--分页-->
      <pagination
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="handleGetList"
      />
    </el-card>
    <!-- 厂家网关表单弹窗 -->
    <el-dialog
      width="700px"
      :title="currentRow ? $t('system.iot.edit') : $t('system.iot.add')"
      :visible.sync="formDialogVisible"
      data-key="formDialogVisible"
      @close="formDialogVisible = false"
    >
      <Form :form-data="currentRow" @success="handleSaveSuccess" />
    </el-dialog>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import iotApi from '@/api/system/iot'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { initQueryParams } from '@/utils/commons'
import { awaitToJs } from '@/utils/index'
import Form from './Form.vue'

export default {
  name: 'IOT',
  components: {
    Form
  },
  filters: {
  },
  mixins: [commonMixin, listMixin],
  data () {
    return {
      ...this.initListData({
        queryParams: initQueryParams({
          model: {
            factoryName: null
          }
        })
      })
    }
  },
  computed: {
    // 通知类型map
    noticeTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.NOTICE_TYPE)
    },
  },
  async created () {
    await this.getList()
  },
  mounted () {
  },
  methods: {
    // 获取数据列表
    async getList (params) {
      return new Promise((resolve) => {
        this.listLoading = true
        iotApi.page(this.queryParams)
          .then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              const { total, records } = data
              this.total = total
              this.list = records
            }
            resolve(isSuccess)
          })
          .catch(() => (resolve(false)))
          .finally(() => (this.listLoading = false))
      })
    },
    // 修改数据状态
    async handleSwitchChange (val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('system.iot.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      iotApi.save(row, id).then((result) => {
        const { isSuccess } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.dataStatus = Number(!+val)
        }
      }).catch(() => {
        row.dataStatus = Number(!+val)
      }).finally(() => (this.listLoading = false))
    },

    // 数据状态搜索发生变化
    handleDataStatusChange (value) {
      this.handleSearch()
    },
    
    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    },
  }
}
</script>
<style lang="scss" scoped></style>

