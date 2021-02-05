<!--
 * @Description: 收费
 * @Author: lingw
 * @Date: 2020-10-23 11:17:15
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 14:48:39
-->
<template>
  <div>
    <el-input v-model="queryString" style="width: 200px;" placeholder="请输入内容" class="input-with-select charge-section">
      <el-button slot="append" icon="el-icon-search" @click="handleSearch" />
    </el-input>
    <el-table :data="userList" :border="false" highlight-current-row class="charge-section">
      <el-table-column label="用户编号">
        <template slot-scope="{row}">
          {{ row.code }}
        </template>
      </el-table-column>
      <el-table-column label="用户名称">
        <template slot-scope="{row}">
          {{ row.name }}
        </template>
      </el-table-column>
      <el-table-column label="证件类型">
        <template slot-scope="{row}">
          {{ row.cardType }}
        </template>
      </el-table-column>
      <el-table-column label="证件号码">
        <template slot-scope="{row}">
          {{ row.idCard }}
        </template>
      </el-table-column>
      <el-table-column label="性别">
        <template slot-scope="{row}">
          {{ row.sex }}
        </template>
      </el-table-column>
      <el-table-column label="联系电话">
        <template slot-scope="{row}">
          {{ row.phone }}
        </template>
      </el-table-column>
      <el-table-column label="地址">
        <template slot-scope="{row}">
          {{ row.address }}
        </template>
      </el-table-column>
    </el-table>
    <el-form v-model="userInfo" class="jh-text" label-position="top">
      <el-card shadow="never" class="charge-section">
        <div slot="header">
          <span class="card-title">购买人信息</span>
        </div>
        <el-form-item label="客户编号">
          <p>{{ userInfo.code }}</p>
        </el-form-item>
        <el-form-item label="客户姓名">
          <el-input v-model="userInfo.name" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="userInfo.phone" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="送货地址">
          <el-input v-model="userInfo.address" style="width: 120px;" />
        </el-form-item>
      </el-card>
      <el-card shadow="never" class="charge-section">
        <div slot="header">
          <span class="card-title">
            开票信息
          </span>
        </div>
        <el-form-item label="发票编号">
          <p>{{ userInfo.invoiceNo | emptyStr }}</p>
        </el-form-item>
        <el-form-item label="发票类型">
          <el-input v-model="userInfo.invoiceType" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="联系电话">
          <el-input v-model="userInfo.telphone" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="发票抬头">
          <el-input v-model="userInfo.buyerName" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="纳税人识别号">
          <el-input v-model="userInfo.buyerTinNo" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="开户行名称">
          <el-input v-model="userInfo.buyerBankName" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="开户行账号">
          <el-input v-model="userInfo.buyerBankAccount" style="width: 120px;" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="userInfo.buyerAddress" style="width: 120px;" />
        </el-form-item>
      </el-card>
      <el-card shadow="never" class="charge-section">
        <div slot="header">
          <span class="card-title">结算信息</span>
        </div>
        <div class="charge-footer-container">
          <div class="charge-footer-left">
            <el-form-item label="支付方式">
              <el-select v-model="userInfo.action" style="width: 120px;">
                <el-option v-for="({ label, value }) in options" :key="value" :label="label" :value="value" />
              </el-select>
            </el-form-item>
            <el-form-item label="合计金额">
              <span>{{ userInfo.mount | emptyStr }}</span>
            </el-form-item>
          </div>
          <el-button type="danger">
            收费
          </el-button>
        </div>
      </el-card>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'Charge',
  props: {
    userList: {
      type: Array,
      default() {
        return []
      }
    }
  },
  data () {
    return {
      // 查询条件
      queryString: '',
      // 用户信息 form 表单数据
      userInfo: {},
      options: [
        {
          label: '微信',
          value: 'wechat'
        },
        {
          label: '支付宝',
          value: 'alipay'
        },
        {
          label: '银联',
          value: 'uninpay'
        }
      ]
    }
  },
  methods: {
    // 搜索
    handleSearch() {}
  }
}
</script>

<style lang='scss' scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 6);
  }
}
.charge-footer-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  .charge-footer-left {
    display: flex;
    justify-content: space-between;
  }
}
.charge-section:not(:last-child) {
  margin-bottom: 12px;
}
</style>
