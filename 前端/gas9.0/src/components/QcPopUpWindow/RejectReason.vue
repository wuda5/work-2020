<!--驳回原因-->
<template>
  <div>
    <el-form label-position="top" class="jh-text">
      <el-form-item label="驳回原因" class="width100">
        <textarea rows="3" class="el-input__inner textarea" :value="value" @input="updateValue($event)" />
      </el-form-item>
    </el-form>
    <div class="btnBox">
      <el-button type="primary" class="fr" @click="submit">驳回</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RejectReason',
  model: {
    prop: 'value',
    event: 'input'
  },
   props: {
    value: String
  },
  methods:{
    updateValue(e) {
     this.$emit('input', e.target.value)
    },
    submit(){
      this.$emit('submit')
    }
  }
}
</script>
<style lang="scss" scoped>
  .textarea{
    height: auto;
    max-width: 100%;
    min-width: 100%;
    line-height: 18px;
    padding: 10px;
  }
</style>