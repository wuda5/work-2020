<!-- 更换节点 -->
<template>
  <el-card shadow="never" class="no-border">
    <el-form label-position="top" :model="formData" class="jh-text meterInfo">
      <el-form-item label="节点编号">
        <el-input v-model="formData[1]" />
      </el-form-item>
      <el-form-item label="节点名称">
        <el-input v-model="formData[2]" />
      </el-form-item>
      <el-form-item label="节点类型">
        <el-select v-model="formData[3]" clearable placeholder="请选择">
          <el-option
            label="6A"
            value="1"
          />
          <el-option
            label="6B"
            value="2"
          />
          <el-option
            label="6C"
            value="3"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="设备厂家">
        <el-select v-model="formData[4]" clearable placeholder="请选择">
          <el-option
            label="6A"
            value="1"
          />
          <el-option
            label="6B"
            value="2"
          />
          <el-option
            label="6C"
            value="3"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="设备型号">
        <el-select v-model="formData[5]" clearable placeholder="请选择">
          <el-option
            label="left"
            value="1"
          />
          <el-option
            label="right"
            value="2"
          />
          <el-option
            label="其他"
            value="3"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="设备口径">
        <el-select v-model="formData[6]" clearable placeholder="请选择">
          <el-option
              label="left"
              value="1"
          />
          <el-option
              label="right"
              value="2"
          />
          <el-option
              label="其他"
              value="3"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="安装地址">
        <el-input v-model="formData[7]" />
      </el-form-item>
      <el-form-item label="温度上限">
        <el-date-picker v-model="formData[8]" />
      </el-form-item>
      <el-form-item label="温度下限">
        <el-input v-model="formData[9]" />
      </el-form-item>
      <el-form-item label="负责人">
        <el-input v-model="formData[10]" />
      </el-form-item>
      <el-form-item label="压力上限">
        <el-input v-model="formData[11]" />
      </el-form-item>
      <el-form-item label="压力下限">
        <el-input v-model="formData[12]" />
      </el-form-item>
      <el-form-item label="报警电话">
        <el-input v-model="formData[13]" />
      </el-form-item>
      <el-form-item label="流量上限">
        <el-input v-model="formData[14]" />
      </el-form-item>
      <el-form-item label="流量下限">
        <el-input v-model="formData[15]" />
      </el-form-item>
      <el-form-item label="备注" class="width100">
        <el-input v-model="formData[16]"  rows="3" type="textarea" />
      </el-form-item>
      <div class="clearfix"></div>
      <el-form-item label="" style="float: right">
        <el-button type="primary" class="width100">更换节点</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'NodeSwitch',
  data() {
    return {
      // 收费表单
      formData: {
        1: 'scdd-001-001',
        2: '模范街',
        3: '',
        4: '',
        5: '',
        6: '',
        7: '花都大道624',
        8: '100',
        9: '0',
        10: '李三',
        11: '180',
        12: '0',
        13: '18612587854',
        14: '120',
        15: '0',
        16: '家具啊啊大师的发射打破发卡；大师傅的开始'
      }

    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body{
  padding: 10px;
}
.jh-text {
  .el-form-item {
    width: calc(100% / 3);
    margin-bottom: 10px;
  }
}
</style>
