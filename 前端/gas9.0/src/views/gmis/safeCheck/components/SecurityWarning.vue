<!--
 * @Description: 录入安检隐患资料
 * @Author: lingw
 * @Date: 2020-11-20 13:43:57
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-27 10:40:45
-->
<template>
 <div>
   <el-form ref="form" :model="form" label-position="top" class="jh-text">
      <el-form-item label="隐患名称" prop="reciveUser">
        <el-input v-model="form.scTermItemsName" disabled></el-input>
      </el-form-item>
      <el-form-item label="隐患状态" prop="reciveUser">
        <el-input v-model="status" disabled></el-input>
      </el-form-item>
      <el-form-item label="隐患描述">
        <el-input v-model="form.hiddenDanger" type="textarea" :rows="2"></el-input>
      </el-form-item>
      <el-form-item label="整改内容">
        <el-input v-model="form.handleInfo" type="textarea" :rows="2"></el-input>
      </el-form-item>
      <el-form-item label="隐患级别">
        <el-input v-model="level" disabled></el-input>
      </el-form-item>
    </el-form>
    <el-button type="primary" @click="handleCancel">
     取消整改
    </el-button>
    <el-button type="primary" :loading="loading" @click="handleSubmit">
     整改完成
    </el-button>
 </div>
</template>

<script>
export default {
  name: 'SecurityCheckInput',
  data () {
    return {
      loading: false,
      form: {
        handleStatus: 0,
        hiddenDanger: '',
        remark: '',
        dangerLeve: ''
      }
    }
  },
  computed: {
    status() {
      return this.form.handleStatus === 0 ? '未整改' : '已整改'
    },
    level() {
      const dangerLevel = this.form.dangerLeve
      switch(dangerLevel) {
        case '0':
          return '重度'
        case '1':
          return '轻度'
        case '2':
          return '中度'
        default:
          return '--'
      }
    }
  },
  methods: {
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          const payload = {
            ...this.form,
          }
          this.loading = true
          this.$emit('submit', payload)
        }
      })
    },
    reset() {
      this.$refs.form.resetFields()
    },
    handleCancel() {
      this.$emit('cancel')
    }
  }
}
</script>
