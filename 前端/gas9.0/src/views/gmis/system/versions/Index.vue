<!-- 气表版本号设置 -->
<template>
  <div class="app-container">
    <search-box>
      <div slot="left">
        <!-- 根据型号搜索 -->
        <el-input
          v-model="queryParams.model.gasMeterVersionName"
          :placeholder="$t('table.versions.name')"
        />
        <el-button type="primary" @click="search">{{ $t("table.search") }}</el-button>
        <el-button type="warning" @click="reset">{{ $t("table.reset") }}</el-button>
      </div>
      <div slot="right">
        <!-- 新增 -->
        <el-button v-has-permission="['versions:add']" type="primary" @click="add">{{
          $t('table.add')
        }}</el-button>
        <!-- 批量启用 -->
        <el-button v-has-permission="['versions:update']" type="primary" :disabled="!isBatchDisabled" @click="batchUpdate(1)">{{ $t("table.startOver") }}</el-button>
        <!-- 批量禁用 -->
        <el-button v-has-permission="['versions:update']" type="primary" :disabled="!isBatchEnabled" @click="batchUpdate(0)">{{ $t("table.disable") }}</el-button>
      </div>
    </search-box>
    <!-- 气表版本号列表 -->
    <el-table
      :key="tableKey"
      ref="table"
      v-loading="loading"
      :data="tableData.records"
      border
      fit
      row-key="id"
      style="width: 100%;"
      @filter-change="filterChange"
      @selection-change="onSelectChange"
    >
      <el-table-column align="center" type="selection" width="40px" :reserve-selection="true" />
      <!-- 版本号名称  -->
      <el-table-column
        :label="$t('table.versions.name')"
        :show-overflow-tooltip="true"
        align="center"
        prop="gasMeterVersionName"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterVersionName }}</span>
        </template>
      </el-table-column>
      <!-- 生产厂商  -->
      <el-table-column
        :label="$t('table.versions.production')"
        :show-overflow-tooltip="true"
        align="center"
        prop="companyName"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.companyName }}</span>
        </template>
      </el-table-column>
      <!-- 版本号描述  -->
      <el-table-column
        :label="$t('table.versions.describe')"
        align="center"
        :show-overflow-tooltip="true"
        width="140px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterDescribe }}</span>
        </template>
      </el-table-column>
      <!-- 备注 -->
      <el-table-column
        :label="$t('table.versions.remarks')"
        align="center"
        :show-overflow-tooltip="true"
        width="180px"
        prop="remark"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.remark }}</span>
        </template>
      </el-table-column>
      <!-- 状态 -->
      <el-table-column
        :label="$t('status')" 
        prop="versionState"
        width="140"
        column-key="versionState"
        :filter-multiple="false"
        :filters="dataStatusfilters"
      >
        <template #default="scope">
          <!-- <qc-switch v-model="row.versionState" :disabled="!checkPermission(['companyConfig:update'])" @change="handleSwitchChange(row.versionState, row)" /> -->
          <el-radio-group v-model="scope.row.versionState" :disabled="!checkPermission(['companyConfig:update'])" @change="handleSwitchChange(scope.row.versionState, scope.row)">
            <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
            <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
          </el-radio-group>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.operation')"
        align="left"
        column-key="operation"
        class-name="small-padding"
        width="180px"
      >
        <template slot-scope="{ row }">
          <!-- 编辑 -->

          <el-button
            v-hasPermission="['versions:update']"
            type="primary"
            @click="edit(row)"
          >{{ $t('edit') }}</el-button>

          <!-- 参数设置 v-hasPermission="['version:wlwbccsz']"-->
          <el-button
            v-if="checkIotParameterSetting(row)"
            type="primary"
            @click="handleParameterSetting(row)"
          >{{ $t('参数设置') }}</el-button>
          <!-- 无权限 -->
          <el-link v-has-no-permission="['versions:update', 'versions:delete', 'version:wlwbccsz']" class="no-perm">{{
            $t('tips.noPermission')
          }}</el-link>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-show="tableData.total > 0"
      :limit.sync="queryParams.size"
      :page.sync="queryParams.current"
      :total="Number(tableData.total)"
      @pagination="fetch"
    />
    <gasVersionEdit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      :order-source-list="orderSourceList"
      :amount-mark-list="amountMarkList"
      @close="editClose"
      @success="editSuccess"
    />
    
    <!-- 参数设置表单弹窗 -->
    <el-dialog
      width="850px"
      :title="$t('参数设置')"
      :visible.sync="parameterSettingFormDialogVisible"
      append-to-body
      @close="parameterSettingFormDialogVisible = false"
    >
      <parameter-setting-Form v-if="parameterSettingFormDialogVisible" :version="currentVersion" @success="handleSaveParameterSuccess" />
    </el-dialog>
  </div>
</template>

<script>
import meterMixin from '@/mixins/meter'
import elDragDialog from '@/directive/el-drag-dialog'
import FileImport from '@/components/gmis/Import'
import Pagination from '@/components/Pagination'
import gasVersionEdit from './components/Edit'
import ParameterSettingForm from '@/components/IotParamterSetting/Form.vue'
import gasMeterVersionApi from '@/api/system/gasMeterVersion'
import DictApi from '@/api/DictionaryItem'
import {downloadFile, initDicts,initQueryParams} from '@/utils/commons'
import { awaitToJs } from '@/utils/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { dataStatusfilters } from '@/enums/common'
import { checkParameterSetting } from '@/enums/parameterSetting'
import { meterFactoryField } from '@/enums/meterInfo'

export default {
  name: 'GasVersionManage',
  directives: { elDragDialog },
  components: { Pagination, gasVersionEdit, FileImport, ParameterSettingForm },
  filters: {
    statusFilter(status) {
      const map = {
        false: 'danger',
        true: 'success',
      }
      return map[status] || 'success'
    },
  },
  mixins: [meterMixin],
  data() {
    this.dataStatusfilters = dataStatusfilters
    return {
      dialog: {
        isVisible: false,
        type: 'add',
      },
      tableKey: 0,
      orgList: [],
      queryParams: initQueryParams({
        model: {},
      }),
      selection: [],
      loading: false,
      tableData: {
        total: 0,
      },
      dicts: {
        CARD_TYPE: {},
        WIRELESS_EQUIPMENT_VENDORS: {},
        REMOTE_SERVICE_FLAG: {},
        AMOUNT_MARK: {},
        ORDER_SOURCE_NAME: {},
      },
      amountMarkList: [],
      orderSourceList: [],
      currentVersion: {}, // 当前气表版号信息
      parameterSettingFormDialogVisible: false, // 参数设置表单弹框
    }
  },
  computed: {
    // 是否批量禁用
    isBatchDisabled() {
      return this.selection.find((item) => !item.versionState)
    },
    
    // 是否批量启用
    isBatchEnabled() {
      return this.selection.find((item) => item.versionState)
    },
  },
  watch: {
    'dialog.isVisible': function(val) {
      if (val) {
        if (!this.orderSourceList.length) {
          this.fetchOrderSource()
        }
        if (!this.amountMarkList.length) {
          this.fetchAmountMark()
        }
      }
    }
  },
  mounted() {
    this.dicts = {
      CARD_TYPE: this.dictMap[dictionaryCodeMap.CARD_TYPE],
      WIRELESS_EQUIPMENT_VENDORS: this.dictMap[dictionaryCodeMap.WIRELESS_EQUIPMENT_VENDORS],
      REMOTE_SERVICE_FLAG: this.dictMap[dictionaryCodeMap.REMOTE_SERVICE_FLAG],
      AMOUNT_MARK: this.dictMap[dictionaryCodeMap.AMOUNT_MARK],
      ORDER_SOURCE_NAME: this.dictMap[dictionaryCodeMap.ORDER_SOURCE_NAME],
    }
    this.fetch()
  },
  methods: {
    checkParameterSetting,
    // 获取订单来源
    async fetchOrderSource() {
      const ORDER_SOURCE = '1298804072366735360'
      const payload = {
        model: {
          dictionaryId: ORDER_SOURCE
        }
      }
      const { data: res } = await DictApi.page(payload)
      if (res.data) {
        const orderSourceList = res.data?.records ?? []
        if (orderSourceList.length) {
          this.orderSourceList = orderSourceList.map(({ code, name }) => ({
            name,
            code
          }))
        }
      }
    },
    // 获取金额标示
    async fetchAmountMark() {
      const AMOUNT_MARK = '1296631159827988480'
      const payload = {
        model: {
          dictionaryId: AMOUNT_MARK
        }
      }
      const { data: res } = await DictApi.page(payload)
      if (res.data) {
        const amountMarkList = res.data?.records ?? []
        if (amountMarkList.length) {
          this.amountMarkList = amountMarkList.map(({ code, name }) => ({
            name,
            code
          }))
        }
      }
    },
    editClose() {
      this.dialog.isVisible = false
    },
    editSuccess() {
      this.search()
    },
    filterChange(filters) {
      for (const key in filters) {
        if (key.includes('.')) {
          const val = {}
          val[key.split('.')[1]] = filters[key][0]
          this.queryParams.model[key.split('.')[0]] = val
        } else {
          this.queryParams.model[key] = filters[key][0]
        }
      }
      this.search()
    },
    onSelectChange(selection) {
      this.selection = selection
    },
    /**
     * 版本号名称搜索
     */
    search() {
      this.fetch({
        ...this.queryParams,
      })
    },
    /**
     * 重置
     */
    reset() {
      this.queryParams = initQueryParams({
        model: {},
      })
      this.$refs.table.clearSort()
      this.$refs.table.clearFilter()
      this.search()
    },
    /**
     * 气表版本号添加
     */
    add() {
      this.dialog.type = 'add'
      this.dialog.isVisible = true
      this.$refs.edit.setGasVersion(false, this.dicts)
    },
    /**
     * 气表版本号编辑
     */
    edit(row) {
      this.dialog.type = 'edit'
      this.dialog.isVisible = true
      this.$refs.edit.setGasVersion(row, this.dicts)
    },
    /**
     * 版本号列表数据获取
     */
    fetch(params = {}) {
      this.loading = true
      if (this.queryParams.timeRange) {
        this.queryParams.map.createTime_st = this.queryParams.timeRange[0]
        this.queryParams.map.createTime_ed = this.queryParams.timeRange[1]
      }

      this.queryParams.current = params.current ? params.current : this.queryParams.current
      this.queryParams.size = params.size ? params.size : this.queryParams.size

      gasMeterVersionApi
        .page(this.queryParams)
        .then(response => {
          const res = response.data
          //获取的远程业务标志转成数组
          if (res.isSuccess) {
            for(let key in res.data.records){
              if(res.data.records[key].remoteServiceFlag){
                res.data.records[key].remoteServiceFlag = res.data.records[key].remoteServiceFlag != null?res.data.records[key].remoteServiceFlag.split(','):''
              }
            }
            this.tableData = res.data
          }
        })
        .finally(() => (this.loading = false))
    },
    /**
     * 批量修改气表版本号
     */
    async batchUpdate($state) {
      if (!this.selection.length) {
        this.$message({
          message: this.$t('tips.noDataSelected'),
          type: 'warning',
        })
        return
      }
      if (!$state) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('meterVersion.batchDisableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          return
        }
      }
      const ids = []
      this.selection.forEach(u => {
        ids.push({ id: u.id, versionState: $state })
      })
      gasMeterVersionApi.updateBatch(ids).then(response => {
        const res = response.data;
        if (res.isSuccess) {
          this.$refs?.table?.clearSelection?.()
          this.$message({
            message: this.$t('batchSaveSuccess'),
            type: 'success'
          });
          this.search();
        } else {
          this.$message.error(res.msg)
        }
      }).catch((err) => {
        this.$message.error(err)
      });
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id } = row
      if (!val) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('meterVersion.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.versionState = Number(!+val)
          return
        }
      }
      this.loading = true
      gasMeterVersionApi.update(row).then((result) => {
        this.loading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.versionState = Number(!+val)
        }
      }).catch(() => {
        this.loading = false
        row.versionState = Number(!+val)
      })
    },

    // 验证是否可以进行物联网表参数设置
    checkIotParameterSetting(row) {
      return row.companyCode === meterFactoryField.QC && this.IS_INTERNET_GASMETER(row) && this.checkParameterSetting(row.gasMeterVersionName)
    },

    handleParameterSetting(row) {
      this.currentVersion = row
      this.$nextTick(() => {
        this.parameterSettingFormDialogVisible = true
      })
    },

    // 参数设置成功
    handleSaveParameterSuccess() {
      this.parameterSettingFormDialogVisible = false
      this.fetch()
    },
  },
}
</script>
<style lang="scss" scoped></style>
