<!-- 气表型号设置 -->
<template>
  <div class="app-container">
    <search-box>
      <div slot="left">
        <!-- 根据气表型号进行搜索 -->
        <el-input
          v-model="queryParams.model.modelName"
          :placeholder="$t('table.gasModel.model')"
        />
        <!-- 根据厂家名称进行搜索 -->
        <el-input
          v-model="queryParams.model.companyName"
          placeholder="生产厂商"
        />
        <!-- 根据气表编号进行搜索 -->
        <el-input
          v-model="queryParams.model.gasMeterVersionName"
          placeholder="气表版号"
        />
        <el-button type="primary" @click="search">{{ $t("table.search") }}</el-button>
        <el-button type="warning" @click="reset">{{ $t("table.reset") }}</el-button>
      </div>
      <div slot="right">
        <!-- 添加气表型号 -->
        <el-button v-has-permission="['gasModel:add']" type="success" @click="add">{{ $t("table.add") }}</el-button>
        <!-- 批量启用 -->
        <el-button v-has-permission="['gasModel:update']" type="primary" :disabled="!isBatchDisabled" @click="batchUpdate(1)">{{ $t("table.startOver") }}</el-button>
        <!-- 批量禁用 -->
        <el-button v-has-permission="['gasModel:update']" type="primary" :disabled="!isBatchEnabled" @click="batchUpdate(0)">{{ $t("table.disable") }}</el-button>
      </div>
    </search-box>
    <!-- 气表列表 -->
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
    >
      <el-table-column align="center" type="selection" width="40px" :reserve-selection="true" />
      <!-- 型号 -->
      <el-table-column
        :label="$t('table.gasModel.model')"
        :show-overflow-tooltip="true"
        align="center"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.modelName }}</span>
        </template>
      </el-table-column>
      <!-- 生产厂商 -->
      <el-table-column
        :label="$t('table.gasModel.production')"
        :show-overflow-tooltip="true"
        align="center"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.companyName }}</span>
        </template>
      </el-table-column>
      <!-- 气表版本号 -->
      <el-table-column
        :label="$t('table.gasModel.version')"
        align="center"
        :show-overflow-tooltip="true"
        width="140px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterVersionName }}</span>
        </template>
      </el-table-column>
      <!-- 最小流量 -->
      <el-table-column
        :label="$t('table.gasModel.minFlow')"
        align="center"
        :show-overflow-tooltip="true"
        width="140px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.minFlow }}</span>
        </template>
      </el-table-column>
      <!-- 最大流量 -->
      <el-table-column
        :label="$t('table.gasModel.maxFlow')"
        align="center"
        :show-overflow-tooltip="true"
        width="180px"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.maxFlow }}</span>
        </template>
      </el-table-column>
      <!-- 状态 -->
      <el-table-column
        :label="$t('status')" 
        prop="dataStatus"
        width="140"
        column-key="dataStatus"
        :filter-multiple="false"
        :filters="dataStatusfilters"
      >
        <template #default="{ row }">
           <el-radio-group v-model="row.dataStatus" :disabled="!checkPermission(['gasModel:update'])" @change="handleSwitchChange(row.dataStatus, row)">
            <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
            <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
          </el-radio-group>
          <!-- <qc-switch v-model="row.dataStatus" :disabled="!checkPermission(['gasModel:update'])" @change="handleSwitchChange(row.dataStatus, row)" /> -->
        </template>
      </el-table-column>
      <el-table-column
        :label="$t('table.operation')"
        align="center"
        column-key="operation"
        class-name="small-padding fixed-width"
        width="160px"
      >
        <template slot-scope="{ row }">
          <el-button
            v-hasPermission="['gasModel:update']"
            type="primary"
            @click="edit(row)"
          >{{ $t('edit') }}</el-button>
         
          <el-link
            v-has-no-permission="['gasModel:update', 'gasModel:delete']"
            class="no-perm"
          >{{ $t("tips.noPermission") }}</el-link>
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
    <gas-model-edit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
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
import elDragDialog from '@/directive/el-drag-dialog'
import Pagination from '@/components/Pagination'
import gasModelEdit from './components/Edit'
import gasModelApi from '@/api/system/gasModel'
import { downloadFile, initQueryParams,initDicts } from '@/utils/commons'
import { awaitToJs } from '@/utils/index'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { dataStatusfilters } from '@/enums/common'

export default {
  name: 'GasModelManage',
  directives: { elDragDialog },
  components: { Pagination, gasModelEdit },
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
    this.dataStatusfilters = dataStatusfilters
    return {
      dialog: {
        isVisible: false,
        type: 'add',
      },
      preview: {
        isVisible: false,
        context: '',
      },
      tableKey: 0,
      orgList: [],
      queryParams: initQueryParams({ model: {},}),
      selection: [],
      loading: false,
      tableData: {
        total: 0,
      },
     dicts: {
        WIRELESS_EQUIPMENT_VENDORS: {},
        SPECIFICATION:{}
      },
    }
  },
  computed: {
    
    // 是否批量禁用
    isBatchDisabled() {
      return this.selection.find((item) => !item.dataStatus)
    },
    
    // 是否批量启用
    isBatchEnabled() {
      return this.selection.find((item) => item.dataStatus)
    },
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.dicts.WIRELESS_EQUIPMENT_VENDORS = this.dictMap[dictionaryCodeMap.WIRELESS_EQUIPMENT_VENDORS]
    this.dicts.SPECIFICATION = this.dictMap[dictionaryCodeMap.SPECIFICATION]
    //  initDicts(['WIRELESS_EQUIPMENT_VENDORS','SPECIFICATION'], this.dicts)
    this.fetch()
  },
  methods: {
    loadListOptions({ callback }) {
      callback()
    },
    editClose() {
      this.dialog.isVisible = false
      this.$refs.edit.loading = false
    },
    editSuccess() {
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
        model: { },
      })
      this.$refs.table.clearSort()
      this.$refs.table.clearFilter()
      this.search()
    },
    add() {
      this.dialog.type = 'add'
      this.dialog.isVisible = true
      this.$refs.edit.setGasModel(false,this.dicts)
    },
    edit(row) {
      this.$refs.edit.setGasModel(row,this.dicts)
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

      gasModelApi
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
    /**
     * 批量修改气表版本号
     */
    async batchUpdate($state) {
      if (!this.selection.length) {
        this.$message({
          message: this.$t('tips.noDataSelected'),
          type: 'warning',
        })
        return
      }
      if (!$state) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('meterModel.batchDisableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          return
        }
      }
      const ids = []
      this.selection.forEach(u => {
        ids.push({ id: u.id, dataStatus: $state })
      })
      gasModelApi.updateBatch(ids).then(response => {
        const res = response.data;
        if (res.isSuccess) {
          this.$refs?.table?.clearSelection?.()
          this.$message({
            message: this.$t('batchSaveSuccess'),
            type: 'success'
          });
          this.search();
        } else {
          this.$message.error(res.msg)
        }
      }).catch((err) => {
        this.$message.error(err)
      });
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id } = row
      if (!val) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('meterModel.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.loading = true
      gasModelApi.update(row).then((result) => {
        this.loading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.dataStatus = Number(!+val)
        }
      }).catch(() => {
        this.loading = false
        row.dataStatus = Number(!+val)
      })
    },
  },
}
</script>
<style lang="scss" scoped></style>
