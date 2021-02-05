<!--抄表计划 添加 | 修改-->
<template>
  <div>
    <el-form ref="planForm" label-position="top" :rules="rules" :model="planForm" class="jh-text">
      <!-- 本期止数 -->
      <el-form-item label="本期止数" prop="currentTotalGas">
         <qc-number-input v-model="planForm.currentTotalGas" :precision="0" :min="+curPlan.lastTotalGas || 0" placeholder="本期止数"></qc-number-input>
      </el-form-item>
    </el-form>
    <div class="text-right">
      <el-button type="primary" @click="update()">修改</el-button>
    </div>
  </div>
</template>

<script>
import apiImport from '@/api/readMeter/import.js'
import data from '@/views/gmis/service/data'
import { mounted } from 'v-charts/lib/core'
export default {
  name: 'Edit',
  props: {
    formType: {
      type: String,
    },
    curPlan: {
      type: Object,
    },
  },
  data() {
    return {
      // 计划表单
      planForm: this.initPlanForm(),
      rules: {
        currentTotalGas: [
          { required: true, message: '必填', trigger: 'blur' },
          // { type: 'number', message: '只能是数字', trigger: 'blur' },
        ],
      },
    }
  },
  created() {
    const min = +(this.curPlan?.lastTotalGas || 0)
    this.rules.currentTotalGas.push({ type: 'number', message: `只能是大于等于${min}的正整数`, min, trigger: 'blur' },)
  },
  methods: {
    initPlanForm() {
      // 如果是修改
      return {
        id: this.curPlan.id,
        currentTotalGas: Number(this.curPlan.currentTotalGas),
      }
    },

    update() {
      // 验证表单
      this.$refs.planForm.validate(valid => {
        if (valid) {
          let submitData = JSON.parse(JSON.stringify(this.planForm))
          submitData.monthUseGas =
            Number(submitData.currentTotalGas) - Number(this.curPlan.lastTotalGas)

          console.log(submitData)
          apiImport.update(submitData).then(res => {
            const { isSuccess } = res.data
            if (isSuccess) {
              this.msg('矫正成功', 'success')
            }
            this.$emit('close')
          })
        }
      })
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 3);
      margin-bottom: 18px;
    }
  }
</style>
