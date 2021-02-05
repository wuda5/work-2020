<!-- 查询添加 关联客户-->
<template>
  <div>
    <div class="subTitle">添加</div>
    <!-- 查询表单 -->
    <search-box>
      <!-- 表身号 -->
      <el-input v-model="userSearch.model.gasMeterNumber" clearable placeholder="表身号" />
      <!-- 街道 -->
      <el-select
        v-model="userSearch.model.streetId"
        placeholder="街道"
        clearable
        @change="getCommunityData"
      >
        <el-option
          v-for="item in streetList"
          :key="item.id"
          :label="item.streetName"
          :value="item.id"
        ></el-option>
      </el-select>
      <!-- 小区 -->
      <el-select v-model="userSearch.model.communityId" clearable placeholder="小区">
        <el-option
          v-for="item in communityList"
          :key="item.id"
          :label="item.communityName"
          :value="item.id"
        ></el-option>
      </el-select>
      <!-- 用气类型 -->
      <el-select v-model="userSearch.model.useGasTypeId" name="useGasTypeId" clearable filterable placeholder="用气类型">
        <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id" />
      </el-select>
      <!-- 气表类型 -->
      <!-- <el-select v-model="userSearch.model.gasMeterType" clearable placeholder="气表类型">
        <el-option
          v-for="item in dict.GASMETER_TYPE"
          :key="item.id"
          :label="item.name"
          :value="item.code"
        ></el-option>
      </el-select> -->
      <!-- 客户名称 -->
      <el-input v-model="userSearch.model.customerName" clearable placeholder="客户名称" />
      <!-- 安装地址 -->
      <el-input v-model="userSearch.model.moreGasMeterAddress" clearable placeholder="安装地址" />
      <el-button type="primary" @click="getListGasMeterBookRecord">查询</el-button>
    </search-box>

    <!-- 用户信息列表 -->
    <el-divider></el-divider>
    <search-box>
      <!-- 操作按钮 -->
      <div slot="right">
        <el-tooltip content="添加前请确认条件是满足！" placement="top">
          <el-button
            v-if="tableData.length>0 && userMultipleSelection.length===0"
            type="info"
            icon="el-icon-zoom-in"
            :loading="loadingBtnQuery"
            @click="addCommunityByQuery"
          >按搜索条件添加</el-button>
        </el-tooltip>
        <el-button
          v-if="userMultipleSelection.length>0"
          type="success"
          icon="el-icon-circle-check"
          :loading="loadingBtnChoice"
          @click="addCommunityByChoice"
        >添加选中项</el-button>
      </div>
    </search-box>

    <!-- 查询数据列表 -->
    <el-table
      ref="multipleTable"
      :data="tableData"
      tooltip-effect="dark"
      border
      stripe
      :height="420"
      @selection-change="userSelectionChange"
    >
      <!--@select-all="tableSelect"-->
      <!-- @selection-change="tableSelect"-->
      <!-- 选择 -->
      <el-table-column type="selection" width="45" />
      <!-- 序号 -->
      <el-table-column type="index" label="#" width="45" />
      <!-- 缴费编号 -->
      <el-table-column :show-overflow-tooltip="true" prop="customerChargeNo" label="缴费编号" width="120" />
      <!-- 客户编号 -->
      <!-- <el-table-column :show-overflow-tooltip="true" prop="customerCode" label="客户编号" width="80" /> -->
      <el-table-column prop="customerName" label="客户名称" width="80" />

      <!-- <el-table-column prop="gasMeterCode" label="气表编号" width="180" /> -->
      <el-table-column prop="gasMeterNumber" label="表身号" show-overflow-tooltip width="150" />
      <!-- <el-table-column prop="recordStatus" label="状态" width="80" /> -->
      <el-table-column prop="useGasTypeName" label="用气类型" show-overflow-tooltip width="120" />
      <!-- 小区名 -->
      <!-- <el-table-column prop="communityName" label="小区名" width="150" /> -->
      <!-- 安装地址 -->
      <el-table-column prop="moreGasMeterAddress" show-overflow-tooltip label="安装地址" />
    </el-table>

    <Pagination
      :page.sync="userSearch.current"
      :limit.sync="userSearch.size"
      :total="+total"
      @pagination="getListGasMeterBookRecord"
    />
  </div>
</template>

<script>
import apiReadMeterBook from '@/api/readMeter/readMeterBook'
// 获取街道小区API
import { getStreetList, getCommunityList } from '@/api/operation/community'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'

export default {
  name: 'AddBySearch',
  mixins: [commonMixin, listMixin],
  props: {
    searchData: {
      type: Object,
    },
    streetList: {
      type: Array,
    },
    // 用气类型列表
    useGasTypeList: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      // 关联客户查询条件
      userSearch: JSON.parse(JSON.stringify(this.searchData)),

      communityList: [], // 小区列表
      readMeterUserList: [], // 关联用户

      userMultipleSelection: [], // 客户多选数据

      tableData: [], // 抄表册表格数据
      total: 0, // 总数

      // loading
      loadingBtnChoice: false,
      loadingBtnQuery: false,
    }
  },
  created() {},
  methods: {
    // 获取小区数据
    getCommunityData(value) {
      console.log(value)
      let params = { model: { streetId: value } }
      getCommunityList(this.generateQueryParams(params)).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.communityList = data.records
        }
      })
    },

    // 分页查询抄表册关联客户
    getListGasMeterBookRecord() {
      apiReadMeterBook.customerPage(this.userSearch).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = data.total
        }
      })
    },

    // 关联用户多选操作
    userSelectionChange(val) {
      this.userMultipleSelection = val
    },

    // 新增抄表册关联用户(条件新增)
    addCommunityByQuery() {
      this.loadingBtnQuery = true
      apiReadMeterBook
        .addCommunityByQuery(this.userSearch)
        .then(res => {
          let { isSuccess, data } = res.data
          if (isSuccess) {
            this.loadingBtnQuery = false
            console.log(data)
            // 刷新列表
            this.getListGasMeterBookRecord()
            // 向父组件传递成功事件
            this.$emit('success')
          }
        })
        .catch(err => {
          this.loadingBtnQuery = false
        })
    },

    // 新增抄表册关联用户(选中新增)
    addCommunityByChoice() {
      this.loadingBtnChoice = true
      let ids = this.userMultipleSelection.map(item => {
        item.readMeterBook = this.searchData.model.readMeterBook
        return item
      })
      apiReadMeterBook
        .addCommunityByChoice(ids)
        .then(res => {
          let { isSuccess } = res.data
          if (isSuccess) {
            this.loadingBtnChoice = false
            this.msg('添加成功', 'success')
            this.getListGasMeterBookRecord()
            // 向父组件传递成功事件
            this.$emit('success')
          }
        })
        .catch(err => {
          this.loadingBtnChoice = false
        })
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 7);
    }
  }

  .el-divider {
    margin: 10px 0;
  }

  .userInfo {
    .el-form-item {
      margin-top: 10px;
    }
  }
</style>
