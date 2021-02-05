<!--换表-->
<template>
  <div>
    <el-steps :active="curStep" finish-status="success">
      <el-step title="确认信息"></el-step>
      <el-step title="支付"></el-step>
      <el-step title="完成"></el-step>
    </el-steps>

    <br />
    <div v-if="isInputInfo">
      <!--旧表 气表状态-->
      <el-card shadow="never" class="no-border">
        <div slot="header">
          <span class="card-title">旧表 气表状态</span>
        </div>
        <el-form v-if="showData" label-position="top" class="jh-text">
          <div v-if="false">
            <el-form-item label="累计充值次数">
              <p>{{ meterStatus.totalChargeCount || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="累计充值气量">
              <p>{{ meterStatus.totalChargeGas || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="累计充值金额">
              <p>{{ meterStatus.totalChargeMoney || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="累计充值上表次数">
              <p>{{ meterStatus.totalRechargeMeterCount || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="累计用气量">
              <p>{{ meterStatus.totalUseGas || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="累计用气金额">
              <p>{{ meterStatus.totalUseGasMoney || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="上次用气量">
              <p>{{ meterStatus.value1 || emptyStr }}</p>
            </el-form-item>
            <el-form-item label="上上次充值气量">
              <p>{{ meterStatus.value2 || emptyStr }}</p>
            </el-form-item>
            <el-form-item label="上上上次充值气量">
              <p>{{ meterStatus.value3 || emptyStr }}</p>
            </el-form-item>

            <el-form-item label="周期累计用气量">
              <p>{{ meterStatus.cycleUseGas || emptyStr }}</p>
            </el-form-item>
            <el-form-item label="表上余额">
              <p>{{ meterStatus.gasMeterBalance || emptyStr }}</p>
            </el-form-item>
            <el-form-item label="表上余量">
              <p>{{ meterStatus.gasMeterGasBalance || emptyStr }}</p>
            </el-form-item>
          </div>

          <!-- 物联网表显示内容 -->
          <template v-if="IS_INTERNET_GASMETER(showData)">
            <el-tag class="meterTag">物联网表</el-tag>
            <!-- 累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalUseGas')">
              <p>{{ showData.totalUseGas || emptyStr }}</p>
            </el-form-item>
            <!-- 周期累计使用量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleUseGas')">
              <p>{{ showData.cycleUseGas || emptyStr }}</p>
            </el-form-item>
            <!-- 阀状态 -->
            <el-form-item :label="$t('meterInfo.meterStatus.valveState')">
              <p>{{ showData.valveState | valveStateFormat }}</p>
            </el-form-item>
            <!-- 报警器 -->
            <el-form-item :label="$t('meterInfo.meterStatus.alarm')">
              <p>{{ showData.alarmStatus | alarmFormat }}</p>
            </el-form-item>
            <!-- 当前阶梯 -->
            <el-form-item :label="$t('meterInfo.meterStatus.currentLadder')">
              <p>{{ showData.currentLadder || emptyStr }}</p>
            </el-form-item>
            <!-- 当前价格 -->
            <el-form-item :label="$t('meterInfo.meterStatus.currentPrice')">
              <p>{{ showData.currentPrice || emptyStr }}</p>
            </el-form-item>
            <!-- 气表余额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.gasMeterBalance')">
              <p>{{ showData.gasMeterBalance || emptyStr }}</p>
            </el-form-item>
            <!-- 更新时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.updateTime')">
              <p>{{ showData.updateTime | timeFormat }}</p>
            </el-form-item>
            <!-- 异常信息 -->
            <el-form-item :label="$t('meterInfo.meterStatus.exceptionInfo')">
              <p>{{ showData.exceptionInfo || emptyStr }}</p>
            </el-form-item>
          </template>
          <!-- 卡表（气量）显示内容 -->
          <template v-else-if="IS_CARD_GASMETER_OF_GAS(showData)">
            <el-tag class="meterTag">卡表（气量）</el-tag>
            <!-- 周期累计充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleChargeGas')">
              <p>{{ showData.cycleChargeGas || emptyStr }}</p>
            </el-form-item>
            <!-- 累计充值气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeGas')">
              <p>{{ showData.totalChargeGas || emptyStr }}</p>
            </el-form-item>
            <!-- 累计充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeMoney')">
              <p>{{ showData.totalChargeMoney || emptyStr }}</p>
            </el-form-item>
            <!-- 累计充值次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeCount')">
              <p>{{ showData.totalChargeCount || emptyStr }}</p>
            </el-form-item>
            <!-- 累计补卡次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReplacementCardCount')">
              <p>{{ showData.totalReplacementCardCount || emptyStr }}</p>
            </el-form-item>
            <!-- 累计补气次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalAdditionalCount')">
              <p>{{ showData.totalAdditionalCount || emptyStr }}</p>
            </el-form-item>
            <!-- 上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value1')">
              <p>{{ showData.value1 || emptyStr }}</p>
            </el-form-item>
            <!-- 上上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value2')">
              <p>{{ showData.value2 || emptyStr }}</p>
            </el-form-item>
            <!-- 上上上次充值量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value3')">
              <p>{{ showData.value3 || emptyStr }}</p>
            </el-form-item>
          </template>
          <!-- 卡表（金额）显示内容 -->
          <template v-else-if="IS_CARD_GASMETER_OF_MONEY(showData)">
            <el-tag class="meterTag">卡表（金额）</el-tag>
            <!-- 累计充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeMoney')">
              <p>{{ showData.totalChargeMoney || emptyStr }}</p>
            </el-form-item>
            <!-- 累计充值次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalChargeCount')">
              <p>{{ showData.totalChargeCount || emptyStr }}</p>
            </el-form-item>
            <!-- 累计补卡次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReplacementCardCount')">
              <p>{{ showData.totalReplacementCardCount || emptyStr }}</p>
            </el-form-item>
            <!-- 累计补气次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalAdditionalCount')">
              <p>{{ showData.totalAdditionalCount || emptyStr }}</p>
            </el-form-item>
            <!-- 上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value1')">
              <p>{{ showData.value1 || emptyStr }}</p>
            </el-form-item>
            <!-- 上上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value2')">
              <p>{{ showData.value2 || emptyStr }}</p>
            </el-form-item>
            <!-- 上上上次充值金额 -->
            <el-form-item :label="$t('meterInfo.meterStatus.value3')">
              <p>{{ showData.value3 || emptyStr }}</p>
            </el-form-item>
          </template>
          <!-- 普表显示内容 -->
          <template v-else>
            <el-tag class="meterTag">普表</el-tag>
            <!-- 累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalUseGas')">
              <p>{{ showData.totalUseGas || emptyStr }}</p>
            </el-form-item>
            <!-- 周期累计用气量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.cycleUseGas')">
              <p>{{ showData.cycleUseGas || emptyStr }}</p>
            </el-form-item>
            <!-- 累计缴费次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalPayCount')">
              <p>{{ showData.totalChargeCount || emptyStr }}</p>
            </el-form-item>
            <!-- 累计抄表次数 -->
            <el-form-item :label="$t('meterInfo.meterStatus.totalReadMeterCount')">
              <p>{{ showData.totalReadMeterCount || emptyStr }}</p>
            </el-form-item>
            <!-- 最后抄表时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastReadMeterTime')">
              <p>{{ showData.lastReadMeterTime | timeFormat }}</p>
            </el-form-item>
            <!-- 最后缴费时间 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastPayTime')">
              <p>{{ showData.lastChargeTime | timeFormat }}</p>
            </el-form-item>
            <!-- 最后抄表量 -->
            <el-form-item :label="$t('meterInfo.meterStatus.lastReadMeterGas')">
              <p>{{ showData.readMeterGas || emptyStr }}</p>
            </el-form-item>
          </template>
        </el-form>
      </el-card>

      <!--新表信息-->
      <br />
      <el-card shadow="never" class="no-border">
        <div slot="header">
          <span class="card-title">新表信息</span>
        </div>
        <el-form
          ref="formRef"
          label-position="top"
          :model="newMeterInfo"
          :rules="formRules"
          class="jh-text newMeterInfo"
        >
          <!-- 换表方式 -->
          <el-radio-group v-model="newMeterInfo.changeMode" @change="handleRadioClick">
            <el-radio-button
              v-for="(item, index) in changeMode"
              :key="index"
              :label="item.value"
              :disabled="IS_GENERAL_GASMETER(showData) && item.value === 'CHANGE_ZERO'"
            >
              {{ item.label }}
            </el-radio-button>
          </el-radio-group>

          <div class="clearfix"></div>

          <template v-if="newMeterInfo.changeMode==='CHANGE_NEW'">
            <el-form-item label="表身号" style="width: calc(100% / 5 * 2)" prop="newMeterNumber">
              <el-input
                v-model="newMeterInfo.newMeterNumber"
                placeholder="表身号"
                class="inputSearch"
              >
                <el-button slot="append" icon="el-icon-search" @click="getNewMeterInfo"></el-button>
              </el-input>
            </el-form-item>

            <!-- 气表厂家 -->
            <el-form-item :label="$t('meterInfo.gasMeterFactoryName')" prop="newMeterFactoryName">
              <el-select
                v-model="newMeterInfo.newMeterFactoryName"
                :disabled="hasMeter"
                name="newMeterFactoryName"
                filterable
                clearable
                :placeholder="`${$t('meterInfo.gasMeterFactoryName')}`"
                @change="handleChangeFactory"
              >
                <el-option
                  v-for="(item, index) in factoryList"
                  :key="index"
                  :value="item.gasMeterFactoryName"
                  :label="item.gasMeterFactoryName"
                ></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表版号 -->
            <el-form-item :label="$t('meterInfo.gasMeterVersionName')" prop="newMeterVersionName">
              <el-select
                v-model="newMeterInfo.newMeterVersionName"
                :disabled="hasMeter"
                name="newMeterVersionName"
                filterable
                clearable
                :placeholder="`${$t('meterInfo.gasMeterVersionName')}`"
                @change="handleChangeVersion"
              >
                <el-option
                  v-for="(item, index) in versionList"
                  :key="index"
                  :value="item.gasMeterVersionName"
                  :label="item.gasMeterVersionName"
                ></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表型号 -->
            <el-form-item :label="$t('meterInfo.gasMeterModelName')" prop="newMeterModelName">
              <el-select
                v-model="newMeterInfo.newMeterModelName"
                :disabled="hasMeter"
                name="newMeterModelName"
                filterable
                clearable
                :placeholder="`${$t('meterInfo.gasMeterModelName')}`"
                @change="handleChangeModel"
              >
                <el-option
                  v-for="(item, index) in modelList"
                  :key="index"
                  :value="item.modelName"
                  :label="item.modelName"
                ></el-option>
              </el-select>
            </el-form-item>

            <el-form-item label="旧表表号">
              <el-input v-model="newMeterInfo.oldGasMeterNumber" disabled />
            </el-form-item>
            <!--<el-form-item label="换表方式" prop="changeMode">
              <el-select v-model="newMeterInfo.changeMode">
                <el-option
                  v-for="(item, index) in changeMode"
                  :key="index"
                  :value="item.value"
                  :label="item.label"
                />
              </el-select>
            </el-form-item>-->
            <el-form-item label="旧表止数" prop="oldMeterEndGas">
              <el-input v-model="newMeterInfo.oldMeterEndGas" />
            </el-form-item>

            <el-form-item label="新表底数" prop="newMeterStartGas">
              <el-input v-model="newMeterInfo.newMeterStartGas" />
            </el-form-item>

            <template v-if="modelAmountMarkMap[newMeterInfo.newMeterVersionId] === 'GAS'">
              <el-form-item label="补充气量" prop="supplementGas">
                <el-input v-model="newMeterInfo.supplementGas" @blur="handleGasBlur" />
              </el-form-item>
              <el-form-item v-if="showData.amountMark === 'MONEY'" label="补充金额" prop="supplementAmount">
                <el-input v-model="newMeterInfo.supplementAmount" @blur="handleMoneyBlur" />
              </el-form-item>
            </template>
            <template v-if="modelAmountMarkMap[newMeterInfo.newMeterVersionId] === 'MONEY'">
              <el-form-item v-if="showData.amountMark === 'GAS'" label="补充气量" prop="supplementGas">
                <el-input v-model="newMeterInfo.supplementGas" @blur="handleGasBlur" />
              </el-form-item>
              <el-form-item label="补充金额" prop="supplementAmount">
                <el-input v-model="newMeterInfo.supplementAmount" @blur="handleMoneyBlur" />
              </el-form-item>
            </template>
            <el-form-item label="周期累计使用量" prop="cycleUseGas">
              <el-input v-model="newMeterInfo.cycleUseGas" :disabled="cycleUseGasDisabled" />
            </el-form-item>
          </template>
          <el-form-item label="换表原因" style="width: 100%" prop="changeReason">
            <el-input v-model="newMeterInfo.changeReason" />
          </el-form-item>
        </el-form>
      </el-card>

      <br />
      <div class="fr">
        <el-button
          v-if="newMeterInfo.changeMode === 'CHANGE_NEW' && (showData.orderSourceName === 'CENTER_RECHARGE' || showData.orderSourceName === 'REMOTE_READMETER')"
          type="primary"
          style="margin-right: 8px;"
          :loading="checkLoading"
          @click="handlecheck"
        >核算
        </el-button>
        <el-button
          type="primary"
          :disabled="bthDisabled"
          :loading="submitLoading"
          @click="handleSubmit"
        >换表
        </el-button>
      </div>
      <div class="clearfix"></div>
    </div>
    <div v-if="isCharge">
      <!--收费信息-->
      <el-card shadow="never" class="no-border">
        <div slot="header">
          <span class="card-title">收费信息</span>
        </div>
        <el-row :gutter="20">
          <!--收费列表-->
          <qc-charge
            scene="change_meter"
            :customer-code="curMeter.customerCode"
            :old-gas-meter-code="curMeter.gasCode"
            :gas-meter-code="curMeter.gasCode"
            :biz-no-or-id="businessId"
            :need-to-pay="needToPay"
            :arrears-detail-ids="arrearsDetailIds"
            :scene-handle="changeMeterSuccess"
            :handle-end="handleChangeMeterEnd"
          ></qc-charge>
        </el-row>
      </el-card>

      <!-- <br> -->
      <!-- <el-button type="primary" class="fr" @click="next">下一步</el-button> -->
      <div class="clearfix"></div>
    </div>
    <div v-if="isFinish">
      <h1 class="success">
        <i class="el-icon-success"></i>
        业务办理成功!
      </h1>
      <p class="success-text">即将返回……</p>
      <el-button type="primary" class="fr" @click="finished">确定</el-button>
      <div class="clearfix"></div>
    </div>
  </div>
</template>

<script>
// 请求气表相关信息接口
import {getFactoryListData, getVersionListData, getModelListData} from '@/api/meterInfo/index'
import meterMixin from '@/mixins/meter'

import {changeMode} from '@/enums/temporary' // 换表方式
import QcCharge from '@/components/QcCharge/index'
import temporaryApi from '@/api/temporary'
import {dataStatusField} from '@/enums/common'
import {dictionaryCodeMap} from '@/enums/dictionary'
import {chargeSceneFields} from '@/enums/business'
import {positiveNumberReg} from '@/utils/reg'
import CardApi from '@/api/card/index'

export default {
  name: 'ChangeMeter',
  components: {
    QcCharge,
    temporaryApi,
  },
  mixins: [meterMixin],
  props: {
    step: Number,
    curBusinessId: String,
    curMeter: Object,
    settlementReturn: Function,
  },
  data() {
    return {
      bizNoOrId: null,
      // 当前步骤
      curStep: this.step || 1,
      businessId: this.curBusinessId,

      showData: {}, // 旧表 气表状态

      changeMode,
      // 新表信息
      newMeterInfo: {
        changeMode: 'CHANGE_NEW', // 换表方式
        changeReason: '', // 换表原因
        customerCode: this.curMeter.customerCode, // 客户编号
        customerName: this.curMeter.customerName, // 客户名称
        newMeterNumber: '', // 新表表身号
        newMeterStartGas: 0, // 新表底数

        oldMeterCode: this.curMeter.gasCode || '', // 旧表表编号
        oldGasMeterNumber: this.curMeter.gasMeterNumber || '', // 旧表表身号
        cycleUseGas: this.showData ? this.showData.cycleUseGas : 0, // 周期累计使用量
        // oldMeterEndGas: this.showData ? this.showData.totalUseGas : 0, // 旧表止数
        oldMeterEndGas: '', // 旧表止数
        supplementAmount: this.showData ? this.showData.gasMeterBalance : 0, // 补充金额
        supplementGas: this.showData ? this.showData.gasMeterGasBalance : 0, // 补充气量

        // 新表 厂家，气表版本，进气型号
        newMeterFactoryName: '', // 厂家名称
        newMeterVersionName: '', // 气表版号
        newMeterModelName: '', //  进气型号
        newMeterFactoryId: '', // 厂家ID
        newMeterVersionId: '', // 气表版本ID
        newMeterModelId: '', // 模型ID
      },

      hasMeter: true,
      factoryList: [], // 气表厂家列表
      factoryMap: {}, // 气表厂家Map
      versionList: [], // 气表版号列表
      versionMap: {}, // 气表版号Map
      modelList: [], // 气表型号列表
      modelMap: {}, // 气表型号Map
      modelAmountMarkMap: {}, // 气表型号对应的气表类型

      // 表单验证规则
      formRules: {
        // 厂家ID
        newMeterFactoryId: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterFactoryName')}`,
            trigger: 'change',
          },
        ],
        // 厂家名称
        newMeterFactoryName: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterFactoryName')}`,
            trigger: 'change',
          },
        ],
        // 气表版本ID
        newMeterVersionId: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterVersionName')}`,
            trigger: 'change',
          },
        ],
        // 气表版号
        newMeterVersionName: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterVersionName')}`,
            trigger: 'change',
          },
        ],
        // 模型ID
        newMeterModelId: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterModelName')}`,
            trigger: 'change',
          },
        ],
        //  进气型号
        newMeterModelName: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('meterInfo.gasMeterModelName')}`,
            trigger: 'change',
          },
        ],
        newMeterNumber: [{required: true, message: `必填`, trigger: 'blur'}],
        changeMode: [{required: true, message: `请选择换表方式`, trigger: 'change'}],
        oldMeterEndGas: [{required: true, message: `必填`, trigger: 'blur'}],
        newMeterStartGas: [{required: true, message: `必填`, trigger: 'blur'}],
        supplementGas: [{required: true, message: `必填`, trigger: 'blur'}],
        supplementAmount: [{required: true, message: `必填`, trigger: 'blur'}],
        cycleUseGas: [{required: true, message: `必填`, trigger: 'blur'}],
        changeReason: [{required: true, message: `必填`, trigger: 'blur'}],
      },
      showChargeStep: true, // 是否显示收费步骤
      needToPay: false, // 是否显示收费步骤
      arrearsDetailIds: '', // 缴费信息ID
      loading: false, // 全局loading
      submitLoading: false, // 提交按钮loading
      newMeterCode: null,
      newMeterType: null,
      checkLoading: false,  // 核算按钮 loading
      bthDisabled: false, // 提交按钮 禁用
      hasChecked: false, // 是否进行核算
    }
  },
  computed: {
    // 是否是确认信息步骤
    isInputInfo() {
      return +this.curStep === 1
    },
    // 是否是收费
    isCharge() {
      return this.showChargeStep && +this.curStep === 2
    },
    // 是否到完成的步骤了
    isFinish() {
      return +this.curStep >= 3 || (!this.showChargeStep && +this.curStep >= 2)
    },
    cycleUseGasDisabled() {
      if (this.curMeter.orderSourceName === 'REMOTE_RECHARGE' || (this.curMeter.orderSourceName === 'IC_RECHARGE' && this.curMeter.amountMark === 'MONEY')) {
        return false
      }
      return true
    }
    // 按钮是否可以点击
    // btnDisabled() {
    //   if (this.IS_GENERAL_GASMETER(this.showData))
    // }
  },
  watch: {
    // 监听当前步骤, 如果是完成步骤，则执行操作
    curStep(value) {
      if (this.isFinish) {
        this.$emit('success', true)
        this.$nextTick(() => {
          setTimeout(() => {
            // 关闭弹出并刷新页面
            this.$emit('close', true)
          }, 2000)
        })
      }
    },
  },
  async created() {
    this.loading = true
    this.getGasMeterStatus()
    // this.showChargeStep = await this.whetherSceneCharge(chargeSceneFields.CHANGE_METER)
    this.factoryList = this.getFactoryList()
    this.versionList = this.getVersionList()
    this.modelList = this.getModelList()
    this.loading = false
  },
  mounted() {
  },
  destroyed() {
    if (this.curStep === 2) {
      this.settlementReturn()
    }
  },
  methods: {
    // changeMeterSuccess(callBack) {
    //   callBack()
    // },
    async changeMeterSuccess(callBack) {
      if (this.newMeterType === 'IC_RECHARGE') {
        this.$loading().setText('收费成功，交互中……')
        await this.readCard(callBack)
      } else {
        callBack()
      }
    },
    //读写卡
    async readCard(callBack) {
      await CardApi.issueCard({
        gasMeterCode: this.newMeterCode,
        customerCode: this.curMeter.customerCode,
      }).then(res => {
        if (res.data.isSuccess) {
          this.bizNoOrId = res.data.data.id
        }
      })
      const reback = await CardApi.shakeHandsSocket({
        shakeOne: CardApi.issueCardLoad,
        shakeTwo: CardApi.issueCardCallBack,
        customerCode: this.curMeter.customerCode,
        id: this.bizNoOrId,
        callBack: () => {
          this.$loading().spinner = 'el-icon-check'
          this.$loading().setText('开卡成功！')
          setTimeout(() => {
            if (callBack) {
              callBack ? callBack() : null
            } else {
              this.$loading().close()
            }
          }, 1200)
        },
        error: () => {
          this.loading = false
          this.next()
        },
      })
    },
    // 收费步骤结束
    handleChangeMeterEnd() {
      this.$loading().setText('收费成功，交互中……')
      this.next()
      this.$loading().close()
    },
    next() {
      this.curStep++
      // if (this.curStep++ > 3) this.curStep = 4;
    },
    // 获取被换表的气表状态
    getGasMeterStatus() {
      let params = {
        gasMeterCode: this.curMeter.gasCode,
        customerCode: this.curMeter.customerCode,
      }
      // console.log(this.curMeter)
      temporaryApi.gasMeterStatus(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.showData = data
          // 设置 默认参数
          this.newMeterInfo.cycleUseGas = data.cycleUseGas || 0 // 周期累计使用量
          // this.newMeterInfo.oldMeterEndGas = data.totalUseGas || 0 // 旧表止数
          this.newMeterInfo.supplementAmount = data.gasMeterBalance || 0 // 补充金额
          this.newMeterInfo.supplementGas = data.gasMeterGasBalance || 0 // 补充气量
          if (data.orderSourceName === 'CENTER_RECHARGE' || data.orderSourceName === 'REMOTE_READMETER') {
            this.bthDisabled = true
          }
        }
      })
    },

    // 根据表身号获取表具信息
    getNewMeterInfo() {
      if (!this.newMeterInfo.newMeterNumber) {
        this.msg('请输入新气表编号查询！', 'error')
        return
      }
      let params = {
        gasMeterNumber: this.newMeterInfo.newMeterNumber,
      }
      temporaryApi.getNewMeterInfoByMeterCode(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess && data) {
          this.hasMeter = true
          this.newMeterInfo.newMeterFactoryId = data.gasMeterFactoryId
          this.newMeterInfo.newMeterModelId = data.gasMeterModelId
          this.newMeterInfo.newMeterVersionId = data.gasMeterVersionId
          this.newMeterInfo.newMeterStartGas = data.gasMeterBase
          //
          this.newMeterInfo.newMeterFactoryName = this.factoryMap[
            this.newMeterInfo.newMeterFactoryId
            ]
          this.newMeterInfo.newMeterModelName = this.modelMap[this.newMeterInfo.newMeterModelId]
          this.newMeterInfo.newMeterVersionName = this.versionMap[
            this.newMeterInfo.newMeterVersionId
            ]
        } else {
          this.hasMeter = false
        }
      })
    },

    // 气表相关选择-----------------------------------------------------
    // 获取气表厂家
    async getFactoryList() {
      if (this.factoryList.length > 0) {
        return true
      }
      return new Promise(resolve => {
        getFactoryListData({
          dataStatus: dataStatusField.VALID,
          gasMeterFactoryStatus: dataStatusField.VALID,
        })
          .then(response => {
            const {isSuccess, data} = response.data

            if (isSuccess) {
              this.factoryList = data
              let factoryMap = {}
              data.forEach(item => {
                factoryMap[item.id] = item.gasMeterFactoryName
              })
              this.factoryMap = factoryMap
            }
            resolve(isSuccess)
          })
          .catch(() => {
            resolve(false)
          })
      })
    },

    // 获取气表版号
    async getVersionList(params = {}) {
      this.loading = true
      return new Promise(resolve => {
        getVersionListData({
          dataStatus: dataStatusField.VALID,
          gasMeterFactoryStatus: dataStatusField.VALID,
          versionState: dataStatusField.VALID,
          ...params,
        })
          .then(response => {
            const {isSuccess, data} = response.data
            if (isSuccess) {
              this.versionList = data
              let versionMap = {}
              let meterXXX = {}
              data.forEach(item => {
                versionMap[item.id] = item.gasMeterVersionName
                meterXXX[item.id] = item.amountMark
              })
              this.versionMap = versionMap
              this.modelAmountMarkMap = meterXXX
            }
            resolve(isSuccess)
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.loading = false))
      })
    },

    // 获取气表型号
    async getModelList(params = {}) {
      this.loading = true
      return new Promise(resolve => {
        getModelListData({
          dataStatus: dataStatusField.VALID,
          gasMeterFactoryStatus: dataStatusField.VALID,
          ...params,
        })
          .then(response => {
            const {isSuccess, data} = response.data
            if (isSuccess) {
              this.modelList = data
              let modelMap = {}

              data.forEach(item => {
                modelMap[item.id] = item.modelName

              })
              this.modelMap = modelMap

            }
            resolve(isSuccess)
          })
          .catch(() => {
            resolve(false)
          })
          .finally(() => (this.loading = false))
      })
    },

    // 气表厂家发生变化, 清空气表版号信息，查找厂家名称赋值
    async handleChangeFactory(value) {
      this.newMeterInfo.newMeterVersionId = null
      this.newMeterInfo.newMeterVersionName = null
      this.versionList = []
      this.modelList = []
      const factory = this.factoryList.find(item => item.gasMeterFactoryName === value)
      if (factory) {
        this.newMeterInfo.newMeterFactoryId = factory?.id || null
        await this.getVersionList({companyId: factory?.id})
      }
    },

    // 气表版号发生变化, 清空气表型号信息，查找版号名称赋值
    async handleChangeVersion(value) {
      this.newMeterInfo.newMeterModelId = null
      this.newMeterInfo.newMeterModelName = null
      this.modelList = []
      const version = this.versionList.find(item => item.gasMeterVersionName === value)
      // console.log(version)
      if (version) {
        this.newMeterInfo.newMeterVersionId = version?.id || null
        await this.getModelList({gasMeterVersionId: version?.id})
      }
    },

    // 气表型号发生变化，查找型号名称赋值
    handleChangeModel(value) {
      const model = this.modelList.find(item => item.modelName === value)
      if (model) {
        this.newMeterInfo.newMeterModelId = model?.id || null
      }
    },

    // 气表类型发生变化
    handleChangeGasMeterType(value) {
      this.newMeterInfo.gasMeterTypeName = this.gasMeterTypeMap[value] ?? null
    },
    // end气表相关选择 -----------------------------------------------------

    // 保存表单信息
    handleSubmit() {
      this.$refs['formRef'].validate(async valid => {
        if (valid) {
          this.changeMeter()
        } else {
          this.$message.error(this.$t('validateError'))
        }
      })
    },

    // 换表
    async changeMeter() {
      this.submitLoading = true
      // const showChargeStep = await this.whetherSceneCharge(chargeSceneFields.CHANGE_METER)
      await temporaryApi
        .changeMeterAdd(this.newMeterInfo)
        .then(async res => {
          const {isSuccess, data} = res.data
          if (isSuccess) {
            this.$message.success(this.$t('saveSuccess'))
            const {busData, needToPay, arrearsDetailIds} = data
            this.businessId = busData?.id ?? null
            this.newMeterCode = busData.newMeterCode
            this.newMeterType = busData.newMeterType
            this.needToPay = needToPay
            this.arrearsDetailIds = arrearsDetailIds
            console.warn(arrearsDetailIds, this.arrearsDetailIds)
            // console.log(data);
            // 如果不需要支付燃气费并且没有可收费场景则跳过一步
            if (!needToPay) {
              this.curStep += 2
              if(this.newMeterType === 'IC_RECHARGE'){
                this.readCard()
              }
            } else {
              this.next()
            }
          }
        })
        .finally(() => (this.submitLoading = false))
    },

    // end
    finished() {
      this.next()
      setTimeout(() => {
        this.$emit('close')
      }, 500)
    },
    // 气量输入框失焦
    handleGasBlur() {
      this.handleBlur('GAS', this.newMeterInfo.supplementGas)
    },
    // 金额输入框失焦
    handleMoneyBlur() {
      this.handleBlur('MONEY', this.newMeterInfo.supplementAmount)
    },
    // 补充气量输入后
    async handleBlur(type, val) {
      const { useGasTypeId, gasCode } = this.curMeter
      const payload = {
        conversionType: {
          code: type
        },
        conversionValue: val,
        gasMeterCode: gasCode,
        useGasTypeId
      }
      await temporaryApi.changeMoneyConvert(payload).then(res => {
        const { data } = res.data
        if (data) {
          if (type === 'GAS') {
            this.newMeterInfo.supplementAmount = data
          } else if (type === 'MONEY') {
            this.newMeterInfo.supplementGas = data
          }
        }
      })
    },
    // 核算按钮点击
    async handlecheck() {
      if (!this.newMeterInfo.newMeterNumber) {
        this.$message({
          type: 'warning',
          message: '请先输入表身号'
        })
        return
      } else if (!this.newMeterInfo.oldMeterEndGas) {
        this.$message({
          type: 'warning',
          message: '请先输入旧表止数'
        })
        return
      } else if (!this.newMeterInfo.newMeterVersionName) {
        this.$message({
          type: 'warning',
          message: '请先输入气表版号'
        })
        return
      }
      this.checkLoading = true
      const payload = {
        ...this.newMeterInfo
      }
      await temporaryApi.costCenterRechargeMeter(payload).then(res => {
        const { data } = res.data
        if (data) {
          const { cycleUseGas, gasMeterBalance } = data
          this.newMeterInfo.cycleUseGas = cycleUseGas
          
          if (+gasMeterBalance > 0) {
            this.newMeterInfo.supplementAmount = gasMeterBalance
          } else {
            this.newMeterInfo.supplementAmount = 0
          }
          this.bthDisabled = false
          this.hasChecked = true
        }
      }).finally(() => {
        this.checkLoading = false
      })
    },
    handleRadioClick(val) {
      // 旧表不禁用按钮
      if (val === 'CHANGE_ZERO') {
        this.bthDisabled = false
      } else {
        // 新表 - 仅当物联网表才需要核算
        if (this.showData.orderSourceName === 'CENTER_RECHARGE' || this.showData.orderSourceName === 'REMOTE_READMETER') {
          if (!this.hasChecked) {
            this.bthDisabled = true
          } else {
            this.bthDisabled = false
          }
        } else {
          this.bthDisabled = false
        }
      }
    }
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 6);
  }
}

.newMeterInfo {
  .el-form-item {
    width: calc(100% / 5);
    margin-bottom: 15px;
  }
}

// 新表设置 搜索样式
.inputSearch {
  ::v-deep {
    .el-input-group__append {
      width: 50px;
      padding: 0 20px;
    }

    .el-input__inner {
      border-bottom-right-radius: 0 !important;
      border-top-right-radius: 0 !important;
    }
  }
}

.success {
  color: #13ce66;
  text-align: center;
  padding-top: 50px;
}

.success-text {
  font-size: 16px;
  color: #666;
  text-align: center;
  padding-bottom: 50px;
}

.meterTag {
  position: absolute;
  top: 10px;
  right: 10px;
}
::v-deep .el-card__body {
  overflow: initial;
}
</style>
