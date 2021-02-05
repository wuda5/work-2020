<!--支付配置-->
<template>
  <div class="qc-main">
    <!--支付宝配置-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">支付宝配置</span>
      </div>
      <!--表单-->
      <el-form v-if="aliForm" label-position="top" class="jh-text" :model="aliForm">
        <!--使用总公司账号-->
        <el-form-item>
          <el-checkbox v-model="aliForm.usedParentPay" :true-label="1" :false-label="0">使用总公司账号</el-checkbox>
        </el-form-item>

        <!--是否启用支付宝-->
        <el-form-item>
          <el-checkbox v-model="aliForm.dataStatus" :true-label="1" :false-label="0">启用支付宝</el-checkbox>
        </el-form-item>

        <!--是否启用支付通-->
        <el-form-item>
          <el-checkbox v-model="aliForm.interfaceMode" :true-label="1" :false-label="0">启用支付通</el-checkbox>
        </el-form-item>

        <div class="clearfix"></div>
        <!--APPID-->
        <el-form-item label="APPID">
          <el-input v-model="aliForm.appId" />
        </el-form-item>
        <!--APP密钥-->
        <el-form-item label="APP密钥">
          <el-input v-model="aliForm.appSecret" />
        </el-form-item>
        <div class="clearfix"></div>
        <!--操作按钮-->
        <el-form-item>
          <el-button v-if="aliForm.id" v-hasPermission="['pay:save']" type="primary" class="width100" @click="updateAli">保存</el-button>
          <el-button v-else v-hasPermission="['pay:save']" type="primary" class="width100" @click="addAli">新增</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <br />

    <!--微信配置-->
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">微信配置</span>
      </div>
      <!-- 表单 -->
      <el-form v-if="wxForm" label-position="top" class="jh-text" :model="wxForm">
        <el-form-item>
          <el-checkbox v-model="wxForm.usedParentPay" :true-label="1" :false-label="0">使用总公司账号</el-checkbox>
        </el-form-item>
         <!--是否启用微信支付-->
        <el-form-item>
          <el-checkbox v-model="wxForm.dataStatus" :true-label="1" :false-label="0">启用微信支付</el-checkbox>
        </el-form-item>

        <!--是否启用支付通-->
        <el-form-item>
          <el-checkbox v-model="wxForm.interfaceMode" :true-label="1" :false-label="0">启用支付通</el-checkbox>
        </el-form-item>
        <div class="clearfix"></div>
        <el-form-item label="APPID">
          <el-input v-model="wxForm.appId" />
        </el-form-item>
        <el-form-item label="商户号">
          <el-input v-model="wxForm.merchantNo" />
        </el-form-item>
        <el-form-item label="API密钥">
          <el-input v-model="wxForm.apiSecret" />
        </el-form-item>
        <el-form-item label="APPSecret">
          <el-input v-model="wxForm.appSecret" />
        </el-form-item>
        <div class="clearfix"></div>
        <el-form-item>
          <el-button v-if="wxForm.id" v-hasPermission="['pay:save']" type="primary" class="width100" @click="updateWX">保存</el-button>
          <el-button v-else v-hasPermission="['pay:save']" type="primary" class="width100" @click="addWX">新增</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import apiPay from '@/api/system/payConfig'

export default {
  name: 'Pay',
  data() {
    return {

      aliSearch: {
        current: 1,
        map: {},
        model: {
          payCode: 'ALIPAY',
          companyCode: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },

      wxSearch: {
        current: 1,
        map: {},
        model: {
          payCode: 'WECHAT',
          companyCode: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      aliForm: null,
      wxForm: null,
    }
  },
  created() {
    this.getAliPayData()
    this.getWXPayData()
  },
  methods: {
    /* 初始化阿里支付数据 */
    initAliData() {
      return {
        accountLevel: 0,
        apiSecret: '',
        appId: '',
        appSecret: '',
        companyCode: '',
        companyName: '',
        deleteStatus: 0,
        merchantNo: '',
        orgId: 0,
        orgName: '',
        payCode: '',
        payStatus: 0,
        payType: '',
        remark: '',
        usedParentPay: 0,
        dataStatus:1, // 是否启用微信支付
        interfaceMode:1 // 使用成都支付通 ：1：使用 0：不使用
      }
    },

    /* 初始化微信支付数据 */
    initWxData() {
      return {
        accountLevel: 0,
        apiSecret: '',
        appId: '',
        appSecret: '',
        companyCode: '',
        companyName: '',
        deleteStatus: 0,
        merchantNo: '',
        orgId: 0,
        orgName: '',
        payCode: '',
        payStatus: 0,
        payType: '',
        remark: '',
        usedParentPay: 0,
        dataStatus:1, // 是否启用微信支付
        interfaceMode:1 // 使用成都支付通 ：1：使用 0：不使用
      }
    },

    // 获取支付宝数据
    getAliPayData() {
      apiPay.page(this.aliSearch).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          if (res1.data.records.length > 0) {
            this.aliForm = res1.data.records[0]
          } else {
            this.aliForm = this.initAliData()
          }
        }
      })
    },

    // 获取微信数据
    getWXPayData() {
      apiPay.page(this.wxSearch).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          if (res1.data.records.length > 0) {
            this.wxForm = res1.data.records[0]
          } else {
            this.wxForm = this.initWxData
          }
        }
      })
    },

    // add 支付宝
    addAli() {
      this.aliForm.payCode = 'ALIPAY'
      apiPay.add(this.aliForm).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.getAliPayData()
          this.msg('新增成功', 'success')
        }
      })
    },

    // update 支付宝
    updateAli() {
      this.aliForm.payCode = 'ALIPAY'
      apiPay.update(this.aliForm).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.getAliPayData()
          this.msg('更新成功', 'success')
        }
      })
    },

    // add 微信
    addWX() {
      this.wxForm.payCode = 'WECHAT'
      apiPay.add(this.wxForm).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.getWXPayData()
          this.msg('新增成功', 'success')
        }
      })
    },

    // update 微信
    updateWX() {
      this.wxForm.payCode = 'WECHAT'
      apiPay.update(this.wxForm).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.getWXPayData()
          this.msg('更新成功', 'success')
        }
      })
    },
  },
}
</script>
<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 6);
      margin-bottom: 15px;
    }
  }
</style>
