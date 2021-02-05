<!-- 赠送减免活动配置 -->
<template>
  <div class="qc-main Preferential-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.preferential.title') }}</span>
      </div>
      <!-- 列表搜索区域 -->
      <search-box class="search-box operation-box">
        <div slot="left" class="">
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 活动名称 -->
            <el-form-item label="" prop="activityName">
              <el-input v-model="searchForm.activityName" clearable :placeholder="$t('operation.preferential.activityName')">
              </el-input>
            </el-form-item>
            <!-- 操作 -->
            <el-form-item label="" prop="dataStatus">
              <el-button type="primary" name="preferential-search" icon="el-icon-search" class="search-btn preferential-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
              <el-button type="warning" name="preferential-search" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
            <!-- <el-form-item label="">
                <data-status-search :value.sync="searchForm.dataStatus" @data-status-change="handleDataStatusChange"></data-status-search>
              </el-form-item> -->
          </el-form>
        </div>
        <!-- 操作 -->
        <div slot="right" class="operation-btn-box">
          <el-button v-has-permission="['preferential:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
        </div>
      </search-box>
      <div>
        <!--数据-->
        <el-table
          :ref="listRef"
          v-loading="listLoading"
          stripe
          border
          :highlight-current-row="false"
          :data="list"
          tooltip-effect="dark"
          @row-click="handleRowClick"
          @filter-change="filterChange"
        >
          <!-- 索引 -->
          <el-table-column
            type="index"
            :label="$t('table.index')"
          >
          </el-table-column>
          <!-- 活动名称 -->
          <el-table-column
            prop="activityName"
            :label="$t('operation.preferential.activityName')"
          >
          </el-table-column>
          <!-- 活动场景 -->
          <el-table-column
            prop="activityScene"
            :label="$t('operation.preferential.activityScene')"
          >
            <template #default="scope">
              {{ activitySceneFormat(scope.row.activityScene) }}
            </template>
          </el-table-column>
          <!-- 用气类型 -->
          <el-table-column
            prop="useGasTypes"
            :label="$t('operation.preferential.useGasTypes')"
          >
            <template #default="scope">
              {{ useGasTypesFormat(scope.row.useGasTypes, scope.row.activityScene) }}
            </template>
          </el-table-column>
          <!-- 活动金额方式 -->
          <el-table-column
            prop="activityMoneyType"
            :label="$t('operation.preferential.activityMoneyType')"
          >
            <template #default="scope">
              {{ activityMoneyTypeFormat(scope.row.activityMoneyType) }}
            </template>
          </el-table-column>
          <!-- 活动金额 -->
          <el-table-column 
            :label="$t('operation.preferential.activityMoney')" 
            prop="activityMoney"
          >
            <template #default="scope">
              {{ IS_GDJE(scope.row.activityMoneyType) ? scope.row.activityMoney : '--' }}
            </template>
          </el-table-column>
          <!-- 活动比列 -->
          <el-table-column 
            :label="$t('operation.preferential.activityPercent')" 
            prop="activityPercent"
          >
            <template #default="scope">
              {{ IS_BFBJE(scope.row.activityMoneyType) ? scope.row.activityPercent : '--' }}
            </template>
          </el-table-column>
          <!-- 赠送气量 -->
          <el-table-column 
            :label="$t('operation.preferential.giveGas')" 
            prop="giveGas"
          >
            <template #default="scope">
              {{ IS_RECHARGE_GIVE(scope.row.activityScene) ? scope.row.giveGas : '--' }}
            </template>
          </el-table-column>
          <!-- 开始时间 -->
          <el-table-column 
            :label="$t('operation.preferential.startTime')" 
            prop="startTime"
          >
            <template #default="scope">
              {{ scope.row.startTime | parseTime('{y}.{m}.{d}') }}
            </template>
          </el-table-column>
          <!-- 结束时间 -->
          <el-table-column 
            :label="$t('operation.preferential.endTime')" 
            prop="endTime"
          >
            <template #default="scope">
              {{ scope.row.endTime | parseTime('{y}.{m}.{d}') }}
            </template>
          </el-table-column>
          <!-- 状态 -->
          <el-table-column 
            :label="$t('status')" 
            prop="dataStatus"
            width="140"
            column-key="dataStatus"
            :filter-multiple="false"
            :filters="dataStatusfilters"
          >
            <template #default="scope">
              <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['preferential:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
              <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['preferential:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
              <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
                <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
            </el-radio-group>
            </template>
          </el-table-column>
          <!-- 操作 -->
          <el-table-column
            fixed="right"
            :label="$t('table.operation')"
            width="120"
          >
            <template #default="{ row }">
              <el-button v-has-permission="['preferential:edit']" type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
              <!-- <el-button v-has-permission="['preferential:delete']" type="danger" name="row-delete" @click.native="handleDelete(row)">{{ $t('delete') }}</el-button> -->
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

        <!-- 表单弹窗 -->
        <qc-dialog
          :width="600"
          :title="currentRow ? $t('operation.preferential.edit') : $t('operation.preferential.add')"
          :visible="formDialogVisible"
          data-key="formDialogVisible"
          @close="dialogClose"
        >
          <preferential-form :form-data="currentRow" @success="handleSaveSuccess"></preferential-form>
        </qc-dialog>
      </div>
    </el-card>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs, parseTime } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { activityMoneyTypeField, activitySceneField } from '@/enums/preferential'
import { getListData, saveData, deleteData } from '@/api/operation/preferential'
import PreferentialForm from './Form'

export default {
  name: 'Preferential',
  components: {
    PreferentialForm,
  },
  filters: {
  },
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        activityName: null,
        useGasTypeId: null,
        dataStatus: null,
      }
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
        getListData(this.generateQueryParams(params)).then((result) => {
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

    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        deleteData({ ids }).then((result) => {
          this.btnLoading = true
          const { isSuccess, data } = result.data
          if (isSuccess) {
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          this.btnLoading = true
          resolve(false)
        })
      })
    },

    //删除操作
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.preferential.deleteConfirm'), this.$t('common.tips'), {
        type: 'warning'
      }))
      if (!confirmResult?.error) {
        const deleteResult = await this.deleteData([row.id])
        if (deleteResult) {
          this.$message.success(this.$t('tips.deleteSuccess'))
          await this.getList()
          const currentRowId = this.currentRow?.id || ''
          if (currentRowId === row.id) {
            this.currentRow = null
            this.isRowClick = false
          }
        }
      }
    },

    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.preferential.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveData(row, id).then((result) => {
        this.listLoading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.dataStatus = Number(!+val)
        }
      }).catch(() => {
        this.listLoading = false
        row.dataStatus = Number(!+val)
      })
    },

    // 数据状态搜索发生变化
    handleDataStatusChange(value) {
      this.handleSearch()
    },

    // 格式化活动场景显示
    activitySceneFormat(value) {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ACTIVITY_SCENE)?.[value]
    },

    // 格式化活动金额方式显示
    activityMoneyTypeFormat(value) {
      return this.getDictionaryMapByCode(dictionaryCodeMap.MONEY_METHOD)?.[value]
    },

    // 格式化用气类型显示
    useGasTypesFormat(value, activityScene) {
      let result = '--'
      if (this.IS_RECHARGE_GIVE(activityScene)) {
        try {
          result = JSON.parse(value).map((item) => item.use_gas_type_name).join('、')
        } catch (error) {
          result = value ?? result
        }
      }
      return result
    },

    // 是否是充值场景
    IS_RECHARGE_GIVE(value) {
      return value === activitySceneField.RECHARGE_GIVE
    },

    // 是否是缴费减免场景
    IS_CHARGE_DE(value) {
      return value === activitySceneField.CHARGE_DE
    },

    // 是否是百分比活动金额方式
    IS_BFBJE(value) {
      return value === activityMoneyTypeField.BFBJE
    },

    // 是否是固定金额活动金额方式
    IS_GDJE(value) {
      return value === activityMoneyTypeField.GDJE
    },

    // 是否是不固定金额活动金额方式
    IS_BGDJE(value) {
      return value === activityMoneyTypeField.BGDJE
    },
  }
}
</script>

<style scoped lang="scss">
  .buy-gas-limit-page {
    ::v-deep .operation-box {
      margin-bottom: 10px;
    }
  }
</style>
