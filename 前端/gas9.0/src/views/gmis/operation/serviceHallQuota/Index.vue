<!-- 营业厅配额 -->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">营业厅配额</span>
      </div>
      <el-row :gutter="50">
        <el-col :span="8">
          <div class="tableTitle">
            <b class="fl">营业厅列表</b>
          </div>
          <!--数据-->
          <el-table
            stripe
            :data="hallListData"
            border
            style="height: calc(100vh - 270px)"
            :highlight-current-row="true"
            @current-change="handleCurrentChange"
          >
            <el-table-column type="index" label="序号"> </el-table-column>
            <el-table-column prop="businessHallName" label="营业厅名称" />
          </el-table>
          <!--分页-->
          <pagination
            :total="total1"
            :page-sizes="[10, 20, 30]"
            :limit="search.size"
            layout="total,sizes,prev,next"
            :small="true"
            @pagination="pagination"
          />
        </el-col>
        <el-col v-if="currentRow" :span="16">
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
              <el-form-item
                label="当前余额"
                prop=""
                style="background-color: #f7f7f7"
              >
                <b v-if="currentRow" class="redFont">{{
                  currentRow.balance || 0
                }}</b>
              </el-form-item>
              <el-form-item label="限制" prop="name">
                <el-checkbox
                  v-model="form.dataStatus"
                  :true-label="1"
                  :false-label="0"
                >
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
                <el-button v-has-permission="['serviceHallQuota:add']" type="primary" class="width100" @click="quota">
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
              :data="quotaRecords"
              border
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
              <el-table-column
                prop="quotaType.code"
                label="配额类型"
                width="100"
              >
                <template slot-scope="{ row }">
                  <!-- {{ row.quotaType ? row.quotaType.desc : "nul" }} -->
                  {{
                    row.quotaType ? dictMap.QUOTA_TYPE[row.quotaType.code] : ""
                  }}
                </template>
              </el-table-column>
              <el-table-column prop="money" label="配额" width="100" />
              <el-table-column prop="createTime" label="配额时间" width="150" />
              <el-table-column
                prop="createUserName"
                label="操作员"
                width="150"
              />
              <el-table-column prop="remark" label="备注信息" />
            </el-table>
            <!--分页-->
            <pagination
              :total="total2"
              :page-sizes="[1, 10, 20, 30]"
              :limit="search2.size"
              layout="total,sizes,prev,pager,next"
              :small="true"
              @pagination="pagination1"
            />
          </div>
        </el-col>
        <el-col v-else :span="16">
          <no-select tips="请选择营业厅" :top="38" />
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import api from '@/api/operation/serviceHallQuota';
import NoSelect from '@/components/QcNoSelect'
let defaultFormValue = {
  businessHallId: 0,
  businessHallName: '',
  dataStatus: 0,
  money: '',
  quotaType: {
    code: '',
    desc: ''
  },
  remark: ''
};

export default {
  name: 'ServiceHallQuota',
  components: {
    NoSelect,
  },
  data() {
    return {
      // 营业厅列表 搜索
      search: {
        current: 1,
        map: {},
        model: {
          deleteStatus: 0
        },
        order: 'descending',
        size: 10,
        sort: 'id'
      },
      // 营业厅列表
      hallListData: [],
      total1: 0,

      // 当前点击行
      currentRow: null,

      // ==================================================

      // 配额表单
      form: {
        businessHallId: 0,
        businessHallName: '',
        dataStatus: 0,
        money: '',
        quotaType: {
          code: '',
          desc: ''
        },
        remark: ''
      },
      formRules: {
        money: [
          {
            required: true,
            message: '必填',
            trigger: 'change'
          },
          {}
        ],
        remark: [
          {
            required: true,
            message: '必填',
            trigger: 'change'
          }
        ],
        'quotaType.code': [
          {
            required: true,
            message: '配置类型',
            trigger: 'change'
          }
        ]
      },

      // ========================================

      // 配置详情查询列表
      search2: {
        current: 1,
        map: {},
        model: {
          businessHallId: 0,
          businessHallName: ''
        },
        order: 'descending',
        size: 10,
        sort: 'id'
      },

      // 营业厅配额记录
      quotaRecords: [],
      total2: 0
    };
  },
  mounted() {
    this.getHallList();
  },
  methods: {
    // 获取营业厅列表
    getHallList() {
      api.hallPage(this.search).then(res => {
        let res1 = res.data;
        if (res1.isSuccess) {
          this.hallListData = res1.data.records;
          this.total1 = parseInt(res1.data.total);
        }
      });
    },

    // 分页数据改变
    pagination(pageData) {
      this.search.size = pageData.size;
      this.search.current = pageData.current;
      this.getHallList();
    },

    // 通过营业厅ID获取营业厅信息
    getHallInfoByID(id) {
      api.getHallInfoById(id).then(res => {
        let res1 = res.data;
        if (res1.isSuccess) {
          this.currentRow = res1.data;
          // 重置数据
          this.form = JSON.parse(JSON.stringify(defaultFormValue));
          // 提交表单必须字段
          this.form.businessHallId = this.currentRow.id;
          this.form.businessHallName = this.currentRow.businessHallName;

          // 添加搜索条件
          this.search2.model.businessHallName = this.currentRow.businessHallName;
          this.search2.model.businessHallId = this.currentRow.id;

          // 获取当前营业厅配额详情
          this.getQuotaList();
        }
      });
    },

    // left table row click
    handleCurrentChange(val) {
      this.getHallInfoByID(val.id);
    },

    // ---------------------------------
    // 配额
    quota() {
      // 验证表单
      this.$refs.form.validate(valid => {
        if (valid) {
          api.add(this.form).then(res => {
            if (res.data.isSuccess) {
              this.msg('添加成功', 'success');
              this.getHallInfoByID(this.currentRow.id);
              this.$refs.form.resetFields();
            }
          });
        } else {
          // console.log('error submit!!');
          return false;
        }
      });
    },

    // -----------------------------------
    // 获取配额详情
    getQuotaList() {
      api.hallQuotaPage(this.search2).then(res => {
        let res1 = res.data;
        if (res1.isSuccess) {
          this.quotaRecords = res1.data.records;
          this.total2 = parseInt(res1.data.total);
        }
      });
    },

    // 分页数据改变
    pagination1(pageData) {
      this.search2.size = pageData.size;
      this.search2.current = pageData.current;
      this.getQuotaList();
    }
  }
};
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
</style>
