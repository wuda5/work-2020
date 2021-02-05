<!-- 详细地址列表 -->
<template>
  <div class="DetailsAddress-page">
    <div class="table-title">{{ $t('operation.community.detailsAddresslist') }}</div>
    <!-- 搜索区域 -->
    <search-box class="search-box operation-box">
      <div slot="left">
        <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
          <!-- 详细地址 -->
          <el-form-item label="">
            <el-input v-model="searchForm.moreDetailAddress" clearable :placeholder="$t('operation.community.moreDetailAddress')">
            </el-input>
          </el-form-item>
          <!-- 搜索操作 -->
          <el-form-item label="">
            <el-button type="primary" name="community-search" :disabled="!isOperation" class="search-btn community-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!-- 列表操作区域 -->
      <div v-if="isOperation" slot="right" class="operation-btn-box">
        <el-button v-has-permission="['community:detailsAddressAdd']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
      </div>
    </search-box>
    <div class="operation-box">
    </div>
    <!--数据-->
    <el-table
      :ref="listRef"
      v-loading="listLoading"
      stripe
      border
      :data="list"
      tooltip-effect="dark"
      @filter-change="filterChange"
    >
      <!-- 索引 -->
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <!-- 详细地址 -->
      <el-table-column
        :label="$t('operation.community.moreDetailAddress')"
        prop="moreDetailAddress"
        show-overflow-tooltip
      >
      </el-table-column>
      <!-- 状态 -->
      <!-- <el-table-column 
        :label="$t('status')" 
        prop="dataStatus"
        width="70"
        column-key="dataStatus"
        :filter-multiple="false"
        :filters="dataStatusfilters"
      >
        <template #default="scope">
          <qc-switch v-model="scope.row.dataStatus" :disabled="!checkPermission(['community:detailsAddressEdit'])" @change="handleSwitchChange(scope.row.dataStatus, scope.row)" />
        </template>
      </el-table-column> -->
      <!-- 操作 -->
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="80"
      >
        <template #default="{ row }">
          <el-button v-has-permission="['community:detailsAddressEdit']" type="primary" name="row-edit" @click.native.stop="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
          <!-- <el-button v-has-permission="['community:detailsAddressDelete']" type="danger" name="row-delete" @click.native.stop="handleDelete(row)">{{ $t('delete') }}</el-button> -->
        </template>
      </el-table-column>
      <template v-if="!isOperation" #empty>
        <b class="text-danger">{{ $t('operation.community.selectCommunityHint') }}</b>
      </template>
    </el-table>
    <!--分页-->
    <pagination
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      :total="+total"
      layout="total, sizes, prev, next, jumper"
      @pagination="handleGetList"
    />

    <!-- 详细地址表单弹窗 -->
    <qc-dialog
      :width="750"
      :title="currentRow ? $t('operation.community.editDetailsAddress') : $t('operation.community.addDetailsAddress')"
      :visible="formDialogVisible"
      data-key="formDialogVisible"
      @close="dialogClose"
    >
      <details-address-form :form-data="currentRow ? currentRow : { communityId: communityData.id }" @success="handleSaveSuccess"></details-address-form>
    </qc-dialog>
  </div>
</template>

<script>
import { isEmpty } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { getDetailsAddressList, deleteDetailsAddress, saveDetailsAddress } from '@/api/operation/community'
import { awaitToJs } from '@/utils/index'
import DetailsAddressForm from './DetailsAddressForm'
import { formStatusField } from '@/enums/form'
import { deleteStatusField } from '@/enums/common'

export default {
  name: 'DetailsAddress',
  components: {
    DetailsAddressForm
  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {
    // 小区信息
    communityData: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        communityId: null,
        moreDetailAddress: null,
      }
    }
  },
  computed: {
    // 判断是否可以操作
    isOperation() {
      return this.communityData?.id
    }
  },
  watch: {
    communityData: {
      handler(value) {
        this.initData()
      },
      immediate: true
    }
  },
  created() {
    // this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    // 初始化数据
    async initData() {
      if (isEmpty(this.communityData)) {
        this.list = []
      } else {
        this.searchForm.communityId = this.communityData.id
        await this.getList()
      }
    },

    // 获取小区(村、xx路)列表根据街道(乡镇)Id
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getDetailsAddressList(this.generateQueryParams(params)).then((result) => {
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
        deleteDetailsAddress({ ids }).then((result) => {
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
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.deleteDetailsAddressConfirm'), this.$t('common.tips'), {
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
    },
    
    // 修改数据状态
    async handleSwitchChange(val, row) {
      const { id, dataStatus } = row
      if (!dataStatus) {
        const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.community.disableDetailsAddressConfirm'), this.$t('common.tips'), {
          type: 'warning'
        }))
        if (confirmResult.error) {
          row.dataStatus = Number(!+val)
          return
        }
      }
      this.listLoading = true
      saveDetailsAddress(row, id).then((result) => {
        this.listLoading = false
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
        this.listLoading = false
        row.dataStatus = Number(!+val)
      })
    },
  }
}
</script>

<style scoped lang="scss">

</style>
