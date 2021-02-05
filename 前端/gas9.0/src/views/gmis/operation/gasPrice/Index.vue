<!-- 用气类型列表 -->
<template>
  <div class="qc-main gas-price-page">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">{{ $t('operation.gasPrice.title') }}</span>
      </div>
      <el-row :gutter="30">
        <el-col :span="8">
          <div class="table-title">{{ $t('operation.gasPrice.useGasTypeTitle') }}</div>
          <!-- 搜索区域 -->
          <search-box class="search-box operation-box">
            <div slot="left">
              <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
                <!-- 用气类型名称 -->
                <el-form-item label="">
                  <el-input v-model="searchForm.useGasTypeName" style="width: 160px !important; " clearable :placeholder="$t('operation.gasPrice.useGasTypeName')">
                  </el-input>
                </el-form-item>
                <!-- 气价类型 -->
                <el-form-item>
                  <el-select v-model="searchForm.priceType" style="width: 110px" name="priceType" clearable :placeholder="`${$t('operation.gasPrice.priceType')}`">
                    <el-option v-for="(value, key) in priceTypeMap" :key="key" :value="key" :label="value"></el-option>
                  </el-select>
                </el-form-item>
                <!-- 操作 -->
                <el-form-item label="">
                  <el-button type="primary" name="street-search" class="search-btn street-search" @click.native="handleSearch(false)">{{ $t('search') }}</el-button>
                </el-form-item>
              </el-form>
            </div>
            <div slot="right" class="operation-btn-box">
              <el-button v-has-permission="['gasPrice:useGasTypeAdd']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
            </div>
          </search-box>
          <!--数据-->
          <el-table
            :ref="listRef"
            v-loading="listLoading"
            stripe
            border
            highlight-current-row
            :data="list"
            tooltip-effect="dark"
            @row-click="handleRowClick"
          >
            <!-- 索引 -->
            <el-table-column
              type="index"
              :label="$t('table.index')"
            >
            </el-table-column>
            <!-- 用气类型名称 -->
            <el-table-column
              prop="useGasTypeName"
              :label="$t('operation.gasPrice.useGasTypeName')"
            >
            </el-table-column>
            <!-- 客户类型 -->
            <!-- <el-table-column
              prop="userTypeName"
              :label="$t('operation.gasPrice.userTypeName')"
            >
              <template #default="scope">
                {{ scope.row.userTypeName }}
              </template>
            </el-table-column> -->
            <!-- 气价类型 -->
            <el-table-column 
              :label="$t('operation.gasPrice.priceType')" 
              prop="priceType"
            >
              <template #default="scope">
                {{ priceTypeMap[scope.row.priceType] }}
              </template>
            </el-table-column>
            <!-- 操作 -->
            <el-table-column
              fixed="right"
              :label="$t('table.operation')"
              width="100"
            >
              <template #default="{ row }">
                <el-button v-has-permission="['gasPrice:useGasTypeEdit']" type="primary" name="row-edit" @click.native="showFormDialog(formStatusField.EDIT, row)">{{ $t('edit') }}</el-button>
                <!-- <el-button v-has-permission="['gasPrice:useGasTypeDelete']" type="danger" name="row-delete" @click.native="handleDelete(row)">{{ $t('delete') }}</el-button> -->
              </template>
            </el-table-column>
          </el-table>
          <!--分页-->
          <pagination
            :page.sync="queryParams.current"
            :limit.sync="queryParams.size"
            :total="+total"
            layout="total, sizes, prev, next, jumper"
            @pagination="handleGetList"
          />

          <!-- 用气类型表单弹窗 -->
          <qc-dialog
            :width="600"
            :title="currentRow ? $t('operation.gasPrice.editUseGasType') : $t('operation.gasPrice.addUseGasType')"
            :visible="formDialogVisible"
            data-key="formDialogVisible"
            @close="dialogClose"
          >
            <use-gas-type-form :form-data="currentRow" @success="handleSaveSuccess"></use-gas-type-form>
          </qc-dialog>
        </el-col>
        <el-col :span="16">
          <template v-if="currentRow">
            <!-- 价格信息页面 -->
            <price-page :use-gas-type-id="currentRow && isRowClick ? currentRow.id : '' " :price-type="currentRow ? currentRow.priceType : ''"></price-page>
            <!-- 滞纳金信息页面 -->
            <!-- <late-fee-page :use-gas-type-id="currentRow && isRowClick ? currentRow.id : '' "></late-fee-page> -->
          </template>
          <no-select v-else :tips="$t('operation.gasPrice.selectUseGasTypeHint')" :top="0" />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import { cloneDeep } from 'lodash'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { dictionaryCodeMap } from '@/enums/dictionary'
import { deleteStatusField } from '@/enums/common'
import { getUseGasTypeList, deleteUseGasType } from '@/api/operation/gasPrice'
import UseGasTypeForm from './components/UseGasTypeForm'
import PricePage from './components/Price'
import LateFeePage from './components/LateFee'
import NoSelect from '@/components/QcNoSelect'

export default {
  name: 'GasPrice',
  components: {
    UseGasTypeForm,
    PricePage,
    LateFeePage,
    NoSelect
  },
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {

  },
  data() {
    this.formStatusField = formStatusField
    // this.dictionaryCodeMap = dictionaryCodeMap
    return {
      searchForm: {
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID,
        priceType: null, // 气价类型
        useGasTypeName: null, // 用气类型名称
      }
    }
  },
  computed: {
    // 气价类型map
    priceTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.PRICE_TYPE)
    },
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
    // 初始化数据
    async initData() {
      await this.getList()
    },
    // 获取列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        getUseGasTypeList(this.generateQueryParams(params)).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            this.$nextTick(() => {
              this.loadData()
            })
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

    // 获取用气类型列表之后加载其它数据
    loadData() {
      const currentItem = this.list.find((item) => item.id === this.currentRow?.id)
      if (currentItem) {
        // 设置选中行高亮
        this.$refs[this.listRef]?.setCurrentRow(currentItem)
        this.currentRow = cloneDeep(currentItem)
      } else {
        this.currentRow = null
      }
    },

    // 删除数据
    deleteData(ids) {
      return new Promise((resolve) => {
        this.btnLoading = true
        deleteUseGasType({ ids }).then((result) => {
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

    //删除操作
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.gasPrice.deleteUseGasTypeConfirm'), this.$t('common.tips'), {
        type: 'warning'
      }))
      if (!confirmResult?.error) {
        const deleteResult = await this.deleteData([row.id])
        if (deleteResult) {
          this.$message.success(this.$t('tips.deleteSuccess'))
          await this.getList()
          const currentRowId = this.currentRow?.id || ''
          if (currentRowId === row.id) {
            this.currentRow = null
            this.isRowClick = false
          }
        }
      }
    },

    // 表单信息保存成功
    async handleSaveSuccess(data) {
      // console.log(data);
      await this.getList()
      this.formDialogVisible = false
    },
  }
}
</script>

<style scoped lang="scss">
  .gas-price-page {
    ::v-deep .operation-box {
      margin-bottom: 10px;
    }
  }
</style>
