<!--抄表册-->
<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="9">
        <!--抄表测搜索-->
        <search-box>
          <div slot="left">
            <el-input v-model="readMeterSearchData.model.bookName" placeholder="抄表册" />
            <el-input
              v-model="readMeterSearchData.model.readMeterUserName"
              placeholder="抄表人员"
            />
            <el-button type="primary" @click="getListReadMeterBook">查询</el-button>
          </div>
          <div slot="right">
            <el-button type="success" @click="addReadMeterBook">添加</el-button>
          </div>
        </search-box>

        <!--抄表册数据表格-->
        <el-table
          :data="readMeterTableData"
          stripe
          border
          height="500"
          :highlight-current-row="true"
          @row-click="handelRowClick"
        >
          <!--索引-->
          <el-table-column type="index" label="#" width="40" />

          <!--抄表册-->
          <el-table-column prop="bookName" label="抄表册" />

          <!--抄表员-->
          <el-table-column prop="readMeterUserName" label="抄表员" width="90" />

          <!--总户数-->
          <el-table-column prop="totalReadMeterCount" label="总户数" width="60" />

          <!--操作-->
          <el-table-column label="操作" width="80">
            <template slot-scope="{ row }">
              <el-button type="primary" @click="editReadMeterBook(row)">编辑</el-button>
              <!-- <el-button type="danger" @click="deleteReadMeterBook(row.id)">删除</el-button> -->
            </template>
          </el-table-column>
        </el-table>

        <!-- 抄表册分页 -->
        <pagination
          name="pagination"
          :page-sizes="[10, 20, 30]"
          layout="total, prev, next, jumper"
          :page="readMeterSearchData.current"
          :limit="readMeterSearchData.size"
          :total="readMeterBookTotal"
          @pagination="pagination"
        />
      </el-col>

      <!--right-->
      <el-col :span="15">
        <template v-if="curReadMetreBook">
          <!-- 关联客户 -->
          <div class="subTitle">关联客户</div>
          <!-- 查询表单 -->
          <el-form label-position="top" :model="userSearch" class="jh-text userInfo">
            <!-- 街道 -->
            <el-form-item>
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
            </el-form-item>
            <!-- 小区 -->
            <el-form-item>
              <el-select v-model="userSearch.model.communityId" clearable placeholder="小区">
                <el-option
                  v-for="item in communityList"
                  :key="item.id"
                  :label="item.communityName"
                  :value="item.id"
                ></el-option>
              </el-select>
            </el-form-item>
            <!-- 用气类型 -->
            <el-form-item>
              <el-select v-model="userSearch.model.useGasTypeId" clearable placeholder="用气类型">
                <el-option
                  v-for="item in dict.GAS_TYPE"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
                ></el-option>
              </el-select>
            </el-form-item>
            <!-- 气表类型 -->
            <el-form-item>
              <el-select v-model="userSearch.model.gasMeterType" clearable placeholder="气表类型">
                <el-option
                  v-for="item in dict.GASMETER_TYPE"
                  :key="item.id"
                  :label="item.name"
                  :value="item.code"
                ></el-option>
              </el-select>
            </el-form-item>
            <!-- 客户名称 -->
            <el-form-item>
              <el-input v-model="userSearch.model.customerName" clearable placeholder="客户名称" />
            </el-form-item>
            <!-- 安装地址 -->
            <el-form-item>
              <el-input
                v-model="userSearch.model.gasMeterAddress"
                clearable
                placeholder="安装地址"
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="getListGasMeterBookRecord">查询</el-button>
            </el-form-item>
          </el-form>

          <!-- 用户信息列表 -->
          <el-divider></el-divider>
          <search-box>
            <div slot="right">
              <el-button type="success" @click="showAddBySearch = true">添加</el-button>
              <el-button
                type="primary"
                :disabled="userMultipleSelection.length === 0"
                :loading="loadingRemove"
                @click="deleteCommunity"
                >移除</el-button>
            </div>
          </search-box>

          <!-- 关联客户数据列表 -->
          <el-table
            ref="multipleTable"
            :data="readMeterUserList"
            tooltip-effect="dark"
            border
            stripe
            :height="375"
            @selection-change="userSelectionChange"
          >
            @select="tableSelect"
            <!--@select-all="tableSelect"-->
            <!-- @selection-change="tableSelect"-->
            <!-- 选择 -->
            <el-table-column type="selection" width="45" />
            <!-- 序号 -->
            <el-table-column type="index" label="#" width="45" />
            <!-- 小区(村、xx路)名 -->
            <el-table-column
              :show-overflow-tooltip="true"
              prop="customerCode"
              label="客户编号"
              width="80"
            />
            <el-table-column prop="customerName" label="客户名称" width="80" />

            <el-table-column prop="gasMeterCode" label="气表编号" width="180" />
            <el-table-column prop="recordStatus" label="状态" width="80" />
            <el-table-column prop="useGasTypeName" label="用气类型" width="80" />
            <el-table-column prop="communityName" label="小区(村、xx路)名" width="150" />
            <el-table-column prop="name" label="安装地址" />
          </el-table>
          <Pagination
            layout="total, prev, next, jumper"
            :page="readMeterSearchData.current"
            :limit="readMeterSearchData.size"
            :total="readMeterBookTotal"
          />
        </template>
        <no-select v-else tips="请选择抄表册" :top="38" :height="500" />
      </el-col>
    </el-row>

    <!-- 弹窗 -->
    <!-- 添加抄表册 -->
    <el-dialog
      :title="bookInfo ? '编辑抄表测' : '添加操表册'"
      :visible="showEditReadMeterBook"
      width="400px"
      :append-to-body="true"
      @close="showEditReadMeterBook = false"
    >
      <edit-read-meter-book
        v-if="showEditReadMeterBook"
        :book-info="bookInfo"
        @close="closeEditReadMeterBook"
      />
    </el-dialog>

    <!-- 添加关联客户 -->
    <el-dialog title="添加" :visible.sync="showAddBySearch" width="1100px" :append-to-body="true">
      <add-by-search
        v-if="showAddBySearch"
        :search-data="initSearchUserData(curReadMetreBook ? curReadMetreBook.id : '', 1)"
        :street-list="streetList"
      />
    </el-dialog>
  </div>
</template>

<script>
import apiReadMeterBook from '@/api/readMeter/readMeterBook'
// 获取街道(乡镇)小区(村、xx路)API
import { getStreetList, deleteStreet, getCommunityList } from '@/api/operation/community'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import NoSelect from '@/components/QcNoSelect'
import editReadMeterBook from './editReadMeterBook'
import AddBySearch from './AddBySearch'

export default {
  name: 'ReadMeterBook',
  components: {
    NoSelect,
    editReadMeterBook,
    AddBySearch,
  },
  mixins: [commonMixin, listMixin],
  data() {
    return {
      // 抄表册搜索数据
      readMeterSearchData: {
        current: 1,
        model: {
          bookName: '',
          readMeterUserName: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      readMeterTableData: [], // 抄表册表格数据
      readMeterBookTotal: 0, // 抄表册表格数据总数
      curReadMetreBook: null, // 点前抄表册点击数据
      showEditReadMeterBook: false, // 显示添加抄表员编辑窗口
      showAddBySearch: false, // 显示添加关联客户组件

      // 编辑操表册信息
      bookInfo: null,

      // 街道(乡镇)列表
      streetList: [],
      // 小区(村、xx路)列表
      communityList: [],

      // 关联客户查询
      userSearch: this.initSearchUserData(),
      readMeterUserList: [], // 关联用户
      userMultipleSelection: [], // 关联客户多选数据

      loadingRemove: false,
    }
  },
  mounted() {
    // 获取抄表册数据
    this.getListReadMeterBook()

    // 获取街道(乡镇)数据
    this.getStreetData({ size: 10000 })
  },
  methods: {
    // 抄表册---------------------------------------------------------------------------------------

    // 分页查询抄表册信息
    getListReadMeterBook() {
      apiReadMeterBook.listReadMeterBook(this.readMeterSearchData).then(res => {
        let { isSuccess, data } = res.data
        // console.log({isSuccess, data})
        if (isSuccess) {
          this.readMeterTableData = data.records
          this.readMeterBookTotal = parseInt(data.total)
        }
      })
    },

    //  操表册行点击
    handelRowClick(row) {
      this.curReadMetreBook = row
      let id = row.id
      this.userSearch = this.initSearchUserData(id)
      this.getGasMeterBookRecordById(id)
    },

    // 添加抄表册
    addReadMeterBook() {
      this.bookInfo = null
      this.showEditReadMeterBook = true
    },

    // 编辑操表册
    editReadMeterBook(row) {
      this.bookInfo = row
      this.showEditReadMeterBook = true
    },

    // 删除操表册
    deleteReadMeterBook(id) {
      let ids = [id]
      apiReadMeterBook.deleteReadMeterBook({ ids: ids }).then(res => {
        let { isSuccess, data } = res.data
        // console.log({isSuccess, data})
        if (isSuccess) {
          this.msg('删除成功', 'success')
          this.getListReadMeterBook()
        }
      })
    },

    // 关闭编辑操表册弹窗
    closeEditReadMeterBook() {
      this.showEditReadMeterBook = false
      this.getListReadMeterBook()
    },

    // 抄表册分页数据改变
    pagination(pageData) {
      this.readMeterSearchData.size = pageData.size
      this.readMeterSearchData.current = pageData.current
      this.getListReadMeterBook()
    },

    // 关联客户---------------------------------------------------------------------------------------

    // 获取街道(乡镇)
    getStreetData(params = {}) {
      getStreetList(this.generateQueryParams(params)).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.streetList = data.records
        }
      })
    },

    // 初始化关联客户查询条件
    initSearchUserData(id = '', getType = 0) {
      return {
        current: 1,
        model: {
          streetId: '', // 街道id
          communityId: '', // 小区id
          communityName: '', // 小区名称

          customerCode: '', // 客户编号

          customerId: '', // 客户id
          customerName: '', // 客户名称
          gasMeterAddress: '', // 安装地址

          gasMeterCode: '', // 气表编号
          gasMeterType: '', // 气表类型
          readMeterBook: id, // 抄表册id

          useGasTypeId: '', // 用气类型id  和阳明确认是ID 而不是code
          useGasTypeName: '', // 用气类型名称

          getType: getType, // 自定义： 获取数据方式 0：查询关联用户 1：查询非关联用户
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      }
    },

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
      this.userSearch.model.readMeterBook = this.curReadMetreBook.id
      apiReadMeterBook.listGasMeterBookRecord(this.userSearch).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.readMeterUserList = data.records
        }
      })
    },

    // 根据id批量获取抄表册关联客户
    getGasMeterBookRecordById(id) {
      let ids = [id]
      apiReadMeterBook.gasMeterBookRecordById(ids).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          // console.log(data)
          this.readMeterUserList = data
        }
      })
    },

    // 关联用户多选操作
    userSelectionChange(val) {
      this.userMultipleSelection = val
    },

    // 关联客户---------------------------------------------------------------------------------------

    // 删除抄表册关联用户
    deleteCommunity() {
      this.loadingRemove = true
      let ids = this.userMultipleSelection.map(item => {
        return item.id
      })

      apiReadMeterBook
        .deleteCommunity(ids)
        .then(res => {
          let { isSuccess } = res.data
          if (isSuccess) {
            this.msg('删除成功', 'success')
            this.getListGasMeterBookRecord()
          }
          this.loadingRemove = false
        })
        .catch(err => {
          this.loadingRemove = false
        })
    },
  },
}
</script>

<style lang="scss" scoped>
  // left
  .searchBox {
    .el-input {
      width: 110px;
    }
  }

  .jh-text {
    .el-form-item {
      width: calc(100% / 4);
      margin-top: 10px;
    }
  }
  .el-divider {
    margin: 10px 0;
  }
</style>
