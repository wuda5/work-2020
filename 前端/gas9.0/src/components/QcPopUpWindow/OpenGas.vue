<!-- 通气登记 -->
<template>
  <div v-loading="loading" class="form-page OpenGas-page">
    <el-form :ref="formRef" :model="form" :rules="formRules" :inline="true" label-position="top" class="qc-form clearfix">
      <!--缴费编号-->
      <el-form-item :label="$t('meterInfo.customerChargeNo')" prop="customerChargeNo">
        <el-tooltip v-if="form.customerChargeNo" :content="form.customerChargeNo" placement="bottom">
          <el-input v-model="form.customerChargeNo" :disabled="true" :placeholder="$t('meterInfo.customerChargeNo')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="form.customerChargeNo" :disabled="true" :placeholder="$t('meterInfo.customerChargeNo')"></el-input>
      </el-form-item>
      <!--客户编号-->
      <!-- <el-form-item :label="$t('customerInfo.customerCode')" prop="customerCode">
        <el-tooltip v-if="form.customerCode" :content="form.customerCode" placement="bottom">
          <el-input v-model="form.customerCode" :disabled="true" :placeholder="$t('customerInfo.customerCode')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="form.customerCode" :disabled="true" :placeholder="$t('customerInfo.customerCode')"></el-input>
      </el-form-item> -->
      <!--客户名称-->
      <el-form-item :label="$t('customerInfo.customerName')" prop="customerName">
        <el-input v-model="form.customerName" :disabled="true" :placeholder="$t('customerInfo.customerName')"></el-input>
      </el-form-item>
      <!--客户电话-->
      <el-form-item :label="$t('customerInfo.telphone')" prop="telphone">
        <el-input v-model="form.telphone" :disabled="true" :placeholder="$t('customerInfo.telphone')"></el-input>
      </el-form-item>
      <!-- 气表编号 -->
      <!-- <el-form-item :label="$t('meterInfo.gasCode')" prop="gasCode">
        <el-tooltip v-if="form.gasCode" :content="form.gasCode" placement="bottom">
          <el-input v-model="form.gasCode" name="gasCode" clearable disabled :placeholder="$t('meterInfo.gasCode')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="form.gasCode" name="gasCode" clearable disabled :placeholder="$t('meterInfo.gasCode')"></el-input>
      </el-form-item> -->
      <!-- 表身号 -->
      <el-form-item :label="$t('meterInfo.gasMeterNumber')" prop="gasMeterNumber">
        <el-tooltip v-if="form.gasMeterNumber" :content="form.gasMeterNumber" placement="bottom">
          <el-input v-model="form.gasMeterNumber" name="gasMeterNumber" clearable disabled :placeholder="$t('meterInfo.gasMeterNumber')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="form.gasMeterNumber" name="gasMeterNumber" clearable disabled :placeholder="$t('meterInfo.gasMeterNumber')"></el-input>
      </el-form-item>
      <!-- 通气状态 -->
      <!-- <el-form-item :label="$t('meterInfo.ventilateStatus')" prop="ventilateStatus">
        <el-select v-model.number="form.ventilateStatus" name="ventilateStatus" clearable :placeholder="$t('meterInfo.ventilateStatus')">
          <el-option v-for="(value, key) in ventilateStatusMap" :key="key" :label="value" :value="+key" />
        </el-select>
      </el-form-item> -->
      <!-- 通气人 -->
      <el-form-item :label="$t('meterInfo.ventilateUserName')" prop="ventilateUserName">
        <el-select v-model.number="form.ventilateUserName" name="ventilateUserName" filterable :remote="false" :remote-method="handleSearchVentilateUser" :loading="ventilateUserListLoading" clearable :placeholder="$t('searchPlaceholder')" @change="handleVentilateUserChange">
          <el-option v-for="(item, index) in ventilateUserList" :key="index" :label="item.name" :value="item.name" />
        </el-select>
        <p class="hint-text">通气人只能在系统用户中进行选择</p>
      </el-form-item>
      <!-- 通气时间 -->
      <el-form-item prop="ventilateTime" :label="$t('meterInfo.ventilateTime')">
        <el-date-picker v-model="form.ventilateTime" type="date" value-format="yyyy-MM-dd" name="ventilateTime" :placeholder="$t('meterInfo.ventilateTime')"></el-date-picker>
      </el-form-item>
      <!-- 操作 -->
      <el-form-item v-if="!onlyView" label="" class="save-btn-box text-right fr">
        <el-button type="primary" name="openAccount" :loading="submitLoading" :disabled="submitLoading" class="save-btn" @click.native="handleSubmit">{{ $t('save') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import { isEmpty, isObjectLike, cloneDeep, isUndefined } from 'lodash'
import commonMixin from '@/mixins/common'
import formMixin from '@/mixins/form'
import { initQueryParams } from '@/utils/commons'
import { arrayCombine } from '@/utils/array'
import { gasMeterFormFieldsMap } from '@/lang/zh/modules/meterInfo'
import { dataStatusField } from '@/enums/common'
import { formStatusField } from '@/enums/form'
import { meterStatusField, ventilateStatusMap, ventilateStatusField } from '@/enums/meterInfo'
import { ventilation } from '@/api/userInfo/index'
import userApi from '@/api/User'

export default {
  name: 'OpenGas',
  components: {
  },
  filters: {},
  mixins: [commonMixin, formMixin],
  props: {
    // 需要修改的表单数据id
    id: {
      type: [String, Number],
      default: ''
    },
    // 表单数据
    formData: {
      type: Object,
      default: () => ({})
    },
    // 客户信息
    customerData: {
      type: Object,
      default: () => ({})
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false
    },
  },
  data() {
    this.ventilateStatusMap = ventilateStatusMap
    return {
      form: this.setInitForm(),
      // 表单验证规则
      formRules: {
        customerCode: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('customerInfo.customerCode')}`, trigger: 'blur' },
        ],
        customerName: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('customerInfo.customerName')}`, trigger: 'blur' },
        ],
        telphone: [
          { required: true, message: `${this.$t('inputHint')}${this.$t('customerInfo.telphone')}`, trigger: 'blur' },
        ],
        ventilateStatus: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.ventilateStatus')}`, trigger: 'change' },
        ],
        ventilateUserId: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.ventilateUserId')}`, trigger: 'change' },
        ],
        ventilateUserName: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.ventilateUserName')}`, trigger: 'change' },
        ],
        ventilateTime: [
          { required: true, message: `${this.$t('selectHint')}${this.$t('meterInfo.ventilateTime')}`, trigger: 'change' },
        ],
      },
      userList: [], // 所有有效用户
      ventilateUserList: [], // 供选择的通气员
      ventilateUserListLoading: false, // 供选择的通气员数据加载状态
    }
  },
  computed: {

  },
  watch: {
    id: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
    formData: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
    customerData: {
      handler(value) {
        this.initFormData()
      },
      immediate: false
    },
  },
  created() {
    this.initData()
    this.initFormData()
  },
  methods: {
    // 初始化表单数据
    setInitForm () {
      return {
        ...arrayCombine(Object.keys(gasMeterFormFieldsMap), new Array(Object.keys(gasMeterFormFieldsMap).length).fill('')),
        customerCode: '',
        customerName: '',
        telphone: '',
        id: '',
        dataStatus: meterStatusField.DTQ,
        ventilateStatus: ventilateStatusField.YES,
      }
    },
    // 初始化数据
    async initData() {
      await this.getValidUserList()
      this.ventilateUserList = this.userList
    },

    // 初始化监听的表单数据
    async initFormData() {
      this.loading = true
      this.setFormData()
      this.loading = false
    },

    // 设置表单数据
    async setFormData(data) {
      this.loading = true
      // 生成最终的表单数据源， 有可能是从prop传入，也有可能是父组件直接调用该方法传入
      if (!isObjectLike(data)) {
        if (this.id) {
          data = await this.getFormDataById(this.id)
        } else if (!isEmpty(this.formData)) {
          data = this.filterFormData({ ...this.customerData, ...this.formData, ventilateStatus: ventilateStatusField.YES })
        }
      }
      this.setFormStatus(data)
      await this.generateFormData(data)
      this.loading = false
    },

    // 设置表单状态
    setFormStatus (data) {
      let formStatus = formStatusField.ADD
      if (!isEmpty(data) && data.id) {
        formStatus = formStatusField.EDIT
      }
      this.formStatus = formStatus
    },

    // 获取表单数据通过porp id
    async getFormDataById(id) {
      return new Promise((resolve) => {
        // 这里通过接口获取数据，resolve返回
        resolve(true)
      })
    },

    // 获取表单数据
    async generateFormData (data) {
      if (!isEmpty(data)) {
        this.resetForm(data)
      } else {
        this.resetForm()
      }
    },

    // 对获取的表单数据进行过滤
    filterFormData(formData, initFormData) {
      const cloneInitFormData = cloneDeep(initFormData || (this.setInitForm?.() || (this.initForm || {})))
      const cloneFormData = cloneDeep(formData)
      for(const key in cloneInitFormData) {
        const value = cloneFormData[key]
        if (!isUndefined(value)) {
          cloneInitFormData[key] = value
        }
      }
      // console.log('cloneInitFormData', cloneInitFormData)
      return cloneInitFormData
    },

    // 获取用户列表
    getValidUserList() {
      if (this.userList.length > 0) {
        return true
      }
      return new Promise((resolve) => {
        userApi.page(initQueryParams({
          model: {
            dataStatus: dataStatusField.VALID
          },
          size: 10000,
        })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.userList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    
    // 选择通气人发生变化
    handleVentilateUserChange(value) {
      const user = this.userList.find((item) => item.name === value)
      this.form.ventilateUserId = user?.id ?? null
    },
    // 搜索用户列表根据输入的字符
    handleSearchUserList(keyword) {
      return this.userList.filter((item) => item.name.includes(keyword.trim()))
    },

    // 输入通气人名字搜索数据
    handleSearchVentilateUser(value) {
      // console.log('value', value)
      if (value !== '') {
        this.ventilateUserListLoading = true
        setTimeout(() => {
          this.ventilateUserListLoading = false
          this.ventilateUserList = this.handleSearchUserList(value)
        }, 200)
      }
    },

    // 保存编辑数据
    saveFormData(data = null) {
      if (!data) {
        data = this.form
      }
      // 避免重复提交
      if (this.submitLoading) {
        return true
      }
      return new Promise((resolve) => {
        this.submitLoading = true
        ventilation(data).then((result) => {
          // console.log('saveresult', result)
          const { isSuccess, data } = result.data
          if (isSuccess) {
            // 新增状态下则 重置表单
            if (this.isAdd) {
              this.resetForm()
            }
            resolve(data ?? this.form)
          } else {
            resolve(false)
          }
          this.submitLoading = false
        }).catch(() => {
          resolve(false)
          this.submitLoading = false
        })
      })
    },

    // 保存表单信息
    handleSubmit() {
      this.$refs[this.formRef].validate(async(valid) => {
        if (valid) {
          const saveResult = await this.saveFormData()
          const msg = this.$t('saveSuccess')
          if (saveResult) {
            this.$message.success(msg)
            // 传递保存成功时间回父级组件
            this.$emit('success', saveResult)
          }
        } else {
          this.$message.error(this.$t('validateError'))
        }
      })
    },
  }
}
</script>
<style lang="scss" scoped>
  .OpenGas-page {
    .qc-form {
      ::v-deep {
        .el-form-item {
          width: calc(100% / 2);
        }
        .save-btn-box {
          margin-top: 15px;
        }
      }
    }
  }
</style>
