<template>
  <el-dialog :title="$t('common.view')" :visible.sync="isVisible" width="700px" class="user-view">
     <h3>基本信息</h3>
    <el-row :gutter="10">
      <el-col :sm="16" :xs="16">
        <div class="view-item">
          <span>客户编号：</span>
          {{ user.customerCode }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>客户姓名：</span>
          {{ user.customerName }}
        </div>
      </el-col>
     
    </el-row>
    <el-row :gutter="10">
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>客户性别：</span>
          {{ user.sex | sexFilter }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>客户状态：</span>
          {{ user.customerStatus | statusFilter }}
        </div>
      </el-col>
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>客户类型：</span>
          {{ user.customerTypeName }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>创建时间：</span>
          {{ user.createTime }}
        </div>
      </el-col>
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>联系电话：</span>
          {{ user.telphone }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>住址：</span>
          {{ user.contactAddress }}
        </div>
      </el-col>
    </el-row>
   <el-row :gutter="10">
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>证件类型：</span>
          {{ user.idTypeName }}
        </div>
      </el-col>
       <el-col :sm="16" :xs="16">
        <div class="view-item">
          <span>证件号码：</span>
          {{ user.idNumber }}
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="10">
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>持卡人：</span>
          {{ user.cardholder }}
        </div>
      </el-col>
       <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>银行账号：</span>
          {{ user.bankAccount }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>开户行：</span>
          {{ user.bank }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>代扣合同编号：</span>
          {{ user.contractNumber }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>代扣签约状态：</span>
          {{ user.contractStatus | contractStatusFilter }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>保险到期时间：</span>
          {{ user.insuranceEndTime }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>保险编号：</span>
          {{ user.insuranceNo }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>发票地址：</span>
          {{ user.invoiceAddress }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>开发行：</span>
          {{ user.invoiceBankAccount }}
        </div>
      </el-col>
      <el-col :sm="8" :xs="8">
        <div class="view-item">
          <span>组织名称：</span>
          {{ user.orgName }}
        </div>
      </el-col>
    </el-row>
  </el-dialog>
</template>

<script>

  export default {
    name: 'UserView',
    filters:{
      //客户性别
      sexFilter(val){
        return val==0 ? '男' : '女'
      },
      //客户状态
      statusFilter(val){
        if(val==1)
          return '预建档'
        else if(val==2)
          return '有效'
        else
          return '销户'
      },
      //代扣签约状
      contractStatusFilter(val){
        return val ? '已签约' : '未签约'
      }
    },
    props: {
      dialogVisible: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
        screenWidth: 0,
        width: this.initWidth(),
        user: {
          
        }
      }
    },
    computed: {
      isVisible: {
        get() {
          return this.dialogVisible
        },
        set() {
          this.close()
        }
      }
    },
    
    mounted() {
      window.onresize = () => {
        return (() => {
          this.width = this.initWidth()
        })()
      }
    },
    methods: {
      initWidth() {
        this.screenWidth = document.body.clientWidth
        if (this.screenWidth < 550) {
          return '95%'
        } else if (this.screenWidth < 990) {
          return '580px'
        } else if (this.screenWidth < 1400) {
          return '600px'
        } else {
          return '650px'
        }
      },
      setUser(val) {
        this.user = {...val}
      },
      close() {
        this.$emit('close')
      }
    }
  }
</script>
<style lang="scss" scoped>
  .user-view {
    .img-wrapper {
      text-align: center;
      margin-bottom: -15px;
      img {
        width: 4rem;
        border-radius: 50%;
      }
    }
    .view-item {
      margin: 10px;
      i {
        font-size: 0.97rem;
      }
      span {
        margin-left: 5px;
      }
    }
  }
</style>
