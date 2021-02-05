<!--
 * @Description: 派单
 * @Author: lingw
 * @Date: 2020-11-17 09:06:04
 * @LastEditors: lingw
 * @LastEditTime: 2021-01-15 15:14:31
-->
<template>
 <div>
   <el-form ref="overForm" :model="overForm" :rules="rules" class="jh-text" label-position="top">
    <el-form-item label="客户名称" prop="customerName">
      <el-input v-model="overForm.customerName"></el-input>
    </el-form-item>
    <el-form-item label="联系电话" prop="customerMobile">
      <el-input v-model="overForm.customerMobile"></el-input>
    </el-form-item>
    <el-form-item label="安装地址" prop="addressDetail">
      <el-input v-model="overForm.addressDetail"></el-input>
    </el-form-item>
    <el-form-item label="接单人" prop="worker">
      <el-select v-model="overForm.worker" value-key="receiveUserId">
        <el-option v-for="user in workerList" :key="user.receiveUserId" :label="user.receiveUserName" :value="user">
        </el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="紧急程度">
      <el-select v-model="overForm.urgency">
        <el-option v-for="({ value, label }) in urgencies" :key="value" :value="value" :label="label"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="工单内容描述">
      <el-input v-model="overForm.workOrderDesc"></el-input>
    </el-form-item>
  </el-form>
  <el-button type="primary" :loading="loading" @click="handleDispatch">
    派单
  </el-button>
 </div>
</template>

<script>
export default {
  name: 'DispatchOrder',
  props: {
    workerList: {
      type: Array,
      required: true,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      loading: false,
      // 紧急程度选项
      urgencies: [
        {
          value: 'NORMAL',
          label: '正常'
        },
        {
          value: 'VERY_URGENT',
          label: '非常紧急'
        },
        {
          value: 'URGENT',
          label: '紧急'
        }
      ],
      // 工单表单
      overForm: {
        orderType: {

        },
        addressDetail: '',
        customerMobile: '',
        customerName: '',
        urgency: '',
        workOrderDesc: '',
        worker: {
          receiveUserId: '1315907666148589568',
          receiveUserName: '张三'
        }
      },
      rules: {
        workOrderType: [
          { required: true, message: '请选择工单类型', trigger: 'change' }
        ],
        worker: [
          { required: true, message: '请选择派单工人', trigger: 'blur' }
        ]
      },
    }
  },
  mounted () {

  },
  methods: {
    handleDispatch() {
      this.$refs['overForm'].validate(valid => {
        if (valid) {
          const payload = {
            ...this.overForm,
            ...this.overForm.worker
          }
          this.loading = true
          this.$emit('diapatch', payload)
        } else {
          return false
        }
      })
    },
    reset() {
      this.$refs.overForm.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
