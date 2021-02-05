<!--用气类型变更-->
<template>
  <div class="ChangeGasType-page">
    <!--当前用气类型信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">当前用气类型信息</span>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="当前用气类型">
          <p>{{ meterInfo.useGasTypeName || '--' }}</p>
        </el-form-item>
        <el-form-item label="周期累计用气量">
          <p>{{ meterStatus.cycleUseGas || '--' }}</p>
        </el-form-item>
      </el-form>
    </el-card>

    <!--变更信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">变更信息</span>
      </div>
      <el-form :model="chargeForm" inline label-position="top" class="qc-form clearfix">
        <!-- 用气类型 -->
        <el-form-item label="用气类型" prop="" style="width: 200px">
          <el-select v-model="chargeForm.useGasTypeId" name="useGasTypeId" :placeholder="$t('meterInfo.useGasTypeName')" @change="handleUseGasTypeChange">
            <el-option v-for="(item, index) in validUseGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id" />
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="周期累计量控制">
            <el-select v-model="chargeForm.reset" name="useGasTypeId" :placeholder="$t('请选择')">
              <el-option v-for="(value, key) in cycleSumControlMap" :key="key" :label="value" :value="+key" />
            </el-select>
        </el-form-item> -->
        <el-form-item label=" ">
          <el-button type="primary" class="width100" :loading="submitLoading" :disabled="submitLoading" @click="handleSubmit">变更</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!--变更记录-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">变更记录</span>
      </div>
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        :border="false"
        :highlight-current-row="false"
        :data="list"
        tooltip-effect="dark"
        style="margin-top: 10px; width: 100%; border:1px solid #eee"
      >
        <el-table-column
          prop="changeTime"
          label="变更时间"
          width="130"
        >
          <template #default="{ row }">
            {{ row.changeTime | parseTime }}
          </template>
        </el-table-column>
        <el-table-column
          prop="oldGasTypeName"
          label="变更前类型"
        />
        <el-table-column
          prop="newGasTypeName"
          label="变更后类型"
        />
        <!-- <el-table-column
          prop="cycleSumControl"
          label="周期累计量控制"
        >
          <template #default="{ row }">
            {{ row.cycleSumControl | cycleSumControlFormat }}
          </template>
        </el-table-column> -->
        <el-table-column
          prop="operator"
          label="操作员"
        />
        <el-table-column
          prop="businessBallName"
          label="营业厅"
          show-overflow-tooltip
        />
      </el-table>
    </el-card>

  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { dataStatusField } from '@/enums/common'
import { cycleSumControlMap, cycleSumControlField } from '@/enums/meterInfo'
import { getUseGasTypeChangeList, getGasMeterDetails, saveUseGasTypeChange } from '@/api/meterInfo'
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  name: 'ChangeGasType',
  components: {
  },
  filters: {
    cycleSumControlFormat(value) {
      return cycleSumControlMap[+value]
    }
  },
  mixins: [commonMixin, listMixin],
  props: {
    meterInfo: {
      type: Object,
      required: true,
      default: () => ({})
    }
  },
  data() {
    return {
      cycleSumControlMap,
      ...this.initListData({
        size: 20,
        queryParams: this.initQueryParams({
          model: {
            dataStatus: dataStatusField.VALID
          }
        })
      }),
      // 用气类型变更表单
      chargeForm: {
        gasMeterCode: null,
        reset: cycleSumControlField.CLEARED,
        useGasTypeId: null,
        useGasTypeName: null,
      },
      useGasTypeList: [], // 用气类型
      meterStatus: {},
      submitLoading: false,
    }
  },
  computed: {
    validUseGasTypeList() {
      return this.useGasTypeList.filter((item) => item.id !== this.meterInfo?.useGasTypeId)
    }
  },
  watch: {
    // 监听气表基本信息
  },
  created() {
    this.initData()
  },
  methods: {

    async initData() {
      this.loading = true
      this.queryParams.gasCode = this.meterInfo.gasCode
      this.chargeForm.gasMeterCode = this.meterInfo.gasCode
      await this.getMeterStatusData()
      await this.getValidUseGasTypeList()
      await this.getList()
      this.loading = false
    },
    
    // 获取数据列表
    async getList (params) {
      return new Promise((resolve) => {
        this.listLoading = true
        getUseGasTypeChangeList({ ...this.queryParams.model, size: 20, gasCode: this.meterInfo.gasCode })
          .then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              // const { total, records } = data
              // this.total = total
              this.list = data
            }
            resolve(isSuccess)
          })
          .catch(() => (resolve(false)))
          .finally(() => (this.listLoading = false))
      })
    },

    // 获取用气类型列表
    getValidUseGasTypeList() {
      return new Promise((resolve) => {
        getUseGasTypeList(this.initQueryParams({model: {dataStatus: dataStatusField.VALID}, size: 10000})).then((result) => {
          const {isSuccess, data} = result.data
          if (isSuccess) {
            const {records} = data
            this.useGasTypeList = records
            const defaultUseGasType = records[0]
            // this.chargeForm.useGasTypeId = defaultUseGasType?.id || null
            // this.chargeForm.useGasTypeName = defaultUseGasType?.useGasTypeName || null
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 获取气表详细信息
    getMeterStatusData() {
      return new Promise((resolve) => {
        getGasMeterDetails({ gasMeterCode: this.meterInfo.gasCode }).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.meterStatus = data.gasMeterInfo || {}
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => {

        })
      })
    },

    // 用气类型改变
    handleUseGasTypeChange(value) {
      const data = this.useGasTypeList.find((item) => item.id === value)
      if (data) {
        this.chargeForm.useGasTypeName = data.useGasTypeName
      }
    },

    // 提交表单
    handleSubmit() {
      this.submitLoading = true
      saveUseGasTypeChange(this.chargeForm).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success('变更用气类型操作成功') 
          // 回调事件
          this.$emit('success')
        }
      })
      .catch(() => {})
      .finally(() => (this.submitLoading = false))
    }

  }
}
</script>

<style lang="scss" scoped>
  // 设置表格头部背景
  ::v-deep .el-table th {
    background-color: #f5f7fa !important;
  }

  .ChangeGasType-page{
    ::v-deep {
      .el-form-item {
        width: calc(100% / 5);
      }
    }
  }
</style>
