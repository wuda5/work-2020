<!--代扣导入-->
<template>
  <div>
    <el-upload
      class="uploadExcel"
      action="https://jsonplaceholder.typicode.com/posts/"
      :on-preview="handlePreview"
      :on-remove="handleRemove"
      :before-remove="beforeRemove"
      :limit="1"
      :on-exceed="handleExceed"
      :file-list="fileList"
    >
      <el-button type="primary" :disabled="fileList.length === 1">选择文件</el-button>
      <!--<div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>-->
    </el-upload>
    <el-button class="uploadBtn" type="primary">导入</el-button>
    <div class="clearfix"></div>
    <el-divider></el-divider>

    <!-- 用户信息列表 -->
    <div class="butGroup">
      <div class="fl">
        <el-button type="primary" plain>失败</el-button>
        <el-button type="primary" plain>成功</el-button>
        <el-button type="primary" plain>全部</el-button>
      </div>
      <div class="fr" style="padding-top: 5px">
        <el-tag type="info">合计气量：256</el-tag>
        <el-tag type="info">合计金额1000</el-tag>
        <el-tag type="info">已收金额 0</el-tag>
        <el-tag type="info">户数合计 10</el-tag>
        <el-tag type="success">成功 1</el-tag>
        <el-tag type="danger">失败 0</el-tag>
      </div>
    </div>
    <el-table
      :data="tableData"
      tooltip-effect="dark"
      :border="false"
      style="margin-top: 10px; width: 100%"
      :highlight-current-row="true"
      height="370px"
    >
      <el-table-column
        prop="userID"
        label="客户编号"
        width="80"
      />
      <el-table-column
        prop="name"
        label="客户姓名"
        width="80"
      />
      <el-table-column
        prop="tel"
        label="联系电话"
        width="100"
      />
      <el-table-column
        prop="userType"
        label="客户类型"
        width="80"
      />
      <el-table-column
        prop="gasType"
        label="用气类型"
        width="80"
      />
      <el-table-column
        prop="meterNo"
        label="气表编号"
        width="140"
      />
      <el-table-column
        prop="pressBoxNo"
        label="调压箱号"
      />

      <el-table-column
        prop="company"
        label="气表厂家"
      />
      <el-table-column
        prop="meterVer"
        label="气表版号"
      />
    </el-table>
    <pagination
      :total="30"
    />
  </div>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'

export default {
  name: 'WithholdImport',
  data() {
    return {
      fileList: [],
      tableData: [
        {
          userID: '224545',
          name: '王小虎',
          tel: '13845874587',
          userType: '个人',
          gasType: '民用',
          meterNo: '1056478850000000',
          pressBoxNo: '36547',
          address: '上海市普陀区金沙江路 1518 弄',
          company: '秦川',
          meterVer: '6A'
        }
      ]
    }
  },
  methods: {
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    handlePreview(file) {
      console.log(file)
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${file.name}？`)
    }
  }

}
</script>

<style lang="scss" scoped>

::v-deep .el-card__body {
  padding: 0;
}

// 设置表格头部背景
::v-deep .el-table th {
  background-color: #f5f7fa !important;
}

.el-table {
  border: 1px solid #ccc;
  border-bottom: none;
}

.butGroup {
  margin: 5px 0;
  overflow: hidden;

  .el-button {
    margin: 0;
  }
}

.uploadExcel {
  margin-top: 30px;
  float: left;
  height: 40px;

  ::v-deep .el-upload-list {
    margin-top: -66px;
  }
}

.uploadBtn {
  margin-top: 30px;
  position: absolute;
  left: 100px;
}

.el-divider--horizontal{
  margin: 0;
}
</style>
