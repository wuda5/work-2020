<!--受理报装-->
<template>
  <el-form label-position="top" class="jh-text">
    <el-form-item label="报装类型">
      <el-select v-model="form.installType" clearable placeholder="请选择">
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
    <el-form-item label="报装人">
      <el-input v-model="form.userName" />
    </el-form-item>
    <el-form-item label="证件类型">
      <el-select v-model="form.cardType" clearable placeholder="请选择">
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
    <el-form-item label="证件号码">
      <el-input v-model="form.IDNumber" />
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
    <el-form-item label="安装地址">
      <el-input v-model="form.addr" />
    </el-form-item>
    <el-form-item label="联系电话">
      <el-input v-model="form.phone" />
    </el-form-item>
    <el-form-item label="户数">
      <el-input v-model="form.hs" />
    </el-form-item>
    <el-form-item label="备注">
      <el-input v-model="form.remark" />
    </el-form-item>
    <el-form-item>

    </el-form-item>
    <el-form-item>
      <el-button type="primary" class="width100">受理</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
export default {
  name: 'AcceptForInstall',
  data() {
    return {
      // 收费表单
      form: {
        installType: '',
        userNum: '2587425',
        cardType: '',
        userName: '徐有容',
        IDNumber: '',
        jd: '天府街道(乡镇)',
        xq: '天府小区(村、xx路)',
        phone: '13978951257',
        hs: 1,
        restMoney: '100.00',
        addr: '龙泉驿区3栋1单元25号',
        remark: ''
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .el-form-item{
    margin-bottom: 10px;
  }
</style>
