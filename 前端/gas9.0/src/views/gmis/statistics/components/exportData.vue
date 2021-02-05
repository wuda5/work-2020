<!-- 数据导出 -->
<template>
  <div class="">
    <el-form ref="formData" label-position="top" :model="formData" class="jh-text">
      <el-form-item style="width:100%">
        <el-col class="diogTitle" :span="24"><span class="card-title">机构选择</span></el-col>
      </el-form-item>
      <el-form-item label="机构选择" prop="organ">
        <el-select v-model="formData.organ" placeholder="请选择">
          <el-option
            v-for="item in organ"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="公司选择" prop="company">
        <el-select v-model="formData.company" placeholder="请选择">
          <el-option
            v-for="item in company"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分公司选择" prop="office">
        <el-select v-model="formData.office" placeholder="请选择">
          <el-option
            v-for="item in office"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="营业网点选择" prop="outlets">
        <el-select v-model="formData.outlets" placeholder="请选择">
          <el-option
            v-for="item in outlets"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item style="width:100%">
        <el-col class="diogTitle" :span="24"><span class="card-title">时间节点选择</span></el-col>
      </el-form-item>
      <el-form-item label="开始时间">
        <el-date-picker
          v-model="formData.startDate"
          type="datetime"
          prefix-icon="el-icon-date"
          placeholder="选择日期时间"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item label="截止时间">
        <el-date-picker
          v-model="formData.endDate"
          type="datetime"
          prefix-icon="el-icon-date"
          placeholder="选择日期时间"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item style="width:100%">
        <el-col class="diogTitle" :span="24"><span class="card-title">导出业务选择</span></el-col>
      </el-form-item>
      <el-form-item style="width:100%" prop="listType">
        <el-checkbox-group v-model="formData.listType">
          <el-checkbox v-for="(item,index) in checkList" :key="index" :name="`listType${index}`" :label="item"></el-checkbox>
        </el-checkbox-group>
      </el-form-item>
      <el-form-item style="width:100%">
        <el-col class="diogTitle" :span="24"><span class="card-title">表格预览</span></el-col>
      </el-form-item>
      <el-form-item style="width:100%">
        <el-table
          :data="formData.tableData"
          stripe
          height="200"
          show-summary
          :header-row-style="{backgroundColor:'#F5F6FD'}"
          :row-style="changeRowStyle()"
          style="width: 100%"
        >
          <el-table-column
            label="序号"
            type="index"
            width="80"
          >
          </el-table-column>
          <el-table-column
            prop="number"
            label="客户编号"
            width="100"
          >
          </el-table-column>
          <el-table-column
            prop="name"
            label="客户名称"
            width="100"
          >
          </el-table-column>
          <el-table-column
            prop="phone"
            label="客户电话"
          >
          </el-table-column>
          <el-table-column
            prop="type"
            label="客户类型"
          >
          </el-table-column>
          <el-table-column
            prop="time"
            label="开户时间"
          >
          </el-table-column>
          <el-table-column
            prop="address"
            label="安装地址"
          >
          </el-table-column>
          <el-table-column
            prop="gender"
            label="客户性别"
          >
          </el-table-column>
          <el-table-column
            prop="certType"
            label="证件类型"
          >
          </el-table-column>
          <el-table-column
            prop="certNum"
            label="证件号码"
          >
          </el-table-column>
          <el-table-column
            prop="khorgan"
            label="开户机构"
          >
          </el-table-column>
          <el-table-column
            prop="mark"
            label="备注"
          >
          </el-table-column>
        </el-table>
      </el-form-item>
      <el-form-item style="width:100%" class="footer">
        <el-button type="primary">确认导出</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      formData: {
        organ: '',
        company: '',
        office: '',
        outlets: '',
        startDate: '',
        endDate: '',
        listType: [],
        tableData: []
      },
      checkList: ['基本信息明细报表', '代扣签约报表', '账户余额报表'],

      organ: [{
        label: '博奥燃气',
        value: 'BA'
      }, {
        label: '华润燃气',
        value: 'HR'
      }, {
        label: '中国石油',
        value: 'Petro'
      }, {
        label: '中国石化',
        value: 'Sinopec'
      }],
      company: [{
        label: '四川分公司',
        value: '1'
      }, {
        label: '成都总公司',
        value: '2'
      }, {
        label: '河南分公司',
        value: '3'
      }, {
        label: '浙江分公司',
        value: '4'
      }],
      office: [
        {
          label: '成都子公司',
          value: '12'
        }, {
          label: '绵阳子公司',
          value: '13'
        }, {
          label: '南充子公司',
          value: '14'
        }, {
          label: '自贡子公司',
          value: '15'
        }],
      outlets: [{
        label: '天府广场',
        value: '121'
      }, {
        label: '春熙路',
        value: '122'
      }, {
        label: '天府三街',
        value: '123'
      }, {
        label: '红牌楼',
        value: '124'
      }]
    }
  },
  methods: {
    changeRowStyle(row, column, rowIndex, columnIndex) {
      // console.log(rowIndex);
    }
  }
}
</script>
<style lang="scss" scoped>
.jh-text {
    .el-form-item {
      width: calc(100% / 4);
      margin-bottom: 15px;
    }
    ::v-deep .el-date-editor.el-input, ::v-deep .el-date-editor.el-input__inner{
        width:180px;
    }
  }
    .el-card .card-title{
        font-size: 16px;
    }
    .diogTitle{
        padding:5px 0;
        border-bottom: 1px solid #eee;
        margin:10px 0;
    }
    .el-checkbox{
        width:150px;
        height:30px;
        line-height: 30px;
        background-color: #F7F7F7;
        text-align: center;

        .el-checkbox__label{
            font-size: 14px;
        }
    }
    .tableTitle{
        font-size: 14px;
        font-weight: bold;
        margin:5px 0;
    }
    .footer{
        text-align: right;
        margin-top:20px;
    }
</style>
