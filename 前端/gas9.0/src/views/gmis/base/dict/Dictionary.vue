<!-- 字典列表 -->
<template>
  <div class="app-container">
    <!-- 搜索 -->
    <search-box>
      <div slot="left">
        <!-- 类型 -->
        <el-input
          v-model="queryParams.model.type"
          :placeholder="$t('table.dictionary.type')"
        />
        <!-- 名称 -->
        <el-input
          v-model="queryParams.model.name"
          :placeholder="$t('table.dictionary.name')"
        />
        <!-- 操作按钮 -->
        <el-button type="primary" @click="search">{{ $t('table.search') }}
        </el-button>
        <!--<el-button @click="reset" type="warning">{{ $t('table.reset') }}</el-button>-->
      </div>

      <div slot="right">
        <!--添加-->
        <el-button v-has-permission="['dict:add']" type="success" @click="add">
          {{ $t('table.add') }}
        </el-button>
        <!--删除-->
        <el-button v-has-permission="['dict:delete']" type="danger" @click="batchDelete">
          {{ $t('table.delete') }}
        </el-button>
      </div>
    </search-box>

    <!--字典列表-->
    <el-table
      ref="table"
      :key="tableKey"
      v-loading="loading"
      :data="tableData.records"
      border
      fit
      row-key="id"
      @filter-change="filterChange"
      @row-click="rowClick"
      @selection-change="onSelectChange"
      @sort-change="sortChange"
    >
      <!--多选-->
      <el-table-column align="center" type="selection" width="40px" :reserve-selection="true" />
      <!--编码-->
      <el-table-column :label="$t('table.dictionary.type')" prop="type" width="180">
        <template slot-scope="scope">
          <span>{{ scope.row.type }}</span>
        </template>
      </el-table-column>
      <!--名称-->
      <el-table-column :label="$t('table.dictionary.name')" :show-overflow-tooltip="true" prop="name">
        <template slot-scope="scope">
          <span>{{ scope.row.name }}</span>
        </template>
      </el-table-column>
      <!--描述-->
      <el-table-column :label="$t('table.dictionary.describe')" :show-overflow-tooltip="true" prop="describe">
        <template slot-scope="scope">
          <span>{{ scope.row.describe }}</span>
        </template>
      </el-table-column>
      <!-- 状态 -->
      <el-table-column
        :filter-multiple="false"
        column-key="status"
        :filters="[{ text: $t('common.status.valid'), value: true }, { text: $t('common.status.invalid'), value: false }]"
        :label="$t('table.dictionary.status')"
        class-name="status-col"
        width="70px"
      >
        <template slot-scope="{row}">
          <el-tag :type="row.status | statusFilter">{{ row.status ? $t('common.status.valid') :
            $t('common.status.invalid') }}
          </el-tag>
        </template>
      </el-table-column>
      <!--创建时间-->
      <el-table-column :label="$t('table.createTime')" prop="createTime" sortable="custom" width="100px">
        <template slot-scope="scope">
          <span>{{ scope.row.createTime.split(" ")[0] }}</span>
        </template>
      </el-table-column>
      <!--操作-->
      <el-table-column
        :label="$t('table.operation')"
        width="160px"
      >
        <template slot-scope="{row}">
          <el-button
            v-hasPermission="['dict:update']"
            type="primary"
            @click="edit(row)"
          >
            {{ $t('edit') }}
          </el-button>
          <el-button
            v-hasPermission="['dict:delete']"
            type="danger"
            @click="singleDelete(row)"
          >
            {{ $t('delete') }}
          </el-button>
          <el-link v-has-no-permission="['dict:update','dict:delete']" class="no-perm">{{ $t('tips.noPermission') }}
          </el-link>
        </template>
      </el-table-column>
    </el-table>

    <!--分页-->
    <pagination
      v-show="tableData.total>0"
      :limit.sync="queryParams.size"
      :page.sync="queryParams.current"
      :total="Number(tableData.total)"
      @pagination="fetch"
    />

    <!--编辑-->
    <dictionary-edit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      width="400px"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
    />
  </div>
</template>

<script>
  import Pagination from '@/components/Pagination'
  import DictionaryEdit from './Edit'
  import dictionaryApi from '@/api/Dictionary.js'
  import {initQueryParams} from '@/utils/commons'

  export default {
    name: 'DictionaryManage',
    components: {Pagination, DictionaryEdit},
    filters: {
      statusFilter(status) {
        const map = {
          false: 'danger',
          true: 'success'
        }

        return map[status] || 'success'
      }
    },
    data() {
      return {
        dialog: {
          isVisible: false,
          type: 'add'
        },
        tableKey: 0,
        queryParams: initQueryParams({}),
        selection: [],
        loading: false,
        tableData: {
          total: 0
        }
      }
    },
    computed: {},
    watch: {},
    mounted() {
      this.fetch()
    },
    methods: {
      editClose() {
        this.dialog.isVisible = false
      },
      editSuccess() {
        this.search()
      },
      onSelectChange(selection) {
        this.selection = selection
      },
      search() {
        this.fetch({
          ...this.queryParams
        })
        this.$emit('dictionaryClick', {id: -1})
      },
      reset() {
        this.queryParams = initQueryParams({});
        this.$refs.table.clearSort();
        this.$refs.table.clearFilter();
        this.search()
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
            type: 'warning'
          })
          return
        }
        this.$confirm(this.$t('tips.confirmDelete'), this.$t('common.tips'), {
          confirmButtonText: this.$t('common.confirm'),
          cancelButtonText: this.$t('common.cancel'),
          type: 'warning'
        }).then(() => {
          const ids = []
          this.selection.forEach((u) => {
            ids.push(u.id)
          })
          this.delete(ids)
        }).catch(() => {
          this.clearSelections()
        })
      },
      clearSelections() {
        this.$refs.table.clearSelection()
      },
      delete(ids) {
        dictionaryApi.delete({'ids': ids})
          .then((response) => {
            const res = response.data
            if (res.isSuccess) {
              this.$message({
                message: this.$t('tips.deleteSuccess'),
                type: 'success'
              })
            }
            this.search()
          })
      },
      add() {
        this.dialog.type = 'add'
        this.dialog.isVisible = true
        this.$refs.edit.setDictionary(false)
      },
      edit(row) {
        this.$refs.edit.setDictionary(row)
        this.dialog.type = 'edit'
        this.dialog.isVisible = true
      },
      fetch(params = {}) {
        this.loading = true

        this.queryParams.current = params.current ? params.current : this.queryParams.current;
        this.queryParams.size = params.size ? params.size : this.queryParams.size;

        dictionaryApi.page(this.queryParams).then(response => {
          const res = response.data;
          if (res.isSuccess) {
            this.tableData = res.data;
          }
        }).finally(() => this.loading = false);
      },
      sortChange(val) {
        this.queryParams.sort = val.prop;
        this.queryParams.order = val.order;
        if (this.queryParams.sort) {
          this.search();
        }
      },
      filterChange(filters) {
        console.log(filters);
        for (const key in filters) {
          if (key.includes('.')) {
            const val = {};
            val[key.split('.')[1]] = filters[key][0];
            this.queryParams.model[key.split('.')[0]] = val;
          } else {
            this.queryParams.model[key] = filters[key][0]
          }
        }
        this.search()
      },
      rowClick(row) {
        this.$emit('dictionaryClick', row)
      }
    }
  }
</script>
<style lang="scss" scoped>
</style>
