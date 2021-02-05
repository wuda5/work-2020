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
      <el-form-item :label="$t('table.gasModel.production')" prop="companyId">
        <el-select v-model="gasModel.companyId" :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item,index) in gasProductList"
            :key="index"
            :label="item.gasMeterFactoryName"
            :value="item.id"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 气表版号 -->
      <el-form-item :label="$t('table.gasModel.version')" prop="gasMeterVersionId">
        <el-select v-model="gasModel.gasMeterVersionId" :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item,index) in gasVersionList" 
            :key="index"
            :label="item.gasMeterVersionName"
            :value="item.id"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 型号名称 -->
      <el-form-item :label="$t('table.gasModel.modelName')" prop="modelName">
        <el-input v-model="gasModel.modelName" />
      </el-form-item>
      <!-- 型号规格 -->
      <el-form-item :label="$t('table.gasModel.modelSpecs')" prop="specification"> 
        <el-select v-model.number="gasModel.specification" :placeholder="$t('common.pleaseSelect')">
          <el-option
            v-for="(item,index) in dicts.SPECIFICATION"
            :key="index"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 公称流量 -->
      <el-form-item :label="$t('table.gasModel.flow')" prop="nominalFlowRate">
        <el-input v-model="gasModel.nominalFlowRate" placeholder="m³/h" />
      </el-form-item>
      <!-- 最大流量 -->
      <el-form-item :label="$t('table.gasModel.maxFlow1')" prop="maxFlow">
        <el-input v-model="gasModel.maxFlow" placeholder="m³/h" />
      </el-form-item>
      <!-- 最小流量 -->
      <el-form-item :label="$t('table.gasModel.minFlow1')" prop="minFlow">
        <el-input v-model="gasModel.minFlow" placeholder="m³/h" />
      </el-form-item>
      <!-- 最大压力 -->
      <el-form-item :label="$t('table.gasModel.maxPressure')" prop="maxPressure">
        <el-input v-model="gasModel.maxPressure" placeholder="kpa" />
      </el-form-item>
      <!-- 字轮最大值 -->
      <el-form-item :label="$t('table.gasModel.max')" prop="maxWordWheel">
        <el-input v-model="gasModel.maxWordWheel" placeholder="m³" />
      </el-form-item>
      <!-- 回转体积 -->
      <el-form-item :label="$t('table.gasModel.volume')" prop="rotationalVolume">
        <el-input v-model="gasModel.rotationalVolume" placeholder="dm³" />
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button plain type="warning" @click="isVisible = false">
        {{ $t("common.cancel") }}
      </el-button>
      <el-button plain type="primary" @click="submitForm">
        {{ $t("common.confirm") }}
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
import gasModelApi from '@/api/system/gasModel'
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
      gasModel: {},
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
        gasMeterVersionId: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        modelName: { required: true,message: this.$t('rules.require')},
        specification:[{ required: true,message: this.$t('rules.require')}],
        nominalFlowRate:[{ required: true,message: this.$t('rules.require')}],
        maxFlow:[{ required: true,message: this.$t('rules.require')}],
        minFlow:[{ required: true,message: this.$t('rules.require')}],
        maxPressure:[{ required: true,message: this.$t('rules.require')}],
        maxWordWheel:[{ required: true,message: this.$t('rules.require')}],
        rotationalVolume:[{ required: true,message: this.$t('rules.require')}]
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
  },
  watch: {
    // 监听气表厂家id
    'gasModel.companyId': {
      handler(value) {
        const factory = this.gasProductList.find((item) => item.id === value)
        console.log('factory', factory)
        let companyName = ''
        let companyCode = ''
        if (factory) {
          companyName = factory.gasMeterFactoryName
          companyCode = factory.gasMeterFactoryCode
        }
        this.gasModel.companyName = companyName
        this.gasModel.companyCode = companyCode
      }
    },
    // 监听气表版号id
    'gasModel.gasMeterVersionId': {
      handler(value) {
        const version = this.gasVersionList.find((item) => item.id === value)
        let gasMeterVersionName = ''
        if (version) {
          gasMeterVersionName = version.gasMeterVersionName
        }
        this.gasModel.gasMeterVersionName = gasMeterVersionName
      }
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
    loadListOptions({ callback }) {
      callback()
    },
    setGasModel(val, dicts) {
      const vm = this
      if (val) {
        vm.gasModel = { ...val }
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
      this.gasModel = {}
    },
    submitForm() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
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
      })
    },
    /**
     * 查询气表生产厂商
     */
    queryGasProduct(){
      this.loading = true
      gasModelApi.queryGasProduct(null).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.loading = false
          this.gasProductList=res.data

        }
      })
    },
     /**
     * 查询气表版号
     */
    queryGasVersion(){
      this.loading = true
      gasModelApi.queryGasVersion(null).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.loading = false
          this.gasVersionList=res.data

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
