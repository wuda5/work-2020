<!--扫码入库-->
<template>
  <div class="ScanMeterToStore-page">
    <strong class="text-danger" style="margin-bottom: 5px; display: block;">{{ $t('meterInfo.inputBaseInfoHint') }}</strong>
    <!-- 表具基本信息 -->
    <el-card class="form-card" shadow="never">
      <template v-slot:header>
        <span class="card-title">{{ $t('meterInfo.meterBaseInfo') }}</span>
      </template>
      <!-- 表具表单信息区域 -->
      <meter-form ref="meterFormRef" :form-data="currentRow" :type="2" />

    </el-card>
    <div class="el-form-item" style="margin: 10px 0 0 0">
      <el-input v-model="gasMeterNumber" size="medium" :placeholder="$t('meterInfo.scanPlaceholder')" @change="handleGasMeterNumberChange"></el-input>
      <p class="hint-text">{{ $t('meterInfo.scanHint') }}</p>
    </div>
    <!-- 入库列表区域 -->
    <el-card class="list-card" shadow="never">
      <template v-slot:header>
          <span class="card-title">{{ $t('meterInfo.scanMeterList') }}</span>
      </template>
      <!-- 上传验证失败提示 -->
      <el-alert v-show="intersectionGasMeter.length > 0" type="error" title="" :closable="false" show-icon style="margin-bottom: 10px">
        <template v-slot:title>
          {{ $t('meterInfo.repeatingMeterTitle') }}
        </template>
        {{ $t('meterInfo.repeatingMeterBody') }}
        <template v-for="(item, index) in intersectionGasMeter">
          <span :key="index">【{{ item.gasMeterNumber }}】</span>
        </template>
      </el-alert>
      <!-- 操作区域 -->
      <search-box class="search-box operation-box">
        <template v-slot:left>
          <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
            <!-- 活动名称 -->
            <el-form-item label="" prop="gasMeterNumber">
              <el-input v-model="searchForm.gasMeterNumber" clearable :placeholder="$t('meterInfo.gasMeterNumber')">
              </el-input>
            </el-form-item>
            <!-- 操作 -->
            <el-form-item label="" prop="dataStatus">
              <el-button type="primary" name="meter-search" icon="el-icon-search" class="search-btn feeReduce-search" @click.native="handleSearch">{{ $t('search') }}</el-button>
              <el-button type="warning" name="meter-search-reset" icon="el-icon-refresh-left" class="search-reset-btn" @click.native="handleResetSearch(searchFormRef)">{{ $t('reset') }}</el-button>
            </el-form-item>
          </el-form>
        </template>
        <template v-slot:right>
          <el-button type="danger" :disabled="btnLoading" :loading="submitLoading" @click="handleBatchDelete">批量删除</el-button>
          <el-button type="primary" :disabled="btnLoading" :loading="submitLoading" @click="handleBatchSave">批量保存</el-button>
          <el-button type="primary" :disabled="btnLoading" :loading="submitLoading" @click="handleAllSave">保存全部</el-button>
        </template>
      </search-box>
      <!--入库列表-->
      <el-table
        ref="multipleTable"
        :data="list"
        tooltip-effect="dark"
        stripe
        border
        :highlight-current-row="false"
        @selection-change="handleSelectionChange"
      >
        <el-table-column
          type="selection"
          width="40"
        >
        </el-table-column>
        <!-- 序号 -->
        <el-table-column
          type="index"
          :label="$t('table.index')"
        >
        </el-table-column>
        <!-- 气表编号 -->
        <el-table-column
          prop="gasMeterNumber"
          :label="$t('meterInfo.gasMeterNumber')"
        >
        </el-table-column>
        <!-- 气表厂家 -->
        <el-table-column
          prop="gasMeterFactoryName"
          :label="$t('meterInfo.gasMeterFactoryName')"
        >
        </el-table-column>
        <!-- 气表版号 -->
        <el-table-column
          prop="gasMeterVersionName"
          :label="$t('meterInfo.gasMeterVersionName')"
        >
        </el-table-column>
        <!-- 气表型号 -->
        <el-table-column
          prop="gasMeterModelName"
          :label="$t('meterInfo.gasMeterModelName')"
        >
        </el-table-column>
        <!-- 气表类型 -->
        <el-table-column
          prop="gasMeterTypeName"
          :label="$t('meterInfo.gasMeterTypeName')"
        >
        </el-table-column>
        <!-- 操作 -->
        <el-table-column
          :label="$t('table.operation')"
          width="90"
        >
          <template #default="{ row, $index }">
            <el-button type="primary" name="row-delete" @click="handleDelete(row, $index)">{{ $t('delete') }}</el-button>
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
  </div>
</template>

<script>
import { cloneDeep, intersection, intersectionWith, isEqual, differenceWith, uniqueId } from 'lodash'
import meterForm from './MeterToStore.vue'
import listMixin from '@/mixins/list'
import { initQueryParams, initListData } from '@/utils/commons'
import { saveData } from '@/api/meterInfo/index'

export default {
  name: 'ScanMeterToStore',
  components: {
    meterForm
  },
  mixins: [listMixin],
  data() {
    return {
      currentRow: null,
      meterForm: null,
      gasMeterNumber: null,
      intersectionGasMeter: [], // 重复表具编号
      ...initListData({
        allList: [], // 所有没有分页的数据
        queryParams: initQueryParams({
          size: 10,
        }),
        searchForm: {
          gasMeterNumber: null
        },
      }),
      multipleSelection: [],
      btnLoading: false,
      submitLoading: false,
    }
  },
  watch: {
  },
  methods: {
    getList() {
      return new Promise((resolve) => {
        const { current, size } = this.queryParams
        const { gasMeterNumber } = this.searchForm
        let allList = cloneDeep(this.allList)
        if (gasMeterNumber) {
          allList = allList.filter((item) => item.gasMeterNumber === gasMeterNumber)
        }
        const total = allList.length
        this.total = total
        this.list = +size > 0 ? (allList.splice((+(current || 1) - 1) * +(size || 100), size)) : allList
        resolve(true)
      })
    },
    toggleSelection(rows) {
      if (rows) {
        rows.forEach(row => {
          this.$refs.multipleTable.toggleRowSelection(row)
        })
      } else {
        this.$refs.multipleTable.clearSelection()
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    // 扫码发生变化
    handleGasMeterNumberChange(value) {
      console.log(value)
      if (!value) {
        return false
      }
      this.$refs?.meterFormRef?.submitFormValidate().then((result) => {
        console.log('result', result)
        const gasMeterNumberArr = value.split(',')
        // 只比较气表表身号
        // const intersectionGasMeterNumber = intersection(gasMeterNumberArr, this.allList.map((item) => item.gasMeterNumber))
        const awaitAddGasMeter = gasMeterNumberArr.map((gasMeterNumber) => {
          const cloneForm = cloneDeep(result)
          cloneForm.gasMeterNumber = gasMeterNumber
          // cloneForm.id = uniqueId('meter_')
          return cloneForm
        })
        // 整个表具信息一起比较
        const intersectionGasMeter = intersectionWith(awaitAddGasMeter, this.allList, isEqual)
        this.intersectionGasMeter = intersectionGasMeter
        // console.log('intersectionGasMeter', intersectionGasMeter)
        // 找出没有重复的需要添加的数据
        const addGasMeter = differenceWith(awaitAddGasMeter, intersectionGasMeter, isEqual)
        // console.log('addGasMeter', addGasMeter)
        if (addGasMeter.length > 0) {
          this.allList.unshift(...addGasMeter)
          this.$refs[this.searchFormRef]?.resetFields?.()
          this.queryParams.current = 1
          this.$nextTick(() => {
            this.getList()
          })
        }
      }).catch((err) => {
        // console.log('err', err)
      }).finally(() => {
        setTimeout(() => {
          this.gasMeterNumber = null
        })
      })
    },

    // 执行操作后重新设置重复项数据
    setIntersectionGasMeter() {
      this.intersectionGasMeter = intersectionWith(this.intersectionGasMeter, this.allList.map((item) => item.gasMeterNumber), isEqual)
    },
    
    // 公共保存表具信息函数
    saveMeterData(data) {
      return new Promise((resolve) => {
        this.btnLoading = true
        this.submitLoading = true
        saveData(data).then((result) => {
          const { isSuccess } = result.data
          if (isSuccess) {
            // 传递保存成功时间回父级组件
            this.$emit('success')
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => {
          this.btnLoading = false
          this.submitLoading = false
        })
      })
    },

    // 批量保存
    async handleBatchSave() {
      if (this.multipleSelection.length === 0) {
        this.$message.error(this.$t('meterInfo.selectMeterHint'))
        return
      }
      const cloneData = cloneDeep(this.multipleSelection)
      const result = await this.saveMeterData(cloneData.map((item) => {
        delete item.id
        return item
      }))
      if (result) {
        this.$message.success(this.$t('saveSuccess'))
        this.allList = differenceWith(this.allList, this.multipleSelection, isEqual)
        this.$nextTick(() => {
          this.setIntersectionGasMeter()
          this.getList()
        })
      }
    },

    // 保存全部表具
    async handleAllSave() {
      const allData = this.allList
      if (allData.length === 0) {
        this.$message.error(this.$t('meterInfo.noneMeterHint'))
        return
      }
      const cloneData = cloneDeep(allData)
      const result = await this.saveMeterData(cloneData.map((item) => {
        delete item.id
        return item
      }))
      if (result) {
        this.$message.success(this.$t('saveSuccess'))
        this.allList = []
        this.$nextTick(() => {
          this.setIntersectionGasMeter()
          this.getList()
        })
      }
    },

    // 单个删除需要入库的表具
    handleDelete(row, index) {
      this.allList.splice(index, 1)
      this.$nextTick(() => {
        this.setIntersectionGasMeter()
        this.getList()
      })
    },

    // 批量删除
    handleBatchDelete () {
      if (this.multipleSelection.length === 0) {
        this.$message.error(this.$t('meterInfo.selectMeterHint'))
        return
      }
      this.multipleSelection.forEach((selection) => {
        const index = this.allList.findIndex((item) => isEqual(item, selection))
        if (index !== -1) {
          this.allList.splice(index, 1)
        }
      })
      this.$nextTick(() => {
        this.setIntersectionGasMeter()
        this.getList()
      })
    },

    // 搜索
    handleSearch() {
      this.getList()
    },

    // 重置搜索
    handleResetSearch(ref) {
      this.$refs[ref]?.resetFields?.()
      this.queryParams.current = 1
      this.$nextTick(() => {
        this.getList()
      })
    }
  }
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px 15px;
}

.jh-text {
  .el-form-item {
    width: calc(100% / 3);
    margin-bottom: 10px;
  }
}
.form-card {
  ::v-deep {
    .qc-form {
      padding-bottom: 0;
      .el-form-item {
        width: calc(100% / 5);
      }
    }
  }
}
</style>
