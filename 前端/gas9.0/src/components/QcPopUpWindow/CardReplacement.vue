<!-- 补卡 -->
<template>
  <div v-loading="loading">
    <el-steps :active="active" finish-status="success">
      <el-step title="开始"></el-step>
      <el-step title="支付"></el-step>
      <el-step title="待发卡"></el-step>
      <el-step title="完成"></el-step>
    </el-steps>
    <el-card shadow="never" class="h195">
      <div slot="header">
        <span class="card-title">业务信息</span>
      </div>
      <el-form v-if="active != 4" label-position="top" class="jh-text">
        <el-form-item label="累计充值金额">
          <p>{{ formData.totalChargeMoney || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值气量">
          <p>{{ formData.totalChargeGas || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值次数">
          <p>{{ formData.totalChargeCount || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上次充值量">
          <p>{{ formData.value1 || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上上次充值量">
          <p>{{ formData.value2 || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上上上次充值量">
          <p>{{ formData.value3 || emptyStr }}</p>
        </el-form-item>
        <el-form-item v-if="repCardStatus == 'WAITE_WRITE_CARD'" label=" ">
          <el-button type="primary" @click="readCardLoad()">开卡</el-button>
        </el-form-item>
      </el-form>
      <div v-if="active == 4">
        <h1 class="success">
          <i class="el-icon-success"></i>
          业务办理成功!
        </h1>
        <p class="success-text">即将返回……</p>
      </div>
      <el-form v-if="!repCardStatus" label-position="top" class="jh-text">
        <el-form-item v-if="orderSourceName === 'IC_RECHARGE'" label="补卡类型">
          <el-select v-model="repCardData.repCardType" clearable placeholder="">
            <el-option
              v-for="item in repCardTypeOption"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-if="orderSourceName === 'IC_RECHARGE'" label="补卡方式">
          <el-select
            v-model="repCardData.repCardMethod"
            clearable
            placeholder=""
            @change="repCardMethodChange"
          >
            <el-option
              v-for="item in repCardMethodOption"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-if="orderSourceName === 'IC_RECHARGE'" label="补卡气量">
          <el-input
            v-model="repCardData.repCardGas"
            type="number"
            :disabled="true"
            placeholder=""
            clearable
          >
          </el-input>
        </el-form-item>
        <el-form-item :class="orderSourceName === 'IC_RECHARGE' ? null : 'w100'" label="补卡原因">
          <el-input v-model="repCardData.repCardDesc" placeholder="" clearable> </el-input>
        </el-form-item>
        <el-form-item label=" " class="btn">
          <el-button
            :disabled="!isRepCard"
            :loading="repCardLoading"
            type="primary"
            @click="repCardSave"
          >
            补卡
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!--补卡信息-->
    <el-card
      v-if="repCardStatus == 'WAITE_CHARGE' && isCharge"
      shadow="never"
      class="no-border mt15"
    >
      <div slot="header">
        <span class="card-title">收费信息</span>
      </div>
      <QcCharge
        scene="card_replacement"
        :gas-meter-code="gasMeterCode"
        :customer-code="customerCode"
        :scene-handle="readCardLoad"
        :handle-end="handleEnd"
        :biz-no-or-id="bizNoOrId"
      />
    </el-card>
  </div>
</template>

<script>
import QcCharge from '@/components/QcCharge'
import Api from '@/api/card/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import temporary from '@/api/temporary'
import { chargeSceneFields } from '@/enums/business'
import { deepClone } from '@/utils'

export default {
  name: 'CardReplacement',
  components: {
    QcCharge,
  },
  props: {
    gasMeterCode: String,
    customerCode: String,
    chargeType: String,
    cardReplaceData: null,
    orderSourceName: String,
  },
  data() {
    return {
      repCardLoading: false,
      loading: true,
      emptyStr: '-',
      cardRepRecord: null,
      repCardTypeOption: [
        {
          value: 'REP_NEW_USER_CARD',
          label: '新用户卡',
        },
        {
          value: 'REP_OLD_USER_CARD',
          label: '老用户卡',
        },
      ],
      repCardMethodOption: [
        {
          value: 'REP_PRE_RECHARGE',
          label: '补上次充值',
        },
        {
          value: 'NOT_REP_RECHARGE',
          label: '不补气量',
        },
      ],
      formData: {
        totalChargeCount: '', //累计充值次数
        totalChargeGas: '', //累计充值气量
        totalChargeMoney: '', //累计充值金额
        value1: '', //上/上上/上上上次充值量
        value2: '',
        value3: '',
      },
      repCardData: {
        repCardDesc: '', //补卡原因
        repCardGas: '', //补卡气量
        repCardMethod: 'REP_PRE_RECHARGE', //补卡方式
        repCardType: 'REP_OLD_USER_CARD', //补卡类型
      },
      repCardStatus: 'REP_CARD_SUCCESS', //状态
      //数据字典
      dicts: {
        REP_CARD_METHOD: {},
        REP_CARD_TYPE: {},
      },
      bizNoOrId: null,
      cardRepRecordId: null,
      isCharge: null,
    }
  },
  computed: {
    isRepCard() {
      return (
        this.repCardData.repCardType !== '' &&
        this.repCardData.repCardMethod !== '' &&
        this.repCardData.repCardDesc !== ''
      )
    },
    active() {
      let active = 1
      switch (this.repCardStatus) {
        case 'WAITE_CHARGE':
          active = 1
          break
        case 'WAITE_WRITE_CARD':
          active = 2
          break
        case 'REP_CARD_SUCCESS':
          active = 4
          break
        default:
          active = 1
      }
      return active
    },
  },
  // watch: {
  //   'repCardData.repCardMethod'(n, o) {
  //     console.log(n, o)
  //     if (n === 'REP_PRE_RECHARGE') {
  //       this.repCardData.repCardGas = this.formData.value1
  //     } else {
  //       this.repCardData.repCardGas = ''
  //     }
  //   },
  // },
  mounted() {
    //初始化数据字典
    this.dicts = {
      REP_CARD_METHOD: this.dictMap[dictionaryCodeMap.REP_CARD_METHOD],
      REP_CARD_TYPE: this.dictMap[dictionaryCodeMap.REP_CARD_TYPE],
    }
    this.handleDicts(this.dicts.REP_CARD_METHOD, 'repCardMethodOption')
    this.handleDicts(this.dicts.REP_CARD_TYPE, 'repCardTypeOption')
  },
  async created() {
    this.getCardData()
    this.isCharge = await this.whetherSceneCharge(chargeSceneFields.CARD_REPLACEMENT)
    this.repCardMethodChange()
  },
  methods: {
    handleDicts(dict, target) {
      let temp = []
      for (let i in dict) {
        temp.push({
          value: i,
          label: dict[i],
        })
      }
      // 表具收费类型不为 (IC_RECHARGE)时，补卡方式 只能是不补气量。
      // if (target === 'repCardMethodOption' && this.chargeType !== 'IC_RECHARGE') {
      if (target === 'repCardMethodOption' && this.chargeType !== 'IC_RECHARGE') {
        temp = temp.filter(i => {
          return i.value === 'NOT_REP_RECHARGE'
        })
      }
      this[target] = temp
    },
    getCardData(reGive) {
      const { gasMeterInfo: data, cardRepRecord } = reGive ? reGive : this.cardReplaceData
      // this.formData = data
      data ? (this.formData = data) : null
      this.cardRepRecord = cardRepRecord
      this.cardRepRecordId = cardRepRecord?.id
      this.repCardStatus = cardRepRecord?.repCardStatus
      this.loading = false
    },
    /* 补上次充值 -补卡气量将上面的上次充值填充到表单
       不补气量-- 补卡气量输入框不让输入 */
    repCardMethodChange() {
      if (this.repCardData.repCardMethod === 'REP_PRE_RECHARGE') {
        this.repCardData.repCardGas = this.formData.value1
      } else {
        this.repCardData.repCardGas = ''
      }
    },
    // 补卡保存按钮
    repCardSave() {
      this.repCardLoading = true
      const params = deepClone(this.repCardData)
      params.gasMeterCode = this.gasMeterCode
      params.customerCode = this.customerCode
      Api.repCardSave(params)
        .then(async res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            this.repCardLoading = false
            this.bizNoOrId = res.data.data.cardRepRecord.id
            this.$message({
              message: '保存成功!',
              type: 'success',
            })
            if (this.isCharge) {
              this.repCardStatus = 'WAITE_CHARGE'
            } else {
              await this.readCardLoad()
              // this.repCardStatus = 'WAITE_CHARGE'
            }
          }
        })
        .finally(() => {
          this.repCardLoading = false
        })
    },
    //补气状态再查询
    reRepCardStatus() {
      Api.repCard({ gasMeterCode: this.gasMeterCode, customerCode: this.customerCode }).then(
        res => {
          if (res.data.isSuccess) {
            this.getCardData(res.data.data)
          }
        }
      )
    },
    //进入最后一步操作
    handleEnd() {
      this.repCardStatus = 'REP_CARD_SUCCESS'
      setTimeout(() => {
        this.$emit('cardReplacementClose')
      }, 3000)
    },
    //收费操作  必要回调用来打印
    async readCardLoad(callBack) {
      this.$loading().setText('收费成功，交互中……')
      const reback = await Api.shakeHandsSocket({
        shakeOne: Api.repCardLoad,
        shakeTwo: Api.repCardCallBack,
        id: this.bizNoOrId || this.cardRepRecordId,
        callBack: () => {
          this.$loading().spinner = 'el-icon-check'
          this.$loading().setText('补卡成功！')
          this.$loading().close()
          if (callBack) {
            callBack()
          } else {
            this.$loading().close()
            this.handleEnd()
          }
        },
        error: () => {
          this.reRepCardStatus()
        },
      })
      // console.log(reback)
      this.formData = {
        totalChargeCount: reback?.totalChargeCount,
        totalChargeGas: reback?.totalChargeGas,
        totalChargeMoney: reback?.totalChargeMoney,
        value1: reback?.value1,
        value2: reback?.value2,
        value3: reback?.value3,
      }
    },
  },
}
</script>

<style lang="scss" scoped>
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
.el-steps {
  padding: 20px 3px;
}
.btn {
  margin-left: 75%;
  button {
    width: 100%;
  }
}
.text-primary {
  color: #1890ff !important;
}
.text-danger {
  color: #ff4949 !important;
}
.text-success {
  color: #13ce66 !important;
}
.mt15 {
  margin-top: 15px;
}
.el-form-item {
  width: 25% !important;
  padding: 0 5% 0 0 !important;
}
.item2 {
  .el-form-item {
    width: 50%;
  }
}
.jh-text {
  .el-form-item {
    width: calc(100% / 5);
    margin-bottom: 15px;
  }
}
.w100 {
  width: 100% !important;
}
::v-deep .el-card__body {
  overflow: initial;
}
</style>
