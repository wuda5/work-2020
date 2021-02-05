<!--表具信息-->
<template>
  <div v-loading="loading" class="info-page MeterDetails-page">
    <info-frame>
      <template v-slot:title>
        <div class="subTitle">{{ $t('meterInfo.detailsTitle') }}</div>
      </template>
      <!-- card -->
      <el-card shadow="never" class="no-border frameFormBody" :body-style="{ padding: '0 10px' }">
        <!-- <slot name="header">
          <div slot="header">
            <span class="card-title">{{ $t('meterInfo.detailsTitle') }}</span>
          </div>
        </slot> -->
        <el-form label-position="top" class="qc-form clearfix show-info-form show-meterinfo-form" :inline="true">
          <!-- 缴费编号 -->
          <el-form-item :label="$t('meterInfo.customerChargeNo')">
            <el-input :value="showData.customerChargeNo" />
          </el-form-item>
          <!-- 气表编号 -->
          <!-- <el-form-item v-if="showAll" :label="$t('meterInfo.gasCode')">
            <template v-if="showData.gasCode">
              <el-tooltip :content="showData.gasCode" placement="bottom">
                <p>{{ showData.gasCode || emptyStr }}</p>
              </el-tooltip>
            </template>
            <p v-else>{{ showData.gasCode || emptyStr }}</p>
          </el-form-item> -->
          <!-- 气表类型 -->
          <el-form-item :label="$t('meterInfo.gasMeterTypeName')">
            <el-input :value="gasMeterTypeMap[showData.orderSourceName]" />
          </el-form-item>
          <!-- 气表厂家 -->
          <el-form-item :label="$t('meterInfo.gasMeterFactoryName')" style="width: 100%;">
            <el-input :value="showData.gasMeterFactoryName" />
          </el-form-item>
          <!-- 气表版号 -->
          <el-form-item :label="$t('meterInfo.gasMeterVersionName')">
            <el-input :value="showData.gasMeterVersionName" />
          </el-form-item>
          <!-- 气表型号 -->
          <el-form-item :label="$t('meterInfo.gasMeterModelName')">
            <el-input :value="showData.gasMeterModelName" />
          </el-form-item>
          <!-- 用气类型 -->
          <el-form-item :label="$t('meterInfo.useGasTypeName')">
            <el-input :value="showData.useGasTypeName" />
          </el-form-item>
          <!-- 表身号 -->
          <el-form-item :label="$t('meterInfo.gasMeterNumber')">
            <el-input :value="showData.gasMeterNumber" />
          </el-form-item>
          <!-- 气表底数 -->
          <el-form-item :label="$t('meterInfo.gasMeterBase')">
            <el-input :value="showData.gasMeterBase" />
          </el-form-item>
          <!-- 进气方向 -->
          <el-form-item :label="$t('meterInfo.direction')">
            <el-input :value=" directionMap[showData.direction]" />
          </el-form-item>
          <!-- 安装地址 -->
          <el-form-item label="安装地址" style="width: 100%">
            <el-input type="textarea" rows="3" :value="showData.moreGasMeterAddress" />
          </el-form-item>

          <!-- 使用人口 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.population')">
            <el-input :value="showData.population" />
          </el-form-item>

          <!-- 调压箱号 -->
          <!-- <el-form-item :label="$t('meterInfo.nodeNumber')">
            <p>{{ showData.nodeNumber || emptyStr }}</p>
          </el-form-item> -->
          <!-- 开户时间 -->
          <el-form-item :label="$t('meterInfo.openAccountTime')">
            <el-input :value="showData.openAccountTime | timeFormat('{y}-{m}-{d} {h}:{i}:{s}')" />
          </el-form-item>
          <!-- 开户人 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.openAccountUserName')">
            <el-input :value="showData.openAccountUserName" />
          </el-form-item>
          <!-- 通气状态 -->
          <!-- <el-form-item v-if="showAll" :label="$t('meterInfo.ventilateStatus')">
            <p>{{ showData.ventilateStatus | ventilateStatusFormat }}</p>
          </el-form-item> -->
          <!-- 通气人 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.ventilateUserName')">
            <el-input :value="showData.ventilateUserName" />
          </el-form-item>
          <!-- 通气时间 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.ventilateTime')">
            <el-input :value="showData.ventilateTime" />
          </el-form-item>
          <!-- 安检人 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.securityUserName')">
            <el-input :value="showData.securityUserName" />
          </el-form-item>
          <!-- 检定时间 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.checkTime')">
            <el-input :value="showData.checkTime" />
          </el-form-item>
          <!-- 检定人 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.checkUser')">
            <el-input :value="showData.checkUser" />
          </el-form-item>
          <!-- 购买时间 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.buyTime')">
            <el-input :value="showData.buyTime | timeFormat('{y}-{m}-{d}')" />
          </el-form-item>
          <!-- 防盗扣编号 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.safeCode')">
            <el-input :value="showData.safeCode" />
          </el-form-item>
          <!-- 是否注册网关 -->
          <el-form-item v-if="IS_INTERNET_GASMETER(showData)" label="是否注册网关">
            <el-input :value="isRegisterGateway(showData) ? '是' : '否'" />
          </el-form-item>

          <!-- 气表状态 -->
          <el-form-item :label="$t('meterInfo.dataStatus')">
            <el-input :value="meterStatusMap[+showData.dataStatus]" />
          </el-form-item>
          <!-- 备注 -->
          <el-form-item v-if="showAll" :label="$t('meterInfo.remark')">
            <el-input :value="showData.remark" />
          </el-form-item>
        </el-form>
      </el-card>
    </info-frame>
  </div>
</template>
<script>
import meterMixin from '@/mixins/meter'
import { getMeterInfoByGasMeterCode } from '@/api/meterInfo/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { blackStatusMap } from '@/enums/customerInfo'
import { meterStatusField, diretionField, ventilateStatusMap } from '@/enums/meterInfo'
import { parseTime } from '@/utils/index'

export default {
  name: 'MeterDetails',
  filters: {
    // 通气状态
    ventilateStatusFormat(value) {
      return ventilateStatusMap[+value] ?? '--'
    },
    // 时间格式化
    timeFormat(value, format) {
      return parseTime(value, format) || '--'
    },
  },
  mixins: [meterMixin],
  // data 和 id prop属于互斥关系
  props: {
    // 展示的信息
    data: {
      type: Object,
      default: function () {
        return {}
      }
    },
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
      showMore: false
    }
  },
  computed: {
    // 进气方向map
    directionMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.VENTILATION_DIRECTION)
    },
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
  },
  watch: {
    gasMeterCode: {
      handler() {
        this.initData()
      }
    },
    data: {
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
        await this.getData()
      } else {
        this.showData = this.data ?? {}
      }
      this.loading = false
    },

    // 需要获取数据
    getData() {
      return new Promise((resolve) => {
        getMeterInfoByGasMeterCode(this.gasMeterCode).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.showData = data
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
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
  }
</style>

