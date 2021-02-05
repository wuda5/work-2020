<!--收费配置-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">收费配置</span>
      </div>

      <search-box>
        <div slot="left">
          <!--search-->
          <el-input v-model="search.model.itemName" placeholder="请输入收费项名称" name="itemName" />
          <el-button name="search" type="primary" @click="getPageList">查询</el-button>
        </div>
        <div slot="right">
          <div class="text-right">
            <!-- <el-button
              v-has-permission="['charge:enable']"
              name="enable"
              type="primary"
              @click="toEnable"
            >启用</el-button>
            <el-button
              v-has-permission="['charge:disable']"
              name="disable"
              type="warning"
              @click="toDisable"
            >禁用</el-button> -->
            <!--<el-button
              v-has-permission="['charge:delete']"
              name="delete"
              type="danger"
              @click="deleteItems"
            >
              删除
            </el-button>-->
            <el-button
              v-has-permission="['charge:add']"
              name="addNew"
              type="success"
              @click="addNew"
            >新增</el-button>
          </div>
        </div>
      </search-box>
      <!--数据-->
      <el-table
        ref="multipleTable"
        border
        :data="tableData"
        tooltip-effect="dark"
        style="width: 100%; margin-top: 15px"
        @filter-change="filterChange"
      >
        <!-- <el-table-column type="selection" width="55" /> -->
        <!--序号-->
        <el-table-column type="index" label="序号" width="55" />
        <!--收费项名称-->
        <el-table-column prop="itemName" label="收费项名称" width="120" />
        <!--收费场景-->
        <el-table-column prop="scenesCode" label="收费场景" width="100">
          <template slot-scope="{ row }">{{ dictMap.SCENES[row.sceneCode] }}</template>
        </el-table-column>
        <!--收费期限-->
        <el-table-column prop="chargePeriod" label="收费期限" width="80">
          <template slot-scope="{ row }">{{ row.chargePeriod === 0 ? '无限期' : row.chargePeriod+'年' }}</template>
        </el-table-column>
        <!--收费频次-->
        <el-table-column prop="chargeFrequency" label="收费频次" width="80">
          <template
            slot-scope="{row}"
          >{{ row.chargeFrequency ? dictMap.CHARGE_FREQUENCY[row.chargeFrequency] : '' }}</template>
        </el-table-column>
        <!--金额-->
        <el-table-column prop="money" label="金额" width="100" />
        <!--金额方式-->
        <el-table-column prop="moneyMethod" label="金额方式" width="80">
          <template
            slot-scope="{row}"
          >{{ row.moneyMethod ? dictMap.MONEY_METHOD[row.moneyMethod] : '' }}</template>
        </el-table-column>
        <!--周期值-->
        <el-table-column prop="cycleValue" label="周期值" width="60">
          <template slot-scope="{row}">{{ row.zeroTaxStatus === 0 ? '是' : '否' }}</template>
        </el-table-column>
        <!--增值税普税税率-->
        <el-table-column prop="vatGeneralRate" label="增值税普税税率" width="110" />
        <!--财务科目-->
        <el-table-column prop="financialSubject" label="财务科目" width="120">
          <template
            slot-scope="{row}"
          >{{ row.financialSubject ? dictMap.FINANCIAL_SUBJECT[row.financialSubject] : '' }}</template>
        </el-table-column>
        <!--税收分类编码-->
        <el-table-column prop="taxCategoryCode" label="税收分类编码" width="100" />
        <!--享受优惠-->
        <el-table-column prop="favouredStatus" label="享受优惠" width="70">
          <template slot-scope="{row}">
            <el-tag type="info">{{ row.favouredStatus === 0? '是':'否' }}</el-tag>
          </template>
        </el-table-column>
        <!--优惠政策内容-->
        <!--<el-table-column prop="favouredPolicy" label="优惠政策内容" width="100"/>-->
        <!--零税率-->
        <el-table-column prop="zeroTaxStatus" label="零税率" width="60">
          <template slot-scope="{row}">
            <el-tag type="info">{{ row.zeroTaxStatus === 0? '是':'否' }}</el-tag>
          </template>
        </el-table-column>
        <!--企业自编码-->
        <el-table-column prop="customCode" label="企业自编码" width="120" />
        <!--编码版本号-->
        <el-table-column prop="codeVersion" label="编码版本号" width="120" />
        <!--用气类型-->
        <!-- <el-table-column prop="useGasTypes" label="用气类型" width="70">
          <template slot-scope="{row}">
            <template v-if="row.useGasTypes">
              <el-tag v-for="(item, index) in JSON.parse(row.useGasTypes)" :key="index" type="info">{{ item.use_gas_type_name }}</el-tag>
            </template>
          </template>
        </el-table-column> -->
        <!--税扣除额-->
        <el-table-column prop="taxDeductionMoney" label="税扣除额" width="70" />
        <!--开始时间-->
        <el-table-column prop="startTime" label="开始时间" width="90" />
        <!--状态-->
        <!-- <el-table-column
          :filter-multiple="false"
          column-key="dataStatus"
          :filters="[
            { text: $t('common.status.valid'), value: 1 },
            { text: $t('common.status.invalid'), value: 0 }
          ]"
          class-name="status-col"
          prop="dataStatus"
          label="状态"
          fixed="right"
        >
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.dataStatus"
              :disabled="!checkPermission(['charge:enable', 'charge:disable'])"
              active-color="#67C23A"
              :title="scope.row.dataStatus ? $t('enable') : $t('disable')"
              inactive-color="#909399"
              :active-value="1"
              :inactive-value="0"
              @change="statusChange($event, scope.$index)"
            />
          </template>
        </el-table-column> -->
        <!--操作-->
        <el-table-column fixed="right" :label="$t('operations')" width="240">
          <template slot-scope="{ row, $index }" class="btns">
            <el-button
              v-has-permission="['charge:update']"
              style="margin-right: 8px;"
              name="rowEdit"
              type="primary"
              @click="edit(row)"
            >{{ $t("edit") }}</el-button>
            <template v-if="row.operate">
              <el-popconfirm
                v-if="row.sceneCode === 'OTHER'"
                title="确定要删除当前项吗?"
                style="margin-left: 10px;"
                @onConfirm="() => forbidden($index)"
              >
                <el-button slot="reference" type="danger">删除</el-button>
              </el-popconfirm>
              <template v-if="row.sceneCode !== 'OTHER'">
                <el-button v-if="row.dataStatus === 1" :loading="row.loading" type="warning" @click="()=> statusChange(row)">
                  {{ $t('disable') }}
                </el-button>
                <el-button v-else :loading="row.loading" type="primary" @click="() => statusChange(row)">
                  {{ $t('enable') }}
                </el-button>
              </template>
            </template>
          </template>
        </el-table-column>

        <el-divider></el-divider>
      </el-table>

      <!--分页-->
      <pagination
        name="pagination"
        :total="total"
        :page-sizes="[10, 20, 30]"
        :limit="search.size"
        @pagination="pagination"
      />

      <!--弹窗------------------------------------------>
      <!-- 添加|编辑 用户-->
      <el-dialog width="600px" :title="formData ? '编辑收费项' : '新增收费项'" :visible.sync="showAdd">
        <edit v-if="showAdd" :form-data="formData" @close="endEdit" />
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import apiChargeConfig from '@/api/system/chargeConfig'
import Edit from './components/Edit'

export default {
  name: 'ChargeConfig',
  components: {
    Edit,
  },
  data() {
    return {
      showAdd: false,
      params: null,
      visible: false,
      curStatus: '',
      search: {
        current: 1,
        map: {},
        model: {
          dataStatus: '', // status 状态  1：启用 0：停用
          itemName: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      formData: null, // 需要编辑的数据 props传递
      tableData: [],
      total: 0,
      // multipleSelection: [],
    }
  },
  created() {
    // 获取列表
    this.getPageList()
  },
  mounted() {},
  methods: {
    // 多选
    // handleSelectionChange(val) {
    //   this.multipleSelection = val
    // },

    // 字段赛选过滤
    filterChange(filters) {
      for (const key in filters) {
        if (key.includes('.')) {
          const val = {}
          val[key.split('.')[1]] = filters[key][0]
          this.search.model[key.split('.')[0]] = val
        } else {
          this.search.model[key] = filters[key][0]
        }
      }
      this.getPageList()
    },

    // 分页数据改变
    pagination(pageData) {
      this.search.size = pageData.size
      this.search.current = pageData.current
      this.getPageList()
    },

    // 结束编辑
    endEdit() {
      this.dialogClose('showAdd')
      this.getPageList()
    },
    forbidden(index) {
      let submitData = this.tableData[index]
      submitData.scenes = JSON.stringify(submitData.scenes)
      // 禁用
      submitData.deleteStatus = 1
      apiChargeConfig
        .update(submitData)
        .then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            this.msg(`删除成功`, 'success')
            this.getPageList()
          }
        })
        .catch(this.getPageList())
    },
    // 转态改版
    statusChange(row) {
      let submitData = {
        ...row
      }
      submitData.scenes = JSON.stringify(submitData.scenes)
      row.loading = true
      if (row.dataStatus === 0) {
        // 启用
        submitData.dataStatus = 1
        apiChargeConfig
          .update(submitData)
          .then(res => {
            const res1 = res.data
            if (res1.isSuccess) {
              this.msg(`启用成功`, 'success')
              this.getPageList()
            }
          })
          .catch(this.getPageList())
          .finally(() => {
            row.loading = false
          })
      } else {
        // 禁用
        submitData.dataStatus = 0
        apiChargeConfig
          .update(submitData)
          .then(res => {
            const res1 = res.data
            if (res1.isSuccess) {
              this.msg(`禁用成功`, 'success')
              this.getPageList()
            }
          })
          .catch(this.getPageList())
          .finally(() => {
            row.loading = false
          })
      }
    },

    // 过滤状态
    filterStatus(status) {
      // status 状态  1：启用 0：停用
      this.curStatus = status
      this.search.model.dataStatus = status
      this.getPageList()
    },

    // 添加按钮点击
    addNew() {
      this.formData = null
      this.dialogOpen('showAdd')
    },

    // 编辑按钮点击
    edit(row) {
      this.formData = JSON.parse(JSON.stringify(row))
      this.dialogOpen('showAdd')
    },

    // 获取列表数据
    getPageList() {
      apiChargeConfig.page(this.search).then(res => {
        const res1 = res.data
        if (res1.isSuccess) {
          let ret = res1.data.records
          this.tableData = ret.map(item => ({
            ...item,
            loading: false
          }))
          this.total = parseInt(res1.data.total)
        }
      })
    },

    // 删除数据方法
    delData(ids) {
      apiChargeConfig.delete({ ids }).then(res => {
        const res1 = res.data
        if (res1.isSuccess) {
          this.msg('删除数据成功', 'success')
          this.getPageList()
        }
      })
    },

    // 删除单条数据
    deleteItem(id) {
      let ids = []
      ids.push(id)
      this.delData(ids)
    },

    // 删除多条数据
    // deleteItems() {
    //   if (this.multipleSelection.length === 0) {
    //     this.msg('请选择您要删除的收费项', 'warning')
    //     return
    //   }
    //   this.confirm('确定要删除已选收费项?', '警告', '确定', '取消', 'warning')
    //     .then(() => {
    //       let ids = []
    //       this.multipleSelection.forEach(item => {
    //         ids.push(item.id)
    //       })
    //       this.delData(ids)
    //     })
    //     .catch(() => {
    //       this.msg('已取消')
    //     })
    // },

    // 启用
    // toEnable(record) {
    //   this.confirm('确定要启用已选收费项?', '确认', '确定', '取消', 'warning')
    //     .then(() => {
    //       let items = []
    //       this.multipleSelection.forEach(item => {
    //         items.push({
    //           id: item.id,
    //           dataStatus: 1,
    //         })
    //       })
    //       apiChargeConfig.update(items).then(() => {
    //         this.getPageList()
    //       })
    //     })
    //     .catch(() => {
    //       this.msg('已取消')
    //     })
    // },

    // 禁用
    // toDisable() {
    //   if (this.multipleSelection.length === 0) {
    //     this.msg('请选择您要禁用的收费项', 'warning')
    //     return
    //   }
    //   this.confirm('确定要禁用已选收费项?', '确认', '确定', '取消', 'warning')
    //     .then(() => {
    //       let items = []
    //       this.multipleSelection.forEach(item => {
    //         items.push({
    //           id: item.id,
    //           dataStatus: 0,
    //         })
    //       })
    //       apiChargeConfig.updateBatch(items).then(() => {
    //         this.getPageList()
    //       })
    //     })
    //     .catch(() => {
    //       this.msg('已取消')
    //     })
    // },
  },
}
</script>

<style lang="scss" scoped>
  .el-input {
    width: auto;
  }

  ::v-deep .el-table {
    border: 1px solid #eee;
    border-bottom: none;
  }

  .btns {
    line-height: 20px;

    svg {
      font-size: 20px;
      margin-right: 10px;
    }
  }

  ::v-deep thead {
    tr {
      background: #f5f7fa;

      th {
        background: transparent;
      }
    }
  }
</style>
