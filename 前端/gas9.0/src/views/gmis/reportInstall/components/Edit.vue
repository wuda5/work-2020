<!--
 * @Description: 报装 - 编辑
 * @Author: lingw
 * @Date: 2020-11-09 10:23:42
 * @LastEditors: lingw
 * @LastEditTime: 2021-01-15 15:14:17
-->

<template>
  <div>
    <el-form ref="form" :rules="rules" :model="form" label-position="top" class="jh-text">
      <el-form-item label="报装类型" prop="installTypeName">
        <el-select v-model="form.installTypeName">
          <el-option v-for="({ value, label, id }) in reportTypes" :key="id" :value="value" :label="label">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="报装人" prop="customerName">
        <!-- <el-input v-model="form.customerName"></el-input> -->
        <el-select
          v-model="form.customer"
          filterable
          remote
          placeholder="请输入报装人"
          :remote-method="remoteMethod"
          :loading="userLoading"
          value-key="customerCode"
        >
          <el-option
            v-for="item in options"
            :key="item.customerCode"
            :label="item.customerName"
            :value="item"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="证件类型" prop="idTypeName">
        <el-select v-model="form.idTypeName">
          <el-option v-for="({ value, label, id }) in cardTypes" :key="id" :value="value" :label="label">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="证件号码" prop="idNumber">
        <el-input v-model="form.idNumber"></el-input>
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
      <el-form-item ref="addressRemark" label="安装地址" prop="addressRemark">
        <el-input v-model="form.addressRemark"></el-input>
      </el-form-item>
      <el-form-item label="联系电话" prop="telphone">
        <el-input v-model="form.telphone"></el-input>
      </el-form-item>
      <el-form-item label="户数" prop="population">
        <el-input v-model.number="form.population" type="number"></el-input>
      </el-form-item>
      <el-form-item label="备注">
        <el-input v-model="form.remark"></el-input>
      </el-form-item>
    </el-form>
    <div style="text-align: right;">
      <el-button type="primary" :loading="loading" class="btn-save" @click="handleSave">
        {{ btnText }}
      </el-button>
    </div>
  </div>
</template>

<script>
import { checkPhone } from '@/utils/commons'
import userInfoApi from '@/api/userInfo'

export default {
  name: 'ReportEdit',
  props: {
    reportTypes: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    cardTypes: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    streetList: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    communityList: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    detailList: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      loading: false,
      userLoading: false, // 报装人搜索loading
      options: [], // 报装人列表
      // 编辑报装参数
      form: {
        installTypeName: '',
        customer: {
          customerCode: '',
          customerName: ''
        },
        idTypeName: '',
        idNumber: '',
        street: {
          streetId: '',
          streetName: ''
        },
        community: {
          communityId: '',
          communityName: ''
        },
        addressRemark: '',
        telphone: '',
        population: '',
        remark: ''
      },
      btnText: '受理',
      rules: {
          installTypeName: [
            { required: true, message: '请选择报装类型', trigger: 'change' }
          ],
          customer: [
            { required: true, message: '请选择报装人', trigger: 'blur' },
          ],
          idTypeName: [
            { required: true, message: '请选择证件类型', trigger: 'change' }
          ],
          idNumber: [
            { required: true, message: '请输入证件号码', trigger: 'blur' },
            { max: 64, message: '最长可以输入64个字符' }
          ],
          street: [
            { required: true, message: '请选择街道', trigger: 'change' }
          ],
          community: [
            { required: true, message: '请选择小区', trigger: 'change' }
          ],
          addressRemark: [
            { required: true, message: '请输入详细地址', trigger: 'blur' },
            { max: 64, message: '最长可以输入64个字符' }
          ],
          telphone: [
            {
              required: true, message: '请输入联系电话', trigger: 'blur'
            },
            {
              validator: (rule, value, callback) => {
                if (!checkPhone(value)) {
                  callback('请输入正确的手机号')
                } else {
                  callback()
                }
              },
              trigger: 'blur'
            }
          ],
          population: [
            {
              required: true, message: '请输入户数', trigger: 'blur'
            }
          ]
        }
    }
  },
  methods: {
    async remoteMethod(query) {
      if (query !== '') {
        this.userLoading = true;
        const payload = {
          customerName: query,
          size: 100
        }
        const { data: res } = await userInfoApi.getListData(payload)
        this.userLoading = false
        if (res.isSuccess) {
          let list = res?.data?.records ?? []
          if (list.length) {
            list = list.map(({ customerName, customerCode }) => ({
              customerName,
              customerCode
            }))
            this.options = list.filter(item => {
              return item.customerName.toLowerCase()
                .indexOf(query.toLowerCase()) > -1;
            });
            console.warn(list, this.options)
          }
        }
      } else {
        this.options = [];
      }
    },
    handleSave() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          const payload = {
            ...this.form,
            ...this.form.street,
            ...this.form.community,
            ...this.form.customer,
            installTypeId: '7', // 包装类型id为固定值 7
            idTypeId: '5', // 证件类型id为固定值 5
          }
          delete payload.street
          delete payload.community
          delete payload.customer
          this.loading = true
          this.$emit('save', payload)
        } else {
          return false
        }
      })
    },
    // 街道选中
    handleStreet(street) {
      this.$refs['community'].resetField()
      this.$refs['addressRemark'].resetField()
      this.$emit('fetchCommunity', street.streetId)
    },
    // 小区选中
    handleCommunity(community) {
      this.$refs['addressRemark'].resetField()
    },
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 2);
    }
    .btn-save {
      margin-top: 12px;
    }
  }
</style>
