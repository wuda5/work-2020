<!-- 补抄数据 新增抄表数据 -->
<template>
  <div v-loading="loading" class="fixReadMeter-page">
    <!--搜索区域-->
    <search-box v-if="!isFix" class="search-box ">
      <el-form ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
        <!-- 客户编号 -->
        <el-form-item label="" prop="customerCode">
          <el-input v-model="queryParams.model.customerCode" name="customerCode" clearable :placeholder="$t('customerInfo.customerCode')" />
        </el-form-item>
        <!-- 客户姓名 -->
        <el-form-item label="" prop="customerName">
          <el-input v-model="queryParams.model.customerName" name="customerName" clearable :placeholder="$t('customerInfo.customerName')" />
        </el-form-item>
        <!-- 联系电话 -->
        <!-- <el-form-item label="" prop="telphone">
          <el-input v-model="queryParams.model.telphone" name="telphone" clearable :placeholder="$t('customerInfo.telphone')" />
        </el-form-item> -->
        <!-- 客户类型 -->
        <!-- <el-form-item label="" prop="customerTypeCode">
          <el-select v-model="queryParams.model.customerTypeCode" name="customerTypeCode" clearable :placeholder="$t('customerInfo.customerTypeCode')">
            <el-option v-for="(value, key) in userTypeMap" :key="key" :label="value" :value="key" />
          </el-select>
        </el-form-item> -->
        <!-- 用气类型 -->
        <el-form-item label="" prop="useGasTypeName">
          <el-input v-model="queryParams.model.useGasTypeName" name="useGasTypeName" clearable :placeholder="$t('meterInfo.useGasTypeName')" />
        </el-form-item>
        <!-- 表身号 -->
        <el-form-item label="" prop="gasMeterNumber">
          <el-input v-model="queryParams.model.gasMeterNumber" name="gasMeterNumber" clearable :placeholder="$t('meterInfo.gasMeterNumber')" />
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item label="" prop="gasMeterAddress">
          <el-input v-model="queryParams.model.gasMeterAddress" name="gasMeterAddress" clearable :placeholder="$t('meterInfo.moreGasMeterAddressPlaceholder')" />
        </el-form-item>
        <el-form-item label="" prop="" style="marginLeft: 10px">
          <el-button type="primary" name="userInfo-search" icon="el-icon-search" class="search-btn userInfo-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
          <el-button type="warning" name="userInfo-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="resetSearch('searchFormRef')">{{ $t('reset') }}</el-button>
        </el-form-item>
      </el-form>
    </search-box>

    <!-- 抄表数据审核 -->
    <el-card shadow="never">
      <div slot="header">
        <search-box style="margin-bottom: 0">
          <div slot="left">
            <span class="card-title">{{ isFix ? '异常数据列表' : '异常数据列表' }}</span>
          </div>
          <div slot="right">
            <!-- <el-button v-if="isFix" type="primary" @click="handleBatchFixCommand">发送补抄数据指令</el-button> -->
            <!-- <el-tooltip v-if="!isFix" content="针对以下展示异常数据批量发送补抄数据指令, 指令执行到数据上报会有一定延迟，请悉知" placement="bottom">
              <el-button v-if="!isFix" type="primary" :disabled="list.length === 0" @click="handleBatchFixCommand">发送补抄数据指令</el-button>
            </el-tooltip> -->
            <!-- <el-tooltip v-if="!isFix" content="针对以下展示异常数据批量填充以往上报数据" placement="bottom">
              <el-button v-if="!isFix" type="primary" :disabled="list.length === 0" @click="handleBatchAutoFill">上期数据自动填充</el-button>
            </el-tooltip> -->
            <el-tooltip content="保存以下展示异常数据中已经纠正的数据，即绿色高亮行数据" placement="bottom">
              <el-button type="success" :disabled="validReadMeterData.length === 0" @click="handleBatchSave">{{ isFix ? '保存已纠错数据' : '保存新增数据' }}</el-button>
            </el-tooltip>
          </div>
        </search-box>
      </div>
      <p class="text-danger mt0" style="marginTop: 0">*点击【{{ isFix ? '保存已纠错数据' : '保存新增数据' }}】只会保存以下绿色高亮行的数据</p>

      <!-- list -->
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        border
        :highlight-current-row="false"
        :data="list"
        tooltip-effect="dark"
        :row-class-name="setRowClassName"
      >
        <el-table-column type="index" label="#" width="40" />
        <el-table-column prop="customerName" label="客户姓名" />
        <el-table-column prop="gasMeterNumber" show-overflow-tooltip label="表身号" width="120" />
        <el-table-column prop="useGasTypeName" show-overflow-tooltip label="用气类型名称	" />
        <el-table-column prop="gasMeterAddress" show-overflow-tooltip label="户表地址" />
        <el-table-column prop="lastTotalGas" label="上期止数" width="90">
          <template slot-scope="{ row }">
            <el-input v-model.number="row.lastTotalGas" type="number" @input="handleInput(row)" @blur="handleBlur(row)"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="currentTotalGas" label="本期止数" width="90">
          <template slot-scope="{ row }">
            <el-input v-model.number="row.currentTotalGas" type="number" @input="handleInput(row)" @blur="handleBlur(row)"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="monthUseGas" label="本期用量" width="90">
          <template slot-scope="{ row }">
            <el-input v-model.number="row.monthUseGas" type="number" @input="handleMonthUseGasInput(row)" @blur="handleMonthUseGasBlur(row)"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="readMeterUserName" show-overflow-tooltip label="抄表员" width="150">
          <template slot-scope="{ row }">
            <el-select v-model.number="row.readMeterUserName" name="readMeterUserName" allow-create filterable remote :remote-method="handleSearchReadMeterUser" :loading="userListLoading" clearable :placeholder="$t('searchPlaceholder')" @blur="handleReadMeterUserNameBlur(row)" @change="handleReadMeterUserChange(row.readMeterUserName, row)">
              <el-option v-for="(item, index) in userList" :key="index" :label="item.name" :value="item.name" />
            </el-select>
          </template>
        </el-table-column>
        <el-table-column prop="recordTime" label="抄表日期" width="160">
          <template slot-scope="{row}">
            <el-date-picker
              v-model="row.recordTime"
              type="date"
              placeholder="选择日期" 
              style="width: 130px"
              value-format="yyyy-MM-dd"
              @change="handleRecordTimeBlur(row)"
              @blur="handleRecordTimeBlur(row)"
            />
          </template>
        </el-table-column>
        <!-- 异常信息 -->
        <el-table-column prop="reviewObjection" show-overflow-tooltip label="异常信息" />
        <!-- 数据状态 -->
        <el-table-column prop="dataStatus" label="状态" show-overflow-tooltip width="110" fixed="right">
          <template slot-scope="{ row }">
            {{ row.dataStatus | dataStatusFormat }}
          </template>
        </el-table-column>
        <!-- 操作 -->
        <!-- <el-table-column label="操作" width="80">
          <template slot-scope="{ row, $index }">
            <el-button type="primary" @click="edit($index, row)">编辑</el-button>
          </template>
        </el-table-column> -->
      </el-table>

      <!--分页-->
      <pagination
        :page-sizes="[10, 15, 20, 30, 50]"
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="handleGetList"
      />
    </el-card>
  </div>
</template>

<script>
import { cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import userApi from '@/api/User'
import iotApi from '@/api/readMeter/iot.js'
import { dataStatusField, deleteStatusField } from '@/enums/common'
import { processField, chargeStatusField, processMap, iotDataStatusMap } from '@/enums/readMeter'
import { parseTime } from '@/utils/index'
import { parseDate2Str } from '@/utils/commons.js'
import { positiveNumberReg } from '@/utils/reg'

export default {
  name: 'FixReadMeter',
  components: {},
  filters: {
    dataStatusFormat(value) {
      return iotDataStatusMap[+value]
    }
  },
  mixins: [commonMixin, listMixin],
  props: {
    // 需要补抄的数据
    readMeterData: {
      type: Array,
      default: () => ([])
    },
  },
  data() {
    return {
      //查询参数设置
      queryParams: this.initQueryParams({
        model: {
          customerCode: null,
          customerName: null,
          telphone: null,
          customerTypeCode: null,
          useGasTypeId: null,
          useGasTypeName: null,
          gasCode: null,
          moreGasMeterAddress: null,
          gasMeterAddress: null,
          gasMeterNumber: null,
          dataStatus: null,
          deleteStatus: deleteStatusField.DELETE_INVALID
        },
        size: 15
      }),
      userListLoading: false,
      userList: [],
      validReadMeterData: [], // 有效纠正过的数据
    }
  },
  computed: {
    // 是否是补抄状态
    isFix() {
      return Array.isArray(this.readMeterData) && this.readMeterData.length > 0
    },
    // 用户名
    userinfo() {
      return this.$store.state?.account?.user || {};
    },
  },
  watch: {
    list: {
      handler(list) {
        this.validReadMeterData = list.filter((item) => item.isValid)
      },
      deep: true,
      immediate: false,
    },
  },
  created() {
    // console.log('sfdf')
    this.initData()
  },
  methods: {

    // 设置默认的数据字段
    setInitRowInfo(row = {}) {
      const defaultRow = {
        id: null,
        customerName: null,
        customerCode: null,
        customerId: null,
        currentTotalGas: null,
        lastTotalGas: null,
        monthUseGas: null,
        cycleTotalUseGas: null,
        gasMeterAddress: null,
        gasMeterCode: null,
        gasMeterName: null,
        gasMeterNumber: null,
        dataStatus: null,
        processStatus: {
          code: processField.TO_BE_REVIEWED,
          desc: null,
        },
        chargeStatus: {
          code: null,
          desc: null,
        },
        recordTime: parseTime(+new Date(), '{y}-{m}-{d}'),
        readMeterUserId: this.userinfo?.id || null,
        readMeterUserName: this.userinfo?.name || null,
        useGasTypeId: null,
        useGasTypeName: null,
      }
      const result = {}
      for (let key in defaultRow) {
        if (row[key]) {
          result[key] = row[key]
        } else {
          result[key] = defaultRow[key]
        }
      }

      return result
    },

    // 初始化数据
    async initData() {
      this.getValidUserList()
      if (this.isFix) {
        this.total = this.readMeterData.length
        const cloneReadMeterData = cloneDeep(this.readMeterData).map((item) => {
          return this.setInitRowInfo(item)
        })
        this.list = cloneReadMeterData
      } else {
        await this.getList()
      }
    },

    // 获取数据列表
    async getList (params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        iotApi.abnormalPage(this.queryParams)
          .then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              const { total, records } = data
              this.total = total
              const cloneData = cloneDeep(records).map((item) => (this.setInitRowInfo(item)))
              this.list = cloneData
            }
            resolve(isSuccess)
          })
          .catch(() => (resolve(false)))
          .finally(() => (this.listLoading = false))
      })
    },

    // 计算各气量之间的关系
    isValidGas(row, canFillValue = true, showErrMsg = true) {
      const lastTotalGas = +row.lastTotalGas
      const currentTotalGas = +row.currentTotalGas
      const monthUseGas = +row.monthUseGas
      let result
      if (positiveNumberReg.test(row.lastTotalGas) && positiveNumberReg.test(row.currentTotalGas)) {
        // console.log(currentTotalGas, lastTotalGas)
        if (currentTotalGas < lastTotalGas) {
          result = false
          showErrMsg && this.$message.error('本期止数不能小于上期止数')
        } else if(currentTotalGas === 0) {
          result = false
          showErrMsg && this.$message.error('本期止数必须大于0')
        } else {
          if (canFillValue) {
            result = true
            row.monthUseGas = currentTotalGas - lastTotalGas
          } else {
            if (monthUseGas && currentTotalGas - lastTotalGas !== monthUseGas) {
              result = false
              showErrMsg && this.$message.error('本期止数和本期用量之和必须等于上期止数')
            } else {
              result = true
            }
          }
        }
      } else if (!row.readMeterUserName) {
        // result = false
        // showErrMsg && this.$message.error('请输入抄表员')
      } else if (!row.recordTime) {
        // result = aflse
        // showErrMsg && this.$message.error('请输入抄表时间')
      }
      row.isValid = result
      return result
    },

    // 验证抄表人员
    isValidReadMeterUserName(row, showErrMsg = true) {
      if (!row.readMeterUserName) {
        row.isValid = false
        showErrMsg && this.$message.error('请输入抄表员')
      } else {
        row.isValid = true
      }
      return row.isValid
    },

    // 验证抄表时间
    isValidRecordTime(row, showErrMsg = true) {
      if (!row.recordTime) {
        row.isValid = false
        showErrMsg && this.$message.error('请输入抄表时间')
      } else {
        row.isValid = true
      }
      return row.isValid
    },
    
    // 输入框失焦判断
    handleBlur(row) {
      this.isValidGas(row, true, true) && this.isValidReadMeterUserName(row) && this.isValidRecordTime(row)
    },
    
    // 输入框失焦判断
    handleInput(row) {
      this.isValidGas(row, true, false) && this.isValidReadMeterUserName(row, false) && this.isValidRecordTime(row, false)
    },

    // 本期用量输入框input值改变
    handleMonthUseGasInput(row) {
      this.isValidGas(row, false, false) && this.isValidReadMeterUserName(row, false) && this.isValidRecordTime(row, false)
    },

    // 本期用量输入框失去焦点
    handleMonthUseGasBlur(row) {
      this.isValidGas(row, false, true) && this.isValidReadMeterUserName(row) && this.isValidRecordTime(row)
    },

    // 抄表员输入框失去焦点
    handleReadMeterUserNameBlur(row) {
      this.isValidReadMeterUserName(row) && this.isValidGas(row) && this.isValidRecordTime(row)
    },

    // 抄表时间输入框失去焦点
    handleRecordTimeBlur(row) {
      this.isValidRecordTime(row) && this.isValidGas(row) && this.isValidReadMeterUserName(row)
    },

    // 批量补抄数据
    handleBatchFixCommand() {
      this.loading = true
      iotApi.batchSendFixCommand(this.list.map((item) => ({ gasMeterNumber: item.gasMeterNumber }))).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success('补抄指令发送成功')
          if (!this.isFix) {
            this.getList()
          }
          // 回调
          this.$emit('success', this.isFix)
        }
      })
      .catch(() => {})
      .finally(() => (this.loading = false))
    },
    // 批量自动填充数据
    handleBatchAutoFill() {
      this.loading = true
      iotApi.batchAutoFill(this.list.map((item) => ({ gasMeterNumber: item.gasMeterNumber }))).then((response) => {
        // console.log('response', response)
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success('自动填充上次抄表数据成功')
          if (!this.isFix) {
            this.getList()
          }
          // 回调
          this.$emit('success')
        }
      })
      .catch((err) => {
        console.log('err', err)
      })
      .finally(() => (this.loading = false))
    },
    // 批量保存纠错数据
    async handleBatchSave() {
      const readMeterData = this.validReadMeterData
      if (readMeterData.length === 0) {
        this.$message.error('当前没有可保存数据。')
        return
      }
      this.loading = true
      iotApi.updateList(readMeterData, this.isFix).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          let msg = '新增抄表数据成功'
          if (this.isFix) {
            msg = '保存纠错数据成功'
          }
          this.$message.success(msg)
          if (!this.isFix) {
            this.getList()
          } else {
            this.readMeterData.forEach((item) => {
              const index = this.list.findIndex((listItem) => listItem.id === item.id)
              if (index !== -1) {
                this.list.splice(index, 1)
              }
            })
          }
          this.$nextTick(() => {
            // 回调
            this.$emit('success', this.isFix)
          })
        }
      })
      .catch(() => {})
      .finally(() => (this.loading = false))
      
    },

    // 获取用户列表
    getValidUserList() {
      if (this.userList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        userApi.page(this.initQueryParams({
          model: {
            dataStatus: dataStatusField.VALID
          },
          size: 10000,
        })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.userList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    
    // 输入名字搜索数据
    handleSearchReadMeterUser(value) {
      if (value !== '') {
        this.userListLoading = true
        setTimeout(() => {
          this.userListLoading = false
          this.userList = this.userList.filter((item) => item.name.includes(value.trim()))
        }, 200)
      }
    },

    // 抄表员发生变化
    handleReadMeterUserChange(value, row) {
      this.handleReadMeterUserNameBlur(row)
      const user = this.userList.find((item) => item.name === value)
      row.readMeterUserId = user?.id ?? null
    },

    // 设置行classname
    setRowClassName({row, rowIndex}) {
      // console.log('index', rowIndex)
      if (row.isValid === false) {
        return 'danger-row'
      } else if(row.isValid === true) {
        return 'success-row'
      } else {
        return ''
      }
    },
  },
}
</script>

<style lang="scss" scoped>
  .fixReadMeter-page {
    ::v-deep {
      table {
        .el-input {
          .el-input__inner {
            padding: 0 5px;
          }
          &.el-date-editor {
            .el-input__inner {
              padding-left: 30px;
            }
          }
        }
      }
    }
  }
</style>