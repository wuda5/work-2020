<!-- 补卡 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">业务信息</span>
      </div>
      <el-form label-position="top" class="jh-text">
        <el-form-item label="累计充值气量">
          <p>{{ businessInfo[1] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值金额">
          <p>{{ businessInfo[2] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值次数">
          <p>{{ businessInfo[3] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计补卡次数">
          <p>{{ businessInfo[4] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="充值次数">
          <p>{{ businessInfo[5] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上次用气量">
          <p>{{ businessInfo[6] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上次充值气量">
          <p>{{ businessInfo[7] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上上次充值气量">
          <p>{{ businessInfo[8] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="充值时间">
          <p>{{ businessInfo[9] || emptyStr }}</p>
        </el-form-item>
      </el-form>
    </el-card>

    <!--补卡信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">业务信息</span>
      </div>
      <el-row :gutter="20">
        <!--收费列表-->
        <el-col :span="12">
          <charge-table :height="350" :is-border="true"></charge-table>
        </el-col>
        <!--业务-->
        <el-col :span="12">
          <el-form label-position="top" :model="chargeForm" class="jh-text item2">
            <el-form-item label="补卡类型">
              <el-select v-model="chargeForm.invoiceType" clearable placeholder="请选择">
                <el-option
                  label="增值税发票"
                  value="1"
                />
                <el-option
                  label="普通发票"
                  value="2"
                />
                <el-option
                  label="其他"
                  value="3"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="补卡方式">
              <el-select v-model="chargeForm.invoiceType" clearable placeholder="请选择">
                <el-option
                  label="增值税发票"
                  value="1"
                />
                <el-option
                  label="普通发票"
                  value="2"
                />
                <el-option
                  label="其他"
                  value="3"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="补卡气量">
              <el-input v-model="chargeForm.prestore" type="number" />
            </el-form-item>
            <el-form-item label="补卡原因">
              <el-input v-model="chargeForm.theSumReceived" type="number" />
            </el-form-item>

            <el-form-item label="发票类型">
              <el-select v-model="chargeForm.invoiceType" clearable placeholder="请选择">
                <el-option
                  label="增值税发票"
                  value="1"
                />
                <el-option
                  label="普通发票"
                  value="2"
                />
                <el-option
                  label="其他"
                  value="3"
                />
              </el-select>

            </el-form-item>
            <el-form-item label="发票编号">
              <el-input v-model="chargeForm.invoiceNo" />
            </el-form-item>
            <el-form-item label="支付方式">
              <el-select v-model="chargeForm.chargeWay" clearable placeholder="请选择">
                <el-option
                  label="支付宝"
                  value="1"
                />
                <el-option
                  label="微信"
                  value="2"
                />
                <el-option
                  label="银联"
                  value="3"
                />
                <el-option
                  label="现金"
                  value="4"
                />
              </el-select>
            </el-form-item>

            <el-form-item label="实收金额">
              <el-input v-model="chargeForm.theSumReceived" type="number" />
            </el-form-item>

            <div class="clearfix"></div>

            <!-- 收费确认 -->

            <div class="rechargeResult">
              <el-form-item label="合计金额">
                <b class="redFont">{{ 360.001 | moneyFormat }}</b>
              </el-form-item>

              <el-form-item label="找零">
                <p class="redFont">{{ 20 || '' }}</p>
                <!--<money-input :point="2" :max="99999" placeholder="请输入金额" v-model.number="chargeForm.amount"/>-->
              </el-form-item>
            </div>

            <!-- 收费按钮 -->
            <div class="btnBox">
              <el-button type="primary">卡回收</el-button>
              <el-button type="primary">补卡</el-button>
            </div>
          </el-form>

        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import ChargeTable from '@/components/WujhTest/ChargeTable'

export default {
  name: 'CardReplacement',
  components: {
    ChargeTable
  },
  data() {
    return {
      businessInfo: {
        1: '233',
        2: '350',
        3: '2',
        4: '0',
        5: '2',
        6: '20',
        7: '50',
        8: '20',
        9: '2020.2.31'
      },
      // 收费表单
      chargeForm: {
        topUpValue: '',
        money: '',
        prestore: '',
        expiryDateInsurance: '',
        delivery: false,
        premium: '',
        invoiceNo: '',
        invoiceType: '',
        chargeWay: ''
        // amount:NaN
      }

    }
  },
  methods: {}
}
</script>

<style lang="scss" scoped>
  .el-form-item {
    width: 20%;
  }
  .item2 {
    .el-form-item {
      width: 50%;
    }
  }
</style>
