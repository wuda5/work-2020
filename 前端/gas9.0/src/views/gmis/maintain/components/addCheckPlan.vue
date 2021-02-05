<!-- 新增安检计划 || 批量新增安检计划 -->
<template>
  <el-card shadow="never" class="no-border">

    <!-- 批量添加-搜索 -->
    <el-form label-position="top" :model="searchForm" class="jh-text">
      <el-form-item label="">
        <el-date-picker v-model="searchForm[1]" placeholder="开始时间" />
      </el-form-item>

      <el-form-item label="">
        <el-date-picker v-model="searchForm[2]" placeholder="结束时间" />
      </el-form-item>

      <el-form-item label="">
        <el-select v-model="searchForm[3]" placeholder="街道(乡镇)">
          <el-option label="ddd" value="4"></el-option>
          <el-option label="888" value="8"></el-option>
          <el-option label="tty" value="9"></el-option>
          <el-option label="sss" value="6"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="">
        <el-select v-model="searchForm[4]" placeholder="小区(村、xx路)">
          <el-option label="ddd" value="4"></el-option>
          <el-option label="888" value="8"></el-option>
          <el-option label="tty" value="9"></el-option>
          <el-option label="sss" value="6"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="">
        <el-select v-model="searchForm[5]" placeholder="用气类型">
          <el-option label="ddd" value="4"></el-option>
          <el-option label="888" value="8"></el-option>
          <el-option label="tty" value="9"></el-option>
          <el-option label="sss" value="6"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="searchForm[6]" placeholder="调压箱号"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="searchForm[7]" placeholder="客户编号"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="searchForm[8]" placeholder="客户姓名"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="searchForm[9]" placeholder="安装地址"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-button type="primary" class="width100">查询</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格 -->
    <el-table
      ref="multipleTable"
      :data="tableData"
      tooltip-effect="dark"
      :border="false"
      :highlight-current-row="true"
      height="400"
    >
      <el-table-column
        type="selection"
      />
      <el-table-column
        prop="1"
        label="客户编号"
        width="100"
      />
      <el-table-column
        prop="2"
        label="客户名称"
        width="80"
      />
      <el-table-column
        prop="3"
        label="气表编号"
        width="100"
      />
      <el-table-column
        prop="4"
        label="安装地址"
        width="200"
      />
      <el-table-column
        prop="5"
        label="联系电话"
        min-width="100"
      />
      <el-table-column
        prop="6"
        label="用气类型"
        width="80"
      />
      <el-table-column
        prop="7"
        label="上传安检时间"
        min-width="100"
      />
      <el-table-column
        prop="8"
        label="上传安检结果"
        width="100"
      />
      <el-table-column
        prop="9"
        label="气表厂家"
        width="100"
      />
      <el-table-column
        prop="10"
        label="气表类型"
        width="80"
      />
    </el-table>
    <Pagination
      style="margin: 10px 0 5px"
      layout="prev, pager, next"
      :page="2"
      :limit="2"
      :total="4"
    />

    <!-- 计划 -->
    <el-divider></el-divider>
    <el-form label-position="top" :model="planForm" class="jh-text">
      <el-form-item label="计划时间">
        <el-date-picker v-model="planForm[1]" />
      </el-form-item>
      <el-form-item label="安检员">
        <el-select v-model="planForm[3]" placeholder="请选择">
          <el-option label="ddd" value="4"></el-option>
          <el-option label="888" value="8"></el-option>
          <el-option label="tty" value="9"></el-option>
          <el-option label="sss" value="6"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="安检内容" style="width: 50%">
        <el-select v-model="planForm[4]" multiple placeholder="小区(村、xx路)">
          <el-option label="ddd" value="4"></el-option>
          <el-option label="888" value="8"></el-option>
          <el-option label="tty" value="9"></el-option>
          <el-option label="sss" value="6"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label=" ">
        <el-button type="primary" class="width100">计划</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'AddCheckPlan',
  data() {
    return {
      // 查询表格数据
      tableData: [
        {
          1: '12955658744',
          2: '李四',
          3: '6546525',
          4: '龙泉驿区车城东二路5214号',
          5: '18478951254',
          6: '民用',
          7: '2020..3.1',
          8: '正常',
          9: '秦川物联',
          10: '卡表'
        }
      ],
      // 收费表单
      searchForm: {
        1: '',
        2: '',
        3: '',
        4: '',
        5: '',
        6: '',
        7: '',
        8: '',
        9: ''
      },
      planForm: {
        1: '',
        2: '',
        3: ''
      },

      // 发票管理搜索
      checkAll: false,
      isIndeterminate: true,
      checkedCities: []
    }
  },
  computed: {},
  methods: {

  }

}
</script>

<style lang="scss" scoped>
::v-deep .el-table {
  border: 1px solid #eee;
  border-bottom: none;
}

.el-form-item {
  width: calc(100% / 6);
  margin-bottom: 15px;
}

// 发票筛选
.card-tool-bar {
  .el-input {
    width: 250px;

    ::v-deep .el-input-group__append {
      padding-left: 0;
    }
  }
}

::v-deep thead {
  tr {
    background: #FAFAFA;

    th {
      background: transparent;
    }
  }
}

.btnBox {
  .el-button {
    width: 100%;
  }
}
</style>
