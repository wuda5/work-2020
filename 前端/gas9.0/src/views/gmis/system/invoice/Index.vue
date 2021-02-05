<!-- 电子发票平台配置 -->
<template>
  <div class="qc-main app-container invoice-page">
    <el-card shadow="never" class="no-border">
      <template v-slot:header>
        <span class="card-title">{{ $t('system.invoice.title') }}</span>
      </template>
      <!--搜索-->
      <search-box>
        <template v-slot:left>
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <el-form-item label="">
              <!--电子发票平台名称-->
              <el-input
                v-model="queryParams.model.platName"
                :placeholder="$t('system.invoice.platName')"
                class="filter-item search-item"
                style="width: 200px"
              />
            </el-form-item>
            <!-- 搜索操作 -->
            <el-form-item label="">
              <el-button type="primary" name="iot-search" icon="el-icon-search" class="search-btn invoice-search" @click="handleSearch">{{ $t('search') }}</el-button>
              <el-button type="warning" name="iot-search" icon="el-icon-refresh-left" class="search-reset-btn" @click="resetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </template>
        <template v-slot:right>
          <!--添加-->
          <el-button v-has-permission="['invoice:add']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog()">{{ $t('add') }}</el-button>
        </template>
      </search-box>

      <!--数据列表-->
      <el-table
        :ref="listRef"
        v-loading="listLoading"
        stripe
        border
        :highlight-current-row="false"
        :data="list"
        tooltip-effect="dark"
        @filter-change="filterChange"
      >
        <!-- 电子发票平台名称	-->
        <el-table-column
          :label="$t('system.invoice.platName')"
          :show-overflow-tooltip="true"
          prop="platName"
          width="130px"
        />
        <!--联系人-->
        <el-table-column
          :label="$t('system.invoice.contacts')"
          :show-overflow-tooltip="true"
          prop="contacts"
          width="80px"
        />
        <!--联系电话-->
        <el-table-column
          :label="$t('system.invoice.telephone')"
          :show-overflow-tooltip="true"
          prop="telephone"
          width="100"
        />
        <!--openId-->
        <el-table-column
          :label="$t('system.invoice.openId')"
          :show-overflow-tooltip="true"
          width="180px"
          prop="openId"
        />
        <!--appSecret-->
        <el-table-column
          :label="$t('system.invoice.appSecret')"
          :show-overflow-tooltip="true"
          prop="appSecret"
          width="180px"
        />
        <!--请求路径-->
        <el-table-column
          :label="$t('system.invoice.url')"
          :show-overflow-tooltip="true"
          prop="url"
          width="200"
        />
        <!--其它参数-->
        <el-table-column
          :label="$t('system.invoice.otherParam')"
          :show-overflow-tooltip="false"
          prop="otherParam"
        >
          <template #default="{ row }">
            {{ row.otherParam }}
            <!-- <template v-if="isJSON(row.otherParam)">
              <pre>{{ JSON.parse(row.otherParam) }}</pre>
            </template>
            <template v-else>
              {{ row.otherParam }}
            </template> -->
          </template>
        </el-table-column>
        <!-- 状态 -->
        <el-table-column
          :label="$t('system.invoice.dataStatus')"
          prop="dataStatus"
          width="140"
          column-key="dataStatus"
          :filter-multiple="false"
          :filters="dataStatusfilters"
        >
          <template #default="scope">
            <!-- <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['invoice:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" /> -->
            <el-radio-group v-model="scope.row.dataStatus" :disabled="!checkPermission(['invoice:edit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)">
              <el-radio-button :label="1">{{ $t('common.status.valid') }}</el-radio-button>
              <el-radio-button :label="0">{{ $t('common.status.invalid') }}</el-radio-button>
            </el-radio-group>
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column
          fixed="right"
          :label="$t('table.operation')"
          width="100"
        >
          <template #default="{ row }">
            <el-button v-has-permission="['invoice:edit']" type="primary" name="row-edit" @click="showFormDialog('edit', row)">{{ $t('edit') }}</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!--分页-->
      <pagination
        :page.sync="queryParams.current"
        :limit.sync="queryParams.size"
        :total="+total"
        @pagination="handleGetList"
      />
    </el-card>
    <!-- 发票平台表单弹窗 -->
    <el-dialog
      width="700px"
      :title="currentRow ? $t('system.invoice.edit') : $t('system.invoice.add')"
      :visible.sync="formDialogVisible"
      data-key="formDialogVisible"
      @close="formDialogVisible = false"
    >
      <Form :form-data="currentRow" @success="handleSaveSuccess" />
    </el-dialog>
  </div>
</template>

<script>
import { isArrayLikeObject } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import invoiceApi from '@/api/system/invoice'
import { initQueryParams } from '@/utils/commons'
import { awaitToJs } from '@/utils/index'
import { isJSON } from '@/utils/my-validate'
import Form from './Form.vue'

export default {
  name: 'Invoice',
  components: {
    Form
  },
  filters: {
  },
  mixins: [commonMixin, listMixin],
  data () {
    return {
      ...this.initListData({
        queryParams: initQueryParams({
          model: {
            platName: null,
            deleteStatus: null
          }
        })
      })
    }
  },
  computed: {
  },
  async created () {
    await this.getList()
  },
  mounted () {
  },
  methods: {
    isJSON,
    isArrayLikeObject,
    // 获取数据列表
    async getList (params) {
      return new Promise((resolve) => {
        this.listLoading = true
        invoiceApi.page(this.queryParams)
          .then((response) => {
            const { isSuccess, data } = response.data
            if (isSuccess) {
              const { total, records } = data
              this.total = total
              this.list = records
            }
            resolve(isSuccess)
          })
          .catch(() => (resolve(false)))
          .finally(() => (this.listLoading = false))
      })
    },
    // 修改数据状态
    async handleSwitchChange (val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('system.invoice.disableConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      invoiceApi.save(row).then((result) => {
        const { isSuccess } = result.data
        if (isSuccess) {
          this.$message({
            type: 'success',
            message: this.$t('saveDataStatusSuccess')
          })
        } else {
          row.dataStatus = Number(!+val)
        }
      }).catch(() => {
        row.dataStatus = Number(!+val)
      }).finally(() => (this.listLoading = false))
    },

    // 数据状态搜索发生变化
    handleDataStatusChange (value) {
      this.handleSearch()
    },

    // 表单信息保存成功
    async handleSaveSuccess (data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    }
  }
}
</script>
<style lang="scss" scoped></style>

