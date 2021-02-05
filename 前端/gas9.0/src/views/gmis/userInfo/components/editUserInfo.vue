<!--客户资料表单-->
<template>
  <div class="form-page userinfo-form-page">
    <!-- 表单区域额 -->
    <el-form
      ref="form"
      label-position="top"
      :inline="true"
      class="qc-form disabled-form clearfix userinfo-form"
      :model="userData"
      :rules="onlyView ? {} : formRules"
    >
      <!--客户编号-->
      <!-- <el-form-item v-if="isEdit || onlyView" :label="$t('customerInfo.customerCode')" prop="customerCode" class="customerCode-form-item">
        <el-tooltip v-if="userData.customerCode" :content="userData.customerCode" placement="bottom">
          <el-input v-model="userData.customerCode" :disabled="true" :placeholder="$t('customerInfo.customerCode')"></el-input>
        </el-tooltip>
        <el-input v-else v-model="userData.customerCode" :disabled="true" :placeholder="$t('customerInfo.customerCode')"></el-input>
      </el-form-item> -->
      <!--客户名称-->
      <el-form-item :label="$t('customerInfo.customerName')" prop="customerName">
        <el-input v-model="userData.customerName" :disabled="onlyView" :placeholder="$t('customerInfo.customerName')"></el-input>
      </el-form-item>
      <!--客户电话-->
      <el-form-item :label="$t('customerInfo.telphone')" prop="telphone" class="telphone-form-item">
        <el-input v-model="userData.telphone" :disabled="onlyView" :placeholder="$t('customerInfo.telphone')"></el-input>
      </el-form-item>
      <!--客户类型-->
      <el-form-item :label="$t('customerInfo.customerTypeCode')" prop="customerTypeCode" class="customerTypeCode-form-item">
        <el-select
          v-model="userData.customerTypeCode"
          :placeholder="$t('customerInfo.customerTypeCode')"
          :disabled="onlyView" 
          @change="customerTypeChange"
        >
          <el-option
            v-for="(item, key, index) in dicts.USER_TYPE"
            :key="index"
            :label="item"
            :value="key"
          ></el-option>
        </el-select>
      </el-form-item>
      <!--性别-->
      <el-form-item :label="$t('customerInfo.sex')" prop="sex" class="sex-form-item">
        <el-select v-model="userData.sex" :placeholder="$t('customerInfo.sex')" :disabled="onlyView">
          <el-option
            v-for="(item, key, index) in dicts.SEX"
            :key="index"
            :label="item"
            :value="key"
          ></el-option>
        </el-select>
      </el-form-item>
      <!--身份证号码-->
      <el-form-item :label="$t('customerInfo.idCard')" prop="idCard" class="idCard-form-item">
        <el-input v-model="userData.idCard" :disabled="onlyView" :placeholder="$t('customerInfo.idNumber')"></el-input>
      </el-form-item>
      <!--证件类型-->
      <!-- <el-form-item :label="$t('customerInfo.idTypeCode')" prop="idTypeCode">
        <el-select
          v-model="userData.idTypeCode"
          :placeholder="$t('customerInfo.idTypeCode')"
          :disabled="onlyView"
          @change="idTypeNameChange"
        >
          <el-option
            v-for="(item, key, index) in dicts.CERTIFICATE_TYPE"
            :key="index"
            :label="item"
            :value="key"
          ></el-option>
        </el-select>
      </el-form-item> -->
      <!--证件号码-->
      <!-- <el-form-item :label="$t('customerInfo.idNumber')" prop="idNumber">
        <el-input v-model="userData.idNumber" :disabled="onlyView" :placeholder="$t('customerInfo.idNumber')"></el-input>
      </el-form-item> -->
      <!--常驻地址-->
      <el-form-item
        :label="$t('customerInfo.contactAddress')"
        prop="contactAddress"
        class="contactAddress-form-item"
      >
        <el-input
          v-model="userData.contactAddress"
          :disabled="onlyView"
          :placeholder="$t('customerInfo.contactAddress')"
        ></el-input>
      </el-form-item>
      <!--备注-->
      <el-form-item :label="$t('customerInfo.remark')" prop="remark" class="remark-form-item">
        <el-input v-model="userData.remark" :disabled="onlyView" :placeholder="$t('customerInfo.remark')"></el-input>
      </el-form-item>
      <el-form-item v-if="showResetBtn" label=" " class="reset-btn-box text-right">
        <el-button
          type="warning"
          name="resetUserinfo"
          :loading="submitLoading"
          :disabled="submitLoading"
          class="reset-btn"
          @click="handleReset()"
        >{{ $t('reset') }}</el-button>
      </el-form-item>
      <el-form-item v-if="!onlyView" label=" " class="save-btn-box text-right">
        <el-button
          type="primary"
          name="saveUserinfo"
          :loading="submitLoading"
          :disabled="submitLoading"
          class="save-btn"
          @click.native="submitForm('form')"
        >{{ isEdit ? $t('save') : $t('add') }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { cloneDeep } from 'lodash'
import comomMixin from '@/mixins/common'
import getUserInfoApi from '@/api/userInfo/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { awaitToJs } from '@/utils/index'
import { mobileReg, idcardReg } from '@/utils/reg'
import { arrayCombine } from '@/utils/array'
import { baseCustomerFormFieldsMap } from '@/lang/zh/modules/customerInfo'

const data = {
  ...arrayCombine(Object.keys(baseCustomerFormFieldsMap), new Array(Object.keys(baseCustomerFormFieldsMap).length).fill('')),
  id: '',
}
export default {
  name: 'UserInfoForm',
  mixins: [comomMixin],
  props: {
    formData: {
      type: Object,
      default: () => ({}),
    },
    // 是否只能查看
    onlyView: {
      type: Boolean,
      default: false
    },

    // 是否显示重置按钮
    showResetBtn: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      userData: {},
      // 表单验证规则
      formRules: {
        customerName: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.customerName')}`,
            trigger: 'blur',
          },
          {max:100,message:'用户名不能超过100个字符'}
        ],
        telphone: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.telphone')}`,
            trigger: 'blur',
          },
          { pattern: mobileReg, message: this.$t('customerInfo.telphoneHint'), trigger: 'blur' },
        ],
        customerTypeCode: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('customerInfo.customerTypeCode')}`,
            trigger: 'change',
          },
        ],
        sex: [
          {
            required: true,
            message: `${this.$t('selectHint')}${this.$t('customerInfo.sex')}`,
            trigger: 'change',
          },
        ],
        idCard: [
          {
            required: true,
            message: `${this.$t('inputHint')}${this.$t('customerInfo.idCard')}`,
            trigger: 'blur',
          },
          { pattern: idcardReg, message: this.$t('customerInfo.idCardHint'), trigger: 'blur' },
        ],
        // idTypeCode: [
        //   {
        //     required: true,
        //     message: `${this.$t('selectHint')}${this.$t('customerInfo.idTypeCode')}`,
        //     trigger: 'change',
        //   },
        // ],
        // idNumber: [
        //   {
        //     required: true,
        //     message: `${this.$t('inputHint')}${this.$t('customerInfo.idNumber')}`,
        //     trigger: 'blur',
        //   },
        // ],
      },
      dicts: {
        USER_TYPE: {},
        CERTIFICATE_TYPE: {},
        SEX: {},
      },
      submitLoading: false,
    }
  },
  computed: {
    isEdit() {
      return this.formData?.id ?? false
    },
  },
  watch: {
    // 监听props表单传递数据
    formData: {
      handler() {
        this.initData()
      },
    },
  },
  created() {
    this.initData()
  },
  mounted() {
    this.dicts = {
      USER_TYPE: this.getDictionaryMapByCode(dictionaryCodeMap.USER_TYPE),
      CERTIFICATE_TYPE: this.getDictionaryMapByCode(dictionaryCodeMap.CERTIFICATE_TYPE),
      SEX: this.getDictionaryMapByCode(dictionaryCodeMap.SEX),
    }
  },
  methods: {
    initData() {
      this.userData = cloneDeep(this.formData ? { ...data, ...this.formData } : data)
      const { idTypeCode } = this.userData
      const certificateType = this.dicts.CERTIFICATE_TYPE
      if (!idTypeCode) {
        // 证件类型默认值
        const certificateTypeCode = Object.keys(certificateType)?.[0] ?? null
        if (certificateTypeCode) {
          this.userData.idTypeCode = certificateTypeCode
          this.userData.idTypeName = certificateType[certificateTypeCode]
        }
      }
      this.$refs.form?.clearValidate()
    },

    //客户类型下拉选择
    customerTypeChange(value) {
      this.userData.customerTypeName = this.dicts.USER_TYPE[value] ?? ''
    },

    //证件类型下拉选择
    idTypeNameChange(value) {
      this.userData.idTypeName = this.dicts.CERTIFICATE_TYPE[value] ?? ''
    },
    //用户档案信息修改
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          let submitData = this.userData
          this.submitLoading = true
          let result
          if (this.isEdit) {
            result = await awaitToJs(getUserInfoApi.editUserInfo(submitData))
          } else {
            result = await awaitToJs(getUserInfoApi.addUserInfo([submitData]))
          }
          console.log('result', result)
          if (result?.error) {
            this.$message.error(result.error)
          } else {
            if (result.data.isSuccess) {
              this.$message.success(this.$t('saveSuccess'))
              this.emitCloseDialog('close', 'editUserInfo')
            }
          }
          this.submitLoading = false
        } else {
          this.$message.error(this.$t('validateError'))
          return false
        }
      })
    },

    // 验证表单信息,返回表单数据
    validateForm() {
      return new Promise((resolve) => {
        this.$refs.form?.validate((valid) => {
          if (!valid) {
            this.$message.error('请核对填写的客户信息是否有误！')
          }
          resolve(valid ? this.userData : false)
        })
      })
    },
    /**
     * 关闭编辑框
     */
    cancel() {
      this.emitCloseDialog('close', 'editUserInfo')
    },

    // 重置表单
    handleReset() {
      this.$refs.form?.resetFields()
      this.userData = cloneDeep(data)
      this.$nextTick(() => {
        this.$refs.form?.clearValidate()
        this.$emit('update:formData', {})
      })
    },
  },
}
</script>

<style lang="scss" scoped>

  .userinfo-form-page {
    ::v-deep {
      .el-input-group__append,
      .el-input-group__prepend {
        background: $primary;
        border-color: $primary;
        color: #fff;
      }

      .search {
        width: 450px;
      }

      // 设置表格头部背景
      .el-table th {
        background-color: #f5f7fa !important;
      }

      .el-form-item {
        width: calc(100% / 6);
        margin-bottom: 10px;

        .el-button {
          width: 100%;
        }
      }
      .idCard-form-item {
        width: calc(100% / 6 * 2);
      }
      .contactAddress-form-item {
        width: calc(100% / 6 * 2);
      }
      .remark-form-item {
        width: calc(100% / 6 * 2);
      }
    }
  }
</style>
