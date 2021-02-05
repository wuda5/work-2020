<template>
  <div class="qc-main -page">
    <div class="table-title">{{ $t('operation.community.list') }}</div>
    <div class="operation-box">
      <div class="fl">
        <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
          <el-form-item label="">
            <el-input v-model="searchForm.communityName" clearable :placeholder="$t('operation.community.communityName')">
            </el-input>
          </el-form-item>
          <el-form-item label="">
            <el-button type="primary" name="community-search" class="search-btn community-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
          </el-form-item>
        </el-form>
      </div>
      <div class="fr">
        <el-button class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
      </div>
    </div>
    <!--数据-->
    <el-table
      :ref="listRef"
      v-loading="listLoading"
      stripe
      border
      :data="list"
      tooltip-effect="dark"
      @row-click="handleRowClick"
    >
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <el-table-column
        prop="communityName"
        :label="$t('operation.community.communityName')"
      >
      </el-table-column>
      <el-table-column :label="$t('operation.community.communityAddress')" prop="communityAddress"></el-table-column>
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="180"
      >
        <template #default="{ row }">
          <el-button type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
          <el-button type="danger" name="row-delete" @click.native="handleDelete(row)">{{ $t('delete') }}</el-button>
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

    <!-- 街道(乡镇)表单弹窗 -->
    <qc-dialog
      :width="600"
      :title="currentRow ? $t('operation.community.editCommunity') : $t('operation.community.addCommunity')"
      :visible="formDialogVisible"
      data-key="formDialogVisible"
      @close="dialogClose"
    >
      <street-form :form-data="currentRow" @success="handleSaveSuccess"></street-form>
    </qc-dialog>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { deleteStatusField } from '@/enums/common'
import { getPriceList } from '@/api/operation/gasPrice'

export default {
  name: '',
  components: {

  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {
       await this.getList()
    },
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getPriceList(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            resolve(records)
          } else {
            resolve(false)
          }
          this.listLoading = false
        }).catch(() => {
          resolve(false)
          this.listLoading = false
        })
      })
    },
    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        getPriceList({ ids }).then((result) => {
          this.btnLoading = true
          const { isSuccess, data } = result.data
          if (isSuccess) {
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          this.btnLoading = true
          resolve(false)
        })
      })
    },

    //删除街道(乡镇)信息
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.deleteConfirm'), this.$t('common.tips'), {
        type: 'warning'
      }))
      if (!confirmResult?.error) {
        const deleteResult = await this.deleteData([row.id])
        if (deleteResult) {
          this.$message.success(this.$t('tips.deleteSuccess'))
          this.getList()
        }
      }
    },

    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    }
  }
}
</script>

<style scoped lang="scss">

</style>
