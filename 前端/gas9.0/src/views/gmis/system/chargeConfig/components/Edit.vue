<template>
  <el-form ref="form" label-position="top" :model="form" :rules="rules" class="jh-text">
    <!--收费项目-->
    <el-form-item label="收费项目" prop="itemName">
      <el-input v-model="form.itemName" :disabled="!isEdit || !isOtherFee" /><!--xlj1027改: 除附加收费外都禁止编辑-->
    </el-form-item>
    <!--收费场景-->
    <el-form-item label="收费场景" prop="sceneCode">
      <el-select v-model="form.sceneCode" :disabled="!!formData||!isEdit" :clearable="true" placeholder="请选择" @change="selectHandle()">
        <el-option
          v-for="item in dict.SCENES"
          :key="item.id"
          :label="item.name"
          :value="item.code"
          :disabled="item.name=='抄表收费'?true:false"
        />
      </el-select>
    </el-form-item>
    <!--收费期限 只有附加费禁止-->
    <el-form-item label="收费期限（年为单位，0代表无限期）" prop="chargePeriod">
      <el-input
        v-model.number="form.chargePeriod"
        :disabled="!isOtherFee || !isEdit"
        type="number"
      />
    </el-form-item>
    <!--收费频次 xlj1022改:收费场景非附加费,按月按年频次禁选-->
    <el-form-item label="收费频次" prop="chargeFrequency">
      <el-select v-model="form.chargeFrequency" :disabled="!isEdit" :clearable="true" placeholder="请选择">
        <el-option
          v-for="item in dict.CHARGE_FREQUENCY"
          :key="item.id"
          :label="item.name"
          :value="item.code"
          :disabled="!isOtherFee && (item.code == 'BY_MONTH' || item.code == 'ON_DEMAND' ||item.code == 'BY_YEAR')"
        />
      </el-select>
    </el-form-item>

    <!--金额方式-->
    <el-form-item label="金额方式" prop="moneyMethod">
      <el-select
        v-model="form.moneyMethod"
        :clearable="true"
        placeholder="请选择"
        @change="moneyMethodChange"
      >
        <template v-for="item in dict.MONEY_METHOD">
          <el-option
            v-if="item.code !== 'percent'"
            :key="item.id"
            :label="item.name"
            :value="item.code"
          />
        </template>
      </el-select>
    </el-form-item>

    <!--金额-->
    <el-form-item label="金额" prop="money">
      <el-input v-model="form.money" />
    </el-form-item>

    <!--周期值 固定值1 暂不显示-->
    <!--<el-form-item label="周期值" prop="cycleValue">
      <el-input v-model="form.cycleValue" type="number"/>
    </el-form-item>-->

    <!--增值税普税税率-->
    <el-form-item label="增值税普税税率">
      <el-input v-model="form.vatGeneralRate" />
    </el-form-item>

    <!--财务科目-->
    <el-form-item label="财务科目">
      <el-select v-model="form.financialSubject" :clearable="true" placeholder="请选择">
        <el-option
          v-for="item in dict.FINANCIAL_SUBJECT || []"
          :key="item.id"
          :label="item.name"
          :value="item.code"
        />
      </el-select>
    </el-form-item>

    <!--税收分类编码-->
    <el-form-item label="税收分类编码">
      <el-input v-model="form.taxCategoryCode" />
    </el-form-item>

    <!--是否享受优惠-->
    <el-form-item label="是否享受优惠">
      <el-radio-group v-model="form.favouredStatus">
        <el-radio-button :label="1">否</el-radio-button>
        <el-radio-button :label="0">是</el-radio-button>
      </el-radio-group>
    </el-form-item>

    <!--优惠政策内容-->
    <el-form-item label="优惠政策内容">
      <el-input v-model="form.favouredPolicy" />
    </el-form-item>

    <!--零税率标识-->
    <el-form-item label="零税率标识">
      <el-radio-group v-model="form.zeroTaxStatus">
        <el-radio-button :label="1">否</el-radio-button>
        <el-radio-button :label="0">是</el-radio-button>
      </el-radio-group>
    </el-form-item>
    <div class="clearfix"></div>

    <!--企业自编码-->
    <el-form-item label="企业自编码">
      <el-input v-model="form.customCode" />
    </el-form-item>

    <!--编码版本号-->
    <el-form-item label="编码版本号">
      <el-input v-model="form.codeVersion" />
    </el-form-item>

    <!--用气类型  只有非附加费禁止-->
    <el-form-item prop="useGasTypeId" label="用气类型" :rules="!isOtherFee ? [] : [{required: true, message: '必填', trigger: 'blur' }]">
      <el-select
        v-model="form.useGasTypeId"
        :disabled="!isOtherFee"
        :clearable="true"
        :multiple="true"
        filterable
        :placeholder="isOtherFee ? '请选择' : '全部'"
        :collapse-tags="true"
      >
        <el-option
          v-for="item in gasTypeList"
          :key="item.id"
          :label="item.useGasTypeName"
          :value="item.id"
        />
      </el-select>
    </el-form-item>

    <!--税扣除额-->
    <el-form-item label="税扣除额">
      <el-input v-model="form.taxDeductionMoney" />
    </el-form-item>

    <!--开始时间 xlj1022改:只有编辑禁止-->
    <el-form-item label="开始时间" prop="startTime">
      <el-date-picker
        v-model="form.startTime"
        :disabled="!isEdit"
        value-format="yyyy-MM-dd"
        type="date"
      />
    </el-form-item>

    <div class="clearfix" />
    <el-form-item label=" " style="float: right">
      <el-button v-if="form.id" type="primary" :disabled="submitLoading" :loading="submitLoading" class="width100" @click="submitForm('form')">保存</el-button>
      <el-button v-else type="primary" :disabled="submitLoading" :loading="submitLoading" class="width100" @click="submitForm('form')">新增</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { cloneDeep } from 'lodash'
import apiChargeConfig from '@/api/system/chargeConfig'
import { getUseGasTypeList } from '@/api/operation/gasPrice'
import { positiveNumberReg } from '@/utils/reg'
import { activityMoneyTypeField } from '@/enums/preferential'

export default {
  name: 'Edit',
  props: {
    formData: {
      type: Object,
    },
  },
  data() {
    return {
      form: {},
      //xlj1022加:新增或编辑判断是否禁止编辑
      isEdit:this.formData? false:true,
      // 获取用气类型查询条件
      useGasTypeNameForm: this.initQueryParams({
        size: 10000,
      }),
      gasTypeList: [],
      // params: null
      rules: {
        itemName: [{ required: true, message: '必填', trigger: 'blur' }], 
        sceneCode: [{ required: true, message: '必填', trigger: 'blur' }], // 收费场景
        // chargePeriod: [{ required: true, message: '必填', trigger: 'blur' }], // 收费期限
        chargeFrequency: [{ required: true, message: '必填', trigger: 'blur' }], // 收费频次
        // 金额
        money: [
          {
            required: true,
            message: '必填',
            trigger: 'blur',
          },
          // { pattern: positiveNumberReg, message: '数据不合法', trigger: 'blur' },
          { validator: (rule, value) => {
            return new Promise((resolve, reject) => {
              if (this.isFixedMoney) {
                if (positiveNumberReg.test(value) && +value > 0) {
                  resolve(true)
                } else {
                  reject('金额是必须大于0的合法数字')
                }
              } else {
                resolve(true)
              }
            })
          }, message: '金额是必须大于0的合法数字', trigger: 'blur' },
        ],
        moneyMethod: [{ required: true, message: '必填', trigger: 'blur' }], // 金额方式
        cycleValue: [{ required: true, message: '必填', trigger: 'blur' }], // 周期值
        startTime:[{ required: true, message: '必填', trigger: 'blur' }], //开始时间,xlj1022:新增时必填开始时间
        // useGasTypeId: [{ required: true, message: '必填', trigger: 'blur' }], // 用气类型
      },
      submitLoading: false,
    }
  },
  computed: {
    // 是否是附加项
    isOtherFee() {
      return this.form.sceneCode === 'OTHER'
    },
    // 金额方式是否是固定
    isFixedMoney() {
      return this.form.moneyMethod === activityMoneyTypeField.GDJE
    },
  },
  watch: {
    'form.moneyMethod': {
      handler: function (val, oldval) {
        if (this.isFixedMoney) {
        this.rules.money[0].required = true
        } else {
          this.rules.money[0].required = false
        }
      },
      deep: true, //对象内部的属性监听，也叫深度监听
    },
  },
  async created() {
    await this.getUseGasType()
    this.form = this.formData ? { ...cloneDeep(this.initFormData()), ...cloneDeep(this.formData) } : cloneDeep(this.initFormData())
    try {
      this.form.useGasTypeId = (JSON.parse(this.form.useGasTypes) || []).map((item) => {
        return item.use_gas_type_id
      })
    } catch (error) {
      console.warn('用气类型json解析失败!')
    }
  },
  mounted() {},
  methods: {
    // initFormData
    initFormData() {
      return {
        itemName: '', // 收费项目
        sceneCode: '', // 收费场景
        chargePeriod: 0, // 收费期限
        chargeFrequency: '', // 收费频次
        money: '', // 金额
        moneyMethod: '', // 金额方式
        cycleValue: 1, // 周期值
        vatGeneralRate: '', // 增值税普税税率
        financialSubject: '', // 财务科目
        taxCategoryCode: '', // 税收分类编码
        favouredStatus: 1, // 是否享受优惠
        favouredPolicy: '', // 优惠政策内容
        zeroTaxStatus: 1, // 零税率标识 0：是 1：否
        customCode: '', // 企业自编码
        codeVersion: '', // 编码版本号
        useGasTypeId: null, // 用气类型
        taxDeductionMoney: '', // 税扣除额
        startTime: '', // 开始时间
      }
    },

    // 添加
    addNew() {
      let submitData = JSON.parse(JSON.stringify(this.form))
      this.submitLoading = true
      apiChargeConfig.add(submitData).then(res => {
        if (res.data.isSuccess) {
          this.msg('添加成功', 'success')
          this.emitCloseDialog('close', 'showAdd')
        }
      })
      .finally(() => (this.submitLoading = false))
    },

    // 更新
    updateData() {
      let submitData = JSON.parse(JSON.stringify(this.form))
      this.submitLoading = true
      submitData.scenes = JSON.stringify(submitData.scenes)
      apiChargeConfig.update(submitData).then(res => {
        if (res.data.isSuccess) {
          this.msg('更新成功', 'success')
          this.emitCloseDialog('close', 'showAdd')
        }
      })
      .finally(() => (this.submitLoading = false))
    },

    // 提交
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.id) {
            // 更新
            this.updateData()
          } else {
            // 新增
            this.addNew()
          }
        } else {
          this.msg('验证失败')
          return false
        }
      })
    },

    // 获取用气类型
    getUseGasType() {
      return new Promise((resolve) => {
        getUseGasTypeList(this.useGasTypeNameForm).then(res => {
          const { isSuccess, data } = res.data
          // console.log({isSuccess, data})
          if (isSuccess) {
            this.gasTypeList = data.records
          }
          resolve(isSuccess)
        })
        .catch(() => {
          resolve(false)
        })
      })
    },

    // 金额方式改变
    moneyMethodChange(value) {
      // 如果方式为不固定
      if (value === 'unfixed') {
        this.form.money = ''
        this.rules.money[0].required = false
      } else {
        this.rules.money[0].required = true
      }
    },
    //xlj1022添加:收费场景若不是附件费，清空频次,非附加费直接把名添加给收费项目
    // 如果是附加费则自己选择，如果非附加费则用气类型默认选全部
    selectHandle(){
      if(!this.isOtherFee){
        this.form.chargeFrequency = ''
        for(let k in this.dict.SCENES){
          if(this.form.sceneCode == this.dict.SCENES[k].code){
              this.form.itemName = this.dict.SCENES[k].name
          }
        }
        this.form.useGasTypeId = null
      }
      
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 3);
      margin-bottom: 15px;
    }
  }
</style>
