<!--短信配置-->
<template>
  <div class="qc-main">
    <!-- 签名配置 -->
    <el-card shadow="never" class="no-border">
      <!-- header -->
      <search-box>
        <div slot="left">
          <div slot="header">
            <span class="card-title">签名配置</span>
            <span class="redFont">注意：添加签名认证通过后才能进行模板添加哦！</span>
          </div>
        </div>
        <div slot="right">
          <el-button v-if="!signData" v-hasPermission="['SMSConfig:add']" name="addNew" type="success" @click="addSign()">添加签名</el-button>
          <!-- 提示初始化 -->
          <el-button v-if="signData && allTypeTotal === 0" v-hasPermission="['SMSConfig:init']" @click="initSMSData">初始化短信模板</el-button>
        </div>
      </search-box>
      <!-- 签名内容 只显示一条 -->
      <el-table
        v-if="signData"
        ref="signTable"
        :data="[signData]"
        tooltip-effect="dark"
        border
        style="width: 100%; margin-top: 15px"
      >
        <el-table-column prop="documentType" label="证明类型" min-width="150">
          <template slot-scope="{ row }">{{ documentTypeMap[row.documentType] }}</template>
        </el-table-column>
        <el-table-column prop="signName" label="签名内容" min-width="150" />
        <el-table-column prop="createTime" label="创建时间" min-width="150" />
        <el-table-column prop="signStatus" label="签名审核状态" min-width="150">
          <template slot-scope="{ row }">{{ signStatusMap[row.signStatus] }}</template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" min-width="300">
          <div slot-scope="{ row }" class="btns">
            <el-button v-if="row.signStatus !== 0" v-hasPermission="['SMSConfig:edit']" type="primary" @click="editSign">编辑</el-button>
            <!-- <el-button type="danger" @click="deleteSign(row.id)">删除</el-button> -->
          </div>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 短信配置 -->
    <el-card
      v-if="signData && signData.signStatus === 0"
      shadow="never"
      class="no-border"
      style="margin-top: 10px"
    >
      <div slot="header">
        <span class="card-title">短信配置</span>
      </div>

      <!-- search -->
      <search-box>
        <!-- form -->
        <div slot="left">
          <el-button
            v-for="item in dict.SMS_TYPE"
            :key="item.id"
            :type="item.id === search.model.templateTypeId ? 'primary' : ''"
            @click="switchSmsType(item)"
          >
            {{ item.name }}
          </el-button>
        </div>
        <!-- btns -->
        <div slot="right">
          <el-button
            v-has-permission="['charge:add']"
            name="addNew"
            type="success"
            @click="addNew()"
            >新增</el-button>
        </div>
      </search-box>

      <!--数据-->
      <el-table
        ref="multipleTable"
        :data="tableData"
        tooltip-effect="dark"
        border
        row-key="id"
        style="width: 100%; margin-top: 15px"
        @filter-change="filterChange"
      >
        <!-- 序号 -->
        <el-table-column type="index" label="#" width="55" />
        <!-- 使用场景 -->
        <el-table-column prop="templateTypeName" label="使用场景" min-width="150" />
        <!-- 模板名称 -->
        <el-table-column prop="name" label="模板名称" min-width="150" />
        <!-- 使用状态 -->
        <el-table-column
          prop="isOpen'"
          label="使用状态"
          min-width="80"
          :filter-multiple="false"
          column-key="templateStatus"
          width="70px"
        >
          <template slot-scope="{ row }">
            <!-- <el-switch
              v-model="row.templateStatus"
              active-color="#67C23A"
              :active-value="0"
              :inactive-value="1"
              inactive-color="#909399"
              @change="statusChange($event, row.id)"
            ></el-switch> -->
            <el-tag v-if="row.templateStatus === 1" type="info">未使用</el-tag>
            <el-tag v-if="row.templateStatus === 0" type="success">使用中</el-tag>
          </template>
        </el-table-column>

        <!-- 审核状态 -->
        <el-table-column
          prop="examineStatus"
          label="审核状态"
          min-width="100"
          :render-header="renderHeader"
        >
          <!-- 0-通过，1-未审核，-1未通过 -->
          <template slot-scope="{ row }">
            <el-tag v-if="row.examineStatus === 0" type="success">通过</el-tag>
            <el-tag v-if="row.examineStatus === 1" type="default">未审核</el-tag>
            <el-tag v-if="row.examineStatus === -1" type="warning">未通过</el-tag>
          </template>
        </el-table-column>

        <!-- 操作 -->
        <el-table-column fixed="right" label="操作" min-width="300">
          <div slot-scope="{ row }" class="btns">
            <!-- edit -->
            <el-button
              v-if="row.examineStatus !== 0"
              type="primary"
              :disabled="row.examineStatus === 0"
              @click="edit(row)"
              >编辑</el-button>
            <!-- test -->
            <el-button v-if="canUseTest(row)" type="success" @click="testMSG(row)">测试</el-button>
            <!-- delete -->
            <el-button type="danger" @click="deleteMSG(row)">删除</el-button>
            <!-- set default -->
            <el-button v-if="row.examineStatus === 0" type="primary" @click="setDefault(row.id)">设置为默认</el-button>
          </div>
        </el-table-column>
      </el-table>

      <!--分页-->
      <pagination
        name="pagination"
        :total="total"
        :page-sizes="[10, 20, 30]"
        :limit="search.size"
        @pagination="pagination"
      />
    </el-card>

    <!--弹窗------------------------------------------>
    <!-- 添加|编辑 短信模板-->
    <el-dialog
      v-if="showSMSEdit"
      width="550px"
      :close-on-click-modal="false"
      :title="formData ? '编辑短信模板' : '添加短信模板'"
      :visible.sync="showSMSEdit"
    >
      <edit :form-data="formData" @close="endEditSMS" />
    </el-dialog>

    <!-- 测试短信模板 -->
    <el-dialog v-if="showTest" width="550px" title="测试短信模板" :visible.sync="showTest">
      <test :form-data="formData" />
    </el-dialog>

    <!-- 短信签名认证 -->
    <el-dialog
      v-if="showSign"
      width="300px"
      :title="signData ? '修改签名认证' : '添加签名认证'"
      :visible.sync="showSign"
    >
      <SMSSign :form-data="signData" @close="endEditSign" />
    </el-dialog>
  </div>
</template>

<script>
import apiSMS from '@/api/system/SMSConfig'
import Edit from './Edit'
import Test from './Test'
import SMSSign from './SMSSign'

export default {
  name: 'SMSConfig',
  components: {
    Edit,
    Test,
    SMSSign,
  },
  data() {
    return {
      showSMSEdit: false, // 显示添加|编辑
      showTest: false, // 显示测试弹窗
      showSign: false, // 显示短信认证添加 | 编辑
      curStatus: '', // 当前过滤状态 启用 | 禁用 | 全部

      allTypeTotal: 0, // 短信总条数，用于判断是否显示初始化模板内容

      // search
      search: {
        current: 1,
        map: {},
        model: {
          templateTypeId: '',
          // templateStatus: '', // 0：启用 1:禁用 '':全部
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      tableData: [],
      total: 0,
      formData: null,

      // 获取签名查询条件
      signSearch: {
        current: 1,
        map: {},
        model: {
          deleteStatus: 0,
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },

      // 签名数据
      signData: null,

      // ======================
      signStatusMap: {
        0: '通过',
        1: '待审核',
        '-1': '未通过',
      },
      // 证明类型
      documentTypeMap: {
        0: '三证合一',
        1: '企业营业执照',
        2: '组织机构代码证书',
        3: '社会信用代码证书',
      },
    }
  },
  created() {
    this.getSignPage()
    this.getPageList()
  },
  mounted() {},
  methods: {
    // 分页数据改变
    pagination(pageData) {
      this.search.size = pageData.size
      this.search.current = pageData.current
      this.getPageList()
    },

    // 获取列表数据
    getPageList() {
      apiSMS.page(this.search).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = parseInt(data.total)

          if (this.search.model.templateTypeId === '') {
            this.allTypeTotal = parseInt(data.total)
          }
        }
      })
    },

    // 更改短息分类
    switchSmsType(item) {
      this.search.model.templateTypeId = item.id
      this.getPageList()
    },

    // 过滤
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

    // 添加按钮点击
    addNew() {
      this.formData = null
      this.dialogOpen('showSMSEdit')
    },

    // 修改
    edit(data) {
      this.formData = data
      this.dialogOpen('showSMSEdit')
    },

    // 添加|编辑 关闭
    endEditSMS() {
      this.dialogClose('showSMSEdit')
      this.getPageList()
    },

    // 表头：审核状态 添加刷新按钮
    renderHeader() {
      return (
        <div>
          审核状态
          <i class="fresh el-icon-refresh" on-click={() => this.getPageList()}></i>
        </div>
      )
    },

    // 测试使用条件
    canUseTest(row) {
      let flag = false
      /* if (!this.signData) {
        flag = false;
      } */
      if (this.signData && this.signData.signStatus === 0 && row.examineStatus === 0) {
        flag = true
      }
      return flag
    },

    // 测试
    testMSG(row) {
      this.formData = row
      this.dialogOpen('showTest')
    },

    // 转态改版（）
    statusChange(value, id) {
      let updateStatusData = {
        templateStatus: value,
        id,
      }

      apiSMS
        .updateStatus(updateStatusData)
        .then(res => {
          const res1 = res.data
          if (res1.isSuccess) {
            this.msg('更新成功', 'success')
            this.getPageList()
          }
        })
        .catch(this.getPageList())
    },

    // 设置默认模板
    statusChange1(id) {
      let updateStatusData = {
        templateStatus: 0,
        id,
      }

      apiSMS
        .updateStatus(updateStatusData)
        .then(res => {
          const res1 = res.data
          if (res1.isSuccess) {
            this.msg('设置成功', 'success')
            this.getPageList()
          }
        })
        .catch(this.getPageList())
    },

    // deleteMSG
    deleteMSG(row) {
      if (row.templateStatus === 0) {
        this.msg('使用中的模板，不能删除', 'error')
        return false
      }
      this.$confirm('确认删除该模板？')
        .then(() => {
          let ids = [row.id]
          apiSMS.delete([row.id]).then(res => {
            const res1 = res.data
            if (res1.isSuccess) {
              this.msg('删除成功')
              this.getPageList()
            }
          })
        })
        .catch(() => {
          return
        })
    },

    // 设置默认
    setDefault(id) {
      apiSMS
        .setDefaultSms({ id })
        .then(res => {
          let { isSuccess } = res.data
          if (isSuccess) {
            this.msg('设置成功', 'success')
            this.getPageList()
          }
        })
        .catch(this.getPageList())
    },

    // ===================================

    // 获取签名状态
    getSignPage() {
      apiSMS
        .signPage(this.signSearch)
        .then(res => {
          const res1 = res.data
          if (res1.isSuccess) {
            this.signData = res1.data.records[0] || null
          }
        })
        .catch(() => {
          // this.getSignPage();
        })
    },

    // 删除签名
    deleteSign(id) {
      apiSMS.signDelete({ ids: [id] }).then(res => {
        if (res.data.isSuccess) {
          this.msg('删除成功', 'success')
          this.signData = null
          this.getSignPage()
        }
      })
    },

    // 修改签名
    editSign() {
      this.showSign = true
    },

    endEditSign() {
      this.dialogClose('showSign')
      this.getSignPage()
    },

    // 添加签名
    addSign() {
      this.showSign = true
    },

    // 初始化默认短息数据
    initSMSData() {
      apiSMS.initSmsTemplate().then(res => {
        console.log(res)
      })
    },
  },
}
</script>

<style lang="scss" scoped>
  .redFont {
    position: relative;
    top: 5px;
    left: 10px;
  }
  .fresh {
    margin-left: 10px;
    font-size: 16px;
    color: $primary;
    &:hover {
      cursor: pointer;
      color: $pink;
    }
  }
</style>
