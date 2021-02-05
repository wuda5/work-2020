<!--户表信息-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">户表信息</div>
    </div>
    <div slot="default" class="frameBody">
      <!--账户: 余额-->
      <el-card shadow="never" class="listItem" style="background:#f7f7f7 ">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="表身号">
            <p>{{ accountInfo.gasMeterNumber || '---' }}</p>
          </el-form-item>
          <el-form-item label="账户余额">
            <p style="color: deeppink">{{ accountInfo.gasMeterBalance || '---' }}</p>
          </el-form-item>
          <!-- <el-form-item label="表端余量">
            <p>{{ accountInfo.gasMeterInBalance || '---' }}</p>
          </el-form-item> -->
        </el-form>
      </el-card>

      <!--list-->
      <template v-if="serialList.length">
        <el-card v-for="(item,index) in serialList" :key="index" shadow="never" class="listItem">
          <div slot="header">
            <el-icon name="time" />
            记录时间：{{ item.createTime | parseTime }}
          </div>
          <el-form ref="form" label-position="top" class="jh-text">
            <el-form-item label="操作类型">
              <el-input :value="dictMap.IOT_ACCOUNT_SERIAL_SCENE[item.billType]" />
            </el-form-item>
            <el-form-item label="记账金额">
              <el-input :value="item.bookMoney" />
            </el-form-item>

            <el-form-item label="记账前金额">
              <el-input :value="item.bookPreMoney" />
            </el-form-item>
            <el-form-item label="记账后金额">
              <el-input :value="item.bookAfterMoney" />
            </el-form-item>
          </el-form>
        </el-card>
      </template>
      <el-alert
        v-else
        title="暂无缴费信息"
        type="warning"
        show-icon
        :closable="false"
      >
      </el-alert>
    </div>
    <div v-if="serialList.length" slot="page">
      <pagination
        :page-sizes="[5, 10, 15, 20]"
        :page.sync="searchData.current"
        :limit.sync="searchData.size"
        :total="total"
        layout="total ,prev, next,jumper"
        @pagination="getAccountSerial"
      />
    </div>
  </info-frame>

</template>
<script>
import tabsApi from '@/api/tabsInfo/index.js'

export default {
  name: 'AccountMeter',
  props: {
    customerCode: String,
    gasMeterCode: String
  },
  data() {
    return {
      // 流水搜索条件
      searchData: this.initQueryParams({
        size: 5,
      }),

      // 户表信息
      accountInfo: {},

      // 流水
      serialList: [],
      total: 0
    }
  },
  computed: {},
  watch: {
    customerCode() {
      if(this.customerCode){
        this.getAccountSerial()
        this.getAccountInfo()
      }
    }
  },
  mounted() {
    // console.log("我是账号信息组件，我被加载了")
    if (this.customerCode) {
      this.getAccountInfo()
      this.getAccountSerial()
    }
  },
  methods: {
    // 获取户表信息
    getAccountInfo() {
      let params = {
        customerCode: this.customerCode,
        gasmeterCode: this.gasMeterCode
      }
      tabsApi.getAccountMeter(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.accountInfo = data || {}
        }
      })
    },

    //  获取账户流水
    getAccountSerial() {
      this.searchData.model.customerCode = this.customerCode
      this.searchData.model.gasMeterCode = this.gasMeterCode
      tabsApi.getAccountMeterSerial(this.searchData).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.serialList = data.records
          this.total = parseInt(data.total)
        }
      })
    }
  }

}
</script>

<style lang="scss" scoped>
::v-deep .el-form-item {
  width: 50%;
}

.listItem {
  .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
  }
}

.listBox {
  height: calc(100vh - 340px);
  overflow-y: scroll;
}

.success {
  color: $success !important;
}
</style>

