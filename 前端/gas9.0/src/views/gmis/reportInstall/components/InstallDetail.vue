<!--
 * @Description: 录入安装资料
 * @Author: lingw
 * @Date: 2020-11-18 09:43:57
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 14:12:36
-->
<template>
 <div>
   <el-form ref="form" :model="form" label-position="top" class="jh-text">
     <el-form-item label="报装编号">
       <p>{{ currentRecord.installNumber || '--' }}</p>
     </el-form-item>
     <el-form-item label="报装人">
       <p>{{ currentRecord.customerName || '--' }}</p>
     </el-form-item>
     <el-form-item label="联系电话">
       <p>{{ currentRecord.telphone || '--' }}</p>
     </el-form-item>
     <el-form-item label="报装地址">
       <p>{{ currentRecord.addressRemark || '--' }}</p>
     </el-form-item>
     <el-form-item label="调压箱编号">
        <el-input v-model="form.surgeTankNumber"></el-input>
      </el-form-item>
      <el-form-item label="气表编号" prop="gasMeterCode">
        <el-input v-model="form.gasMeterCode"></el-input>
      </el-form-item>
      <el-form-item label="用气类型">
        <el-select v-model="form.gas" value-key="useGasTypeId">
          <el-option v-for="gas in useGasType" :key="gas.useGasTypeId" :label="gas.useGasTypeName" :value="gas">
          </el-option>
        </el-select>
      </el-form-item>
     <el-form-item label="街道" prop="street">
        <el-select v-model="form.street" value-key="streetId" @change="handleStreet">
          <el-option v-for="street in streetList" :key="street.streetId" :value="street" :label="street.streetName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item ref="community" label="小区" prop="community">
        <el-select v-model="form.community" value-key="communityId" @change="handleCommunity">
          <el-option v-for="community in communityList" :key="community.communityId" :value="community" :label="community.communityName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item ref="addressDetail" label="详细地址" prop="addressDetail">
        <el-input v-model="form.addressDetail"></el-input>
      </el-form-item>
   </el-form>
   <div style="text-align: right;">
    <el-button type="primary" :loading="loading" @click="handleSubmit">
      提交
    </el-button>
   </div>
 </div>
</template>

<script>
export default {
  name: 'InstallDetail',
  props: {
    streetList: {
      type: Array,
      default: () => {
        return []
      }
    },
    communityList: {
      type: Array,
      default: () => {
        return []
      }
    },
    useGasType: {
      type: Array,
      default: () => {
        return []
      }
    },
    currentRecord: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data () {
    return {
      loading: false,
      form: {
        street: {},
        community: {},
        addressDetail: '',
        gasMeterCode: '',
        surgeTankNumber: '',
        gas: {
          useGasTypeId: '',
          useGasTypeName: ''
        },
      },
      rules: {
        street: [
          { required: true, message: '请选择街道', trigger: 'change' }
        ],
        community: [
          { required: true, message: '请选择小区', trigger: 'change' }
        ],
        addressDetail: [
          { required: true, message: '请输入详细地址', trigger: 'blur' },
          { max: 64, message: '最长可以输入64个字符' }
        ],
        gasMeterCode: [
          { required: true, message: '请输入气表编号', trigger: 'blur' },
          { max: 64, message: '最长可以输入64个字符' }
        ]
      }
    }
  },
  methods: {
    // 街道选中
    handleStreet(street) {
      this.$refs['community'].resetField()
      this.$refs['addressDetail'].resetField()
      this.$emit('fetchCommunity', street.streetId)
    },
    // 小区选中
    handleCommunity(community) {
      this.$refs['addressDetail'].resetField()
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          const payload = {
            ...this.form,
            ...this.form.street,
            ...this.form.community,
            ...this.form.gas
          }
          delete payload.street
          delete payload.community
          delete payload.gas
          this.loading = true
          this.$emit('submit', payload)
        }
      })
    },
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
