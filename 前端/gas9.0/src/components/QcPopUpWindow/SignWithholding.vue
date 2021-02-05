<!-- 代扣签约 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="chargeForm" class="jh-text">
        <el-form-item label="开户行">
          <el-select v-model="chargeForm.invoiceType" clearable placeholder="请选择">
            <el-option
              label="中国银行"
              value="1"
            />
            <el-option
              label="建设银行"
              value="2"
            />
            <el-option
              label="农业银行"
              value="3"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="持卡人">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="银行账号" class="width100">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>

        <el-form-item label="合同编号" class="width100">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>

        <div class="clearfix"></div>
        <p>签约状态：已签约</p>
        <div class="btnBox">
          <el-button type="primary">签约</el-button>
          <el-button type="danger">解约</el-button>
        </div>
      </el-form>
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
  computed: {},
  methods: {}
}
</script>

<style lang="scss" scoped>
</style>
