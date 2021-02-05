<!--IC卡信息-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">IC卡信息</div>
    </div>
    <div slot="default" class="frameBody">

      <el-card v-if="cardObj" shadow="never" class="listItem">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="卡号">
            <el-input :value="cardObj.cardNo" />
          </el-form-item>
          <!-- <el-form-item label="缴费编号">
            <p>{{ cardObj.customerChargeNo || emptyStr }}</p>
          </el-form-item> -->
          <el-form-item label="卡类型">
            <el-input :value="cardObj.cardType" />
          </el-form-item>
          <template v-if="cardObj.cardType === 'IC'">
            <el-form-item label="上表次数">
              <el-input :value="cardObj.meterCount" />
            </el-form-item>
            <el-form-item :label="cardObj.amountMark === 'GAS' ? '卡上气量' : '卡上金额'">
              <el-input :value="cardObj.cardBalance" />
            </el-form-item>
          </template>
        </el-form>
      </el-card>
      <el-alert
        v-else
        title="暂无IC卡信息"
        type="warning"
        show-icon
        :closable="false"
      >
      </el-alert>
    </div>
  </info-frame>
</template>
<script>
import tabsApi from '@/api/tabsInfo';
import {
  amountMarkField
} from '@/enums/meterInfo'

export default {
  name: 'CardInfo',
  props: {
    options: {
      type: Object,
      default: () => ({}),
    }
  },
  data() {
    return {
      cardObj: null,
    }
  },
  computed: {
    // 是否是气量卡表
    IS_CARD_GASMETER_OF_GAS() {
      return amountMarkField.GAS === this.options?.amountMark ?? ''
    },
  },
  watch: {
    options(data) {
      this.initData()
    }
  },
  mounted() {
    this.initData()
  },
  methods: {
    initData() {
      const { gasCode, customerCode } = this.options || {}
      if (gasCode && customerCode) {
        this.getCardInfo()
      } else {
        this.cardObj = null
      }
    },
    //  获取账户流水
    getCardInfo() {
      const { gasCode, customerCode } = this.options
      let params = {
        gasMeterCode: gasCode,
        customerCode: customerCode
      }
      tabsApi.cardInfo(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.cardObj = data
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.el-form-item {
  width: 50%;
}

::v-deep .el-card__body {
  padding: 10px;
}

</style>

