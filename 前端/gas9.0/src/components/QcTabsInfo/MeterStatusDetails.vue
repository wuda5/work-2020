<!--气表状态信息-->
<template>
  <div v-loading="loading" class="info-page MeterStatusDetails-page">
    <info-frame>
      <template v-slot:title>
        <div class="subTitle">{{ $t('meterInfo.meterStatus.detailsTitle') }}</div>
      </template>
      <!-- card -->
      <el-card shadow="never" class="no-border frameFormBody" :body-style="{ padding: '0 10px' }">
        <el-form label-position="top" class="qc-form clearfix show-info-form show-meterinfo-form" :inline="true">
          <!-- 物联网表显示内容 -->
          <template v-if="IS_INTERNET_GASMETER(showData)">
            <el-tag class="fr">物联网表</el-tag>
            <!-- 累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalUseGas')">
              <el-input :value="showData.totalUseGas" />
            </el-form-item>

            <!-- 表端累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.meterTotalGas')">
              <el-input :value="showData.meterTotalGas" />
            </el-form-item>

            <!-- 周期累计使用量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleUseGas')">
              <el-input :value="showData.cycleUseGas" />
            </el-form-item>
            <!-- 阀状态 -->
            <el-form-item :label="$t('meterInfo.meterStatus.valveState')">
              <el-input :value="showData.valveState | valveStateFormat" />
            </el-form-item>
            <!-- 报警器 -->
            <el-form-item :label="$t('meterInfo.meterStatus.alarm')">
              <el-input :value="showData.alarmStatus | alarmFormat" />
            </el-form-item>
            <!-- 当前阶梯 -->
            <el-form-item :label="$t('meterInfo.meterStatus.currentLadder')">
              <el-input :value="showData.currentLadder" />
            </el-form-item>
            <!-- 当前价格 -->
            <el-form-item :label="$t('meterInfo.meterStatus.currentPrice')">
              <el-input :value="showData.currentPrice" />
            </el-form-item>
            <!-- 气表余额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.gasMeterBalance')">
              <el-input :value="showData.gasMeterInBalance" />
            </el-form-item>
            <!-- 更新时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.updateTime')">
              <el-input :value="showData.updateTime | timeFormat" />
            </el-form-item>
            <!-- 异常信息 -->
            <el-form-item :label="$t('meterInfo.meterStatus.exceptionInfo')" style="width: 100%">
              <p v-for="(item,index) in showData.exceptionInfoList" :key="index" class="tag-exceptionInfo" type="danger">
                {{ item.alarmContent }}
              </p>
            </el-form-item>

          </template>
          <!-- 卡表（气量）显示内容 -->
          <template v-else-if="IS_CARD_GASMETER_OF_GAS(showData)">
            <el-tag class="fr">卡表（气量）</el-tag>
            <!-- 周期累计充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleChargeGas')">
              <el-input :value="showData.cycleUseGas" />
            </el-form-item>
            <!-- 累计充值气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeGas')">
              <el-input :value="showData.totalChargeGas" />
            </el-form-item>
            <!-- 累计充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeMoney')">
              <el-input :value="showData.totalChargeMoney" />
            </el-form-item>
            <!-- 累计充值次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeCount')">
              <el-input :value="showData.totalChargeCount" />
            </el-form-item>
            <!-- 累计补卡次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReplacementCardCount')">
              <el-input :value="showData.totalReplacementCardCount" />
            </el-form-item>
            <!-- 累计补气次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalAdditionalCount')">
              <el-input :value="showData.totalAdditionalCount" />
            </el-form-item>
            <!-- 上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value1')">
              <el-input :value="showData.value1" />
            </el-form-item>
            <!-- 上上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value2')">
              <el-input :value="showData.value2" />
            </el-form-item>
            <!-- 上上上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value3')">
              <el-input :value="showData.value3" />
            </el-form-item>
          </template>
          <!-- 卡表（金额）显示内容 -->
          <template v-else-if="IS_CARD_GASMETER_OF_MONEY(showData)">
            <el-tag class="fr">卡表（金额）</el-tag>
            <!-- 周期累计充值金额 -->
            <!-- <el-form-item :label="$t('meterInfo.meterStatus.cycleChargeMoney')">
              <el-input :value="showData.cycleUseGas" />
            </el-form-item> -->
            <!-- 累计充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeMoney')">
              <el-input :value="showData.totalChargeMoney" />
            </el-form-item>
            <!-- 累计充值次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeCount')">
              <el-input :value="showData.totalChargeCount" />
            </el-form-item>
            <!-- 累计补卡次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReplacementCardCount')">
              <el-input :value="showData.totalReplacementCardCount" />
            </el-form-item>
            <!-- 累计补气次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalAdditionalCount')">
              <el-input :value="showData.totalAdditionalCount" />
            </el-form-item>
            <!-- 上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value1')">
              <el-input :value="showData.value1" />
            </el-form-item>
            <!-- 上上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value2')">
              <el-input :value="showData.value2" />
            </el-form-item>
            <!-- 上上上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value3')">
              <el-input :value="showData.value3" />
            </el-form-item>
          </template>
          <!-- 普表显示内容 -->
          <template v-else>
            <el-tag class="fr">普表</el-tag>
            <!-- 累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalUseGas')">
              <el-input :value="showData.totalUseGas" />
            </el-form-item>
            <!-- 周期累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleUseGas')">
              <el-input :value="showData.cycleUseGas" />
            </el-form-item>
            <!-- 累计缴费次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalPayCount')">
              <el-input :value="showData.totalChargeCount" />
            </el-form-item>
            <!-- 累计抄表次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReadMeterCount')">
              <el-input :value="showData.totalReadMeterCount" />
            </el-form-item>
            <!-- 最后抄表时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastReadMeterTime')">
              <el-input :value="showData.lastReadMeterTime | timeFormat" />
            </el-form-item>
            <!-- 最后缴费时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastPayTime')">
              <el-input :value="showData.lastChargeTime | timeFormat" />
            </el-form-item>
            <!-- 最后抄表量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastReadMeterGas')">
              <el-input :value="showData.readMeterGas" />
            </el-form-item>
          </template>
        </el-form>
      </el-card>
    </info-frame>
  </div>
</template>
<script>
import {getGasMeterDetails} from '@/api/meterInfo/index'
import meterMixin from '@/mixins/meter'
import {gasMeterTypeField, settlementTypeField} from '@/enums/meterInfo'

export default {
  name: 'MeterStatusDetails',
  filters: {},
  mixins: [meterMixin],
  props: {
    // 客户编号
    customerCode: String,
    // 气表编号
    gasMeterCode: String,
    // 是否全部显示信息
    showAll: {
      type: Boolean,
      default: true
    },
  },
  data() {
    return {
      showData: {}, // 最终显示的数据
      loading: true, // 页面加载状态
      emptyStr: '--',
      showMore: false,
      meterInfo: {}, // 气表基本信息
      meterStatus: {}, // 气表状态信息

    }
  },
  computed: {},
  watch: {
    gasMeterCode: {
      handler() {
        this.initData()
      }
    },
  },
  created() {
    this.initData()
  },
  methods: {
    async initData() {
      if (this.gasMeterCode) {
        await this.getMeterStatusInfo()
        // await this.getLadderDetails(gasCode)
      } else {
        this.showData = {}
      }
      this.loading = false
    },

    // 获取气表状态信息
    getMeterStatusInfo() {
      return new Promise((resolve) => {
        let params = {
          customerCode: this.customerCode,
          gasMeterCode: this.gasMeterCode
        }
        getGasMeterDetails(params).then((response) => {
          const {isSuccess, data} = response.data
          if (isSuccess) {
            this.showData = data
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => {

        })
      })
    },

    // 获取气表阶梯用量信息
    getLadderDetails(gasMeterCode) {
      return new Promise((resolve) => {
        getGasMeterDetails(gasMeterCode).then((response) => {
          const {isSuccess, data} = response.data
          if (isSuccess) {
            this.showData = data
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        }).finally(() => {

        })
      })
    },
    viewMore() {
      // todo: 跳转地址
    }
  }

}
</script>

<style lang="scss" scoped>
.show-info-form {
  .el-form-item {
    width: calc(100% / 2);
  }
  .tag-exceptionInfo {
    margin-bottom: 6px;
    color: #ff4949;
    border-color: #ffdbdb;
    background-color: #ffeded;
    padding: 0 10px;
    border-radius: 4px;
    font-size: 12px;
    width: 100%;
    white-space: normal;
    word-wrap: break-word;
    word-break: break-all;
  }
}
</style>

