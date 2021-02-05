<!-- 生产厂商设置 -->
<template>
  <div class="app-container">
    <search-box>
      <div slot="left">
        <!-- 厂商名称输入框 -->
        <el-input
          v-model="queryParams.model.gasMeterFactoryName"
          :placeholder="$t('table.companyConfig.companyName')"
        />
        <!-- 搜索按钮 -->
        <el-button type="primary" @click="search">{{ $t("table.search") }}</el-button>
        <!-- 重置按钮 -->
        <el-button type="warning" @click="reset">{{ $t("table.reset") }}</el-button>
      </div>
      <div slot="right">
        <!-- 新增 -->
        <el-button v-has-permission="['companyConfig:add']" type="primary" @click="add">{{ $t("table.add") }}</el-button>
        <!-- 批量启用 -->
        <el-button v-has-permission="['companyConfig:update']" type="primary" :disabled="!isBatchDisabled || loading" @click="batchUpdate(1)">{{ $t("table.startOver") }}</el-button>
        <!-- 批量禁用 -->
        <el-button v-has-permission="['companyConfig:update']" type="primary" :disabled="!isBatchEnabled || loading" @click="batchUpdate(0)">{{ $t("table.disable") }}</el-button>
      </div>
    </search-box>
    <!-- 厂商列表 -->
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
    >
      <el-table-column align="center" type="selection" width="40px" :reserve-selection="true" />
      <!-- 厂商名称 -->
      <el-table-column
        :label="$t('table.companyConfig.companyName')"
        :show-overflow-tooltip="true"
        align="center"
        prop="gasMeterFactoryName"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterFactoryName }}</span>
        </template>
      </el-table-column>
      <!-- 厂商编码 -->
      <el-table-column
        :label="$t('table.companyConfig.companyCode')"
        :show-overflow-tooltip="true"
        align="center"
        prop="gasMeterFactoryCode"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterFactoryCode }}</span>
        </template>
      </el-table-column>
      <!-- 厂商地址 -->
      <el-table-column
        :label="$t('table.companyConfig.companyAddress')"
        align="center"
        :show-overflow-tooltip="true"
        width="180px"
        prop="gasMeterFactoryAddress"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.gasMeterFactoryAddress }}</span>
        </template>
      </el-table-column>
      <!-- 厂商联系人 -->
      <el-table-column
        :label="$t('table.companyConfig.contacts')"
        align="center"
        :show-overflow-tooltip="true"
        width="140px"
        prop="contacts"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.contacts }}</span>
        </template>
      </el-table-column>
      <!-- 厂商电话 -->
      <el-table-column
        :label="$t('table.companyConfig.telephone')"
        align="center"
        :show-overflow-tooltip="true"
        width="140px"
        prop="telphone"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.telphone }}</span>
        </template>
      </el-table-column>
      <!-- 厂商的状态 -->
      <el-table-column
        :label="$t('status')" 
        prop="gasMeterFactoryStatus"
        width="140"
        column-key="gasMeterFactoryStatus"
        :filter-multiple="false"
        :filters="dataStatusfilters"
      >
        <template #default="scope">
          <!-- <qc-switch v-model="row.gasMeterFactoryStatus" :disabled="!checkPermission(['companyConfig:update'])" @change="handleSwitchChange(row.gasMeterFactoryStatus, row)" /> -->
          <el-radio-group v-model="scope.row.gasMeterFactoryStatus" :disabled="!checkPermission(['companyConfig:update'])" @change="handleSwitchChange(scope.row.gasMeterFactoryStatus, scope.row)">
              <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
                <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
            </el-radio-group>
        </template>
      </el-table-column>
      <!-- 操作按钮 -->
      <el-table-column
        :label="$t('table.operation')"
        align="center"
        column-key="operation"
        class-name="small-padding fixed-width"
        width="160px"
      >
        <template slot-scope="{ row }">
          <el-button
            v-hasPermission="['companyConfig:update']"
            type="primary"
            @click="edit(row)"
          >{{ $t('edit') }}</el-button>
          <el-link
            v-has-no-permission="['companyConfig:update', 'companyConfig:delete']"
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
    <company-edit
      ref="edit"
      :company-list="companyList"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
    />
  </div>
</template>

<script>
import Pagination from '@/components/Pagination'
import companyEdit from './components/Edit'
import gasMeterFactoryApi from '@/api/system/gasMeterFactory'
import DicItems from '@/api/DictionaryItem'
import { downloadFile, initQueryParams } from '@/utils/commons'
import { awaitToJs } from '@/utils/index'
import { dataStatusfilters } from '@/enums/common'

export default {
  name: 'CompanyManage',
  components: { Pagination, companyEdit },
  filters: {
    statusFilter(status) {
      const map = {
        0: 'danger',
        1: 'success',
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
      tableKey: 0,
      orgList: [],
      queryParams: initQueryParams({
        model: {
         
        },
      }),
      selection: [],
      loading: false,
      tableData: {
        total: 0,
      },
      companyList: [], // 商家列表
    }
  },
  computed: {
    // 是否批量禁用
    isBatchDisabled() {
      return this.selection.find((item) => !item.gasMeterFactoryStatus)
    },
    
    // 是否批量启用
    isBatchEnabled() {
      return this.selection.find((item) => item.gasMeterFactoryStatus)
    },
  },
  watch: {
    'dialog.isVisible': function(val) {
      if (val && !this.companyList.length) {
        this.fetchCompanyList()
      }
    }
  },
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
      filterChange(filters) {
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
      onSelectChange(selection) {
        this.selection = selection;
      },
      /**
       * 厂商列表分页加载
       */
      fetch(params = {}) {
        this.loading = true
        if (this.queryParams.timeRange) {
          this.queryParams.map.createTime_st = this.queryParams.timeRange[0]
          this.queryParams.map.createTime_ed = this.queryParams.timeRange[1]
        }
        this.queryParams.current = params.current ? params.current : this.queryParams.current
        this.queryParams.size = params.size ? params.size : this.queryParams.size
        gasMeterFactoryApi
        .page(this.queryParams)
        .then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.tableData = res.data
            // console.log(' this.tableData='+JSON.stringify( this.tableData))
          }
        })
        .finally(() => (this.loading = false))
      },
      /**
       * 生产厂商添加
       */
      add() {
        this.dialog.type = 'add'
        this.dialog.isVisible = true
        this.$refs.edit.setCompanyInfo(false)
      },
      /**
       * 生产厂商编辑
       */
      edit(row) {
        this.$refs.edit.setCompanyInfo(row)
        this.dialog.type = 'edit'
        this.dialog.isVisible = true
      },
      /**
       * 生产厂商搜索
       */
      search() {
        this.fetch({
          ...this.queryParams,
        })
      },
      reset() {
        this.queryParams = initQueryParams({
          model: {
            
          },
        })
        this.$refs.table.clearSort()
        this.$refs.table.clearFilter()
        this.search()
    },
    /**
     * 批量修改生产厂商的状态
     */
    async batchUpdate($state){
       if (!this.selection.length) {
          this.$message({
            message: this.$t('tips.noDataSelected'),
            type: 'warning'
          });
          return;
        }
        if (!$state) {
          const confirmResult = await awaitToJs(this.$confirm(this.$t('meterFactory.batchDisableConfirm'), this.$t('common.tips'), {
            type: 'warning'
          }))
          if (confirmResult.error) {
            return
          }
        }
        const ids = [];
        this.selection.forEach(u => {
          ids.push({'id':u.id,'gasMeterFactoryStatus':$state});
        });
        this.loading = true
         gasMeterFactoryApi.updateBatch(ids).then(response => {
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
        }).finally(() => {
          this.loading = false
        })
    },

    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id } = row
      if (!val) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('meterFactory.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.gasMeterFactoryStatus = Number(!+val)
          return
        }
      }
      this.loading = true
      gasMeterFactoryApi.update(row).then((result) => {
        this.loading = false
        const { isSuccess, data } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.gasMeterFactoryStatus = Number(!+val)
        }
      }).catch(() => {
        this.loading = false
        row.gasMeterFactoryStatus = Number(!+val)
      })
    },
    // 获取 编辑/新增 获取厂家选项
    async fetchCompanyList() {
      const COMPANY_CODE = '1333240644239360000'
      const payload = {
        model: {
          dictionaryId: COMPANY_CODE
        },
        size: 200
      }
      const { data: res } = await DicItems.page(payload)
      if (res.data) {
        const companyList = res.data?.records ?? []
        if (companyList.length) {
          this.companyList = companyList.map(({ code, name }) => ({
            gasMeterFactoryName: name,
            gasMeterFactoryCode: code
          }))
        }
      }
    }
  }
}
</script>
<style lang="scss" scoped></style>
