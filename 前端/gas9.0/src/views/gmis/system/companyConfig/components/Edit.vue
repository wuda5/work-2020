<!-- 生产厂商添加和编辑 -->
<template>
  <el-dialog
    :close-on-click-modal="false"
    :close-on-press-escape="true"
    :title="title"
    :type="type"
    :visible.sync="isVisible"
    :width="width"
    top="50px"
  >
    <el-form ref="form" :model="company" :rules="rules" label-position="right" label-width="100px" class="jh-text">
      <!-- 厂商名称 -->
      <el-form-item :label="$t('table.companyConfig.companyName')" prop="companyInfo">
        <el-select v-model="company.companyInfo" value-key="gasMeterFactoryCode" filterable @change="handleCompanyChange">
          <el-option v-for="comp in companyList" :key="comp.gasMeterFactoryCode" :label="comp.gasMeterFactoryName" :value="comp">
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 厂商编码 -->
      <el-form-item :label="$t('table.companyConfig.companyCode')" prop="gasMeterFactoryCode">
        <el-input v-model="company.gasMeterFactoryCode" disabled />
      </el-form-item>
      <!-- 厂商地址 -->
      <el-form-item :label="$t('table.companyConfig.companyAddress')" prop="gasMeterFactoryAddress">
        <el-input v-model="company.gasMeterFactoryAddress" />
      </el-form-item>
      <!-- 厂商标识码 -->

      <!-- <el-form-item :label="$t('table.companyConfig.companyIdenfy')" prop="gasMeterFactoryMarkCode">
        <el-select v-model="company.gasMeterFactoryMarkCode" filterable>
          <el-option
            v-for="(item,index) in gasMarkCodeList"
            :key="index"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item> -->
      <!-- 厂商电话 -->
      <el-form-item :label="$t('table.companyConfig.telephone')">
        <el-input v-model="company.telphone" />
      </el-form-item>
      <!-- 是否启用 -->
      <el-form-item :label="$t('table.companyConfig.isValid')">
        <el-radio-group v-model="company.gasMeterFactoryStatus">
          <el-radio :label="1">{{ $t("common.status.valid") }}</el-radio>
          <el-radio :label="0">{{ $t("common.status.invalid") }}</el-radio>
        </el-radio-group>
      </el-form-item>
      <!-- 联系人 -->
      <el-form-item :label="$t('table.companyConfig.contacts')">
        <el-input v-model="company.contacts" />
      </el-form-item>
      <!-- 传真号码 -->
      <el-form-item :label="$t('table.companyConfig.fax')">
        <el-input v-model="company.faxNumber" />
      </el-form-item>
      <!-- 经理 -->
      <el-form-item :label="$t('table.companyConfig.manager')">
        <el-input v-model="company.manager" />
      </el-form-item>
      <!-- 税务登记号 -->
      <el-form-item :label="$t('table.companyConfig.cnpj')">
        <el-input v-model="company.taxRegistrationNo" />
      </el-form-item>
      <!-- 开户银行 -->
      <el-form-item :label="$t('table.companyConfig.bank')">
        <el-input v-model="company.bank" />
      </el-form-item>
      <!-- 银行账号 -->
      <el-form-item :label="$t('table.companyConfig.bankAccount')">
        <el-input v-model="company.bankAccount" />
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button plain type="warning" @click="isVisible = false">
        {{ $t("common.cancel") }}
      </el-button>
      <el-button :loading="loading" plain type="primary" @click="submitForm">
        {{ $t("common.confirm") }}
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
import gasMeterFaactoryApi from '@/api/system/gasMeterFactory'

export default {
  name: 'CompanyEdit',
  props: {
    dialogVisible: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: 'add',
    },
    companyList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data() {
    return {
      loading: false,
      company: {
        gasMeterFactoryStatus:1,
        gasMeterFactoryMarkCode: 2,
        companyInfo: {}
      }, //生产厂商数据
      screenWidth: 0,
      width: this.initWidth(),
      gasMarkCodeList:[{
        label:'秦川',
        value:'2'
      }],
      //表单的验证规则
      rules: {
        companyInfo: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          }
        ],
        gasMeterFactoryCode: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
        gasMeterFactoryAddress: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
        gasMeterFactoryMarkCode: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
      },
    }
  },
  computed: {
    isVisible: {
      get() {
        return this.dialogVisible
      },
      set() {
        this.close()
        this.reset()
      },
    },
    title() {
      return this.type === 'add' ? this.$t('common.add') : this.$t('common.edit')
    },
  },
  watch: {},
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    /**
     * 对弹框进行初始化操作--根据屏幕分辩率动态修改弹窗的宽度
     */
    initWidth() {
      this.screenWidth = document.body.clientWidth
      return this.screenWidth < 991 ? '90%' : '40%'
    },
    loadListOptions({ callback }) {
      callback()
    },
    /**
     * 编辑-初始化数据
     */
    setCompanyInfo(val) {
      const vm = this
      console.warn(val)
      if (val) {
        vm.company = {
          ...val,
          companyInfo: {
            gasMeterFactoryName: val.gasMeterFactoryName,
            gasMeterFactoryCode: val.gasMeterFactoryCode
          }
        }
      }
    },
    /**
     * 关闭弹窗
     */
    close() {
      this.$emit('close')
    },
    /**
     * 表单重置
     */
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.company = {}
    },
    /**
     * 表单提交
     */
    submitForm() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.loading = true
          vm.editSubmit()
        } else {
          return false
        }
      })
    },
    /**
     * 表单修改
     */
    editSubmit() {
      const vm = this
      if (vm.type === 'add') {
        vm.save()
      } else {
        vm.update()
      }
    },
    /**
     * 生产厂商新增
     */
    save() {
      const vm = this
      const payload = {
        ...this.company,
        ...this.company.companyInfo
      }
      delete payload.companyInfo
      gasMeterFaactoryApi.save(payload).then(response => {
        const res = response.data
        if (res.isSuccess) {
          vm.isVisible = false
          vm.$message({
            message: vm.$t('tips.createSuccess'),
            type: 'success',
          })
          vm.$emit('success')
        }
      }).finally(() => {
        this.loading = false
      })
    },
    /**
     * 生产厂商修改
     */
    update() {
      const payload = {
        ...this.company,
        ...this.company.companyInfo
      }
      delete payload.companyInfo
      gasMeterFaactoryApi.update(payload).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.isVisible = false
          this.$message({
            message: this.$t('tips.updateSuccess'),
            type: 'success',
          })
          this.$emit('success')
        }
      }).finally(() => {
        this.loading = false
      })
    },
    // 选中厂家后自动填充厂家编码
    handleCompanyChange(record) {
      this.company.gasMeterFactoryCode = record?.gasMeterFactoryCode ?? ''
      this.checkWhetherExisit(record?.gasMeterFactoryCode)
    },
    // 验证是否已经添加过商家
    async checkWhetherExisit(code = '') {
      const payload = {
        gasMeterFactoryCode: code
      }
      const { data: res } = await gasMeterFaactoryApi.check(payload)
      if (res.data) {
        this.$message({
          type: 'warning',
          message: '该商家已被添加， 请勿重复操作'
        })
      }
    }
  },
}
</script>
<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 2);
    margin-bottom: 15px;
  }
}
</style>
