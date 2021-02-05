<!-- 角色 -->
<template>
  <div class="app-container">
    <!-- search -->
    <search-box class="filter-container">
      <div slot="left">
        <!-- 编码 -->
        <el-input v-model="queryParams.model.code" :placeholder="$t('table.role.code')" />
        <!-- 角色名称 -->
        <el-input v-model="queryParams.model.name" :placeholder="$t('table.role.name')" />

        <!-- 操作按钮 -->
        <el-button type="primary" @click="search">{{ $t("table.search") }}</el-button>
        <el-button type="warning" @click="reset">{{ $t("table.reset") }}</el-button>
      </div>
      <!-- -->
      <div slot="right">
        <el-button v-has-permission="['user:add']" type="success" @click="add">{{ $t("table.add") }}</el-button>

        <!--<el-button v-has-permission="['role:delete']" type="danger" @click="batchDelete">
          {{ $t("table.delete") }}
        </el-button>-->
      </div>
    </search-box>

    <!-- 数据表格 -->
    <el-table
      :key="tableKey"
      ref="table"
      v-loading="loading"
      :data="tableData.records"
      border
      fit
      row-key="id"
      style="width: 100%;"
      @filter-change="filterChange"
      @selection-change="onSelectChange"
      @sort-change="sortChange"
      @cell-click="cellClick"
    >
      <!-- 多选 -->
      <!-- <el-table-column align="center" type="selection" width="40px" :reserve-selection="true" /> -->
      <!-- index -->
      <el-table-column align="center" type="index" label="#" width="40px" />
      <!-- 编码 -->
      <el-table-column :label="$t('table.role.code')" align="center" prop="code" width="200px">
        <template slot-scope="scope">
          <span>{{ scope.row.code }}</span>
        </template>
      </el-table-column>
      <!-- 角色名称 -->
      <el-table-column
        :label="$t('table.role.name')"
        :show-overflow-tooltip="true"
        align="center"
        prop="name"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.name }}</span>
        </template>
      </el-table-column>
      <!-- 角色描述 -->
      <el-table-column
        :label="$t('table.role.describe')"
        :show-overflow-tooltip="true"
        align="center"
        prop="describe"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.describe }}</span>
        </template>
      </el-table-column>

      <!-- 数据范围 -->
      <!-- <el-table-column
        column-key="dsType.code"
        :label="$t('table.role.dsType')"
        align="center"
        width="100px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.dsType ? scope.row.dsType.desc : '' }}</span>
        </template>
      </el-table-column>-->

      <!-- 是否内置 -->
      <el-table-column
        column-key="readonly"
        :label="$t('table.role.readonly')"
        align="center"
        width="80px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.readonly ? $t('common.yes') : $t('common.no') }}</span>
        </template>
      </el-table-column>

      <!-- 状态 -->
      <el-table-column
        :filter-multiple="false"
        column-key="status"
        :filters="[
          { text: $t('common.status.valid'), value: true },
          { text: $t('common.status.invalid'), value: false }
        ]"
        :label="$t('table.role.status')"
        class-name="status-col"
        width="70px"
      >
        <template slot-scope="{ row }">
          <el-tag :type="row.status | statusFilter">
            {{
            row.status ? $t("common.status.valid") : $t("common.status.invalid")
            }}
          </el-tag>
        </template>
      </el-table-column>

      <!-- 创建时间 -->
      <el-table-column
        :label="$t('table.createTime')"
        align="center"
        prop="createTime"
        width="170px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.createTime }}</span>
        </template>
      </el-table-column>

      <!-- 操作 -->
      <el-table-column
        :label="$t('table.operation')"
        align="center"
        column-key="operation"
        class-name="small-padding fixed-width"
        width="300px"
      >
        <div slot-scope="{ row }" class="btns">
          <el-button
            v-if="!row.readonly"
            v-hasPermission="['role:update']"
            type="primary"
            @click="edit(row)"
          >{{ $t('edit') }}</el-button>
          <!--<el-button
            type="danger"
            v-hasPermission="['role:delete']"
            title="删除"
            @click="singleDelete(row)"
          >
            {{$t('delete')}}
          </el-button>-->
          <el-button v-hasPermission="['role:auth']" type="primary" @click="authUser(row)">授权用户</el-button>
          <el-button
            v-if="!row.readonly"
            v-hasPermission="['role:config']"
            type="warning"
            @click="authResource(row)"
          >分配权限</el-button>

          <!-- dropdown 有时候会有bug，不知道这么解决 -->

          <!-- <el-dropdown v-has-any-permission="['role:delete','role:auth','role:config']">
            <span class="el-dropdown-link">
              {{ $t('table.more') }}
              <i class="el-icon-arrow-down el-icon--right" />
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item @click.native="singleDelete(row)" icon="el-icon-delete" v-hasPermission="['role:delete']">删除</el-dropdown-item>
              <el-dropdown-item @click.native="authUser(row)" icon="el-icon-user" v-hasPermission="['role:auth']">授权</el-dropdown-item>
              <el-dropdown-item @click.native="authResource(row)" icon="el-icon-setting" v-hasPermission="['role:config']">配置</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>-->

          <el-link
            v-has-no-permission="[
              'role:update',
              'role:delete',
              'role:auth',
              'role:config'
            ]"
            class="no-perm"
          >{{ $t("tips.noPermission") }}</el-link>
        </div>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination
      v-show="tableData.total > 0"
      :limit.sync="queryParams.size"
      :page.sync="queryParams.current"
      :total="Number(tableData.total)"
      @pagination="fetch"
    />

    <!-- 角色编辑 -->
    <role-edit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
    />

    <!-- 授权用户 -->
    <user-role
      ref="userRole"
      :dialog-visible="userRoleDialog.isVisible"
      @close="userRoleClose"
      @success="userRoleSuccess"
    />

    <!-- 分配权限 -->
    <role-authority
      ref="roleAuthority"
      :dialog-visible="roleAuthorityDialog.isVisible"
      @close="roleAuthorityClose"
      @success="roleAuthoritySuccess"
    />
    <file-import
      ref="import"
      :dialog-visible="fileImport.isVisible"
      :type="fileImport.type"
      :action="fileImport.action"
      accept=".xls, .xlsx"
      @close="importClose"
      @success="importSuccess"
    />
    <el-dialog
      v-el-drag-dialog
      :close-on-click-modal="false"
      :close-on-press-escape="true"
      title="预览"
      width="80%"
      top="50px"
      :visible.sync="preview.isVisible"
    >
      <el-scrollbar>
        <div v-html="preview.context"></div>
      </el-scrollbar>
    </el-dialog>
  </div>
</template>

<script>
import Pagination from '@/components/Pagination'
import elDragDialog from '@/directive/el-drag-dialog'
import RoleEdit from './Edit'
import UserRole from './UserRole'
import FileImport from '@/components/gmis/Import'
import RoleAuthority from './RoleAuthority'
import roleApi from '@/api/Role.js'
import { convertEnum } from '@/utils/utils'
import { downloadFile, initEnums, initQueryParams } from '@/utils/commons'

export default {
  name: 'RoleManage',
  directives: { elDragDialog },
  components: { Pagination, RoleEdit, UserRole, RoleAuthority, FileImport },
  filters: {
    statusFilter(status) {
      const map = {
        false: 'danger',
        true: 'success',
      }
      return map[status] || 'success'
    },
  },
  data() {
    return {
      dialog: {
        isVisible: false,
        type: 'add',
      },
      preview: {
        isVisible: false,
        context: '',
      },
      fileImport: {
        isVisible: false,
        type: 'import',
        action: `${process.env.VUE_APP_BASE_API}/authority/role/import`,
      },
      userRoleDialog: {
        isVisible: false,
      },
      roleAuthorityDialog: {
        isVisible: false,
      },
      tableKey: 0,
      queryParams: initQueryParams({
        model: {
          dsType: {
            code: null,
          },
        },
      }),
      selection: [],
      loading: false,
      tableData: {
        total: 0,
      },
      enums: {
        DataScopeType: {},
      },
      dicts: {},
    }
  },
  computed: {
    dsTypeList() {
      return convertEnum(this.enums.DataScopeType)
    },
  },
  mounted() {
    initEnums('DataScopeType', this.enums)
    this.fetch()
  },
  methods: {
    editClose() {
      this.dialog.isVisible = false
    },
    userRoleClose() {
      this.userRoleDialog.isVisible = false
    },
    roleAuthorityClose() {
      this.roleAuthorityDialog.isVisible = false
    },
    editSuccess() {
      this.search()
    },
    userRoleSuccess() {
      this.search()
    },
    roleAuthoritySuccess() {
      this.search()
    },
    onSelectChange(selection) {
      this.selection = selection
    },
    search() {
      this.fetch({
        ...this.queryParams,
      })
    },
    reset() {
      this.queryParams = initQueryParams({
        model: {
          dsType: {
            code: null,
          },
        },
      })
      this.$refs.table.clearSort()
      this.$refs.table.clearFilter()
      this.search()
    },
    exportExcelPreview() {
      if (this.queryParams.timeRange) {
        this.queryParams.map.createTime_st = this.queryParams.timeRange[0]
        this.queryParams.map.createTime_ed = this.queryParams.timeRange[1]
      }
      this.queryParams.map.fileName = '导出角色数据'
      roleApi.preview(this.queryParams).then(response => {
        const res = response.data
        this.preview.isVisible = true
        this.preview.context = res.data
      })
    },
    exportExcel() {
      if (this.queryParams.timeRange) {
        this.queryParams.map.createTime_st = this.queryParams.timeRange[0]
        this.queryParams.map.createTime_ed = this.queryParams.timeRange[1]
      }
      this.queryParams.map.fileName = '导出角色数据'
      roleApi.export(this.queryParams).then(response => {
        downloadFile(response)
      })
    },
    importExcel() {
      this.fileImport.type = 'upload'
      this.fileImport.isVisible = true
      this.$refs.import.setModel(false)
    },
    importSuccess() {
      this.search()
    },
    importClose() {
      this.fileImport.isVisible = false
    },
    singleDelete(row) {
      this.$refs.table.clearSelection()
      this.$refs.table.toggleRowSelection(row, true)
      this.batchDelete()
    },
    batchDelete() {
      if (!this.selection.length) {
        this.$message({
          message: this.$t('tips.noDataSelected'),
          type: 'warning',
        })
        return
      }
      this.$confirm(this.$t('tips.confirmDelete'), this.$t('common.tips'), {
        confirmButtonText: this.$t('common.confirm'),
        cancelButtonText: this.$t('common.cancel'),
        type: 'warning',
      })
        .then(() => {
          const ids = []
          this.selection.forEach(u => {
            ids.push(u.id)
          })
          this.delete(ids)
        })
        .catch(() => {
          this.clearSelections()
        })
    },
    clearSelections() {
      this.$refs.table.clearSelection()
    },
    delete(ids) {
      roleApi.delete({ ids: ids }).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.$message({
            message: this.$t('tips.deleteSuccess'),
            type: 'success',
          })
        }
        this.search()
      })
    },
    add() {
      this.dialog.type = 'add'
      this.dialog.isVisible = true
      this.$refs.edit.setRole({ enums: this.enums })
    },
    edit(row) {
      this.$refs.edit.setRole({ row, enums: this.enums })
      this.dialog.type = 'edit'
      this.dialog.isVisible = true
    },
    fetch(params = {}) {
      this.loading = true
      if (this.queryParams.timeRange) {
        this.queryParams.map.createTime_st = this.queryParams.timeRange[0]
        this.queryParams.map.createTime_ed = this.queryParams.timeRange[1]
      }

      this.queryParams.current = params.current ? params.current : this.queryParams.current
      this.queryParams.size = params.size ? params.size : this.queryParams.size

      roleApi
        .page(this.queryParams)
        .then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.tableData = res.data
          }
        })
        .finally(() => (this.loading = false))
    },
    sortChange(val) {
      this.queryParams.sort = val.prop
      this.queryParams.order = val.order
      if (this.queryParams.sort) {
        this.search()
      }
    },
    filterChange(filters) {
      for (const key in filters) {
        if (key.includes('.')) {
          const val = {}
          val[key.split('.')[1]] = filters[key][0]
          this.queryParams.model[key.split('.')[0]] = val
        } else {
          this.queryParams.model[key] = filters[key][0]
        }
      }
      this.search()
    },
    cellClick(row, column) {
      if (column['columnKey'] === 'operation') {
        return
      }
      let flag = false
      this.selection.forEach(item => {
        if (item.id === row.id) {
          flag = true
          this.$refs.table.toggleRowSelection(row)
        }
      })

      if (!flag) {
        this.$refs.table.toggleRowSelection(row, true)
      }
    },
    authResource(row) {
      this.roleAuthorityDialog.isVisible = true
      this.$refs.roleAuthority.setRoleAuthority(row)
    },
    authUser(row) {
      this.userRoleDialog.isVisible = true
      this.$refs.userRole.setUserRole(row)
    },
  },
}
</script>
<style lang="scss" scoped>
  .btns {
    display: flex;
    justify-content: flex-start;
    .el-button {
      width: auto;
    }
  }
</style>
