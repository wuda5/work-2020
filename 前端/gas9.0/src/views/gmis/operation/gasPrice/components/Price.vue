<!-- 价格信息列表 -->
<template>
  <div class="price-index-page">
    <!-- 搜索区域 -->
    <search-box class="operation-box">
      <div slot="left" class="">
        <div class="table-title">{{ $t('operation.gasPrice.priceTitle') }}</div>
      </div>
      <!-- 操作 -->
      <div v-if="isOperation" slot="right" class="operation-btn-box">
        <el-button v-if="list.length > 0" v-has-permission="['gasPrice:batchChangePrice']" :disabled="btnLoading" class="price-adjustment-btn" name="add-btn" type="success" @click.native="handleAdjustmentPrice">{{ $t('operation.gasPrice.adjustmentPrice') }}</el-button>
        <el-button v-has-permission="['gasPrice:ladderPriceAdd']" class="add-btn" name="add-btn" type="success" @click.native="showFormDialog(formStatusField.ADD, null)">{{ $t('add') }}</el-button>
      </div>
    </search-box>
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
      <!-- 索引 -->
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <!-- 固定价格 -->
      <el-table-column
        v-if="IS_FIXED_PRICE"
        key="fixedPrice"
        prop="fixedPrice"
        :label="$t('operation.gasPrice.fixedPrice')"
      >
      </el-table-column>
      <!-- 阶梯价格 -->
      <el-table-column
        v-else
        key="ladderPrice"
        prop=""
        :label="$t('operation.gasPrice.priceInfo')"
      >
        <template #default="scope">
          {{ scope.row | ladderPriceFormat }}
        </template>
      </el-table-column>
      <!-- 阶梯气量 -->
      <el-table-column
        v-if="!IS_FIXED_PRICE"
        key="ladderGas"
        prop=""
        :label="$t('operation.gasPrice.ladderInfo')"
      >
        <template #default="scope">
          {{ scope.row | ladderGasFormat }}
        </template>
      </el-table-column>
      <!-- 补差价格 -->
      <el-table-column
        key="compensationPrice"
        prop="compensationPrice"
        :label="$t('operation.gasPrice.compensationPrice')"
      >
      </el-table-column>
      <!-- 有效时间 -->
      <el-table-column
        key="validTime"
        prop=""
        :label="$t('operation.gasPrice.validTimeLabel')"
        width="180"
      >
        <template #default="scope">
          {{ scope.row.startTime | parseTime('{y}.{m}.{d}') }} —— {{ scope.row.endTime | parseTime('{y}.{m}.{d}') }}
        </template>
      </el-table-column>
      <!-- 切换时间 -->
      <el-table-column
        v-if="IS_HEATING_PRICE"
        key="cycleStartTime"
        prop="cycleStartTime"
        :label="$t('operation.gasPrice.cycleStartTime')"
        width="100"
      >
        <template #default="scope">
          {{ scope.row.cycleStartTime | parseTime('{y}.{m}.{d}') }}
        </template>
      </el-table-column>
      <!-- 采暖或者非采暖 -->
      <el-table-column
        v-if="IS_HEATING_PRICE"
        key="isHeating"
        prop="isHeating"
        :label="$t('operation.gasPrice.isHeatingLable')"
        width="140"
      >
        <template #default="scope">
          {{ scope.row.isHeating | isHeatingFormat }}
        </template>
      </el-table-column>
      <!-- 状态 -->
      <el-table-column
        key="dataStatus"
        prop="dataStatus"
        :label="$t('operation.gasPrice.dataStatus')"
        width="80"
      >
        <template #default="scope">
          <el-tag :type="scope.row.dataStatus | dataStatusClassFormat" effect="dark">{{ scope.row.dataStatus | dataStatusFormat }}</el-tag>
        </template>
      </el-table-column>
      <!-- 操作 -->
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="100"
      >
        <template #default="{ row }">
          <el-button type="primary" name="row-edit" @click.native.stop="showFormDialog(formStatusField.EDIT, row)">{{ $t('view') }}</el-button>
          <!-- <el-button type="danger" name="row-delete" @click.native.stop="handleDelete(row)">{{ $t('delete') }}</el-button> -->
        </template>
      </el-table-column>
      <template v-if="!isOperation" #empty>
        <b class="text-danger">{{ $t('operation.gasPrice.selectUseGasTypeHint') }}</b>
      </template>
    </el-table>
    <!--分页-->
    <pagination
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      :total="+total"
      @pagination="handleGetList"
    />

    <!-- 价格信息表单弹窗 -->
    <qc-dialog
      :width="formDialogWidth"
      :title="formDialogTitle"
      :visible="formDialogVisible"
      data-key="formDialogVisible"
      @close="dialogClose"
    >
      <!-- 固定价格表单 -->
      <fixed-price-form v-if="IS_FIXED_PRICE" :form-data="formData" :only-view="!!currentRow" @success="handleSaveSuccess"></fixed-price-form>
      <!-- 采暖价格表单 -->
      <heating-price-form v-else-if="IS_HEATING_PRICE" :form-data="formData" :only-view="!!currentRow" @success="handleSaveSuccess"></heating-price-form>
      <!-- 阶梯价格表单 -->
      <ladder-price-form v-else :form-data="formData" :only-view="!!currentRow" @success="handleSaveSuccess"></ladder-price-form>
    </qc-dialog>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import { awaitToJs } from '@/utils/index'
import { formStatusField } from '@/enums/form'
import { deleteStatusField, dataStatusMap, dataStatusClassMap } from '@/enums/common'
import { priceTypeField, isHeatingMap } from '@/enums/gasPrice'
import FixedPriceForm from './FixedPriceForm'
import HeatingPriceForm from './HeatingPriceForm'
import LadderPriceForm from './LadderPriceForm'
import { getPriceList, adjustmentPrice } from '@/api/operation/gasPrice'

export default {
  name: 'PriceIndex',
  components: {
    FixedPriceForm,
    HeatingPriceForm,
    LadderPriceForm,
  },
  filters: {
    // 阶梯气量格式化
    ladderGasFormat(row) {
      let result = []
      for (const key in row) {
        if (/^gas\d+$/g.test(key)) {
          const value = row[key]
          if (value > 0) {
            result.push(row[key] || '0.00')
          }
        }
      }
      return result.join(',')
    },
    // 阶梯价格格式化
    ladderPriceFormat(row) {
      let result = []
      for (const key in row) {
        if (/^price\d+$/g.test(key)) {
          const value = row[key]
          if (value > 0) {
            result.push(row[key] || '0.0000')
          }
        }
      }
      return result.join(',')
    },
    // 是否采暖格式化
    isHeatingFormat(value) {
      return isHeatingMap[+value]
    },
    // 数据状态格式化
    dataStatusFormat(value) {
      return dataStatusMap[+value]
    },
    // 数据状态class格式化
    dataStatusClassFormat(value) {
      return dataStatusClassMap[+value]
    },
  },
  mixins: [commonMixin, listMixin],
  props: {
    // 用气类型id
    useGasTypeId: {
      type: [String, Number],
      default: ''
    },
    // 气价类型
    priceType: {
      type: String,
      default: ''
    },
  },
  data() {
    this.formStatusField = formStatusField
    this.dataStatusMap = dataStatusMap
    return {
      searchForm: {
        useGasTypeId: null,
        dataStatus: null,
        deleteStatus: deleteStatusField.DELETE_INVALID
      }
    }
  },
  computed: {
    // 判断是否可以操作
    isOperation() {
      return this.useGasTypeId
    },
    // 是否是采暖价
    IS_HEATING_PRICE() {
      return this.priceType === priceTypeField.HEATING_PRICE
    },
    // 是否是阶梯价格
    IS_LADDER_PRICE() {
      return this.priceType === priceTypeField.LADDER_PRICE
    },
    // 是否是固定价格
    IS_FIXED_PRICE() {
      return this.priceType === priceTypeField.FIXED_PRICE
    },
    // 生成传递的formData
    formData() {
      const defaultData = { useGasTypeId: this.useGasTypeId, priceType: this.priceType }
      return this.currentRow ? { ...defaultData, ...this.currentRow } : defaultData
    },
    // form表单弹出框标题
    formDialogTitle() {
      let result = this.$t('add')
      if (this.currentRow) {
        result = this.$t('view')
      }
      if (this.IS_FIXED_PRICE) {
        result += this.$t('operation.gasPrice.fixedPrice')
      } else if (this.IS_LADDER_PRICE) {
        result += this.$t('operation.gasPrice.ladderPrice')
      } else if (this.IS_HEATING_PRICE) {
        result += this.$t('operation.gasPrice.heatingPrice')
      }
      return result
    },
    // form表单弹出框宽度
    formDialogWidth() {
      let result = 600
      if (this.IS_FIXED_PRICE) {
        result = 600
      } else if (this.IS_LADDER_PRICE) {
        result = 600
      } else if (this.IS_HEATING_PRICE) {
        result = 1100
      }
      return result
    },

  },
  watch: {
    // 监听用气类型id
    useGasTypeId: {
      handler(value) {
        this.initData()
      },
      immediate: true
    }
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
      const { useGasTypeId } = this
      if (!useGasTypeId) {
        this.list = []
      } else {
        this.searchForm.useGasTypeId = this.useGasTypeId
        await this.getList()
      }
    },
    // 获取列表
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
        // deleteStreet({ ids }).then((result) => {
        //   this.btnLoading = true
        //   const { isSuccess, data } = result.data
        //   if (isSuccess) {
        //     resolve(true)
        //   } else {
        //     resolve(false)
        //   }
        // }).catch(() => {
        //   this.btnLoading = true
        //   resolve(false)
        // })
      })
    },

    //删除街道(乡镇)信息
    async handleDelete(row) {
      const confirmResult = await awaitToJs(this.$confirm(this.$t('operation.gasPrice.deleteConfirm'), this.$t('common.tips'), {
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

    // 批量远程调价
    handleAdjustmentPrice() {
      this.loading = true
      this.btnLoading = true
      adjustmentPrice({ curGasTypeId: this.useGasTypeId }).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success(this.$t('operation.gasPrice.adjustmentPriceSuccess'))
        }
      })
      .catch(() => {

      })
      .finally(() => {
        this.loading = false
        this.btnLoading = false
      })
    },
  }
}
</script>

<style scoped lang="scss">

</style>
