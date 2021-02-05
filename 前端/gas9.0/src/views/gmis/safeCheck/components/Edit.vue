<!--
 * @Description: 安检 - 编辑
 * @Author: lingw
 * @Date: 2020-11-09 10:23:42
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-28 10:09:08
-->

<template>
  <div>
    <!--search-->
    <top-search-box
      :search-condition="searchCondition"
      :use-gas-type="useGasType"
      :search-loading="searchLoading"
      :search="handleSearch"
    />
    <el-table
      ref="multipleTable"
      :data="userList.records"
      tooltip-effect="dark"
      style="width: 100%"
      :border="true"
      height="calc(100vh - 300px)"
      highlight-current-row
      @selection-change="handleSelectionChange"
    >
      <el-table-column
        type="selection"
        width="55"
      >
      </el-table-column>
      <el-table-column type="index" label="#" width="45" />
      <el-table-column
        prop="customerCode"
        label="客户编号"
        width="160"
        show-overflow-tooltip
      />
      <el-table-column prop="customerName" label="客户姓名" width="100" />
      <el-table-column prop="telphone" label="联系电话" width="100" />
      <el-table-column prop="customerTypeName" label="客户类型" width="100" />
      <el-table-column
        prop="useGasTypeName"
        label="用气类型"
        width="120"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        prop="gasCode"
        label="气表编号"
        width="180"
        :show-overflow-tooltip="true"
      />
      <el-table-column label="调压箱号">
        <template slot-scope="scope">{{ !scope.row.nodeNumber ? '---' : scope.row.nodeNumber }}
        </template>
      </el-table-column>
      <el-table-column label="气表厂家">
        <template slot-scope="scope">{{ !scope.row.gasMeterFactoryName ? '---' : scope.row.gasMeterFactoryName }}
        </template>
      </el-table-column>
      <el-table-column label="气表版号">
        <template slot-scope="scope">{{ !scope.row.gasMeterVersionName ? '---' : scope.row.gasMeterVersionName }}
        </template>
      </el-table-column>
    </el-table>
    <Pagination
      :page-sizes="[10, 15, 20, 30]"
      :page.sync="searchCondition.pageNo"
      :limit.sync="searchCondition.pageSize"
      :total="+userList.total"
      @pagination="handleSearch"
    />
    <el-form ref="form" :model="form" label-position="top" class="jh-text">
      <el-form-item label="安检日期">
        <el-date-picker v-model="form.planSecurityCheckTime" type="datetime" 
        format="yyyy-MM-dd HH:mm:ss"
        value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择安检日期"
>
        </el-date-picker>
      </el-form-item>
      <el-form-item label="计划安检员">
        <el-input v-model="form.planSecurityCheckUserName" placeholder="请选择计划安检员"></el-input>
      </el-form-item>
      <el-form-item label="安检内容">
        <el-input v-model="form.securityCheckContent" placeholder="请输入安检内容"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button :loading="loading" class="btn-save" type="primary" @click="handlePlan">{{ btnText }}</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import TopSearchBox from './SearchBox'; // 顶部搜索框
import { checkPhone } from '@/utils/commons'
import userInfoApi from '@/api/userInfo'

export default {
  name: 'SecurityCheck',
  components: {
    TopSearchBox
  },
  props: {
    useGasType: {
      type: Array,
      default: () => {
        return []
      }
    },
    userList: {
      type: Object,
      default: () => {
        return {
          records: [],
          total: 0,
          pages: 1,
          size: 10
        }
      }
    },
    customerCode: String
  },
  data () {
    return {
      loading: false,
      searchLoading: false,
      //搜索条件
      searchCondition: {
        customerCode: '', // 客户编号
        customerName: '', // 客户名称
        telphone: '', // 联系电话
        customerTypeCode: '', // 客户类型
        useGasTypeId: '',  // 用气类型
        gasCode: '', // 气表编号
        moreGasMeterAddress: '',  //安装地址
        pageSize: 10, // 一页显示几条数据
        pageNo: 1, // 当前第几页
      },
      form: {
        planSecurityCheckTime: '',
        securityCheckContent: '',
        planSecurityCheckUserName: ''
      },
      multipleSelection: [],
      btnText: '受理' // 
    }
  },
  methods: {
    tableRowClassName({ row, rowIndex }) {
      console.warn(this.customerCode, row)
      if (this.customerCode && this.customerCode === row.customerCode) {
        return 'selected-row'
      }
    },
    // 搜索
    handleSearch() {
      this.$emit('search', this.searchCondition)
    },
    handleSelectionChange(val) {
      console.warn(val)
      this.multipleSelection = val;
    },
    handlePlan() {
      if (!this.multipleSelection.length) {
        this.$message({
          type: 'warning',
          message: '请先选中用户'
        })
        return
      }
      this.$refs['form'].validate(valid => {
        if (valid) {
          this.loading = true
          const payload = this.multipleSelection.map(({ customerCode, customerName, gasCode, gasMeterFactoryId, useGasTypeId }) => ({
            customerCode,
            customerName,
            gasCode,
            useGasTypeId,
            gasMeterFactoryId,
            ...this.form
          }))
          this.$emit('submit', payload)
        } else {
          return false
        }
      })
    },
    // 切换选中行
    toggleSelection(rows) {
        if (rows) {
          rows.forEach(row => {
            this.$refs.multipleTable.toggleRowSelection(row);
          });
        } else {
          this.$refs.multipleTable.clearSelection();
        }
      },
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>

<style lang='scss' scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 4);
    }
    .btn-save {
      margin-top: 26px;
    }
  }
  .selected-row {
    background: red;
  }
</style>
