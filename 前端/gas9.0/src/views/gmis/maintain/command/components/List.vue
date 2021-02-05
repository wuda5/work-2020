<!-- 指令维护 -->
<template>
  <div class="Command-list">
      <!--搜索-->
      <search-box class="search-box">
        <template v-slot:left>
          <el-form :ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
            <el-form-item v-if="(filterData && !filterData.meterNo) || !filterData" label="" prop="meterNo">
              <!--表编号-->
              <el-input
                v-model="queryParams.model.meterNo"
                :placeholder="$t('maintain.command.meterNo')"
                clearable
                class="filter-item search-item"
              />
            </el-form-item>
            <el-form-item label="" prop="transactionNo">
              <!--流水号-->
              <el-input
                v-model="queryParams.model.transactionNo"
                :placeholder="$t('maintain.command.transactionNo')"
                clearable
                class="filter-item search-item"
              />
            </el-form-item>
            <el-form-item label="" prop="commandType">
              <!--指令类型-->
              <el-select v-model="queryParams.model.commandType" filterable clearable :placeholder="$t('maintain.command.commandType')">
                <el-option v-for="(value, key) in commandTypeMap" :key="key" :label="value" :value="key"></el-option>
              </el-select>
            </el-form-item>
            <!--指令执行阶段-->
            <!-- <el-form-item label="" prop="commandStage">
              <el-select v-model="queryParams.model.commandStage" filterable clearable :placeholder="$t('maintain.command.commandStage')">
                <el-option v-for="(value, key) in commandExecuteStageMap" :key="key" :label="value" :value="key"></el-option>
              </el-select>
            </el-form-item> -->
            <el-form-item label="" prop="executeResult">
              <!--指令执行状态-->
              <el-select v-model="queryParams.model.executeResult" filterable clearable :placeholder="$t('maintain.command.commandStatus')">
                <el-option v-for="(value, key) in commandExecuteResultMap" :key="key" :label="value" :value="key"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="" prop="commandStatus">
              <!--指令执行结果-->
              <el-select v-model="queryParams.model.commandStatus" filterable clearable :placeholder="$t('maintain.command.executeResult')">
                <el-option v-for="(value, key) in commandExecuteStatusMap" :key="key" :label="value" :value="key"></el-option>
              </el-select>
            </el-form-item>
            <!--指令发送时间-->
            <!-- <el-form-item label="" prop="sendTime">
              <el-date-picker
                v-model="queryParams.model.sendTime"
                type="daterange"
                clearable
                :range-separator="$t('to')"
                :start-placeholder="$t('maintain.command.sendTimeStart')"
                :end-placeholder="$t('maintain.command.sendTimeEnd')"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd"
              >
              </el-date-picker>
            </el-form-item> -->
            <!--指令执行时间-->
            <el-form-item label="" prop="executeTime">
              <el-date-picker
                v-model="queryParams.model.executeTime"
                type="daterange"
                clearable
                :range-separator="$t('to')"
                :start-placeholder="$t('maintain.command.executeTimeStart')"
                :end-placeholder="$t('maintain.command.executeTimeEnd')"
                :picker-options="pickerOptions"
                value-format="yyyy-MM-dd"
              >
              </el-date-picker>
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
          <!--批量重试-->
          <el-button v-has-permission="['command:retry']" :disabled="batchRetryCommand.length === 0 || btnLoading" class="batchRetry-btn" name="batchRetry-btn" type="primary" @click.native="handleBatchRetry()">{{ $t('maintain.command.batchRetry') }}</el-button>
          <!--批量取消执行-->
          <el-button v-has-permission="['command:cancel']" :disabled="batchCancelCommand.length === 0 || btnLoading" class="batchCancel-btn" name="batchCancel-btn" type="danger" @click.native="handleBatchCancel()">{{ $t('maintain.command.batchCancel') }}</el-button>
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
        @row-click="handleRowClick"
        @selection-change="handleSelectionChange"
      >
        <!-- 多选框 -->
        <el-table-column
          align="center"
          type="selection"
          width="40px" 
          :reserve-selection="false" 
          :selectable="setSelectable"
        />
        <!--指令流水号-->
        <el-table-column
          :label="$t('maintain.command.transactionNo')"
          :show-overflow-tooltip="true"
          prop="transactionNo"
          width="80px" 
        />
        <!-- 指令类型	-->
        <el-table-column
          :label="$t('maintain.command.commandType')"
          :show-overflow-tooltip="true"
          prop="commandType"
          width="200" 
        >
          <template #default="{ row }">
            {{ commandTypeMap[row.commandType] }}
          </template>
        </el-table-column>
        <!--表编号-->
        <el-table-column
          :label="$t('maintain.command.meterNo')"
          :show-overflow-tooltip="true"
          prop="meterNo"
          width="200px" 
        />
        <!-- 指令执行阶段	-->
        <el-table-column
          :label="$t('maintain.command.commandStage')"
          :show-overflow-tooltip="true"
          prop="commandStage"
        >
          <template #default="{ row }">
            {{ row.commandStage | commandExecuteStage }}
          </template>
        </el-table-column>
        <!-- 指令执行状态	-->
        <el-table-column
          :label="$t('maintain.command.commandStatus')"
          :show-overflow-tooltip="true"
          prop="executeResult"
        >
          <template #default="{ row }">
            {{ commandExecuteResultMap[+row.executeResult] }}
          </template>
        </el-table-column>
        <!-- 指令执行结果	-->
        <el-table-column
          :label="$t('maintain.command.executeResult')"
          :show-overflow-tooltip="true"
          prop="commandStatus"
        >
          <template #default="{ row }">
            {{ commandExecuteStatusMap[+row.commandStatus] }}
          </template>
        </el-table-column>
        <!-- 指令执行异常描述	-->
        <el-table-column
          :label="$t('maintain.command.errorDesc')"
          :show-overflow-tooltip="true"
          prop="errorDesc"
        >
        </el-table-column>
        <!-- 指令发送时间	-->
        <el-table-column
          :label="$t('maintain.command.sendTime')"
          :show-overflow-tooltip="true"
          prop="sendTime"
          sortable
        >
          <template #default="{ row }">
            {{ row.executeTime | parseTime }}
          </template>
        </el-table-column>
        <!-- 指令执行时间	-->
        <el-table-column
          :label="$t('maintain.command.executeTime')"
          :show-overflow-tooltip="true"
          prop="executeTime"
          sortable
        >
          <template #default="{ row }">
            {{ row.executeTime | parseTime }}
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column
          fixed="right"
          :label="$t('table.operation')"
          width="200"
        >
          <template #default="{ row }">
            <!--重试-->
            <el-button v-if="canRetryExec(row)" v-has-permission="['command:retry']" :disabled="btnLoading" class="retry-btn" name="retry-btn" type="primary" @click.native="handleRetry(row)">{{ $t('maintain.command.retry') }}</el-button>
            <!--取消执行-->
            <el-button v-if="canCancelExec(row)" v-has-permission="['command:cancel']" :disabled="btnLoading" class="cancel-btn" name="cancel-btn" type="danger" @click.native="handleCancel(row)">{{ $t('maintain.command.cancel') }}</el-button>
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
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import commandApi from '@/api/maintain/command'
import { commandTypeMap, commandExecuteStatusField, commandExecuteStatusMap, commandExecuteResultField, commandExecuteResultMap, commandExecuteStageField, commandExecuteStageMap } from '@/enums/meterInfo'
import { initQueryParams } from '@/utils/commons'
import { awaitToJs } from '@/utils/index'

export default {
  name: 'Commandlist',
  components: {
  },
  filters: {
    commandExecuteStage(value) {
      return commandExecuteStageMap[+value]
    },
  },
  mixins: [commonMixin, listMixin],
  props: {
    // 自定义的筛选条件
    filterData: {
      type: Object,
      default: () => ({})
    },
  },
  data () {
    return {
      ...this.initListData({
        queryParams: initQueryParams({
          model: {
            commandStatus: null,
            commandType: null,
            createTime: null,
            executeResult: null,
            executeTime: null,
            commandStage: null,
            meterNo: null,
            sendTime: null,
            transactionNo: null,
          }
        })
      }),
      commandTypeMap,
      commandExecuteStatusMap,
      commandExecuteResultMap,
      commandExecuteStageMap,
      pickerOptions: {
        shortcuts: [{
          text: '最近一周',
          onClick(picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近一个月',
          onClick(picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近三个月',
          onClick(picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
            picker.$emit('pick', [start, end])
          }
        }]
      }
    }
  },
  computed: {
    // 可以批量重试的指令
    batchRetryCommand() {
      return this.multipleSelection.filter((item) => this.canRetryExec(item))
    },
    // 可以批量取消的指令
    batchCancelCommand() {
      return this.multipleSelection.filter((item) => this.canCancelExec(item))
    },
  },
  async created () {
    await this.getList(this.filterData)
  },
  mounted () {
  },
  methods: {
    // 获取数据列表
    async getList (params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        const { current, size, model } = this.queryParams
        commandApi.page({ pageNo: current, pageSize: size, ...model, ...params })
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

    // 是否可以执行重试指令操作
    canRetryExec(row) {
      return ![commandExecuteStatusField.SUCCESS, commandExecuteStatusField.RECHARGED].includes(+row.commandStatus) || !row.transactionNo
    },

    // 是否可以执行取消指令操作
    canCancelExec(row) {
      return [commandExecuteStageField.WaitSend, commandExecuteStageField.SendToNet, commandExecuteStageField.SendToDevice].includes(+row.commandStage) && ![commandExecuteResultField.RESULT_SUCCESS].includes(+row.executeResult)
    },

    // 指令重试操作
    commandRetry(data) {
      return new Promise((resolve) => {
        this.btnLoading = true
        commandApi.retry(data).then((response) => {
          const { isSuccess } = response.data
          if (isSuccess) {
            this.$message.success(this.$t('maintain.command.retrySuccess'))
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
        .finally(() => {
          this.btnLoading = false
        })
      })
    },

    // 指令取消执行操作
    commandCancel(data) {
      return new Promise((resolve) => {
        this.btnLoading = true
        commandApi.cancel(data).then((response) => {
          const { isSuccess } = response.data
          if (isSuccess) {
            this.$message.success(this.$t('maintain.command.cancelSuccess'))
            this.handleSearch()
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
        .finally(() => {
          this.btnLoading = false
        })
      })
    },

    // 单条指令重新执行
    async handleRetry(row) {
      await this.commandRetry([{
        gasMeterNumber: row.meterNo,
        transactionNo: row.transactionNo,
        commandId: row.commandId,
      }])
    },

    // 多条指令重新执行
    async handleBatchRetry() {
      await this.commandRetry(this.batchRetryCommand.map((item) => ({ gasMeterNumber: item.meterNo, transactionNo: item.transactionNo,
        commandId: item.commandId })))
    },

    // 单条指令取消执行
    async handleCancel(row) {
      await this.commandCancel([{
        gasMeterNumber: row.meterNo,
        transactionNo: row.transactionNo,
      }])
    },

    // 多条指令取消执行
    async handleBatchCancel() {
      await this.commandCancel(this.batchCancelCommand.map((item) => ({ gasMeterNumber: item.meterNo, transactionNo: item.transactionNo, })))
    },

    // 刷新数据方法
    refreshData(filterData = {}) {
      this.getList(filterData)
    },

    // 设置是否可勾选
    setSelectable(row, index) {
      return this.canRetryExec(row) || this.canCancelExec(row)
    }
  }
}
</script>
<style lang="scss" scoped>
  .Command-list {
    ::v-deep {
      .el-date-editor {
        .el-range-separator {
          width: 26px;
        }
      }
    }
  }
</style>

