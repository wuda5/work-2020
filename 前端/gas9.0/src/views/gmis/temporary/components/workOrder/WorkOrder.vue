<!-- 创建工单 -->
<template>
  <div>
    <el-card shadow="never" class="no-border">
      <el-form label-position="top" :model="form" class="jh-text buka">
        <el-form-item label="工单类型">
          <el-select v-model="form.type" clearable placeholder="请选择">
            <!--  todo : 字典替换-->
            <el-option
              label="维修"
              value="1"
            />
            <el-option
              label="更换"
              value="2"
            />
            <el-option
              label="检查"
              value="3"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="紧急程度">
          <el-radio-group v-model="form.level">
            <el-radio-button label="正常" value="正常"></el-radio-button>
            <el-radio-button label="紧急" value="紧急"></el-radio-button>
            <el-radio-button label="非常紧急" value="非常紧急"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="工单内容" class="width100">
          <el-input v-model="form.content" rows="5" type="textarea"/>
        </el-form-item>

        <el-form-item label="联系电话">
          <el-input v-model="form.tel"/>
        </el-form-item>
        <el-form-item label="接单人">
          <el-input v-model="form.js"/>
        </el-form-item>

        <div class="clearfix"></div>
        <div class="btnBox width100">
          <el-button type="primary">创建</el-button>
          <el-button type="primary">打印</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>
<script>
export default {
  name: 'WorkOrder',
  props: {
    userInfo: Object,
  },
  data() {
    return {
      form: {
        type: '',
        level: '正常',
        content: '',
        tel: '',
        js: ''
      }
    }
  },
  computed: {},
  methods: {}
}
</script>
<style lang="scss" scoped>
</style>
