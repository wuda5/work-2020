<!--过户-->
<template>
  <div v-loading="loading">
    <el-steps :active="curStep" finish-status="success">
      <template v-if="isCharge">
        <el-step title="选择过户对象"></el-step>
        <el-step title="支付"></el-step>
        <el-step title="完成"></el-step>
      </template>
      <template v-else>
        <el-step title="选择过户对象"></el-step>
        <el-step title="完成"></el-step>
      </template>
    </el-steps>

    <el-divider></el-divider>
    <!-- 选择过户对象  -->
    <div v-if="isInputInfo">
      <!--表具信息-->
      <span class="subTitle">表具信息</span>
      <el-form v-if="curMeter" label-position="top" class="jh-text meterInfo">
        <el-form-item label="缴费编号">
          {{ curMeter.customerChargeNo || emptyStr }}
        </el-form-item>
        <el-form-item label="客户名称">
          <p>{{ curMeter.customerName || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="客户类型">
          {{ curMeter.customerTypeName || emptyStr }}
        </el-form-item>
        <el-form-item label="电话">
          {{ curMeter.telphone || emptyStr }}
        </el-form-item>
        <el-form-item label="表类型">
          {{ dictMap.ORDER_SOURCE_NAME[curMeter.orderSourceName] }}
        </el-form-item>

        <!-- <el-form-item label="气表编号">
          {{ curMeter.gasCode || emptyStr }}
        </el-form-item> -->
        <el-form-item label="表身号">
          {{ curMeter.gasMeterNumber || emptyStr }}
        </el-form-item>

        <el-form-item label="气表厂家">
          {{ curMeter.gasMeterFactoryName || emptyStr }}
        </el-form-item>

        <el-form-item label="气表版号">
          {{ curMeter.gasMeterVersionName || emptyStr }}
        </el-form-item>
      </el-form>
      <el-divider></el-divider>
      <el-row :gutter="15">
        <el-col :span="14">
          <!-- search -->
          <search-box>
            <el-input
              v-model.trim="searchCondition.customerName"
              clearable
              placeholder="客户姓名"
            />
            <el-input v-model.trim="searchCondition.telphone" clearable placeholder="联系电话" />
            <el-input v-model.trim="searchCondition.idCard" clearable placeholder="身份证" />
            <el-button type="primary" :loading="searchLoading" @click="search">查询</el-button>
          </search-box>

          <!-- list -->
          <el-table :border="true" highlight-current-row :data="userListData" height="380px" @row-click="rowClick">
            <el-table-column type="index" label="#" width="45" />
            <!-- 客户姓名 -->
            <el-table-column prop="customerName" label="客户姓名" width="80" />
            <!-- 身份证号码 -->
            <el-table-column prop="idCard" label="身份证号码" show-overflow-tooltip width="150" />
            <!-- 联系电话 -->
            <el-table-column prop="telphone" label="联系电话" width="100" />
            <!-- 安装地址 -->
            <el-table-column prop="contactAddress" label="安装地址" width="230" show-overflow-tooltip />
          </el-table>
          <pagination
            :page-sizes="[10, 15, 20, 30]"
            layout="total,prev, next,jumper"
            :page.sync="searchCondition.pageNo"
            :limit.sync="searchCondition.pageSize"
            :total="total"
            @pagination="search"
          />
        </el-col>
        <el-col :span="10">
          <!--过户对象信息-->
          <el-card shadow="never" class="no-border">
            <div slot="header">
              <search-box>
                <div slot="left">
                  <span class="card-title">过户到</span>
                </div>
                <div slot="right">
                  <el-button :disabled="addNewUserDisabled" @click="addNewUser">新增客户</el-button>
                </div>
              </search-box>

            </div>
            <el-form
              v-if="curUser"
              ref="userFrom"
              :rules="rules"
              :model="curUser"
              :disabled="disabledUserForm"
              label-position="top"
              class="jh-text userForm"
            >
              <el-form-item label="客户名称" prop="customerName">
                <el-input v-model="curUser.customerName"></el-input>
              </el-form-item>
              <el-form-item label="性别" prop="sex">
                <el-select v-model="curUser.sex">
                  <el-option
                    v-for="item in dict.SEX"
                    :key="item.id"
                    :value="item.code"
                    :label="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="身份证号" style="width: 100%" prop="idCard">
                <el-input v-model="curUser.idCard"></el-input>
              </el-form-item>
              <el-form-item label="客户类型" prop="customerTypeCode">
                <el-select v-model="curUser.customerTypeCode">
                  <el-option
                    v-for="item in dict.USER_TYPE"
                    :key="item.id"
                    :value="item.code"
                    :label="item.name"
                  ></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="电话" prop="telphone">
                <el-input v-model="curUser.telphone"></el-input>
              </el-form-item>
              <el-form-item label="安装地址" style="width: 100%">
                <el-input v-model="curUser.contactAddress"></el-input>
              </el-form-item>
            </el-form>
          </el-card>

          <!--缴费编号 选填-->
          <br>
          <el-card v-if="openChargeFlag" shadow="never" class="no-border">
            <div slot="header">
              <span class="card-title">缴费编号</span>
            </div>
            <el-input v-model="customerChargeNo" placehoder="缴费编号"></el-input>
          </el-card>
          <br>
          <el-card v-if="curUser" shadow="never" class="no-border">
            <div slot="header">
              <span class="card-title">使用人数</span>
            </div>
            <el-input v-model="population" placehoder="使用人数"></el-input>
          </el-card>
          <br>
        </el-col>
      </el-row>

      <div class="text-right">
        <el-button v-if="curUser" type="primary" @click="handleTransferAccount">过户</el-button>
      </div>
    </div>
    <!-- 支付  -->
    <div v-if="isShowCharge">
      <!--收费信息-->
      <el-card shadow="never" class="no-border">
        <div slot="header">
          <span class="card-title">收费信息</span>
        </div>
        <el-row :gutter="20">
          <!--收费列表-->
          <qc-charge
            scene="transfer"
            :customer-code="curUser.customerCode"
            :gas-meter-code="curMeter.gasCode"
            :biz-no-or-id="curBusinees.id"
            :customer-charge-no="customerChargeNo"
            :scene-handle="transferSuccess"
            :handle-end="handleTransferChargeEnd"
          ></qc-charge>
        </el-row>
      </el-card>
      <!-- <div class="text-right">
        <el-button type="primary" @click="next">下一步</el-button>
      </div> -->
    </div>
    <div v-if="isFinish">
      <!--确定-->
      <h1 class="success">
        <i class="el-icon-success"></i>
        业务办理成功!
      </h1>
      <p class="success-text">即将返回……</p>
      <div class="text-right">
        <el-button type="primary" @click="finished">完成</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import getUserInfoApi from '@/api/userInfo/index'
import temporaryApi from '@/api/temporary/index.js'
import QcCharge from '@/components/QcCharge/index'
import {initQueryParams} from '@/utils/commons'
import {idcardReg, mobileReg} from '@/utils/reg';
import {chargeSceneFields} from '@/enums/business'

export default {
  name: 'MeterTransfer',
  components: {
    QcCharge,
  },
  props: {
    step: Number,
    curMeter: Object,
    customerCode: String,

    // 是否收费
    isCharge: {
      type: Boolean,
      default: false
    },

    // 开启输入缴费编号
    openChargeFlag: {
      type: Boolean,
      default: false
    },
  },
  data() {
    return {
      // 当前步骤
      curStep: this.step || 1,
      searchCondition: this.initSearchCondition(),
      total: 0,
      searchLoading: false,
      curUser: null,
      curBusinees: null,
      userListData: [],
      customerChargeNo: '',
      population: '', // 使用人数
      // disabledUserForm:true
      rules: {
        customerName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.customerName')}`,
            trigger: 'blur',
          },
          {max: 100, message: '用户名不能超过100个字符'}
        ],
        telphone: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.telphone')}`,
            trigger: 'blur',
          },
          {pattern: mobileReg, message: this.$t('customerInfo.telphoneHint'), trigger: 'blur'},
        ],
        customerTypeCode: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('customerInfo.customerTypeCode')}`,
            trigger: 'blur',
          },
        ],
        sex: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('customerInfo.sex')}`,
            trigger: 'blur',
          },
        ],
        idCard: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.idCard')}`,
            trigger: 'blur',
          },
          {pattern: idcardReg, message: this.$t('customerInfo.idCardHint'), trigger: 'blur'},
        ],
      },
      loading: false, // 全局loading
      addNewUserDisabled: false
    }
  },
  computed: {
    disabledUserForm: function () {
      let ret = true
      if (this.curUser && !this.curUser.id) {
        ret = false
      }
      return ret
    },
    // 是否是确认信息步骤
    isInputInfo() {
      return +this.curStep === 1
    },
    // 是否是收费
    isShowCharge() {
      return this.isCharge && +this.curStep === 2
    },
    // 是否到完成的步骤了
    isFinish() {
      return +this.curStep >= 3 || (!this.isCharge && +this.curStep === 2)
    }
  },
  watch: {
    // 监听当前步骤, 如果是完成步骤，则执行操作
    curStep(value) {
      if (this.isFinish) {
        this.$emit('success', true)
        this.$nextTick(() => {
          setTimeout(() => {
            this.$emit('close', true)
          }, 2000)
        })
      }
    },
  },
  async created() {
    this.loading = true
    // this.showChargeStep = await this.whetherSceneCharge(chargeSceneFields.TRANSFER)
    this.loading = false
  },
  methods: {
    next() {
      this.curStep++
      // if (this.curStep++ > 3) this.curStep = 4;
    },

    // 客户列表表格行点击,根据返回值是否显示缴费编号
    rowClick(row) {
      if (row.customerCode === this.curMeter.customerCode) {
        this.msg('选择的新老客户为同一客户，无需过户', 'error')
        return
      }

      if (this.$refs['userFrom']) {
        this.$refs['userFrom'].resetFields();
      }

      this.curUser = JSON.parse(JSON.stringify(row))
    },

    // 新增客户
    addNewUser() {
      this.curUser = {
        customerName: '', // 客户名称
        sex: '',
        customerTypeCode: '', // 客户类型
        telphone: '', // 联系电话
        idCard: '', // 身份证
        contactAddress: '', // 联系地址
        customerCode:'' // 客户编号
      }
      this.addNewUserDisabled = true
    },

    // 初始化搜索条件
    initSearchCondition() {
      return {
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        idCard: '', // 身份证
        pageSize: 10, // 一页显示几条数据
        pageNo: 1, // 当前第几页
        customerStatus: 1
      }
    },

    search(params = {}) {
      this.searchLoading = true
      getUserInfoApi
        .getListData(this.searchCondition)
        .then(response => {
          this.loading = false
          const {isSuccess, data} = response.data
          if (isSuccess) {
            this.userListData = data.records
            this.total = parseInt(data.total)
          }
        })
        .finally(() => (this.searchLoading = false))
    },

    handleTransferAccount() {
      this.$refs['userFrom'].validate((valid) => {
        if (valid) {
          this.transferAccount()
        } else {
          return false
        }
      })
    },

    // 过户
    transferAccount() {
      // 过户传递参数
      if (this.openChargeFlag && !this.customerChargeNo) {
        this.$message.warning('缴费编号必填')
        return
      }
      this.loading = true

      let data = {
        contactAddress: this.curUser.contactAddress,
        customerName: this.curUser.customerName,
        customerTypeCode: this.curUser.customerTypeCode,
        idCard: this.curUser.idCard,
        sex: this.curUser.sex,
        telphone: this.curUser.telphone,

        customerCode: this.curUser.customerCode,
        gasMeterCode: this.curMeter.gasCode,
        oldCustomerCode: this.curMeter.customerCode,
        customerChargeNo: this.customerChargeNo,
        population: this.population,
      }

      temporaryApi.transferAccount(data).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.curUser.customerCode = data.customerCode
          this.curBusinees = data
          this.customerChargeNo = data.customerChargeNo
          this.population = data.population
          console.log('过户成功', data)
          // 需要传递给收费组件的参数
          this.curStep++

        }
      }).finally(() => {
        this.loading = false
        this.addNewUserDisabled = false
      })
    },

    // end
    finished() {
      this.$emit('close', false)
    },
    //过户成功
    transferSuccess(callBack) {
      callBack()
    },

    // 过户步骤全部完成
    handleTransferChargeEnd() {
      this.$loading().setText('收费成功，交互中……')
      this.next()
      this.$loading().close()
    }
  },
}
</script>

<style lang="scss" scoped>
@import '~@/styles/variables.scss';

.meterInfo {
  .el-form-item {
    width: auto;
    float: left;
    margin-right: 20px;
  }
}

.userForm {
  .el-form-item {
    margin-bottom: 20px;
  }
}

.search {
  width: 450px;

  .el-button {
    float: left;
  }
}

.success {
  color: #13ce66;
  text-align: center;
  padding-top: 50px;
}

.success-text {
  font-size: 16px;
  color: #666;
  text-align: center;
  padding-bottom: 50px;
}

// 设置表格头部背景
::v-deep .el-table th {
  background-color: #f5f7fa !important;
}
</style>
