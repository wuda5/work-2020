
<!-- 营业厅编辑 -->
<template>
  <div>
    <!-- 表单 -->
    <el-form ref="userForm" label-position="top" :model="form" :rules="rules" class="jh-text">
      <!-- 营业厅名 -->
      <el-form-item :label="$t('system.serviceHall.name')" prop="businessHallName">
        <el-input v-model="form.businessHallName" name="businessHallName" />
      </el-form-item>
      <!-- 营业厅地址 -->
      <el-form-item :label="$t('system.serviceHall.addr')" prop="businessHallAddress">
        <el-input v-model="form.businessHallAddress" name="businessHallAddress" />
      </el-form-item>
      <!-- 营业厅电话 -->
      <el-form-item :label="$t('system.serviceHall.hallTel')" prop="businessHallPhone">
        <el-input v-model="form.businessHallPhone" name="businessHallPhone" />
      </el-form-item>
      <!-- 联系人 -->
      <el-form-item :label="$t('system.serviceHall.contact')" prop="contacts">
        <el-input v-model="form.contacts" name="contacts" />
      </el-form-item>
      <!-- 联系人电话 -->
      <el-form-item :label="$t('system.serviceHall.tel')" prop="telphone">
        <el-input v-model="form.telphone" name="telphone" />
      </el-form-item>
      <!-- 是否代理 -->
      <el-form-item :label="$t('system.serviceHall.agency')" prop="isSale">
        <el-checkbox
          v-model="form.isSale"
          name="isSale"
          :true-label="1"
          :false-label="0"
        >{{ $t('system.serviceHall.agency') }}</el-checkbox>
      </el-form-item>
    </el-form>
    <!-- 按钮 -->
    <div class="text-right">
      <!-- 保存 -->
      <el-button
        v-if="form.id"
        name="save"
        type="primary"
        @click="submitForm('userForm')"
      >{{ $t('save') }}</el-button>
      <!-- 更新 -->
      <el-button v-else name="edit" type="primary" @click="submitForm('userForm')">{{ $t('add') }}</el-button>
    </div>
  </div>
</template>

<script>
import apiServiceHall from '@/api/system/serviceHall'
import apiOrg from '@/api/Org'
export default {
  name: 'Edit',
  props: {
    formData: {
      type: Object,
    },
  },
  data() {
    return {
      form: this.formData ? this.formData : this.initFormData(),
      rules: {
        businessHallName: [{ required: true, message: '必填', trigger: 'blur' }],
        businessHallAddress: [{ required: true, message: '必填', trigger: 'blur' }],
        businessHallPhone: [{ required: true, message: '必填', trigger: 'blur' }],
        contacts: [{ required: true, message: '必填', trigger: 'blur' }],
        telphone: [{ required: true, message: '必填', trigger: 'blur' }],
      },
    }
  },

  methods: {
    initFormData() {
      return {
        balance: '',
        businessHallAddress: '',
        businessHallName: '',
        businessHallPhone: '',
        businessHallStatus: 0,
        companyCode: '',
        companyName: '',
        contacts: '',
        deleteStatus: 0,
        deleteTime: '',
        deleteUser: '',
        email: '',
        isSale: '',
        orgId: '',
        orgName: '',
        pointOfSale: '',
        pointType: '',
        restrictStatus: '',
        singleLimit: '',
        telphone: '',
      }
    },

    // 添加营业
    addServiceHall() {
      apiServiceHall.add(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('添加成功', 'success')
          this.emitCloseDialog('close', 'showAddServiceHall')
        }
      })
    },

    // 更新营业厅
    updateServiceHall() {
      apiServiceHall.update(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('更新成功', 'success')
          this.emitCloseDialog('close', 'showAddServiceHall')
        }
      })
    },

    // close(name){
    //   this.$emit('closeDialog',name)
    // },

    // 提交
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.id) {
            // 更新
            this.updateServiceHall()
          } else {
            // 新增
            this.addServiceHall()
          }
        } else {
          this.msg('验证失败')
          return false
        }
      })
    },
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
