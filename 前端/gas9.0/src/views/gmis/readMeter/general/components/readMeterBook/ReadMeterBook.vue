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
          ref="readMeterTableRef"
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
              <!-- v-has-permission="['readMeterGeneral:readBookDelete']" -->
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
            <!-- 表身号 -->
            <el-form-item>
              <el-input v-model="userSearch.model.gasMeterNumber" clearable placeholder="表身号" />
            </el-form-item>
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
            <el-form-item label="" prop="useGasTypeId">
              <el-select v-model="userSearch.model.useGasTypeId" name="useGasTypeId" clearable filterable placeholder="用气类型">
                <el-option v-for="(item, index) in useGasTypeList" :key="index" :label="item.useGasTypeName" :value="item.id" />
              </el-select>
            </el-form-item>
            <!-- 气表类型 -->
            <!-- <el-form-item>
              <el-select v-model="userSearch.model.gasMeterType" clearable placeholder="气表类型">
                <el-option
                  v-for="item in dict.GASMETER_TYPE"
                  :key="item.id"
                  :label="item.name"
                  :value="item.code"
                ></el-option>
              </el-select>
            </el-form-item> -->
            <!-- 客户名称 -->
            <el-form-item>
              <el-input v-model="userSearch.model.customerName" clearable placeholder="客户名称" />
            </el-form-item>
            <!-- 安装地址 -->
            <el-form-item>
              <el-input
                v-model="userSearch.model.moreGasMeterAddress"
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
              <el-button type="primary" @click="exprot">导出</el-button>
              <el-button v-if="editOrSave" type="success" @click="batcnSave()">保存修改数据</el-button>
              <el-button v-else type="primary" :disabled="isAvailable" @click="batchEdit()">批量修改</el-button>
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
            :default-sort="{prop:'number',order:'ascending'}"
            :height="375"
            class="readMeterUser"
            @selection-change="userSelectionChange"
          >
            <!-- @select="tableSelect" -->
            <!--@select-all="tableSelect"-->
            <!-- @selection-change="tableSelect"-->
            <!-- 选择 -->
            <el-table-column type="selection" width="45" />
            <!-- 序号 -->
            <el-table-column prop="number" label="#" width="45">
              <template slot-scope="{ row, $index }">
                <el-input v-if="showEdit[$index]" v-model.number="row.number" v-only-number="{min:0,precision:0}" type="number" @blur="handleBlur($index, row)"></el-input>
                <span v-else>{{ row.number }}</span>
              </template>
            </el-table-column>
            <!-- 缴费编号 -->
            <el-table-column :show-overflow-tooltip="true" prop="customerChargeNo" label="缴费编号" width="120" />
            <!-- 客户编号 -->
            <!-- <el-table-column
              :show-overflow-tooltip="true"
              prop="customerCode"
              label="客户编号"
              width="80"
            /> -->
            <el-table-column prop="customerName" label="客户名称" width="80" />

            <!-- <el-table-column prop="gasMeterCode" label="气表编号" width="180" /> -->
            <el-table-column prop="gasMeterNumber" label="表身号" show-overflow-tooltip width="150" />
            <!-- <el-table-column prop="recordStatus" label="状态" width="80" /> -->
            <el-table-column prop="useGasTypeName" show-overflow-tooltip label="用气类型" width="120" />
            <!-- <el-table-column prop="communityName" label="小区(村、xx路)名" width="150" /> -->
            <!-- 安装地址 -->
            <el-table-column prop="moreGasMeterAddress" show-overflow-tooltip label="安装地址" />
          </el-table>
          <Pagination
            layout="total, prev, next, jumper"
            :page.sync="userSearch.current"
            :limit.sync="userSearch.size"
            :total="+readMeterUserTotal"
            @pagination="handleGetReadMeterUserList"
          />
        </template>
        <no-select v-else tips="请选择抄表册" :top="38" :height="500" />
      </el-col>
    </el-row>

    <!-- 弹窗 -->
    <!-- 添加抄表册 -->
    <el-dialog
      :title="bookInfo ? '编辑抄表册' : '添加抄表册'"
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
        :use-gas-type-list="useGasTypeList"
        @success="handleAddCustomerSuccess"
      />
    </el-dialog>
  </div>
</template>

<script>
import apiReadMeterBook from '@/api/readMeter/readMeterBook'
import { fileStreamDownload } from '@/api/File'
// 获取街道(乡镇)小区(村、xx路)API
import { getStreetList, deleteStreet, getCommunityList } from '@/api/operation/community'
import { getUseGasTypeList } from '@/api/operation/gasPrice'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import NoSelect from '@/components/QcNoSelect'
import editReadMeterBook from './editReadMeterBook'
import AddBySearch from './AddBySearch.vue'
import { initQueryParams } from '@/utils/commons'
import { dataStatusField } from '@/enums/common'
import { gasMeterTypeField } from '@/enums/meterInfo'

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
      useGasTypeList: [], // 用气类型列表

      // 关联客户查询
      userSearch: this.initSearchUserData(),
      readMeterUserList: [], // 关联用户
      readMeterUserTotal: [], // 关联用户总数
      userMultipleSelection: [], // 关联客户多选数据
      // 编辑过的 ceil
      showEdit: [],

      loadingRemove: false,
      isAvailable:false,//批量保存数据是否禁用
      editOrSave:false,// 批量修改和保存切换
      bookId:'',//抄表册id
      bookName:'',//抄表册名字
    }
  },
  mounted() {
    // 获取抄表册数据
    this.getListReadMeterBook()

    // 获取街道(乡镇)数据
    this.getStreetData({ size: 10000 })

    // 获取用气类型列表
    this.getValidUseGasTypeList()

  },
  methods: {
    // 抄表册---------------------------------------------------------------------------------------

    // 分页查询抄表册信息
    getListReadMeterBook() {
      return new Promise((resolve) => {
        apiReadMeterBook.listReadMeterBook(this.readMeterSearchData).then(res => {
          let { isSuccess, data } = res.data
          // console.log({isSuccess, data})
          if (isSuccess) {
            this.readMeterTableData = data.records
            this.readMeterBookTotal = parseInt(data.total)
            this.$nextTick(() => {
              // 重新高亮当前选择抄表册和加载抄表客户列表
              this.loadData()
            })
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        })
      })
    },

    //  操表册行点击
    handelRowClick(row) {
      this.curReadMetreBook = row
      let id = row.id
      this.bookId = row.id
      this.bookName = row.bookName
      this.userSearch = this.initSearchUserData(id)
      this.getListGasMeterBookRecord()
      this.showEdit = []
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
          moreGasMeterAddress: '', // 安装地址

          gasMeterCode: '', // 气表编号
          gasMeterNumber: '', // 表身号
          gasMeterType: gasMeterTypeField.GENERAL_GASMETER, // 气表类型
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
      apiReadMeterBook.customerPage(this.userSearch).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          const { records, total } = data
          this.readMeterUserList = records
          this.readMeterUserTotal = total
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

    // 分页获取列表
    handleGetReadMeterUserList() {
      this.getListGasMeterBookRecord()
    },

    // 添加抄表册客户成功
    async handleAddCustomerSuccess() {
      await this.getListReadMeterBook()
    },

    // 重新高亮当前选择抄表册和加载抄表客户列表
    loadData() {
      const readMetreBook = this.readMeterTableData.find((item) => item.id === this.curReadMetreBook?.id)
      if (readMetreBook) {
        this.curReadMetreBook = readMetreBook
        this.$refs?.readMeterTableRef?.setCurrentRow(readMetreBook)
        this.userSearch = this.initSearchUserData(readMetreBook.id)
        this.getListGasMeterBookRecord()
      } else {
        // 置空数据
        this.curReadMetreBook = null
        this.readMeterUserList = []
        this.readMeterUserTotal = 0
      }
    },

    // 获取用气类型列表
    getValidUseGasTypeList() {
      return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.useGasTypeList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    //批量修改
    async batchEdit(){
      const arr = []
      for(let index in this.readMeterUserList){
        this.edit(index)
      }
    },
    // 切换输入框或选择框
    edit(index, row) {
      this.showEdit[index] = true
      this.$set(this.showEdit, index, true)
    },
    // 输入框失焦处理number
    handleBlur(index, row) {
      const number = Number(row.number)
      if(!number){
         this.$message.error('编号不能为空')
         this.isAvailable = true
         return true
      }

        this.$refs.multipleTable.toggleRowSelection(row,true);
        this.editOrSave = true
        if(this.userMultipleSelection.length<1){
          this.editOrSave = false
        }

    },
    //批量保存修改数据
    batcnSave(){
      const arr = []
      this.userMultipleSelection.forEach(item => {
        const id = item.id
        const number = Number(item.number)
        if (id || number) {
          arr.push({
            id,
            number,
          })
        }
      })
      return new Promise(resolve => {
        apiReadMeterBook.updateBookRecord(arr)
          .then(result => {
            const { isSuccess } = result.data
            if (isSuccess) {
              this.$message.success('修改成功', 'success')
              this.showEdit = []
              this.getListGasMeterBookRecord()
              this.editOrSave = false
              resolve(true)
            } else {
              resolve(false)
            }
          })
          .catch(() => {
            resolve(false)
          })
      })
    },
    // 导出
    exprot() {
      // 这个地方传递 抄表册id
      // console.log(this.curPlan, this.multipleSelection)
      // if (!this.userMultipleSelection.length) {
      //   this.$message({
      //     type: 'warning',
      //     message: '请先选择抄表册再导出'
      //   })
      //   return
      // }
      fileStreamDownload(
        '/bizcenter/readmeter/register/readMeterBook/exportReadMeterBook',
        {'id':JSON.parse(this.bookId)},
        {},
        { name: `${this.bookName}抄表册名单.xls` }
      )
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
  ::v-deep .readMeterUser .el-input__inner{
    padding:0;
  }
  .jh-text {
    .el-form-item {
      width: calc(100% / 4);
      margin-top: 10px;
      margin-bottom:0 ;
    }
  }
  .el-divider {
    margin: 10px 0;
  }
</style>
