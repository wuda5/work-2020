<!--营业厅配置-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('system.serviceHall.title') }}</span>
      </div>
      <!-- searchBox -->
      <search-box>
        <div slot="left">
          <el-input
            v-model="search.model.businessHallName"
            :placeholder="$t('system.serviceHall.searchTip')"
            name="businessHallName"
          />
          <el-button name="search" type="primary" @click="getPageList">{{ $t('search') }}</el-button>
        </div>
        <div slot="right">
          <el-button
            v-has-permission="['serviceHall:enable']"
            name="enable"
            type="primary"
            @click="toEnable"
          >{{ $t('enable') }}</el-button>
          <el-button
            v-has-permission="['serviceHall:disable']"
            name="disable"
            type="warning"
            @click="toDisable"
          >{{ $t('disable') }}</el-button>
        </div>
      </search-box>

      <!--数据-->
      <el-table
        ref="multipleTable"
        border
        :data="tableData"
        tooltip-effect="dark"
        @selection-change="handleSelectionChange"
        @filter-change="filterChange"
      >
        <!-- 多选 -->
        <el-table-column type="selection" width="55" />
        <!-- index -->
        <el-table-column type="index" :label="$t('table.index')" width="55" />
        <!-- 营业厅名 -->
        <el-table-column
          prop="businessHallName"
          :label="$t('system.serviceHall.name')"
          width="120"
        />
        <!-- 营业厅地址 -->
        <el-table-column
          prop="businessHallAddress"
          :label="$t('system.serviceHall.addr')"
          width="120"
        />
        <!-- 联系人 -->
        <el-table-column
          prop="contacts"
          :label="$t('system.serviceHall.contact')"
          show-overflow-tooltip
        />
        <!-- 联系电话 -->
        <el-table-column
          prop="telphone"
          :label="$t('system.serviceHall.tel')"
          show-overflow-tooltip
        />
        <!-- 营业厅电话 -->
        <el-table-column
          prop="businessHallPhone"
          :label="$t('system.serviceHall.hallTel')"
          show-overflow-tooltip
        />
        <!-- 代售点 -->
        <el-table-column prop="isSale" :label="$t('system.serviceHall.agency')">
          <template slot-scope="{row}">
            <el-tag v-if="row.isSale" type="success">{{ $t('yes') }}</el-tag>
            <el-tag v-else type="success">{{ $t('no') }}</el-tag>
          </template>
        </el-table-column>
        <!-- 状态 -->
        <el-table-column
          prop="businessHallStatus"
          :label="$t('status')"
          :filter-multiple="false"
          column-key="businessHallStatus"
          :filters="[
          { text: $t('common.status.valid'), value: 1 },
          { text: $t('common.status.invalid'), value: 0 }
        ]"
          class-name="status-col"
          width="80px"
        >
          <template slot-scope="scope">
            <el-switch
              :disabled="!checkPermission(['serviceHall:enable','serviceHall:disable'])"
              :value="scope.row.businessHallStatus"
              active-color="#67C23A"
              :title="scope.row.businessHallStatus ? $t('enable') : $t('disable')"
              inactive-color="#909399"
              :active-value="1"
              :inactive-value="0"
              @change="statusChange($event,scope.$index)"
            />
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column fixed="right" :label="$t('operations')" width="80">
          <template slot-scope="{row}">
            <el-button
              v-has-permission="['serviceHall:update']"
              name="rowEdit"
              type="primary"
              @click="edit(row)"
            >{{ $t('edit' ) }}</el-button>
            <!-- <el-button
              v-has-permission="['serviceHall:delete']"
              name="rowDelete"
              type="danger"
              @click="deleteItem(row.id)"
            >
              {{ $t('delete ') }}
            </el-button>-->
          </template>
        </el-table-column>
      </el-table>

      <!--分页-->
      <pagination
        name="pagination"
        :total="total"
        :page-sizes="[10,20,30]"
        :limit="search.size"
        @pagination="pagination"
      />

      <!--弹窗------------------------------------------>
      <!-- 添加|编辑 用户-->
      <el-dialog
        :visible.sync="showAddServiceHall"
        width="400px"
        :title="formData ? $t('system.serviceHall.editHall') : $t('system.serviceHall.addHall')"
      >
        <Edit v-if="showAddServiceHall" :form-data="formData" @close="endEdit" />
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import apiServiceHall from '@/api/system/serviceHall'
import Edit from './components/Edit'

export default {
  name: 'ServiceHall',
  components: {
    Edit,
  },
  data() {
    return {
      showAddServiceHall: false,
      curStatus: '',
      search: {
        current: 1,
        map: {},
        model: {
          businessHallName: '',
          businessHallStatus: '',
          deleteStatus: 0,
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      formData: null, // 需要编辑的数据 props传递
      tableData: [],
      total: 0,
      multipleSelection: [],
    }
  },
  created() {
    this.getPageList()
  },
  mounted() {},
  methods: {
    handleSelectionChange(val) {
      this.multipleSelection = val
    },

    // 分页数据改变
    pagination(pageData) {
      this.search.size = pageData.size
      this.search.current = pageData.current
      this.getPageList()
    },

    endEdit() {
      this.dialogClose('showAddServiceHall')
      this.getPageList()
    },

    // 转态改版
    statusChange(value, index) {
      if (value === 1) {
        // 启用
        this.tableData[index].businessHallStatus = 1
        apiServiceHall
          .update(this.tableData[index])
          .then(res => {
            const res1 = res.data
            if (res1.isSuccess) {
              this.$message.success(this.$t('system.serviceHall.confirm.hallIsEnable'))
              this.getPageList()
            }
          })
          .catch(this.getPageList())
      } else {
        // 禁用
        this.tableData[index].businessHallStatus = 0
        apiServiceHall
          .update(this.tableData[index])
          .then(res => {
            const res1 = res.data
            if (res1.isSuccess) {
              this.$message.success(this.$t('system.serviceHall.confirm.hallIsDisble'))
              this.getPageList()
            }
          })
          .catch(this.getPageList())
      }
    },

    // 过滤状态
    filterStatus(status) {
      // status 状态  1：启用 0：停用
      this.curStatus = status
      this.search.model.businessHallStatus = status
      this.getPageList()
    },

    // 添加按钮点击
    addNew() {
      this.formData = null

      this.showAddServiceHall = true
    },

    // 编辑按钮点击
    edit(row) {
      this.formData = JSON.parse(JSON.stringify(row))
      this.showAddServiceHall = true
    },

    // 获取列表数据
    getPageList() {
      apiServiceHall.page(this.search).then(res => {
        const res1 = res.data
        if (res1.isSuccess) {
          this.tableData = res1.data.records
          this.total = parseInt(res1.data.total)
        }
      })
    },

    // 删除数据方法
    delData(ids) {
      apiServiceHall.delete({ ids }).then(res => {
        const res1 = res.data
        if (res1.isSuccess) {
          this.msg(this.$t('system.serviceHall.confirm.delSuccess'), 'success')
          this.getPageList()
        }
      })
    },

    // 删除单条数据
    deleteItem(id) {
      let ids = []
      ids.push(id)
      this.delData(ids)
    },

    // 删除多条数据
    deleteItems() {
      if (this.multipleSelection.length === 0) {
        this.msg(this.$t('system.serviceHall.confirm.selectToDelete'), 'warning')
        return
      }
      this.confirm(
        this.$t('system.serviceHall.confirm.deleteHallSure'),
        '',
        this.$t('ok'),
        this.$t('cancle'),
        'warning'
      )
        .then(() => {
          let ids = []
          this.multipleSelection.forEach(item => {
            ids.push(item.id)
          })
          this.delData(ids)
        })
        .catch(() => {
          this.msg(this.$t('system.serviceHall.confirm.canceled'))
        })
    },

    // 启用
    toEnable() {
      if (this.multipleSelection.length === 0) {
        this.msg(this.$t('system.serviceHall.confirm.selectToEnable'), 'warning')
        return
      }
      // this.confirm(this.$t('system.serviceHall.confirm.enableHallsure'), '确认', '确定', '取消', 'warning').then(() => {
      this.confirm(
        this.$t('system.serviceHall.confirm.enableHallsure'),
        '',
        this.$t('ok'),
        this.$t('cancle'),
        'warning'
      )
        .then(() => {
          let items = []
          this.multipleSelection.forEach(item => {
            items.push({
              id: item.id,
              businessHallStatus: 1,
            })
          })
          apiServiceHall.updateBatch(items).then(() => {
            this.getPageList()
          })
        })
        .catch(() => {
          this.msg(this.$t('system.serviceHall.confirm.canceled'))
        })
    },

    // 禁用
    toDisable() {
      if (this.multipleSelection.length === 0) {
        this.msg(this.$t('system.serviceHall.confirm.selectToDisable'), 'warning')
        return
      }
      this.confirm(
        this.$t('system.serviceHall.confirm.disableHallSure'),
        '',
        this.$t('ok'),
        this.$t('cancle'),
        'warning'
      )
        .then(() => {
          let items = []
          this.multipleSelection.forEach(item => {
            items.push({
              id: item.id,
              businessHallStatus: 0,
            })
          })
          apiServiceHall.updateBatch(items).then(() => {
            this.getPageList()
          })
        })
        .catch(() => {
          this.msg(this.$t('system.serviceHall.confirm.canceled'))
        })
    },
    filterChange(filters) {
      for (const key in filters) {
        if (key.includes('.')) {
          const val = {}
          val[key.split('.')[1]] = filters[key][0]
          this.search.model[key.split('.')[0]] = val
        } else {
          this.search.model[key] = filters[key][0]
        }
      }
      this.getPageList()
    },
  },
}
</script>