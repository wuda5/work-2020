<!-- 编辑 | 新增 岗位 -->
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
    <!-- 表单 -->
    <el-form ref="form" :model="station" :rules="rules" label-position="right" label-width="100px">
      <!-- 组织 -->
      <el-form-item :label="$t('table.station.orgId')" prop="orgId">
        <treeselect
          v-model="station.org.key"
          :disabled="type ==='edit'"
          :clear-value-text="$t('common.clear')"
          :load-options="loadListOptions"
          :multiple="false"
          :options="formatOrgList(orgList)"
          :searchable="true"
          placeholder=" "
          no-results-text="无查询结果"
          style="width:100%"
        />
      </el-form-item>

      <!-- 岗位名称 -->
      <el-form-item :label="$t('table.station.name')" prop="name">
        <el-input v-model="station.name" />
      </el-form-item>

      <!-- 状态 -->
      <el-form-item :label="$t('table.station.status')" prop="status">
        <el-radio-group v-model="station.status">
          <el-radio :label="true">{{ $t('common.status.valid') }}</el-radio>
          <el-radio :label="false">{{ $t('common.status.invalid') }}</el-radio>
        </el-radio-group>
      </el-form-item>
      <!-- 描述 -->
      <el-form-item :label="$t('table.station.describe')" prop="describe">
        <el-input v-model="station.describe" />
      </el-form-item>
    </el-form>
    <!-- 底部操作 -->
    <div slot="footer" class="dialog-footer">
      <el-button type="warning" @click="isVisible = false">{{
        $t('common.cancel')
      }}
      </el-button>
      <el-button type="primary" :disabled="submitDisable" @click="submitForm">{{ $t('common.confirm') }}</el-button>
    </div>
  </el-dialog>
</template>
<script>
  import Treeselect from '@riophae/vue-treeselect'
  import '@riophae/vue-treeselect/dist/vue-treeselect.css'
  import stationApi from '@/api/Station.js'

  export default {
    name: 'StationEdit',
    components: {Treeselect},
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
      /* 工作岗位是否重复 */
      let stationCheck = (rule, value, callback) => {

        let orgId = this.station.org.key
        if (!orgId) {
          callback('请选择组织')
        }

        if(this.type==='edit'){
          if (this.oldName === value) {
            callback()
            return
          }
        }

        let params = {
          orgId,
          name: value
        }

        stationApi.stationCheck(params).then(res => {
          // console.log(res)
          let {isSuccess, data, msg} = res.data
          if (isSuccess) {
            if (!data) {
              callback('此岗位已存在')
            }
            callback()
          }
        })
      }

      return {
        remoteStationLoading: false,
        oldName: '',// 添加次字段用于在编辑信息时判断重复岗位时，排除自身
        station: this.initStation(),
        screenWidth: 0,
        width: this.initWidth(),
        orgList: [],
        stationList: [],
        rules: {
          /* orgId: [
             {
               required: true,
               message: this.$t('rules.require'),
               trigger: 'blur',
             },
           ],*/
          name: [
            {
              required: true,
              message: this.$t('rules.require'),
              trigger: 'blur',
            },
            {
              min: 2,
              max: 10,
              message: this.$t('rules.range2to10'),
              trigger: 'blur',
            },
            {
              validator: stationCheck,
              trigger: 'blur',
            },
            {
              validator: (rule, value, callback) => {
                if (!this.station.id) {
                  // this.$get(`system/user/check/${value}`).then((r) => {
                  //   if (!r.data) {
                  //     callback(this.$t('rules.usernameExist'))
                  //   } else {
                  //     callback()
                  //   }
                  // })
                } else {
                  // callback()
                }
                callback()
              },
              trigger: 'blur',
            },
          ],
          status: {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        },
        submitDisable:false
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
      initStation() {
        return {
          id: '',
          name: '',
          org: {
            key: null,
            data: null,
          },
          status: true,
          describe: '',
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
      loadListOptions({callback}) {
        callback()
      },
      setStation(val, orgs) {
        console.log('val=' + JSON.stringify(val))
        const vm = this

        vm.orgList = orgs
        if (val) {
          vm.oldName = val.name
          vm.station = {...val}
        }
      },
      close() {
        this.$emit('close')
      },
      reset() {
        // 先清除校验，再清除表单，不然有奇怪的bug
        this.$refs.form.clearValidate()
        this.$refs.form.resetFields()
        this.station = this.initStation()
      },
      submitForm() {
        this.submitDisable = true
        const vm = this
        this.$refs.form.validate(valid => {
          if (valid) {
            vm.editSubmit()
          } else {
            this.submitDisable = false
            return false
          }
        })
      },
      editSubmit() {
        const vm = this
        if (vm.type === 'add') {
          vm.save()
        } else {
          vm.update()
        }
      },
      save() {
        const vm = this
        stationApi.save(this.station).then(response => {
          this.submitDisable = false
          const res = response.data
          if (res.isSuccess) {
            vm.isVisible = false
            vm.$message({
              message: vm.$t('tips.createSuccess'),
              type: 'success',
            })
            vm.$emit('success')
          }
        }).catch(()=>{
          this.submitDisable = false
        })
      },
      update() {
        stationApi.update(this.station).then(response => {
          this.submitDisable = false
          const res = response.data
          if (res.isSuccess) {
            this.isVisible = false
            this.$message({
              message: this.$t('tips.updateSuccess'),
              type: 'success',
            })
            this.$emit('success')
          }
        }).catch(()=>{
          this.submitDisable = false
        })
      },

    },
  }
</script>
<style lang="scss" scoped></style>
