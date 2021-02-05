<!-- 发卡 -->
<template>
  <div v-loading="loading">
    <el-steps :active="active" finish-status="success">
      <el-step title="开始"></el-step>
      <!-- <el-step title="支付"></el-step> -->
      <el-step title="待写卡"></el-step>
      <el-step title="完成"></el-step>
    </el-steps>
    <!-- <el-steps v-else :active="active" finish-status="success">
      <el-step title="开始"></el-step>
      <el-step title="待写卡"></el-step>
      <el-step title="完成"></el-step>
    </el-steps> -->
    <el-card shadow="never" class="h1951">
      <div slot="header">
        <span class="card-title"> 业务信息 </span>
      </div>
      <el-form v-if="active != 3" label-position="top" class="jh-text">
        <el-form-item v-if="active == 3" label="表编码">
          <p>{{ gasMeterCode }}</p>
        </el-form-item>
        <el-form-item v-if="active == 3" label="卡号">
          <p>{{ cardNo }}</p>
        </el-form-item>
        <el-form-item v-if="active == 3" label="发卡时间">
          <p>{{ createTime }}</p>
        </el-form-item>
        <el-form-item v-if="active == 2 || (active == 1 && showButton)" label="操作">
          <el-button type="primary" @click="readCardLoad()"> 发卡 </el-button>
        </el-form-item>
      </el-form>
      <div v-if="active == 3">
        <h1 class="success">
          <i class="el-icon-success"></i>
          业务办理成功!
        </h1>
        <p class="success-text">即将返回……</p>
      </div>
    </el-card>
    <el-card v-if="active == 1 && !showButton" shadow="never" class="no-border mt15">
      <div slot="header">
        <span class="card-title">收费信息</span>
      </div>
      <QcCharge
        v-if="loadingCharge"
        scene="issue_card"
        :customer-code="customerCode"
        :gas-meter-code="gasMeterCode"
        :charge-type="chargeType"
        :settlement-type="settlementType"
        :use-gas-type-id="useGasTypeId"
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
import { chargeSceneFields } from '@/enums/business'

export default {
  name: 'GetCard',
  components: {
    QcCharge,
  },
  props: {
    gasMeterCode: String,
    customerCode: String,
    chargeType: String,
    settlementType: String,
    useGasTypeId: String,
  },
  data() {
    return {
      loading: true,
      cardNo: '---', //卡号
      createTime: '---', //发卡时间
      cardStatus: '---', //状态
      // statusMap: {
      //   WAITE_CHARGE: '待收费',
      //   WAITE_WRITE_CARD: '待写卡',
      //   ISSUE_CARD: '已发卡',
      // },
      bizNoOrId: null,
      //是否加载收费项
      isCharge: false,
      cardType: null,
      loadingCharge: false,
    }
  },
  computed: {
    active() {
      let active = 1
      switch (this.cardStatus) {
        case '':
        case null:
          active = 1
          break
        case 'WAITE_WRITE_CARD':
          active = 2
          break
        case 'ISSUE_CARD':
          active = 3
          break
        default:
          active = 1
      }
      return active
    },
    //不收费且不是IC卡
    showButton() {
      return !this.isCharge && this.cardType !== 'IC'
    },
  },
  async created() {
    this.getCardData()
    this.isCharge = await this.whetherSceneCharge(chargeSceneFields.ISSUE_CARD)
  },
  methods: {
    //缴费数据加载
    getCardData() {
      Api.issueCard({ gasMeterCode: this.gasMeterCode, customerCode: this.customerCode })
        .then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            const { data } = res.data
            this.cardNo = data.cardNo
            this.createTime = data.createTime
            this.cardStatus = data.cardStatus
            this.bizNoOrId = res.data.data.id
            this.cardType = res.data.data.cardType
            this.loadingCharge = true
          }
        })
        .catch(err => {
          console.log(err)
        })
        .finally(() => {
          this.loading = false
        })
    },
    //进入最后一步操作
    handleEnd() {
      this.cardStatus = 'ISSUE_CARD'
      setTimeout(() => {
        this.$emit('getCardClose')
      }, 3000)
    },
    //开卡操作  必要回调用来打印
    async readCardLoad(callBack) {
      this.$loading().setText('收费成功，交互中……')
      // this.getCardData()
      const reback = await Api.shakeHandsSocket({
        shakeOne: Api.issueCardLoad,
        shakeTwo: Api.issueCardCallBack,
        // code: this.gasMeterCode,
        customerCode: this.customerCode,
        id: this.bizNoOrId,
        callBack: () => {
          this.$loading().spinner = 'el-icon-check'
          this.$loading().setText('开卡成功！')
          // setTimeout(() => {
          if (callBack) {
            callBack()
          } else {
            this.$loading().close()
            this.handleEnd()
          }
          // }, 1200)
        },
        error: () => {
          this.$loading().close()
          this.getCardData()
        },
      })
      // console.log(reback)
      this.cardNo = reback?.cardNo
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
.text-primary {
  color: #1890ff !important;
}
.text-danger {
  color: #ff4949 !important;
}
.text-success {
  color: #13ce66 !important;
}
.h195 {
  height: 195px;
}
.el-form-item {
  width: 33.33% !important;
}

.mt15 {
  margin-top: 15px;
  overflow: initial;
}
.rechargeResult {
  .el-form-item {
    width: 25%;
  }
}
::v-deep .el-card__body {
  overflow: initial;
  margin: 0;
}
</style>
