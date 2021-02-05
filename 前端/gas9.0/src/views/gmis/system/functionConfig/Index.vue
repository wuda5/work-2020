<!--功能项配置-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">功能项配置</span>
      </div>
      <!--表单-->
      <el-form ref="functionForm" label-position="top" class="jh-text" :model="form" :rules="rules">
        <!--启用ID卡-->
        <!-- <el-form-item>
          <el-checkbox v-model="form.openIdCard" :true-label="1" :false-label="0">启用ID卡</el-checkbox>
        </el-form-item>
        <div class="clearfix"></div>
        -->

        <el-form-item label="票据公司名称">
          <el-input v-model="form.invoiceCompanyName" />
        </el-form-item>
        <div class="clearfix"></div>

        <el-form-item label="发票编码规则设置">
          <div class="groupBox">
            <el-radio v-model="form.invoiceCodeRule" :label="1">系统自动生成</el-radio>
            <el-radio v-model="form.invoiceCodeRule" :label="0">人工录入</el-radio>
          </div>
        </el-form-item>
        <div class="clearfix"></div>

        <el-form-item label="缴费编码规则设置">
          <div class="groupBox">
            <el-radio v-model="form.openCustomerPrefix" :label="1">自增长</el-radio>
            <span style="margin:auto 30px ">固定前缀：<el-input v-model="form.customerPrefix" style="width: 120px;" /></span>
            <el-radio v-model="form.openCustomerPrefix" :label="0">人工录入</el-radio>
          </div>
        </el-form-item>
        <div class="clearfix"></div>

        <el-form-item label="过户修改缴费编号">
          <div class="groupBox">
            <el-radio v-model="form.transferAccountFlag" :label="1">是</el-radio>
            <el-radio v-model="form.transferAccountFlag" :label="0">否</el-radio>
          </div>
        </el-form-item>
         <div class="clearfix"></div>

        <el-form-item label="是否启用保险功能业务">
          <div class="groupBox">
            <el-radio v-model="form.openInsuranceType" :label="1">是</el-radio>
            <el-radio v-model="form.openInsuranceType" :label="0">否</el-radio>
          </div>
        </el-form-item>

        <!-- 客户缴费编号 -->
        <!-- <el-form-item label=" ">
          <el-checkbox v-model="form.openCustomerPrefix" :true-label="1" :false-label="0">客户缴费编号</el-checkbox>
        </el-form-item> -->

        <!--客户编号前缀-->
        <!-- <el-form-item label="客户编号前缀" prop="customerPrefix">
          <el-input v-model="form.customerPrefix" :disabled="form.openCustomerPrefix===0" />
        </el-form-item> -->
        <div class="clearfix"></div>

        <!--启用增值税发票-->
        <!-- <el-form-item label=" ">
          <el-checkbox v-model="form.openVatInvoice" :true-label="1" :false-label="0" @input="handleTaxRate">启用增值税发票</el-checkbox>
        </el-form-item> -->

        <!-- 税率 -->
        <!-- <el-form-item label="税率" prop="blackMaxMoney">
          <el-input v-model="form.taxRate" type="number" @input="handleTaxRate"></el-input>
        </el-form-item>
        <div class="clearfix"></div> -->

        <!--向上，向下取整-->
        <el-form-item label=" 取整模式">
          <!-- <el-checkbox v-model="form.openRounding" :true-label="1" :false-label="0" @change="handleRounding">启用取整模式</el-checkbox> -->
          <div class="groupBox">
            <el-radio v-model="form.rounding" :label="1">向上取整</el-radio>
            <el-radio v-model="form.rounding" :label="0">向下取整</el-radio>
          </div>
        </el-form-item>
        <div class="clearfix"></div>

        <!--启用黑名单限购-->
        <!-- <el-form-item label="黑名单限购">
          <div class="groupBox">
            <el-form-item label="是否启用黑名单限购">
              <el-checkbox v-model="form.openBlackList" :true-label="1" :false-label="0">启用黑名单限购</el-checkbox>
            </el-form-item>
            <el-form-item label="黑名单限购最大充值金额" prop="blackMaxMoney">
              <el-input v-model="form.blackMaxMoney" :disabled="form.openBlackList===0">黑名单限购最大充值金额</el-input>
            </el-form-item>

            <el-form-item label="黑名单限购最大充值气量" prop="blackMaxVolume">
              <el-input v-model="form.blackMaxVolume" :disabled="form.openBlackList===0">黑名单限购最大充值气量</el-input>
            </el-form-item>
          </div>
        </el-form-item>
        <div class="clearfix"></div> -->

        <!--启动安检限购-->
        <!-- <el-form-item label="安检限购">
          <div class="groupBox">
            <el-form-item label="是否启动安检限购">
              <el-checkbox v-model="form.openCheckLimit" :true-label="1" :false-label="0">启动安检限购</el-checkbox>
            </el-form-item>

            <el-form-item label="安检限购最大充值金额" prop="checkMaxMoney">
              <el-input v-model="form.checkMaxMoney" :disabled="form.openCheckLimit===0" />
            </el-form-item>

            <el-form-item label="	安检限购最大充值气量" prop="checkMaxVolume">
              <el-input v-model="form.checkMaxVolume" :disabled="form.openCheckLimit===0" />
            </el-form-item>
          </div>
        </el-form-item>
        <div class="clearfix"></div> -->

        <!--费用结算日期-->
        <el-divider content-position="left">费用结算日期</el-divider>
        <el-form-item label="物联网抄表结算日期">
          <el-date-picker v-model="form.settlementDate" value-format="yyyy-MM-dd" />
        </el-form-item>

        <div class="clearfix"></div>

        <el-form-item>
          <el-button v-hasPermission="['functionConfig:save']" type="primary" @click="updateData('functionForm')">保存</el-button>
          <!-- <el-button v-else type="primary" @click="saveData('functionForm')">新增</el-button> -->
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import apiSysFuction from '@/api/system/sysFunction'
import {positiveNumberReg} from '@/utils/reg'

export default {
  name: 'FunctionConfig',
  data() {
    return {
      radio: 1,
      customer: 1,
      isAdd: false, // flag 用于识别是新增还是修改
      rules: {
        blackMaxMoney: [{pattern: positiveNumberReg, message: '数据不合法', trigger: 'blur'}],
        blackMaxVolume: [{pattern: positiveNumberReg, message: '数据不合法', trigger: 'blur'}],
        checkMaxMoney: [{pattern: positiveNumberReg, message: '数据不合法', trigger: 'blur'}],
        checkMaxVolume: [{pattern: positiveNumberReg, message: '数据不合法', trigger: 'blur'}],
      },

      // 表单数据
      form: this.initForm(),

    }
  },
  created() {
    this.getData()
  },
  methods: {

    // 获取数据
    getData() {
      apiSysFuction.page().then(res => {
        const {data, isSuccess} = res.data
        // 如果成功且有数据
        if (isSuccess) {
          const result = data ?? {}
          this.form = {
            ...result
          }
        }
      })
    },

    // 保存|新增数据
    // saveData(formName) {
    //   // console.log(this.form);    return
    //   this.$refs[formName].validate(valid => {
    //     if (valid) {
    //       apiSysFuction.add(this.form).then(res => {
    //         let { isSuccess } = res.data
    //         // 如果成功且有数据
    //         if (isSuccess) {
    //           this.msg('新增成功', 'success')
    //           this.getData()
    //         }
    //       })
    //     }
    //   })
    // },

    // 更新数据
    updateData(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          apiSysFuction.update(this.form).then(res => {
            let {isSuccess} = res.data
            // 如果成功且有数据
            if (isSuccess) {
              this.msg('修改成功', 'success')
              this.getData()
            }
          })
        }
      })
    },

    // 初始化表单数据
    initForm() {
      return {
        invoiceCompanyName: '', // 票据公司名称
        blackMaxMoney: 0,
        blackMaxVolume: 0,
        checkMaxMoney: 0,
        checkMaxVolume: 0,
        companyCode: '',
        companyName: '',
        openBlackList: 0, //  启用黑名单限购
        openCheckLimit: 0, // 启动安检限购
        openCustomerPrefix: 0, // 自编客户编号前缀
        customerPrefix: '', // 客户编号前缀
        // openIdCard: 0, // 启用ID卡
        // openVatInvoice: 0, // 启用增值税发票
        settlementDate: '', // 费用结算日期
        // taxRate:null, // 税率
        rounding: null,  //取整 1向上 0向下
        transferAccountFlag: 1, // 过户修改缴费编号 1 是 0 否
        invoiceCodeRule: 1, // 发票编码规则设置 1 自动 0 人工 默认 1

      }
    },
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: auto;
    margin-bottom: 15px;

    .el-button {
      width: 100%;
    }
  }
}

.groupBox {
  border: 1px solid #eee;
  border-radius: 3px;
  padding: 10px 20px;

  .el-form-item{
    display: inline-block;
    margin-right: 30px;
  }

}

</style>
