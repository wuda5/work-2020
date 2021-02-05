<!-- 收费 -->
<template>
  <div>
    <!--发票信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">发票信息</span>
      </div>
      <el-form label-position="top" :model="invoiceDetailForm" class="jh-text">
        <el-form-item label="发票编号">
          <el-input v-model="invoiceDetailForm[1]"></el-input>
        </el-form-item>
        <el-form-item label="发票类型">
          <el-input v-model="invoiceDetailForm[2]"></el-input>
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="invoiceDetailForm[8]"></el-input>
        </el-form-item>
        <el-form-item label="发票抬头">
          <el-input v-model="invoiceDetailForm[5]"></el-input>
        </el-form-item>
        <el-form-item label="纳税人识别号">
          <el-input v-model="invoiceDetailForm[6]"></el-input>
        </el-form-item>
        <el-form-item label="开户行">
          <el-input v-model="invoiceDetailForm[9]"></el-input>
        </el-form-item>
        <el-form-item label="账号" style="width: 50%">
          <el-input v-model="invoiceDetailForm[10]"></el-input>
        </el-form-item>
        <el-form-item label="地址" style="width: 50%">
          <el-input v-model="invoiceDetailForm[7]"></el-input>
        </el-form-item>
      </el-form>
    </el-card>
    <!--核算信息-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">核算信息</span>
      </div>
      <el-form label-position="top" :model="invoiceDetailForm" class="jh-text">
        <el-form-item label="支付方式" style="width: 20%">
          <el-select clearable placeholder="请选择">
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
        <el-form-item label="合计金额" style="width: 20%; margin-left: 30px">
          <p>10</p>
        </el-form-item>
        <el-form-item label=" " class="btnBox">
          <el-button type="danger">收费</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
const cityOptions = [
  {
    label: '未开票',
    value: 1
  },
  {
    label: '票据',
    value: 2
  },
  {
    label: '普票',
    value: 3
  },
  {
    label: '专票',
    value: 4
  },
  {
    label: '电子票',
    value: 5
  },
  {
    label: '红票',
    value: 6
  },
  {
    label: '废票',
    value: 7
  },
  {
    label: '蓝票',
    value: 8
  }

]
export default {
  name: 'ChargeBox',
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
      invoiceList: [
        {
          1: '12955658744',
          2: '专票',
          3: '蓝票',
          4: '已开',
          5: '秦川物联网科技有限公司',
          6: '12658945465+6596',
          7: '车城大道254号',
          8: '13812577854',
          9: '总共银行',
          10: '889895665363223233'
        },
        {
          1: '12955658744',
          2: '专票',
          3: '蓝票',
          4: '已开',
          5: '秦川物联网科技有限公司',
          6: '12658945465+6596',
          7: '车城大道254号',
          8: '13812577854',
          9: '总共银行',
          10: '889895665363223233'
        }
      ],
      invoiceDetailList: [
        {
          1: '燃气费',
          2: 1,
          3: 100,
          4: 100
        },
        {
          1: '燃气费',
          2: 1,
          3: 100,
          4: 100
        }
      ],
      // 收费表单
      invoiceDetailForm: {
        1: '12955658744',
        2: '专票',
        3: '蓝票',
        4: '已开',
        5: '秦川物联网科技有限公司',
        6: '11112222333366655544',
        7: '车城大道254号',
        8: '13812577854',
        9: '总共银行',
        10: '889895665363223233'
      },

      // 发票管理搜索
      checkAll: false,
      isIndeterminate: true,
      checkedCities: [],
      cities: cityOptions
    }
  },
  computed: {},
  methods: {
    handleCheckAllChange(val) {
      const all = []
      cityOptions.forEach(function (item) {
        all.push(item.value)
      })

      this.checkedCities = val ? all : []
      this.isIndeterminate = false
    },
    handleCheckedCitiesChange(value) {
      const checkedCount = value.length
      this.checkAll = checkedCount === this.cities.length
      this.isIndeterminate = checkedCount > 0 && checkedCount < this.cities.length
    }
  }

}
</script>

<style lang="scss" scoped>
  .el-form-item {
    width: calc(100% / 3);
    float: left;
  }

  .btnBox {
    width: 20%;
    float: right;
    .el-button {
      width: 100%;
    }
  }

</style>
