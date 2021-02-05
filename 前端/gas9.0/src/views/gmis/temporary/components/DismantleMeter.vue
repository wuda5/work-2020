<!--拆表-->
<template>
  <div>
    <!--费用结算-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">费用结算</span>
      </div>
      <el-row :gutter="20">
        <!--收费列表-->
        <el-col :span="12">
          <charge-table :height="250" :is-border="true"></charge-table>
        </el-col>
        <!--业务-->
        <el-col :span="12">
          <el-form label-position="top" :model="chargeForm" class="jh-text">

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
            <el-form-item label="拆表原因">
              <el-input v-model="chargeForm.theSumReceived" type="number" />
            </el-form-item>

            <div class="clearfix"></div>

            <!-- 收费确认 -->

            <div class="rechargeResult">
              <el-form-item label="账户余额">
                <b class="redFont">{{ 360.001 | moneyFormat }}</b>
              </el-form-item>

              <el-form-item label="拆后余额">
                <b class="redFont">{{ 0 || '0' }}</b>
                <!--<money-input :point="2" :max="99999" placeholder="请输入金额" v-model.number="chargeForm.amount"/>-->
              </el-form-item>
            </div>

            <el-form-item label="合计金额">
              <b class="redFont">{{ 20 || '' }}</b>
            </el-form-item>
            <el-form-item label=" ">
              <el-button type="primary" class="width100">拆表</el-button>
            </el-form-item>

            <!-- 收费按钮 -->
            <div class="btnBox">
              <el-button type="primary">过户</el-button>
            </div>
          </el-form>

        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import ChargeTable from '@/components/WujhTest/ChargeTable' // 收费列表表格
export default {
  name: 'DismantleMeter',
  components: {
    ChargeTable
  },
  data() {
    return {
      tableData: [
        {
          userID: '224545',
          name: '王小虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        }
      ],
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
      },
      myData: {
        userNum: '2587425',
        userName: '徐有容',
        phone: '13978951257',
        userTpye: '居民',
        gasType: '民用',
        time: '2016-03-21',
        restMoney: '100.00',
        addr: '龙泉驿区3栋1单元25号'
      }

    }
  }
}
</script>

<style lang="scss" scoped>
  @import "~@/styles/variables.scss";

  ::v-deep .el-input-group__append, .el-input-group__prepend {
    background: $primary;
    border-color: $primary;
    color: #FFF;
  }

  .search {
    width: 450px;

    .el-button {
      float: left;
    }

  }

  // 设置表格头部背景
  ::v-deep .el-table th {
    background-color: #f5f7fa !important;
  }

  .userInfo {
    .el-form-item {
      width: calc(100% / 5);

      .el-button {
        width: 100%;
      }
    }
  }

</style>
