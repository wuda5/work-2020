<!--编辑-->
<template>
  <div>
    <!--客户信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">客户信息</span>
      </div>

      <el-form label-position="top" class="jh-text">
        <el-form-item label="报装编号">
          <el-input v-model="myData.userNum"></el-input>
        </el-form-item>
        <el-form-item label="客户编号">
          <el-input v-model="myData.userNum"></el-input>
        </el-form-item>
        <el-form-item label="客户名称">
          <el-input v-model="myData.userName"></el-input>
        </el-form-item>
        <el-form-item label="客户电话">
          <el-input v-model="myData.phone"></el-input>
        </el-form-item>
        <el-form-item label="客户类型">
          <el-input v-model="myData.userTpye"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-input v-model="myData.userTpye"></el-input>
        </el-form-item>
        <el-form-item label="证件类型">
          <el-input v-model="myData.gasType"></el-input>
        </el-form-item>
        <el-form-item label="证件号码">
          <el-input v-model="myData.gasType"></el-input>
        </el-form-item>
        <el-form-item label="常驻地址" style="width: 33.3%">
          <el-input v-model="myData.addr"></el-input>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="myData.restMoney"></el-input>
        </el-form-item>
      </el-form>

    </el-card>
    <!--表具信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">表具信息</span>
      </div>
      <el-form label-position="top" :model="chargeForm" class="jh-text">
        <el-form-item label="气表编号">
          <el-input v-model="chargeForm.prestore" type="number" />
        </el-form-item>
        <el-form-item label="气表厂家">
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
        <el-form-item label="版号">
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
        <el-form-item label="进气方向">
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

        <el-form-item label="用气类型">
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

        <el-form-item label="街道(乡镇)">
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
        <el-form-item label="小区(村、xx路)">
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
        <el-form-item label="安装地址">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="人口">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="调压箱号">
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
        <el-form-item label="通气状态">
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
        <el-form-item label="通气人">
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

        <el-form-item label="通气时间">
          <el-input v-model="chargeForm.theSumReceived" type="timepicker" />
        </el-form-item>

        <el-form-item label="安检员">
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
        <el-form-item label="经度">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="纬度">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="">

        </el-form-item>
        <el-form-item label="  ">
          <el-button type="primary">保存</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import ChargeTable from '@/components/WujhTest/ChargeTable' // 收费列表表格
export default {
  name: 'InfoEdit',
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
  }

  // 设置表格头部背景
  ::v-deep .el-table th {
    background-color: #f5f7fa !important;
  }

  .el-form-item {
    width: calc(100% / 6);
    margin-bottom: 10px;

    .el-button {
      width: 100%;
    }
  }
</style>
