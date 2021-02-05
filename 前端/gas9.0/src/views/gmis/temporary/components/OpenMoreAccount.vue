<!--批量开户-->
<template>
  <el-form label-position="top" class="jh-text">
    <el-form-item label="报装编号">
      <el-input v-model="form.installNo" />
    </el-form-item>
    <el-form-item label="气表厂家">
      <el-select v-model="form.company" clearable placeholder="请选择">
        <el-option
          label="秦川物联网"
          value="1"
        />
        <el-option
          label="厂家2"
          value="2"
        />
        <el-option
          label="厂家3"
          value="3"
        />
      </el-select>
    </el-form-item>
    <el-form-item label="版号">
      <el-input v-model="form.bh" />
    </el-form-item>
    <el-form-item label="街道(乡镇)">
      <el-select v-model="form.jd" clearable placeholder="请选择">
        <el-option
          label="类型1"
          value="1"
        />
        <el-option
          label="类型2"
          value="2"
        />
        <el-option
          label="类型3"
          value="3"
        />
      </el-select>
    </el-form-item>
    <el-form-item label="小区(村、xx路)">
      <el-select v-model="form.xq" clearable placeholder="请选择">
        <el-option
          label="类型1"
          value="1"
        />
        <el-option
          label="类型2"
          value="2"
        />
        <el-option
          label="类型3"
          value="3"
        />
      </el-select>
    </el-form-item>
    <el-form-item label="栋">
      <el-input v-model="form.dong" />
    </el-form-item>
    <el-form-item label="单元">
      <el-input v-model="form.dany" />
    </el-form-item>
    <el-form-item label="楼层">
      <el-input v-model="form.lc" />
    </el-form-item>
    <el-form-item label="每次户数">
      <el-input v-model="form.hs" />
    </el-form-item>
    <el-form-item label="  ">
      <el-button type="primary" class="width100">建档</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
export default {
  name: 'OpenMoreAccount',
  data() {
    return {
      // 收费表单
      form: {
        installNo: '2587425',
        company: '2587425',
        bh: '6A',
        userName: '徐有容',
        jd: '天府街道(乡镇)',
        xq: '天府小区(村、xx路)',
        dong: '2栋',
        lc: '3层',
        dany: '3单元',
        hs: 8,
        addr: '龙泉驿区3栋1单元25号',
        remark: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .el-form-item {
    margin-bottom: 10px;
  }
</style>
