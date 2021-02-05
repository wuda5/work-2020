<!--充值记录-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">充值记录</div>
    </div>
    <div slot="default" class="frameBody">
      <!--list-->
      <template v-if="listData.length">
        <el-card v-for="(item,index) in listData" :key="index" shadow="never" class="listItem">
          <div slot="header">
            <el-icon name="time"/>
            {{ (item.chargeItemTime || item.createTime) | parseTime('{y}-{m}-{d}') }}
          </div>
          <el-form ref="form" label-position="top" class="jh-text">
            <!--<el-form-item label="缴费场景">
              <p>{{ item.chargeItemName }}</p>
            </el-form-item>-->
            <el-form-item label="金额">
              <p>{{ item.rechargeMoney }}</p>
            </el-form-item>
            <br>
            <el-form-item label="状态">
              <p v-if="isSpecial">{{ statusText(item.moneyFlowStatus) }}</p>
              <p v-else>充值成功</p>
            </el-form-item>

          </el-form>
        </el-card>
      </template>
      <el-alert
        v-else
        title="暂无充值信息"
        type="warning"
        show-icon
        :closable="false"
      >
      </el-alert>
    </div>
    <div v-if="listData.length" slot="page">
      <pagination
        :page-sizes="[5, 10, 15, 20]"
        :page.sync="searchData.current"
        :limit.sync="searchData.size"
        :total="total"
        layout="total ,prev, next,jumper"
        @pagination="getListData"
      />
    </div>
  </info-frame>
</template>
<script>
import tabsApi from '@/api/tabsInfo';
import {moneyFlowStatus} from '@/enums/business.js';
import {dictionaryCodeMap} from '@/enums/dictionary';

export default {
  name: 'RechargeRecords',
  props: {
    gasMeterCode: String,
    customerCode: String,
    orderSourceName: String
  },
  data() {
    return {
      moneyFlowStatus,
      // 流水搜索条件
      searchData: this.initQueryParams({
        size: 5,
      }),

      // 流水
      listData: [],
      total: 0
    }
  },
  computed: {
    // 是否为要特殊显示的表具
    /*
    * 远程充值（物联网表表端计费）: REMOTE_RECHARGE
    * IC卡充值: IC_RECHARGE
    *
    * 上面两种要特殊显示 这两种表单独信息显示，其他的都只有success，直接显示 充值成功。
    * */
    isSpecial() {
      return this.orderSourceName === 'REMOTE_RECHARGE' || this.orderSourceName === 'IC_RECHARGE';
    },

  },
  watch: {
    gasMeterCode() {
      if (this.gasMeterCode && this.customerCode) {
        this.getListData()
      } else {
        this.listData = []
      }
    },
    customerCode() {
      if (this.gasMeterCode && this.customerCode) {
        this.getListData()
      } else {
        this.listData = []
      }
    }
  },
  mounted() {
    // console.log("我是账号信息组件，我被加载了")
    if (this.gasMeterCode && this.customerCode) {
      this.getListData()
    }
  },
  methods: {
    //  获取账户流水
    getListData() {
      this.searchData.model.gasmeterCode = this.gasMeterCode
      this.searchData.model.customerCode = this.customerCode
      tabsApi.rechargeRecords(this.searchData).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.listData = data.records
          this.total = parseInt(data.total)
        }
      })
    },

    // 状态文字
    /*
    * 远程充值（物联网表表端计费）: REMOTE_RECHARGE
    * IC卡充值: IC_RECHARGE
    * */
    statusText(moneyFlowStatus) {
      //  waite_deal: '待处理（下发|写卡）',
      if (moneyFlowStatus === 'waite_deal') {
        switch (this.orderSourceName) {
          case 'REMOTE_RECHARGE':
            return '待下发'
          case 'IC_RECHARGE':
            return '待写卡'
        }
      }
      // deal_failure: '处理失败（下发|写卡）',
      if (moneyFlowStatus === 'deal_failure') {
        switch (this.orderSourceName) {
          case 'REMOTE_RECHARGE':
            return '待重新下发'
          case 'IC_RECHARGE':
            return '待重新写卡'
        }
      }

      return this.moneyFlowStatus[moneyFlowStatus]

    }
  }
}
</script>

<style lang="scss" scoped>
.el-form-item {
  width: calc(100% / 3);
}

.listItem {
  ::v-deep .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
  }
}
</style>

