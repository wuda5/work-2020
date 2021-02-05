<template>
  <div class="app-container">
    <search-box>
      <div slot="left">
        <el-input
          v-model="queryParams.model.account"
          :placeholder="$t('table.user.account')"
          clearable
        />
        <el-button type="primary" @click="search">
          {{ $t('table.search') }}
        </el-button>
        <el-button type="warning" @click="reset">
          {{ $t('table.reset') }}
        </el-button>
      </div>
      <div slot="right">
        <el-button v-has-permission="['user:add']" type="success" @click="add">
          {{ $t('table.add') }}
        </el-button>
      </div>
    </search-box>

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
      <el-table-column align="center" type="selection" width="40px" :reserve-selection="true"/>

      <el-table-column
        :label="$t('table.user.account')"
        :show-overflow-tooltip="true"
        align="center"
        prop="account"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.account }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.user.name')"
        :show-overflow-tooltip="true"
        align="center"
        prop="name"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.name }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :filter-multiple="false"
        column-key="sex.code"
        :label="$t('table.user.sex')"
        class-name="status-col"
        prop="sex.desc"
        width="70px"
      >
        <template slot-scope="{ row }">
          <el-tag :type="row.sex ? row.sex['code'] : '' | sexFilter">
            {{ row.sex ? row.sex.desc : '' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column :label="$t('table.user.email')" :show-overflow-tooltip="true" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.email }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.user.nation')"
        :show-overflow-tooltip="true"
        align="center"
        width="80px"
      >
        <template slot-scope="scope">
          <span>{{
            scope.row.nation['data'] ? scope.row.nation['data'] : scope.row.nation['key']
          }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :filter-multiple="false"
        column-key="education.key"
        :label="$t('table.user.education')"
        :show-overflow-tooltip="true"
        align="center"
        width="80px"
      >
        <template slot-scope="scope">
          <span>{{
            scope.row.education['data'] ? scope.row.education['data'] : scope.row.education['key']
          }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :filter-multiple="false"
        column-key="positionStatus.key"
        :label="$t('table.user.positionStatus')"
        :show-overflow-tooltip="true"
        align="center"
        width="100px"
      >
        <template slot-scope="scope">
          <span>{{
            scope.row.positionStatus['data']
              ? scope.row.positionStatus['data']
              : scope.row.positionStatus['key']
          }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.user.orgId')"
        align="center"
        :show-overflow-tooltip="true"
        width="100px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.org['data'] ? scope.row.org.data.label : scope.row.org.key }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.user.stationId')"
        align="center"
        :show-overflow-tooltip="true"
        width="100px"
      >
        <template slot-scope="scope">
          <span>{{
            scope.row.station['data'] ? scope.row.station.data : scope.row.station.key
          }}</span>
        </template>
      </el-table-column>
      <el-table-column
        column-key="status"
        :label="$t('table.user.status')"
        class-name="status-col"
        width="70px"
      >
        <template slot-scope="{ row }">
          <el-tag :type="row.status | statusFilter">
            {{ row.status ? $t('common.status.valid') : $t('common.status.invalid') }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.user.createTime')"
        align="center"
        prop="createTime"
        width="170px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.createTime }}</span>
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.operation')"
        align="center"
        column-key="operation"
        fixed="right"
        class-name="small-padding fixed-width"
        width="230px"
      >
        <template slot-scope="{ row }">
          <el-button v-hasPermission="['user:view']" type="success" @click="view(row)">
            {{ $t('edit') }}
          </el-button>

          <el-button v-hasPermission="['user:update']" type="primary" @click="edit(row)">
            {{ $t('edit') }}
          </el-button>
          <el-button v-hasPermission="['user:delete']" type="danger" @click="singleDelete(row)">
            {{ $t('delete') }}
          </el-button>

          <el-link
            v-has-no-permission="['user:view', 'user:update', 'user:delete']"
            class="no-perm"
          >
            {{ $t('tips.noPermission') }}
          </el-link>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-show="tableData.total > 0"
      :limit.sync="queryParams.size"
      :page.sync="queryParams.current"
      :total="Number(tableData.total)"
      @pagination="fetch"
    />
    <user-edit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
    />
    <user-view ref="view" :dialog-visible="userViewVisible" @close="viewClose"/>
    <file-import
      ref="import"
      :dialog-visible="fileImport.isVisible"
      :type="fileImport.type"
      :export-error-url="fileImport.exportErrorUrl"
      :action="fileImport.action"
      accept=".xls,.xlsx"
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
        <div v-html="preview.context"/>
      </el-scrollbar>
    </el-dialog>
  </div>
</template>

<script>
  import Pagination from '@/components/Pagination'
  import Treeselect from '@riophae/vue-treeselect'
  import '@riophae/vue-treeselect/dist/vue-treeselect.css'
  import elDragDialog from '@/directive/el-drag-dialog'
  import FileImport from '@/components/gmis/Import'
  import UserEdit from './Edit'
  import UserView from './View'
  import userApi from '@/api/User.js'
  import orgApi from '@/api/Org.js'
  import {convertEnum} from '@/utils/utils'
  import {downloadFile, initDicts, initEnums, initQueryParams} from '@/utils/commons'

  export default {
    name: 'UserManage',
    directives: {elDragDialog},
    components: {Pagination, UserEdit, UserView, Treeselect, FileImport},
    filters: {
      userAvatarFilter(name) {
        return name.charAt(0)
      },
      sexFilter(status) {
        const map = {
          W: 'danger',
          M: 'primary',
          N: 'info',
        }
        return map[status] || 'info'
      },
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
        orgList: [],
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
          action: `${process.env.VUE_APP_BASE_API}/authority/user/import`,
          exportErrorUrl: `/authority/user/exportError`,
        },
        userViewVisible: false,
        tableKey: 0,
        queryParams: initQueryParams({
          model: {
            nation: {
              key: '',
            },
            education: {
              key: '',
            },
            positionStatus: {
              key: '',
            },
            org: {
              key: null,
            },
            station: {
              key: null,
            },
            sex: {
              code: '',
            },
          },
        }),
        selection: [],
        loading: false,
        tableData: {
          total: 0,
        },
        enums: {
          Sex: {},
        },
        dicts: {
          NATION: {},
          POSITION_STATUS: {},
          EDUCATION: {},
        },
      }
    },
    computed: {
      currentUser() {
        return this.$store.state.account.user
      },
    },
    watch: {
      $route() {
        if (this.$route.path === '/user/user') {
          this.initOrg()
        }
      },
    },
    mounted() {
      initEnums('Sex', this.enums)
      initDicts(['NATION', 'POSITION_STATUS', 'EDUCATION'], this.dicts)
      this.fetch()
      this.initOrg()
    },
    methods: {
      initOrg() {
        orgApi.allTree({status: true}).then(response => {
          const res = response.data
          this.orgList = res.data
        })
      },
      myAvatar(avatar) {
        if (!avatar) {
          return require(`@/assets/avatar/default.jpg`)
        } else {
          if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
            return avatar
          } else {
            return require(`@/assets/avatar/${avatar}`)
          }
        }
      },
      viewClose() {
        this.userViewVisible = false
      },
      editClose() {
        this.dialog.isVisible = false
      },
      editSuccess() {
        this.search()
      },
      onSelectChange(selection) {
        this.selection = selection
      },
      loadListOptions({callback}) {
        callback()
      },
      search() {
        this.fetch({
          ...this.queryParams,
        })
      },
      reset() {
        this.queryParams = initQueryParams({
          model: {
            nation: {
              key: '',
            },
            education: {
              key: '',
            },
            positionStatus: {
              key: '',
            },
            org: {
              key: null,
            },
            station: {
              key: null,
            },
            sex: {
              code: '',
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
        this.queryParams.map.fileName = '导出用户数据'
        userApi.preview(this.queryParams).then(response => {
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
        this.queryParams.map.fileName = '导出用户数据'
        userApi.export(this.queryParams).then(response => {
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
      resetPassword() {
        if (!this.selection.length) {
          this.$message({
            message: this.$t('tips.noDataSelected'),
            type: 'warning',
          })
          return
        }
        this.$confirm(this.$t('tips.confirmRestPassword'), this.$t('common.tips'), {
          confirmButtonText: this.$t('common.confirm'),
          cancelButtonText: this.$t('common.cancel'),
          type: 'warning',
        })
          .then(() => {
            const ids = []
            this.selection.forEach(u => {
              ids.push(u.id)
            })
            userApi.reset({ids: ids}).then(response => {
              const res = response.data
              if (res.isSuccess) {
                this.$message({
                  message: this.$t('tips.resetPasswordSuccess'),
                  type: 'success',
                })
              }
              this.clearSelections()
            })
          })
          .catch(() => {
            this.clearSelections()
          })
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
        let contain = false
        this.$confirm(this.$t('tips.confirmDelete'), this.$t('common.tips'), {
          confirmButtonText: this.$t('common.confirm'),
          cancelButtonText: this.$t('common.cancel'),
          type: 'warning',
        })
          .then(() => {
            const ids = []
            this.selection.forEach(u => {
              if (u.id === this.currentUser.id) {
                contain = true
                return
              }
              ids.push(u.id)
            })
            if (contain) {
              this.$message({
                message: this.$t('tips.containCurrentUser'),
                type: 'warning',
              })
              this.clearSelections()
            } else {
              this.delete(ids)
            }
          })
          .catch(() => {
            this.clearSelections()
          })
      },
      clearSelections() {
        this.$refs.table.clearSelection()
      },
      delete(ids) {
        userApi.delete({ids: ids}).then(response => {
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
        this.$refs.edit.setUser(false, this.orgList, this.dicts, this.enums)
      },
      view(row) {
        this.$refs.view.setUser(row, this.orgList, this.dicts, this.enums)
        this.userViewVisible = true
      },
      edit(row) {
        this.$refs.edit.setUser(row, this.orgList, this.dicts, this.enums)
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

        userApi
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
    },
  }
</script>
<style lang="scss" scoped></style>
