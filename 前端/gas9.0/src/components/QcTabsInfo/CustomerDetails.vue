<!--客户信息-->
<template>
  <div v-loading="loading" class="info-page CustomerDetails-page">
    <info-frame>
      <template v-slot:title>
        <div class="subTitle">{{ $t('customerInfo.detailsTitle') }}</div>
      </template>
      <!-- card -->
      <el-card shadow="never" class="no-border frameFormBody " :body-style="{ padding: '0 10px' }">
        <el-form label-position="top" class="qc-form clearfix show-info-form show-customerinfo-form" :inline="true">
          <!-- 客户编号 -->
          <!-- <el-form-item :label="$t('customerInfo.customerCode')">
            <p>{{ showData.customerCode || emptyStr }}</p>
          </el-form-item> -->
          <!-- 客户名称 -->
          <el-form-item :label="$t('customerInfo.customerName')">
            <el-input :value="showData.customerName" />
          </el-form-item>
          <!-- 客户性别 -->
          <el-form-item :label="$t('customerInfo.sex')">
            <el-input :value="sexMap[showData.sex]" />
          </el-form-item>
          <!-- 客户状态 -->
          <el-form-item :label="$t('customerInfo.customerStatus')">
            <el-input :value="customerStatusMap[showData.customerStatus]" />
          </el-form-item>
          <!-- 客户类型 -->
          <el-form-item :label="$t('customerInfo.customerTypeName')">
            <el-input :value="showData.customerTypeName" />
          </el-form-item>
          <!-- 黑名单 -->
          <el-form-item :label="$t('customerInfo.blackStatus')">
            <el-input :value="showData.blackStatus" />
          </el-form-item>
          <!-- 创建时间 -->
          <el-form-item :label="$t('customerInfo.createTime')">
            <el-input :value="showData.createTime" />
          </el-form-item>
          <!-- 开户时间 -->
          <!-- <el-form-item :label="$t('customerInfo.openTime')">
            <p>{{ showData.createTime || emptyStr }}</p>
          </el-form-item> -->
          <!-- 账户余额 -->
          <!-- <el-form-item :label="$t('customerInfo.balance')">
            <p>{{ showData.balance || emptyStr }}</p>
          </el-form-item> -->
          <!-- 预存次数 -->
          <!-- <el-form-item :label="$t('customerInfo.preStoreCount')">
            <p>{{ showData.preStoreCount || emptyStr }}</p>
          </el-form-item> -->
          <!-- 预存总额 -->
          <!-- <el-form-item :label="$t('customerInfo.preStoreMoney')">
            <p>{{ showData.preStoreMoney || emptyStr }}</p>
          </el-form-item> -->
          <!-- 联系电话 -->
          <el-form-item :label="$t('customerInfo.telphone')">
            <el-input :value="showData.telphone" />
          </el-form-item>
          <!-- 身份证号码 -->
          <el-form-item :label="$t('customerInfo.idCard')">
            <el-input :value="showData.idCard" />
          </el-form-item>
          <!-- 安装地址 -->
          <el-form-item :label="$t('customerInfo.contactAddress')" style="width: 100%">
            <el-input :value="showData.contactAddress" />
          </el-form-item>

          <!-- 证件类型 -->
          <!-- <el-form-item :label="$t('customerInfo.idTypeName')">
            <p>{{ showData.idTypeName || emptyStr }}</p>
          </el-form-item> -->
          <!-- 证件号码 -->
          <!-- <el-form-item :label="$t('customerInfo.idNumber')">
            <p>{{ showData.idNumber || emptyStr }}</p>
          </el-form-item> -->
          <!-- 持卡人 -->
          <el-form-item :label="$t('customerInfo.cardholder')">
            <el-input :value="showData.cardholder" />
          </el-form-item>
          <!-- 银行账号 -->
          <el-form-item :label="$t('customerInfo.bankAccount')">
            <el-input :value="showData.bankAccount" />
          </el-form-item>
          <!-- 开户行 -->
          <el-form-item :label="$t('customerInfo.bank')">
            <el-input :value="showData.bank" />
          </el-form-item>
          <!-- 代扣合同编号 -->
          <el-form-item :label="$t('customerInfo.contractNumber')">
            <el-input :value="showData.contractNumber" />
          </el-form-item>
          <!-- 代扣签约状态 -->
          <el-form-item :label="$t('customerInfo.contractStatus')">
            <el-input :value="showData.contractStatus | contractStatusFilter" />
          </el-form-item>
          <!-- 保险到期时间 -->
          <el-form-item :label="$t('customerInfo.insuranceEndTime')">
            <el-input :value="showData.insuranceEndTime | dateTimeFormat('{y}-{m}-{d}')" />
          </el-form-item>
          <!-- 保险编号 -->
          <el-form-item :label="$t('customerInfo.insuranceNo')">
            <el-input :value="showData.insuranceNo" />
          </el-form-item>
          <!-- 发票开户行及账号 -->
          <el-form-item :label="$t('customerInfo.invoiceBankAccount')">
            <el-input :value="showData.invoiceBankAccount" />
          </el-form-item>
          <!-- 发票地址 -->
          <el-form-item :label="$t('customerInfo.invoiceAddress')" style="width: 100%">
            <el-input :value="showData.invoiceAddress" />
          </el-form-item>

          <!-- 组织名称 -->
          <el-form-item :label="$t('customerInfo.orgName')" style="width: 100%">
            <el-input :value="showData.orgName" />
          </el-form-item>
        </el-form>
      </el-card>
    </info-frame>
  </div>
</template>
<script>
import { getCustomerInfoByGasMeterCode } from '@/api/meterInfo/index'
import { getCustomerInfoByCustomerCode } from '@/api/userInfo/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { blackStatusMap, contractStatusMap, contractStatusField, customerStatusField } from '@/enums/customerInfo'
import { parseTime } from '@/utils/index'

export default {
  name: 'CustomerDetails',
  filters: {
    //代扣签约状
    contractStatusFilter(val){
      return contractStatusMap[val] ?? '--'
    },
    // 时间日期格式化
    dateTimeFormat(value, format = '{y}-{m}-{d} {h}:{i}:{s}') {
      return parseTime(value, format) || '--'
    },
    // 黑名单格式化
    blackStatusFilter(val){
      return blackStatusMap[+val] ?? '--'
    },
  },
  // data 和 id prop属于互斥关系
  props: {
    // 展示的信息
    data: {
      type: Object,
      default: function () {
        return {}
      }
    },
    // 展示的信息id
    id: {
      type: [String, Number],
      default: null
    },
    // 气表编号
    gasMeterCode: String,
    // 客户编号
    customerCode: String,
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
    // 性别map
    sexMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SEX)
    },
    // 客户状态map
    customerStatusMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.CUMSTOMER_STATE)
    }
  },
  watch: {
    gasMeterCode: {
      handler() {
        this.initData()
      }
    },
    customerCode: {
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
        await this.getDataByGasMeterCode()
      } else if (this.customerCode) {
        await this.getDataByCustomerCode()
      } else {
        this.showData = this.data ?? {}
      }
      this.loading = false
    },

    // 获取数据通过气表编号
    getDataByGasMeterCode() {
      return new Promise((resolve) => {
        getCustomerInfoByGasMeterCode(this.gasMeterCode).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.showData = data || {}
          }
          resolve(isSuccess)
        })
        .catch(() => (resolve(false)))
      })
    },

    // 获取数据通过客户编号
    getDataByCustomerCode() {
      return new Promise((resolve) => {
        getCustomerInfoByCustomerCode(this.customerCode).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.showData = data || {}
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
  .show-customerinfo-form {
    .el-form-item {
      width: calc(100% / 2);
    }
  }
</style>

