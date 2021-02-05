<!--远程控制-->
<template>
  <div class="remote-control-page">
    <!--当前用气类型信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">控制</span>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item v-if="meterInfo && meterInfo.useGasTypeName" :label="$t('meterInfo.useGasTypeName')">
          <p>{{ meterInfo.useGasTypeName }}</p>
        </el-form-item>
        <el-form-item v-if="isMeterMode()" label=" ">
          <el-button type="primary" :disabled="btnLoading" class="width100" @click="handleIssuedGasPricePlan">{{ $t('button.issuedGasPricePlan') }}</el-button>
        </el-form-item>
        <el-form-item label=" ">
          <el-button type="primary" :disabled="btnLoading" class="width100" @click="handleValveControl('10')">{{ $t('button.openValve') }}</el-button>
        </el-form-item>
        <el-form-item label=" ">
          <el-button type="primary" :disabled="btnLoading" class="width100" @click="handleValveControl('00')">{{ $t('button.closeValve') }}</el-button>
        </el-form-item>
        <el-form-item v-if="IS_CENTER_RECHARGE(meterInfo)" label=" ">
          <el-button type="primary" :disabled="btnLoading" class="width100" @click="handleValveControl('01')">{{ $t('button.forceCloseValve') }}</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!--指令信息-->
    <el-card shadow="never" class="no-border" style="margin-top: 15px">
      <div slot="header">
        <span class="card-title">指令信息</span>
      </div>
      <command-list ref="commandListRef" :filter-data="meterInfo ? { meterNo: meterInfo.gasCode } : {}"></command-list>
    </el-card>
  </div>
</template>

<script>
import meterMixin from '@/mixins/meter'
import commandApi from '@/api/maintain/command'
import CommandList from '@/views/gmis/maintain/command/components/List.vue'

export default {
  name: 'RemoteControl',
  components: {
    CommandList
  },
  mixins: [meterMixin],
  props: {
    // 气表信息
    meterInfo: {
      type: Object,
      default: () => ({})
    },
    // 客户信息
    customerInfo: {
      type: Object,
      default: () => ({})
    },
  },
  data() {
    return {
      btnLoading: false,
    }
  },
  methods: {
    // 下发调价指令
    handleIssuedGasPricePlan() {
      this.btnLoading = true
      commandApi.changePricePlan({ gasMeterNumber: this.meterInfo.gasMeterNumber, gasMeterCode: this.meterInfo.gasCode, curGasTypeId: this.meterInfo?.useGasTypeId, customerCode: this.meterInfo.customerCode ?? this.customerInfo.customerCode }).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success('下发调价方案指令成功')
          this.$refs.commandListRef.refreshData()
        }
      })
      .catch(() => {})
      .finally(() => { this.btnLoading = false })
    },
    // 阀控指令
    handleValveControl(code) {
      let msg = ''
      // 控制码:00-关阀, 01强制关阀，10-开阀
      if (code === '00') {
        msg = this.$t('meterInfo.iot.closeValveSuccess')
      } else if (code === '01') {
        msg = this.$t('meterInfo.iot.forceCloseValveSuccess')
      } else {
        msg = this.$t('meterInfo.iot.openValveSuccess')
      }
      this.$confirm('您确定要执行此操作吗？', '提示', {
        type: 'warning'
      }).then(() => {
        this.btnLoading = true
        commandApi.valveControl([{ controlCode: code, gasMeterNumber: this.meterInfo.gasMeterNumber }]).then((response) => {
          const { isSuccess } = response.data
          if (isSuccess) {
            this.$message.success(msg)
            this.$refs.commandListRef.refreshData()
          }
        })
        .catch(() => {})
        .finally(() => { this.btnLoading = false })
      }).catch(() => {})
    },
  }
}
</script>

<style lang="scss" scoped>
  // 设置表格头部背景
  ::v-deep .el-table th {
    background-color: #f5f7fa !important;
  }

  .el-form-item {
    width: calc(100% / 5);
  }
  .remote-control-page {
    ::v-deep {
      .Command-list {
        .searchBox {
          .right {
            margin-bottom: 15px;
          }
        }
      }
    }
  }
</style>
