<!-- 操作员配额 -->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">柜台配额</span>
      </div>
      <el-row :gutter="50">
        <el-col :span="8">
          <div class="tableTitle">
            <b class="fl">柜台列表</b>
          </div>
          <!--数据-->

          <el-collapse v-model="activeNames" accordion class="counterBox">
            <el-collapse-item v-for="(value, key, index) in counterList" :key="index" :name="index">
              <template slot="title">
                <i class="el-icon-house" style="margin-right:5px"></i>{{ key }}
              </template>
              <ul>
                <li
                  v-for="item in value"
                  :key="item.userId"
                  :class="item.userId === curUserId ? 'on' : null"
                  @click="userClick(item)"
                >
                  <i class="el-icon-user"></i>
                  {{ item.name }}
                </li>
              </ul>
            </el-collapse-item>
          </el-collapse>

          <!-- 操作员列表接口设计无分页 -->
        </el-col>
        <el-col v-if="curUserId" :span="16">
          <!--配额-->
          <div>
            <div class="tableTitle">
              <b class="fl">配额</b>
            </div>
            <!--配额表单-->
            <el-form
              ref="form"
              label-position="top"
              :model="form"
              :rules="formRules"
              class="jh-text"
            >
              <el-form-item label="当前余额" prop="" style="background-color: #f7f7f7">
                <b class="redFont">{{ (records.length > 0 && records[0].totalMoney) || 0 }}</b>
              </el-form-item>
              <el-form-item label="限制" prop="name">
                <el-checkbox v-model="form.dataStatus" :true-label="1" :false-label="0">
                  开启限制
                </el-checkbox>
              </el-form-item>
              <el-form-item label="配置类型" prop="quotaType.code">
                <el-select v-model="form.quotaType.code">
                  <el-option
                    v-for="item in dict.QUOTA_TYPE"
                    :key="item.id"
                    :label="item.name"
                    :value="item.code"
                  ></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="配额" prop="money">
                <el-input v-model="form.money" type="number" />
              </el-form-item>
              <div class="clearfix"></div>
              <el-form-item label="备注" prop="remark" class="width100">
                <el-input v-model="form.remark" placeholder="请输入配额备注" />
              </el-form-item>
              <el-form-item class="fr" label="" prop="">
                <el-button v-has-permission="['shopAssistantQuota:add']" type="primary" class="width100" @click="addNewQuotaInfo">
                  配额
                </el-button>
              </el-form-item>
            </el-form>
          </div>
          <div class="clearfix"></div>

          <!-- 配额记录 -->
          <div style="margin-top: 20px">
            <div class="tableTitle">
              <b class="fl">配额记录</b>
            </div>
            <!--数据-->
            <el-table
              stripe
              :data="records"
              height="height:calc(100vh - 535px)"
              style="height:calc(100vh - 535px)"
            >
              <el-table-column type="index" label="序号" />
              <el-table-column prop="dataStatus" label="限制" width="50">
                <template slot-scope="{ row }">
                  <el-tag v-if="row.dataStatus === 1" type="danger">是</el-tag>
                  <el-tag v-if="row.dataStatus === 0" type="success">否</el-tag>
                </template>
              </el-table-column>
              <el-table-column prop="quotaType.code" label="配额类型" width="100">
                <template slot-scope="{ row }">
                  <!-- {{ row.quotaType ? row.quotaType.desc : "nul" }} -->
                  {{ row.quotaType ? dictMap.QUOTA_TYPE[row.quotaType.code] : '' }}
                </template>
              </el-table-column>
              <el-table-column prop="money" label="配额" width="100" />
              <el-table-column prop="createTime" label="配额时间" width="150" />
              <el-table-column prop="createUserName" label="操作员" width="150" />
              <el-table-column prop="remark" label="备注信息" />
            </el-table>
            <!--分页-->
            <pagination
              :total="total"
              :page-sizes="[10, 20, 30]"
              :limit="searchQuota.size"
              layout="total,sizes,prev,pager,next"
              :small="true"
              @pagination="pagination"
            />
          </div>
        </el-col>
        <el-col v-else :span="16">
          <no-select tips="请选择营业员" :top="38" />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import apiShop from '@/api/operation/shopAssistantQuota'
import NoSelect from '@/components/QcNoSelect'
export default {
  name: 'ShopAssistantQuota',
  components: {
    NoSelect,
  },
  data() {
    return {
      // 用户搜索条件
      searchCounter: {
        model: {},
      },
      counterList: [],
      // 面板默认展开
      activeNames: [0],
      // 当前用户ID
      curUserId: '',

      // 当前用户配额（取最后一次配额记录）
      curUserQuota: null,

      // =======================================
      // 配额表单
      form: {
        userId: '',
        businessHallId: '',
        businessHallName: '',
        dataStatus: 0,
        money: '',
        quotaType: {
          code: '',
          desc: '',
        },
        remark: '',
      },
      formRules: {
        money: [
          {
            required: true,
            message: '必填',
            trigger: 'change',
          },
          {},
        ],
        remark: [
          {
            required: true,
            message: '必填',
            trigger: 'change',
          },
        ],
        'quotaType.code': [
          {
            required: true,
            message: '配置类型',
            trigger: 'change',
          },
        ],
      },
      // =================================
      searchQuota: {
        current: 1,
        map: {},
        model: {
          userId: '',
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      total: 0,
      records: [],
    }
  },
  created() {
    this.getcounterList()
  },
  methods: {
    // 获取操作员列表
    getcounterList() {
      apiShop.counterPage(this.searchCounter).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.counterList = res1.data
        }
      })
    },
    // 用户点击
    userClick(userInfo) {
      this.curUserId = userInfo.userId
      this.searchQuota.model.userId = userInfo.userId

      //配额表单数据
      this.form.userId = userInfo.userId
      this.form.businessHallId = userInfo.businessHallId
      this.form.businessHallName = userInfo.businessHallName

      //
      this.getQuotaListByUserId()
    },
    // region
    //  更具用户ID获取配额详情
    getQuotaListByUserId() {
      apiShop.companyUserQuotaRecord(this.searchQuota).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.records = res1.data.records
          this.total = parseInt(res1.data.total)
        }
      })
    },

    // 新增配额信息
    addNewQuotaInfo() {
      // 验证表单
      this.$refs.form.validate(valid => {
        if (valid) {
          apiShop.add(this.form).then(res => {
            let res1 = res.data
            if (res1.isSuccess) {
              this.msg('添加成功', 'success')
              this.getQuotaListByUserId()
            }
          })
        } else {
          // console.log('error submit!!');
          return false
        }
      })
    },

    // 分页数据改变
    pagination(pageData) {
      this.searchQuota.size = pageData.size
      this.searchQuota.current = pageData.current
      this.getQuotaListByUserId()
    },
    // endregion
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  border: 1px solid #eee;
  padding: 15px 20px 0;
  overflow: hidden;
  .el-form-item {
    width: calc(100% / 4);
    margin-bottom: 15px;
  }
}

.tableTitle {
  overflow: hidden;
  margin-bottom: 10px;

  b {
    font-size: 14px;
    vertical-align: middle;
    line-height: 28px;
  }
}

::v-deep .el-form-item__content {
  background: #f7f7f7;
  .el-checkbox__input {
    margin-left: 10px;
  }
}

.pagination-container {
  padding: 15px 0 0;
}

// 操作员列表
.counterBox {
  border-left: 1px solid #e6ebf5;
  border-right: 1px solid #e6ebf5;
  height: calc(100vh - 230px);

  .el-collapse-item {
    ::v-deep .el-collapse-item__header {
      padding-left: 10px;
    }
    ::v-deep .el-collapse-item__content {
      padding: 0;
      background: #fbfbfb;
    }
  }

  ul {
    margin: 0;
    padding: 0;
    li {
      list-style: none;
      border-top: 1px solid #e6ebf5;
      line-height: 40px;
      padding-left: 20px;
      &:hover {
        background: #eee;
      }
      &.on {
        background: #9fceff;
        color: #fff;
      }
    }
  }
}
</style>
