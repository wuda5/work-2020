<!-- 退费编辑 -->
<template>
  <el-dialog
    title="编辑"
    :modal="false"
    :visible.sync="isVisible"
    :width="width"
    append-to-body
    top="50px"
  >
    <el-form ref="form" :model="form" :rules="rules" label-position="top" label-width="120px" class="jh-text">
      <!-- 客户名称 -->
      <el-form-item label="客户名称" prop="customerName">
        <el-input v-model="form.customerName" disabled />
      </el-form-item>
      <!-- 客户编号 -->
      <el-form-item label="客户编号" prop="customerCode">
        <el-input v-model="form.customerCode" disabled />
      </el-form-item>
      <!-- 收费流水号 -->
      <el-form-item label="收费流水号" prop="chargeNo">
        <el-input v-model="form.chargeNo" disabled></el-input>
      </el-form-item>
      <!-- 可退费金额 -->
      <el-form-item label="可退费金额" prop="canBackMoney">
        <el-input v-model="form.canBackMoney" disabled></el-input>
      </el-form-item>
      <!-- 退费金额 -->
      <el-form-item label="退费金额" prop="backMoney">
        <el-input v-model="form.backMoney" disabled></el-input>
      </el-form-item>
      <!-- 退费方式 -->
      <el-form-item label="退费方式" prop="backMethod">
        <el-select v-model="form.backMethod" clearable filterable placeholder="请选择退费方式">
          <el-option
            label="微信"
            :value="1"
          >
          </el-option>
          <el-option
            label="支付宝"
            :value="2"
          >
          </el-option> 
        </el-select>
      </el-form-item>
      <!-- 无线通讯版本 -->
      <el-form-item label="审核人" prop="audutMan">
        <el-input v-model="form.audutMan" />
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
export default {
  name: 'BackFeeEdit',
  props: {
    record: {
      type: Object,
      default: () => {
        return {}
      }
    },
    dialogVisible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      loading: false,
      form: {
        backMethod: '',
        audutMan: ''
      },
      width: this.initWidth(),
      //表单验证规则
      rules: {
        backMoney: [
          {
            required: true,
            message: '请输入退费金额',
            trigger: 'blur'
          }
        ],
        backMethod:[
          {
            required: true,
            message: '请选择退费方式',
            trigger: 'blur',
          },
        ],
        audutMan: {
          required: true,
          message: '请选择审核人',
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
      return this.screenWidth < 991 ? '90%' : '40%'
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.form = {}
    },
    submitForm() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.loading = true
          vm.update()
        } else {
          return false
        }
      })
    },
    update() {
      
    }
  }
}
</script>
<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 2);
    margin-bottom: 15px;
    float: initial;
  }
}
</style>
