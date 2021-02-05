<!-- 气表型号添加和编辑 -->
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
    <el-form ref="form" :model="gasModel" :rules="rules" label-position="right" label-width="100px" class="jh-text">
      <!-- 生产厂商 -->
      <el-form-item :label="$t('table.gasModel.production')" prop="companyName">
        <el-select v-model="gasModel.companyName" filterable clearable :placeholder="$t('common.pleaseSelect')" @change="handleFactoryChange">
          <el-option
            v-for="(item,index) in gasProductList"
            :key="index"
            :label="item.gasMeterFactoryName"
            :value="item.gasMeterFactoryName"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 气表版号 -->
      <el-form-item :label="$t('table.gasModel.version')" prop="gasMeterVersionName">
        <el-select v-model="gasModel.gasMeterVersionName" filterable clearable :placeholder="$t('common.pleaseSelect')" @change="handleVersionChange">
          <el-option
            v-for="(item,index) in gasVersionList"
            :key="index"
            :label="item.gasMeterVersionName"
            :value="item.gasMeterVersionName"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 型号规格 -->
      <el-form-item :label="$t('table.gasModel.modelSpecs')" prop="specification"> 
        <el-select v-model="gasModel.specification" filterable clearable :placeholder="$t('common.pleaseSelect')" @change="handleChange">
          <el-option
            v-for="(item, index) in specifications"
            :key="index"
            :label="item.name"
            :value="item.code"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 型号名称 -->
      <el-form-item :label="$t('table.gasModel.modelName')" prop="modelName">
        <el-input v-model="gasModel.modelName" />
      </el-form-item>
      <!-- 公称流量 -->
      <el-form-item :label="$t('table.gasModel.flow')">
        <el-input v-model="gasModel.nominalFlowRate" placeholder="m³/h" />
      </el-form-item>
      <!-- 最大流量 -->
      <el-form-item :label="$t('table.gasModel.maxFlow1')">
        <el-input v-model="gasModel.maxFlow" placeholder="m³/h" />
      </el-form-item>
      <!-- 最小流量 -->
      <el-form-item :label="$t('table.gasModel.minFlow1')">
        <el-input v-model="gasModel.minFlow" placeholder="m³/h" />
      </el-form-item>
      <!-- 最大压力 -->
      <el-form-item :label="$t('table.gasModel.maxPressure')">
        <el-input v-model="gasModel.maxPressure" placeholder="kpa" />
      </el-form-item>
      <!-- 字轮最大值 -->
      <el-form-item :label="$t('table.gasModel.max')">
        <el-input v-model="gasModel.maxWordWheel" placeholder="m³" />
      </el-form-item>
      <!-- 回转体积 -->
      <el-form-item :label="$t('table.gasModel.volume')">
        <el-input v-model="gasModel.rotationalVolume" placeholder="dm³" />
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
import { orderBy, sortBy } from 'lodash'
import gasModelApi from '@/api/system/gasModel'
import { dataStatusField, useStatusField, deleteStatusField } from '@/enums/common'
export default {
  name: 'GasModelEdit',
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
      loading: false,
      gasModel: this.setInitForm(),
      screenWidth: 0,
      width: this.initWidth(),
      rules: {
        companyId: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        companyName: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        gasMeterVersionId: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        gasMeterVersionName: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        specification:[{ required: true,message: this.$t('rules.require')}],
        modelName: [{ required: true,message: this.$t('rules.require')}],
      },
       //数据字典
      dicts: {
        WIRELESS_EQUIPMENT_VENDORS:{},
      },
      gasProductList:[],
      gasVersionList:[]
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
    // 型号规格map
    specifications() {
      return sortBy(this.dict['SPECIFICATION'], (item) => {
        return +item.name
      })
    }
  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    // 初始化表单数据
    setInitForm() {
      return {
        companyCode: null,
        companyId: null,
        companyName: null,
        gasMeterVersionId: null,
        gasMeterVersionName: null,
        maxFlow: null,
        maxPressure: null,
        maxWordWheel: null,
        minFlow: null,
        modelName: null,
        nominalFlowRate: null,
        rotationalVolume: null,
        specification: null,
      }
    },
    initWidth() {
      this.screenWidth = document.body.clientWidth
      return this.screenWidth < 991 ? '90%' : '40%'
    },
    loadListOptions({ callback }) {
      callback()
    },
    setGasModel(val, dicts) {
      const vm = this
      if (val) {
        vm.gasModel = { ...this.setInitForm(), ...val }
      }
      vm.dicts = dicts;
      //获取气表生产厂商信息
      this.queryGasProduct()
      this.queryGasVersion()
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.gasModel = this.setInitForm()
    },
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
    editSubmit() {
      const vm = this
      if (vm.type === 'add') {
        vm.save()
      } else {
        vm.update()
      }
    },
    /**
     * 新增
     */
    save() {
      const vm = this
      gasModelApi.save(this.gasModel).then(response => {
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
     * 编辑
     */
    update() {
      gasModelApi.update(this.gasModel).then(response => {
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
    /**
     * 查询气表生产厂商
     */
    queryGasProduct(){
      // this.loading = true
      gasModelApi.queryGasProduct({ gasMeterFactoryStatus: useStatusField.ENABLE, deleteStatus: deleteStatusField.DELETE_INVALID}).then(response => {
        const res = response.data
        if (res.isSuccess) {
          // this.loading = false
          this.gasProductList=res.data

        }
      })
    },
     /**
     * 查询气表版号
     */
    queryGasVersion(){
      const payload = {
        companyId: this.gasModel.companyId,
        versionState: useStatusField.ENABLE,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
      gasModelApi.queryGasVersion(payload).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.gasVersionList = res.data
        }
      })
    },

    // 厂家发生改变
    handleFactoryChange(value) {
      // 置空版号选择信息
      this.gasModel.gasMeterVersionId = ''
      this.gasModel.gasMeterVersionName = ''
      this.gasVersionList = []
      const factory = this.gasProductList.find((item) => item.gasMeterFactoryName === value)
      this.gasModel.companyId = factory?.id ?? null
      this.gasModel.companyCode = factory?.companyCode ?? null
      this.queryGasVersion()
    },

    // 版号发生改变
    handleVersionChange(value) {
      const version = this.gasVersionList.find((item) => item.gasMeterVersionName === value)
      this.gasModel.gasMeterVersionId = version?.id ?? null
    },
    // 型号选择变更 触发 型号名称改变
    handleChange(val) {
      this.gasModel.modelName = val
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
