<!-- 发票管理 -->
<template>
  <div>
    <el-card shadow="never" class="no-border" style="height: 225px">
      <div slot="header">
        <span class="card-title">发票列表</span>

        <!-- 操作按钮 -->
        <div class="card-tool-bar">
          <!--search-->
          <el-input placeholder="请输入内容" class="input-with-select">
            <el-button slot="append" type="success" icon="el-icon-search"></el-button>
          </el-input>
          <!--筛选-->
          <el-dropdown
            :hide-on-click="false"
          >
            <el-button type="primary">
              发票筛选<i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>重试</el-dropdown-item>
              <el-dropdown-item>
                <el-checkbox v-model="checkAll" :indeterminate="isIndeterminate" @change="handleCheckAllChange">全选</el-checkbox>
              </el-dropdown-item>
              <el-checkbox-group
                v-model="checkedCities"
                @change="handleCheckedCitiesChange"
              >
                <el-dropdown-item v-for="city in cities" :key="city.value">
                  <el-checkbox :label="city.value">{{ city.label }}</el-checkbox>
                </el-dropdown-item>
              </el-checkbox-group>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>

      <!-- 发票列表 -->
      <el-table
        ref="multipleTable"
        :data="invoiceList"
        tooltip-effect="dark"
        :border="false"
        :highlight-current-row="true"
      >

        <el-table-column
          type="selection"
        />
        <el-table-column
          prop="1"
          label="发票编号"
          width="100"
        />
        <el-table-column
          prop="2"
          label="发票类型"
          width="80"
        />
        <el-table-column
          prop="3"
          label="发票种类"
          width="100"
        />
        <el-table-column
          prop="4"
          label="发票状态"
          width="80"
        />
        <el-table-column
          prop="5"
          label="发票抬头"
          min-width="200"
        />
        <el-table-column
          prop="6"
          label="纳税人识别号"
          width="140"
        />
        <el-table-column
          prop="7"
          label="安装地址"
          min-width="200"
        />
        <el-table-column
          prop="8"
          label="电话"
          width="100"
        />
        <el-table-column
          prop="9"
          label="开户行"
          width="140"
        />
        <el-table-column
          prop="10"
          label="账号"
          width="150"
        />
      </el-table>
      <Pagination
        style="margin: 10px 0 5px"
        layout="prev, pager, next"
        :page="2"
        :limit="2"
        :total="4"
      />
    </el-card>
    <el-divider></el-divider>
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">发票明细</span>
      </div>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-table
            :data="invoiceDetailList"
            :stripe="true"
            height="300px"
            style="width: 100%"
          >
            <el-table-column
              prop="1"
              label="商品名称"
            >
            </el-table-column>
            <el-table-column
              prop="2"
              label="数量"
            >
            </el-table-column>
            <el-table-column
              prop="3"
              label="单价"
            >
            </el-table-column>

            <el-table-column
              prop="4"
              label="金额"
            >
            </el-table-column>
          </el-table>
        </el-col>
        <el-col :span="12">
          <el-form label-position="top" :model="invoiceDetailForm" class="jh-text">
            <el-form-item label="发票抬头" style="width: 66.6%;">
              <el-input v-model="invoiceDetailForm[5]"></el-input>
            </el-form-item>

            <el-form-item label="联系电话">
              <el-input v-model="invoiceDetailForm[8]"></el-input>
            </el-form-item>

            <el-form-item label="地址" style="width: 100%">
              <el-input v-model="invoiceDetailForm[7]"></el-input>
            </el-form-item>

            <el-form-item label="发票类型">
              <el-input v-model="invoiceDetailForm[2]"></el-input>
            </el-form-item>
            <el-form-item label="发票编号">
              <el-input v-model="invoiceDetailForm[1]"></el-input>
            </el-form-item>

            <el-form-item label="开户行">
              <el-input v-model="invoiceDetailForm[9]"></el-input>
            </el-form-item>
            <el-form-item label="账号" style="width: 50%">
              <el-input v-model="invoiceDetailForm[10]"></el-input>
            </el-form-item>

            <el-form-item label="纳税人识别号" style="width: 50%">
              <el-input v-model="invoiceDetailForm[6]"></el-input>
            </el-form-item>

            <div class="clearfix"></div>
            <div class="btnBox">
              <el-form-item label="  ">
                <el-button type="primary">开盘</el-button>
              </el-form-item>
              <el-form-item label="  ">
                <el-button type="primary">补打</el-button>
              </el-form-item>
              <el-form-item label="  ">
                <el-button type="primary">重开</el-button>
              </el-form-item>
            </div>
          </el-form>
        </el-col>
      </el-row>

    </el-card>
  </div>
</template>

<script>
const cityOptions = [
  {
    label: '未开票',
    value: 1
  },
  {
    label: '票据',
    value: 2
  },
  {
    label: '普票',
    value: 3
  },
  {
    label: '专票',
    value: 4
  },
  {
    label: '电子票',
    value: 5
  },
  {
    label: '红票',
    value: 6
  },
  {
    label: '废票',
    value: 7
  },
  {
    label: '蓝票',
    value: 8
  }

]
export default {
  name: 'InvoiceManage',
  data() {
    return {
      businessInfo: {
        1: '233',
        2: '350',
        3: '2',
        4: '0',
        5: '2',
        6: '20',
        7: '50',
        8: '20',
        9: '350',
        10: '350',
        11: '350',
        12: '350'
      },
      invoiceList: [
        {
          1: '12955658744',
          2: '专票',
          3: '蓝票',
          4: '已开',
          5: '秦川物联网科技有限公司',
          6: '12658945465+6596',
          7: '车城大道254号',
          8: '13812577854',
          9: '总共银行',
          10: '889895665363223233'
        },
        {
          1: '12955658744',
          2: '专票',
          3: '蓝票',
          4: '已开',
          5: '秦川物联网科技有限公司',
          6: '12658945465+6596',
          7: '车城大道254号',
          8: '13812577854',
          9: '总共银行',
          10: '889895665363223233'
        }
      ],
      invoiceDetailList: [
        {
          1: '燃气费',
          2: 1,
          3: 100,
          4: 100
        },
        {
          1: '燃气费',
          2: 1,
          3: 100,
          4: 100
        }
      ],
      // 收费表单
      invoiceDetailForm: {
        1: '12955658744',
        2: '专票',
        3: '蓝票',
        4: '已开',
        5: '秦川物联网科技有限公司',
        6: '11112222333366655544',
        7: '车城大道254号',
        8: '13812577854',
        9: '总共银行',
        10: '889895665363223233'
      },

      // 发票管理搜索
      checkAll: false,
      isIndeterminate: true,
      checkedCities: [],
      cities: cityOptions
    }
  },
  computed: {},
  methods: {
    handleCheckAllChange(val) {
      const all = []
      cityOptions.forEach(function (item) {
        all.push(item.value)
      })

      this.checkedCities = val ? all : []
      this.isIndeterminate = false
    },
    handleCheckedCitiesChange(value) {
      const checkedCount = value.length
      this.checkAll = checkedCount === this.cities.length
      this.isIndeterminate = checkedCount > 0 && checkedCount < this.cities.length
    }
  }

}
</script>

<style lang="scss" scoped>
  ::v-deep .el-table {
    border: 1px solid #eee;
    border-bottom: none;
  }

  .el-form-item {
    width: calc(100% / 3);
  }

  // 发票筛选
  .card-tool-bar {
    .el-input {
      width: 250px;

      ::v-deep .el-input-group__append {
        padding-left: 0;
      }
    }
  }

  ::v-deep thead {
    tr {
      background: #FAFAFA;

      th {
        background: transparent;
      }
    }
  }

  .btnBox {
    .el-button {
      width: 100%;
    }
  }
</style>
