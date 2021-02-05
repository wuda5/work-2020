<!-- 编辑 | 新增 角色 -->
<template>
  <el-dialog
    :close-on-click-modal="false"
    :title="title"
    :type="type"
    :visible.sync="isVisible"
    :width="width"
    top="50px"
  >
    <!-- 表单 -->
    <el-form ref="form" :model="role" :rules="rules" label-position="right" label-width="100px">
      <!-- 编码 -->
      <el-form-item :label="$t('table.role.code')" prop="code">
        <el-input v-model="role.code" :disabled="type === 'edit'" />
      </el-form-item>
      <!-- 角色名称 -->
      <el-form-item :label="$t('table.role.name')" prop="name">
        <el-input v-model="role.name" />
      </el-form-item>
      <!-- 状态 -->
      <el-form-item :label="$t('table.role.status')" prop="status">
        <el-radio-group v-model="role.status">
          <el-radio-button :label="true">{{ $t('common.status.valid') }}</el-radio-button>
          <el-radio-button :label="false">{{ $t('common.status.invalid') }}</el-radio-button>
        </el-radio-group>
      </el-form-item>
      <!-- 角色描述 -->
      <el-form-item :label="$t('table.role.describe')" prop="describe">
        <el-input v-model="role.describe" />
      </el-form-item>

      <!-- 数据 -->
      <!-- <el-form-item :label="$t('table.role.dsType')" prop="dsType">
        <el-radio-group v-model="role.dsType.code" @change="dsTypeChange">
          <el-radio-button
            v-for="(item, key, index) in enums.DataScopeType"
            :key="index"
            :label="key"
            :value="key"
          >{{ item }}</el-radio-button>
        </el-radio-group>
      </el-form-item>-->

      <!-- 数据范围（组织） -->
      <el-form-item :label="$t('table.role.dsType')" prop="orgList">
        <el-tree
          ref="orgTree"
          :data="orgList"
          :check-strictly="true"
          :default-checked-keys="role.orgList"
          :default-expanded-keys="role.orgList"
          :expand-on-click-node="true"
          highlight-current
          node-key="id"
          show-checkbox
        />
      </el-form-item>
    </el-form>

    <div slot="footer" class="dialog-footer">
      <el-button type="warning" @click="isVisible = false">{{ $t('common.cancel') }}</el-button>
      <el-button :loading="confirmLoading" type="primary" @click="submitForm">{{ $t('common.confirm') }}</el-button>
    </div>
  </el-dialog>
</template>
<script>
import { debounce } from '@/utils'
import roleApi from '@/api/Role.js'
import orgApi from '@/api/Org.js'

export default {
  name: 'RoleEdit',
  components: {},
  props: {
    dialogVisible: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: 'add',
    },
  },
  data() {
    return {
      confirmLoading: false,
      wujh: ['643775612976106881'],
      role: this.initRole(),
      screenWidth: 0,
      width: this.initWidth(),
      orgList: [],
      orgHidden: false,
      enums: {
        DataScopeType: {},
      },
      rules: {
        code: [{ required: true, message: this.$t('rules.require'), trigger: 'blur' }],

        name: [
          { required: true, message: this.$t('rules.require'), trigger: 'blur' },
          { min: 1, max: 255, message: this.$t('rules.range4to10'), trigger: 'blur' },
          {
            validator: (rule, value, callback) => {
              if (!this.type === 'add' && value.trim().length > 0) {
                roleApi.check(value).then(response => {
                  const res = response.data
                  if (res.data) {
                    callback('编码重复')
                  } else {
                    callback()
                  }
                })
              } else {
                callback()
              }
              callback()
            },
            trigger: 'blur',
          },
        ],
        status: { required: true, message: this.$t('rules.require'), trigger: 'blur' },
        orgList: {
          validator: (rule, value, callback) => {
            //if (this.role.dsType.code === 'CUSTOMIZE') {
            if (this.$refs.orgTree.getCheckedKeys().length > 0) {
              callback()
            } else {
              callback('请至少选择一个组织')
            }
            // } else {
            //   callback()
            // }
          },
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
    this.initOrg()
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    initRole() {
      return {
        id: '',
        code: '',
        name: '',
        orgList: [],
        status: true,
        describe: '',
        dsType: {
          code: 'CUSTOMIZE',
          desc: '',
        },
      }
    },
    initWidth() {
      this.screenWidth = document.body.clientWidth
      if (this.screenWidth < 991) {
        return '90%'
      } else if (this.screenWidth < 1400) {
        return '45%'
      } else {
        return '800px'
      }
    },
    initOrg() {
      orgApi.allTree({ status: true }).then(response => {
        const res = response.data

        this.orgList = res.data
      })
    },
    loadListOptions({ callback }) {
      callback()
    },
    setRole(val = {}) {
      const vm = this

      if (val['enums']) {
        vm.enums = val['enums']
      }

      if (val['row']) {
        vm.role = { ...val['row'] }

        /* this.orgHidden = vm.role.dsType.code !== 'CUSTOMIZE'
        if (!this.orgHidden) {
          roleApi.getDetails(vm.role.id).then(response => {
            const res = response.data
            if (res.isSuccess) {
              this.role.orgList = res.data.orgList
              this.$refs.orgTree.setCheckedKeys(res.data.orgList)
            }
          })
        } */

        // this.orgHidden = vm.role.dsType.code !== 'CUSTOMIZE'

        roleApi.getDetails(vm.role.id).then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.role.orgList = res.data.orgList
            this.$refs.orgTree.setCheckedKeys(res.data.orgList)
          }
        })
      }
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.role = this.initRole()
      this.orgHidden = true
      this.$refs.orgTree.setCheckedKeys([])
    },
    submitForm: debounce(function() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.confirmLoading = true
          vm.editSubmit()
        } else {
          return false
        }
      })
    }, 300),
    editSubmit() {
      const vm = this
      /*  if (this.orgHidden && this.role.orgList) {
        this.role.orgList.length = 0
      } else { */
      this.role.orgList = this.$refs.orgTree.getCheckedKeys()
      // }

      if (vm.type === 'add') {
        vm.save()
      } else {
        vm.update()
      }
    },
    save() {
      const vm = this
      roleApi.save(this.role).then(response => {
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
        vm.confirmLoading = false
      })
    },
    update() {
      roleApi.update(this.role).then(response => {
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
        this.confirmLoading = false
      })
    },
    dsTypeChange(value) {
      this.orgHidden = value !== 'CUSTOMIZE'
    },
  },
}
</script>
<style lang="scss" scoped></style>
