<!-- 收费 -->
<template>
  <div>
    <!--开票信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">开票信息</span>
      </div>
      <el-form v-loading="loading" label-position="top" :model="invoiceForm" class="jh-text">
        <el-form-item label="历史发票记录">
          <el-select
            v-model="invoiceForm.buyerName"
            placeholder="请选择"
            clearable
            filterable
            allow-create
            @change="handleBuyerName"
          >
            <el-option
              v-for="(item, idx) in invoiceFormList"
              :key="item.buyerName"
              :label="item.buyerName"
              :value="idx"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label=" "></el-form-item>
        <el-form-item label=" "></el-form-item>
        <!-- <el-form-item label="发票编号">
          <el-input v-model="invoiceForm.invoiceNumber" :disabled="invoiceForm.invoiceValue.value === 'ELECTRONIC_INVOICE'"></el-input>
        </el-form-item> -->
        <el-form-item label="抬头类型">
          <el-select
            v-model="buyerTypeValue"
            clearable
            placeholder="选择抬头类型"
            @change="buyerTypeChange"
          >
            <el-option
              v-for="item in buyerType"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="发票类型">
          <el-select v-model="invoiceForm.invoiceValue" disabled clearable placeholder="选择发票">
            <el-option
              v-for="item in invoiceType"
              :key="item.value"
              :label="item.label"
              :value="item"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="发票抬头">
          <el-input v-model="buyerName" @focus="inputFocus($event)"></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="invoiceForm.buyerPhone" @focus="inputFocus($event)"></el-input>
        </el-form-item>
        <el-form-item label="纳税人识别号">
          <el-input
            v-model="invoiceForm.buyerTinNo"
            :disabled="buyerTypeValue === 'company'"
            @focus="inputFocus($event)"
          ></el-input>
        </el-form-item>
        <el-form-item label="开户行">
          <el-input
            v-model="invoiceForm.buyerBankName"
            :disabled="buyerTypeValue === 'company'"
            @focus="inputFocus($event)"
          ></el-input>
        </el-form-item>
        <el-form-item label="账号">
          <el-input
            v-model="invoiceForm.buyerBankAccount"
            :disabled="buyerTypeValue === 'company'"
            @focus="inputFocus($event)"
          ></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input
            v-model="invoiceForm.buyerAddress"
            :disabled="buyerTypeValue === 'company'"
            @focus="inputFocus($event)"
          ></el-input>
        </el-form-item>
        <el-form-item label="合计金额">
          <p>{{ invoiceForm.total }}</p>
        </el-form-item>
        <el-form-item label=" " class="btnBox">
          <el-button :loading="btnLoading" type="danger" @click="print">
            {{ invoiceForm.invoiceValue.value === 'ELECTRONIC_INVOICE' ? '开票' : '打印' }}
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import Api from '@/api/invoice/index'

export default {
  name: 'ChargeBox',
  props: {
    invoiceNoFromList: {
      type: null,
      default: null,
    },
    invoiceValueFromList: {
      type: null,
      default: null,
    },
    invoiceType: Array,
    totalMoney: {
      type: null,
      default: 0,
    },
    closeChargeBox: Function,
  },
  data() {
    return {
      btnLoading: false,
      loading: true,
      idAndNo: {},
      buyerName: '',
      invoiceFormList: [],
      invoiceForm: {
        invoiceValue: this.invoiceValueFromList, //发票类型
        invoiceNumber: this.invoiceNoFromList, //发票编号
        buyerPhone: '', //电话
        buyerName: '', //发票抬头
        buyerTinNo: '', //纳税人识别号
        buyerBankName: '', //银行名称
        buyerBankAccount: '', //银行账户
        buyerAddress: '', //银行地址
        total: this.totalMoney, //合计金额
      },
      buyerType: [
        {
          label: '个人',
          value: 'person',
        },
        {
          label: '公司',
          value: 'company',
        },
      ],
      buyerTypeValue: 'person',
    }
  },
  computed: {
    // invoiceValue() {
    //   return this.invoiceValueFromList
    // },
    // invoiceNumber() {
    //   return this.invoiceNoFromList
    // },
  },
  created() {
    // console.log(this.invoiceValueFromList)
  },
  methods: {
    //抬头选择事件
    buyerTypeChange() {
      const { buyerTypeValue } = this
      if (buyerTypeValue === 'company') {
        this.invoiceForm = {
          ...this.invoiceForm,
          buyerTinNo: '', //纳税人识别号
          buyerBankName: '', //银行名称
          buyerBankAccount: '', //银行账户
          buyerAddress: '', //银行地址
        }
      }
    },
    //聚焦时全选
    inputFocus(event) {
      event.currentTarget.select()
    },
    //切换发票抬头
    handleBuyerName(val) {
      this.invoiceForm = { ...this.invoiceForm, ...this.invoiceFormList[val] }
      this.buyerName = this.invoiceForm.buyerName
      this.buyerTypeValue = 'person'
    },
    //获取chargeId,chargeNo
    getIdAndNo(id, no) {
      this.idAndNo = {
        chargeId: id,
        chargeNo: no,
      }
    },
    //打印按钮
    print() {
      let params = {
        ...this.invoiceForm,
        ...this.idAndNo,
        buyerName: this.buyerName,
        invoiceType: this.invoiceForm.invoiceValue.value,
      }
      this.btnLoading = true
      Api.printInvoiceByCharge(params)
        .then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            setTimeout(() => {
              this.$message({
                message: '操作成功！',
                type: 'success',
              })
            }, 1500)
            this.closeChargeBox()
          }
        })
        .finally(() => {
          this.btnLoading = false
        })
    },
    getBuyerTaxInfo(customerCode) {
      Api.getBuyerTaxInfo({ customerCode: customerCode }).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          const { invoiceFormList } = this
          if (data.length) {
            data.forEach(i => {
              let invoiceForm = {}
              invoiceForm.buyerPhone = i.buyerPhone
              invoiceForm.buyerName = i.buyerName
              invoiceForm.buyerTinNo = i.buyerTinNo
              invoiceForm.buyerBankName = i.buyerBankName
              invoiceForm.buyerBankAccount = i.buyerBankAccount
              invoiceForm.buyerAddress = i.buyerAddress
              invoiceFormList.push(invoiceForm)
            })
            this.invoiceForm = {
              ...this.invoiceForm,
              ...invoiceFormList[invoiceFormList.length - 1],
            }
            this.buyerName = this.invoiceForm.buyerName
          }
          this.loading = false
        }
      })
    },
  },
}
</script>

<style lang="scss" scoped>
.el-form-item {
  width: calc(100% / 3);
  float: left;
  padding: 0 20px 0 10px;
}
.el-card {
  border: 0;
  ::v-deep .el-card__header {
    border: 0;
    padding-left: 0;
  }
}
.btnBox {
  width: 100%;
  float: none !important;
  margin: 0 auto;
  padding: 0;
  .el-button {
    width: 36% !important;
    float: none !important;
  }
}
</style>
