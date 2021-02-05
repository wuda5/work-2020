<!--缴费记录-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">缴费信息</div>
    </div>
    <div slot="default" class="frameBody">
      <!--list-->
      <template v-if="listData.length">
        <el-card v-for="(item,index) in listData" :key="index" shadow="never" class="listItem">
          <div slot="header">
            缴费时间
            {{ (item.chargeItemTime || item.createTime) | parseTime }}
          </div>
          <table>
            <thead>
            <tr>
              <th>收费项</th>
              <th>金额</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="sitem in item.chargeItemList" :key="sitem.id">
              <td>{{ sitem.chargeItemName }}</td>
              <td>{{ sitem.chargeItemMoney }}</td>
            </tr>
            </tbody>
          </table>
          <el-tag v-if="item.refundStatus==='REFUNDED'" class="tfTag" type="danger"> 已退费 </el-tag>
          <!--<el-form ref="form" label-position="top" class="jh-text">
            <el-form-item label="缴费场景">
              <p>{{ item.chargeItemName }}</p>
            </el-form-item>
            <el-form-item label="金额">
              <p>{{ item.chargeItemMoney }}</p>
            </el-form-item>

            &lt;!&ndash; <el-form-item v-if="item.refundStatus==='REFUNDED'" label=" ">&ndash;&gt;
            <el-form-item label=" ">
              <p v-if="item.refundStatus==='REFUNDED'" class="redFont"> 退费 </p>
              &lt;!&ndash;              <p v-else> 缴费 </p>&ndash;&gt;
            </el-form-item>
          </el-form>-->
        </el-card>
      </template>
      <el-alert
        v-else
        title="暂无缴费信息"
        type="warning"
        show-icon
        :closable="false"
      >
      </el-alert>
    </div>
    <div v-if="listData.length" slot="page">
      <pagination
        :page-sizes="[5, 10, 15, 20]"
        :page.sync="searchData.current"
        :limit.sync="searchData.size"
        :total="total"
        layout="total ,prev, next,jumper"
        @pagination="getListData"
      />
    </div>
  </info-frame>
</template>
<script>
import tabsApi from '@/api/tabsInfo';

export default {
  name: 'PaymentRecords',
  props: {
    gasMeterCode: String,
    customerCode: String

  },
  data() {
    return {
      // 流水搜索条件
      searchData: this.initQueryParams({
        size: 5,
      }),

      // 流水
      listData: [],
      total: 0
    }
  },
  watch: {
    gasMeterCode() {
      if (this.gasMeterCode && this.customerCode) {
        this.getListData()
      } else {
        this.listData = []
      }
    },
    customerCode() {
      if (this.gasMeterCode && this.customerCode) {
        this.getListData()
      } else {
        this.listData = []
      }
    }
  },
  mounted() {
    // console.log('我是账号信息组件，我被加载了', this.gasMeterCode, this.customerCode)
    if (this.gasMeterCode && this.customerCode) {
      this.getListData()
    }
  },
  methods: {
    //  获取账户流水
    getListData() {
      this.searchData.model.gasMeterCode = this.gasMeterCode
      this.searchData.model.customerCode = this.customerCode
      tabsApi.paymentRecords(this.searchData).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.listData = data.records
          this.total = parseInt(data.total)
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
table, table tr th, table tr td {
  border: 1px solid #888;
  padding: 5px 10px;
  text-align: left
}

table {
  width: 100%;
  border-collapse: collapse;
}

.listItem {
  ::v-deep .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
  }
}

.tfTag {
  position: absolute;
  top: 5px;
  right: 5px;
}
</style>

