<!-- 创建工单 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="chargeForm" class="jh-text buka">
        <el-form-item label="工单类型">
          <el-select v-model="chargeForm.invoiceType" clearable placeholder="请选择">
            <el-option
              label="维修"
              value="1"
            />
            <el-option
              label="更换"
              value="2"
            />
            <el-option
              label="检查"
              value="3"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="紧急程度">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="工单内容" class="width100">
          <el-input v-model="chargeForm.invoiceNo" type="textarea" />
        </el-form-item>

        <el-form-item label="联系电话">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>
        <el-form-item label="接单人">
          <el-input v-model="chargeForm.invoiceNo" />
        </el-form-item>

        <div class="clearfix"></div>
        <br>
        <div class="btnBox">
          <el-button type="primary">创建</el-button>
          <el-button type="primary">打印</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'QcWorkOrder',
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
::v-deep .el-card__body{
  padding: 0;
}
</style>
