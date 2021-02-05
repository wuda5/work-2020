<!-- 气表版本号设置添加和编辑 -->
<template>
  <el-dialog
    :close-on-click-modal="false"
    :close-on-press-escape="true"
    :title="title"
    :type="type"
    :visible.sync="isVisible"
    width="700px"
    top="50px"
  >
    <el-form ref="form" :model="version" :rules="rules" label-position="right" label-width="120px" class="jh-text">
      <!-- 版号名称 -->
      <el-form-item :label="$t('table.versions.name')" prop="gasMeterVersionName">
        <el-input v-model="version.gasMeterVersionName" />
      </el-form-item>
      <!-- 版本号描述 -->
      <el-form-item :label="$t('table.versions.describe')">
        <el-input v-model="version.gasMeterDescribe" />
      </el-form-item>
      <!-- 生产厂商prop="companyName" -->
      <el-form-item :label="$t('table.versions.production')" prop="companyName">
        <el-select v-model="version.companyName" clearable filterable :placeholder="$t('common.pleaseSelect')" @change="handleFactoryChange">
          <el-option
            v-for="(item,index) in gasProductList"
            :key="index"
            :label="item.gasMeterFactoryName"
            :value="item.gasMeterFactoryName"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 无线通信设备厂商 -->
      <el-form-item :label="$t('table.versions.wirelessDevice')">
        <el-select v-model="version.equipmentVendorsName" clearable filterable :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item, key) in dicts.WIRELESS_EQUIPMENT_VENDORS"
            :key="key"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 无线通讯版本 -->
      <el-form-item :label="$t('table.versions.wirelessDevVersion')">
        <el-input v-model="version.wirelessVersion" />
      </el-form-item>
      <!-- 订单来源 -->
      <!-- <el-form-item :label="$t('table.versions.orderSource')" prop="orderSourceName">
        <el-select v-model="version.orderSourceName" clearable filterable :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item, key) in dicts.ORDER_SOURCE_NAME"
            :key="key"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item> -->
      <el-form-item :label="$t('table.versions.orderSource')" prop="orderSourceName">
        <el-select v-model="version.orderSourceName" name="orderSourceName" filterable clearable :placeholder="`${$t('common.pleaseSelect')}`" @change="handleOrderSourceChange">
          <el-option v-for="({ name, code }) in orderSourceList" :key="code" :value="code" :label="name"></el-option>
        </el-select>
      </el-form-item>
      <!-- 结算模式 -->
      <!-- <el-form-item :label="$t('meterInfo.settlementMode')" prop="settlementMode">
        <el-select v-model="form.settlementMode" name="settlementMode" filterable clearable :placeholder="`${$t('meterInfo.settlementMode')}`">
          <el-option v-for="(value, key) in settlementModeMap" :key="key" :value="key" :label="value"></el-option>
        </el-select>
      </el-form-item> -->
      <!-- 金额标志 -->
      <!-- <el-form-item :label="$t('table.versions.amountFlag')">
        <el-select v-model="version.amountMark" clearable filterable :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item, key) in dicts.AMOUNT_MARK"
            :key="key"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item> -->
      <!-- 金额标志 -->
      <el-form-item :label="$t('table.versions.amountFlag')" prop="amountMark">
        <el-select v-model="version.amountMark" name="amountMark" filterable clearable :placeholder="`${$t('common.pleaseSelect')}`">
          <el-option v-for="({ name, code }) in amountMarkList" :key="code" :value="code" :label="name"></el-option>
        </el-select>
      </el-form-item>
      <!-- 远程业务标志 -->
      <el-form-item :label="$t('meterInfo.remoteServiceFlag')" prop="remoteServiceFlag">
        <el-row type="flex" :gutter="5" align="middle">
          <el-col :span="22">
            <el-select v-model="version.remoteServiceFlag" name="remoteServiceFlag" collapse-tags filterable multiple clearable :placeholder="`${$t('meterInfo.remoteServiceFlag')}`" @change="handleChangeRemoteServiceFlag">
              <el-option v-for="(value, key) in remoteServiceFlagMap" :key="key" :value="key" :label="value"></el-option>
            </el-select>
          </el-col>
          <el-col style="width: auto">
            <el-button type="primary" size="mini" @click.native="handleSelectAllRemoteServiceFlag">全选</el-button>
          </el-col>
        </el-row>
      </el-form-item>
      <!-- 是否发卡 -->
      <el-form-item :label="$t('table.versions.isHaveCard')">
        <el-checkbox v-model="version.issuingCards" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE" :disabled="whetherIC" :checked="checked" @change="handleCheckBoxChange"></el-checkbox>
      </el-form-item>
      <!-- 是否必须录入底数 -->
      <el-form-item :label="$t('table.versions.isBaseNumber')">
        <el-checkbox v-model="version.radix" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 开户是否开阀 -->
      <el-form-item :label="$t('table.versions.isOpenValve')">
        <el-checkbox v-model="version.openValve" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 气量表金额位数 -->
      <el-form-item :label="$t('table.versions.amountDigit')">
        <el-input v-model="version.amountDigits" />
      </el-form-item>
      <!-- 是否单阶金额表 -->
      <el-form-item :label="$t('table.versions.isAmountSurface')">
        <el-checkbox v-model="version.singleLevelAmount" name="singleLevelAmount" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- IC卡内核标识 -->
      <el-form-item :label="$t('table.versions.icFlag')">
        <el-input v-model="version.icCardCoreMark" />
      </el-form-item>
      <!-- 小数位数 -->
      <!-- <el-form-item :label="$t('table.versions.decimalPlaces')">
        <el-input v-model="version.measurementAccuracy" />
      </el-form-item> -->
      <!-- 是否选择地址 -->
      <!-- <el-form-item :label="$t('table.versions.isSelectAddress')">
        <el-checkbox v-model="version.selectAddress" name="selectAddress" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item> -->
      <!-- 是否启用 -->
      <!-- <el-form-item :label="$t('table.versions.isValid')">
        <el-checkbox v-model="version.versionState" name="versionState" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item> -->
      <!-- 补气是否累加金额 -->
      <el-form-item v-show="false" :label="$t('table.versions.accumulationAmount')">
        <el-checkbox v-model="version.accumulatedAmount" name="accumulatedAmount" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 补气是否累加次数 -->
      <el-form-item :label="$t('table.versions.accumulatioFrequency')">
        <el-checkbox v-model="version.accumulatedCount" name="accumulatedCount" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 开户是否录入表号 -->
      <el-form-item :label="$t('table.versions.isInput')">
        <el-checkbox v-model="version.checked" name="checked" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 卡号类型 -->
      <!-- <el-form-item :label="$t('table.versions.cardType')">
        <el-select v-model="version.cardType" clearable filterable :placeholder="$t('common.pleaseSelect')" value>
          <el-option
            v-for="(item, key) in dicts.CARD_TYPE"
            :key="key"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item> -->
      <!-- 卡号长度 -->
      <el-form-item :label="$t('table.versions.cardLength')" prop="cardNumberLength">
        <el-input v-model="version.cardNumberLength" type="number" />
      </el-form-item>
      <!-- 卡号前缀 -->
      <el-form-item :label="$t('table.versions.cardPrefix')">
        <el-input v-model="version.cardNumberPrefix" />
      </el-form-item>
      <!-- 是否验证表号 -->
      <el-form-item :label="$t('table.versions.isCheckCardNo')">
        <el-checkbox v-model="version.verificationTableNo" name="verificationTableNo" :true-label="useStatusField.ENABLE" :false-label="useStatusField.DISABLE"></el-checkbox>
      </el-form-item>
      <!-- 备注 -->
      <el-form-item :label="$t('table.versions.remarks')">
        <el-input
          v-model="version.remark"
          type="textarea"
          :rows="2"
          placeholder="请输入内容"
        >
        </el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button plain type="warning" @click="isVisible = false">
        {{ $t("common.cancel") }}
      </el-button>
      <el-button :loading="loading" plain type="primary" @click="submitForm">
        {{ $t("common.confirm") }}
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
import { cloneDeep } from 'lodash'
import meterMixin from '@/mixins/meter'
import gasMeterVersionApi from '@/api/system/gasMeterVersion'
import { dataStatusField, useStatusField, deleteStatusField } from '@/enums/common'
import { dictionaryCodeMap } from '@/enums/dictionary'

// 初始化的表单数据
const initVersion = {
  versionState: useStatusField.ENABLE,
  cardType: 'CHARACTER',
  radix: 0, // 是否录入底数：默认0; 1、是; 0、否
  openValve: 0, // 是否开阀：默认0; 1、是; 0、否
  remoteServiceFlag: null, // 远程业务标志
}
// 订单来源IC卡标识
const IC_CARD = 'IC_RECHARGE'

export default {
  name: 'GasVersionEdit',
  mixins: [meterMixin],
  props: {
    dialogVisible: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: 'add',
    },
    orderSourceList: {
      type: Array,
      default: () => {
        return []
      }
    },
    amountMarkList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data() {
    return {
      loading: false,
      version: cloneDeep(initVersion),
      screenWidth: 0,
      width: this.initWidth(),
      //数据字典
      dicts: {
        CARD_TYPE: {},
        WIRELESS_EQUIPMENT_VENDORS:{},
        REMOTE_SERVICE_FLAG:{},
        AMOUNT_MARK:{},
        ORDER_SOURCE_NAME:{}
      },
      useStatusField: useStatusField,
      //表单验证规则
      rules: {
        gasMeterVersionName:[
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        companyId: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'change',
        },
        companyName: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'change',
        },
        orderSourceName:{
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
        cardNumberLength:{
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
        amountMark: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        }
      },
     gasProductList:[],
     whetherIC: false,
     checked: false
    }
  },
  computed: {
    // 远程业务标志map
    remoteServiceFlagMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.REMOTE_SERVICE_FLAG)
    },
    isVisible: {
      get() {
        return this.dialogVisible
      },
      set() {
        this.close()
        this.reset()
      },
    },
    title() {
      return this.type === 'add' ? this.$t('common.add') : this.$t('common.edit')
    },
    // 结算模式map
    settlementModeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SETTLEMENT_MODE)
    },
    // 结算类型map
    settlementTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.SETTLEMENT_TYPE)
    },
    // 收费类型map
    // chargeTypeMap() {
    //   return this.getDictionaryMapByCode(dictionaryCodeMap.CHARGE_TYPE)
    // },
  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    initWidth() {
      this.screenWidth = document.body.clientWidth
      return this.screenWidth < 991 ? '90%' : '40%'
    },
    loadListOptions({ callback }) {
      callback()
    },
    setGasVersion(val,dicts) {
      const vm = this
      if (val) {
        console.log('val', val)
        vm.version = {
          ...val,
          // remoteServiceFlag: val?.remoteServiceFlag?.split?.(',') || null
        }
      } else {
        vm.version = cloneDeep(initVersion)
      }
      vm.dicts = dicts
      this.queryGasProduct()
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.version = {}
    },
    submitForm() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.loading = true
          vm.editSubmit()
        } else {
          return false
        }
      })
    },

    editSubmit() {
      const vm = this
      if (vm.type === 'add') {
        vm.save()
      } else {
        vm.update()
      }
    },
    save() {
      const vm = this
      //将远程业务标志从数组转成字符串，再保存
      // if(this.version.remoteServiceFlag){
      //   this.version.remoteServiceFlag = this.version.remoteServiceFlag.toString();
      // }
      const payload = {
        ...this.version,
        issuingCards: Number(this.version.issuingCards),
        remoteServiceFlag: (this.version.remoteServiceFlag || []).join(',')
      }
      gasMeterVersionApi.save(payload).then(response => {
        const res = response.data
        if (res.isSuccess) {
          vm.isVisible = false
          vm.$message({
            message: vm.$t('tips.createSuccess'),
            type: 'success',
          })
          vm.$emit('success')
        }
      }).finally(() => {
        this.loading = false
      })
    },
    update() {
      //将远程业务标志从数组转成字符串，再保存
      // if(this.version.remoteServiceFlag){
      //   this.version.remoteServiceFlag = this.version.remoteServiceFlag.toString();
      // }
      const payload = {
        ...this.version,
        issuingCards: Number(this.version.issuingCards),
        remoteServiceFlag: (this.version.remoteServiceFlag || []).join(',')
      }
      gasMeterVersionApi.update(payload).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.isVisible = false
          this.$message({
            message: this.$t('tips.updateSuccess'),
            type: 'success',
          })
          this.$emit('success')
        }
      }).finally(() => {
        this.loading = false
      })
    },
    /**
     * 查询气表生产厂商
     */
    queryGasProduct(){
      // this.loading = true
      gasMeterVersionApi.queryGasProduct({ gasMeterFactoryStatus: useStatusField.ENABLE, deleteStatus: deleteStatusField.DELETE_INVALID}).then(response => {
        const res = response.data
        if (res.isSuccess) {
          // this.loading = false
          this.gasProductList=res.data
        }
      })
    },

    // 气表厂家发生变化
    handleFactoryChange(value) {
      const factory = this.gasProductList.find((item) => item.gasMeterFactoryName === value)
      this.version.companyId = factory?.id ?? null
      this.version.companyCode = factory?.gasMeterFactoryCode ?? null
    },
    handleOrderSourceChange(val) {
      if (val === IC_CARD) {
        this.whetherIC = true
        this.version.issuingCards = true
      } else {
        this.whetherIC = false
        this.version.issuingCards = false
      }
    },
    handleCheckBoxChange(val) {
      this.checked = Boolean(val)
    },

    // 远程业务标志发生变化
    handleChangeRemoteServiceFlag(value) {

    },
    // 远程标志全选
    handleSelectAllRemoteServiceFlag() {
      this.version.remoteServiceFlag = Object.keys(this.remoteServiceFlagMap)
    }
  },
}
</script>
<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 2);
    margin-bottom: 15px;
    float: initial;
  }
}
</style>
