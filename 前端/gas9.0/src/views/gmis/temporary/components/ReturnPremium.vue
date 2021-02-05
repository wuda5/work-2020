<!-- 退费 -->
<template>
  <div>
    <el-table
      :data="tableData"
      :stripe="true"
      height="200px"
    >
      <el-table-column
        prop="type"
        label="类型"
      >
      </el-table-column>
      <el-table-column
        prop="value"
        label="气量"
      >
      </el-table-column>
      <el-table-column
        prop="price"
        label="单价"
      >
      </el-table-column>
      <el-table-column
        prop="total"
        label="金额"
      >
      </el-table-column>
    </el-table>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" class="jh-text">
        <el-form-item label="充值气量">
          <p>{{ businessInfo[1] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="充值金额">
          <p>{{ businessInfo[2] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="预存">
          <p>{{ businessInfo[3] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="保费">
          <p>{{ businessInfo[4] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="保险到期时间">
          <p>{{ businessInfo[5] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="收费方式">
          <p>{{ businessInfo[6] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="发票类型">
          <p>{{ businessInfo[7] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="发票编号">
          <p>{{ businessInfo[8] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="定的编号">
          <p>{{ businessInfo[9] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="收费时间">
          <p>{{ businessInfo[10] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="应退金额">
          <p>{{ businessInfo[10] || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="退费原因" style="width: 60%">
          <el-input v-model=" businessInfo[12]" />
        </el-form-item>

        <el-form-item label="  ">
          <el-button type="primary" style="width: 100%">退费</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import ChargeTable from '@/components/WujhTest/ChargeTable'

export default {
  name: 'ReturnPremium',
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
        9: '350',
        10: '350',
        11: '350',
        12: '350'
      },
      tableData: [
        {
          type: '充值',
          value: 100,
          price: 3.5,
          total: 350
        },
        {
          type: '充值',
          value: 100,
          price: 3.5,
          total: 350
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

      }

    }
  },
  computed: {},
  methods: {}

}
</script>

<style lang="scss" scoped>
  .el-form-item {
    width: 20%;
  }
</style>
