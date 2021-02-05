<!--欠费明细-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">欠费明细</div>
    </div>
    <div slot="default" class="frameBody">
      <template v-if="listData.length">
        <el-card v-for="(item,index) in listData" :key="index" shadow="never" class="listItem">
          <div slot="header">
            抄表月:{{ item.readmeterMonth }}
            <span style="float: right">滞纳天数：{{ item.latepayDays || emptyStr }}</span>
          </div>
          <el-form ref="form" label-position="top" class="jh-text">
            <el-form-item label="用气量">
              <el-input :value="item.gas" />
            </el-form-item>
            <el-form-item label="用气金额">
              <el-input :value="item.gasMoney" />
            </el-form-item>
            <el-form-item label="欠费金额">
              <el-input :value="item.arrearsMoney" />
            </el-form-item>
            <el-form-item label="滞纳金">
              <el-input :value="item.latepayAmount" />
            </el-form-item>
          </el-form>
        </el-card>
      </template>
      <el-alert
        v-else
        title="暂无欠费数据"
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
import tabsApi from '@/api/tabsInfo/index.js'
import Temporary from '@/views/gmis/temporary/temporary';

export default {
  name: 'ArrearageInfo',
  props: {
    gasMeterCode: String
  },
  data() {
    return {
      //
      searchData: this.initQueryParams({
        size: 5,
        model: {
          arrearsStatus: 'UNCHARGE',
          dataStatus: 1
        }
      }),

      // 流水
      listData: [],
      total: 0
    }
  },
  computed: {},
  watch: {
    gasMeterCode() {
      console.log(this.gasMeterCode);
      this.getListData()
    }
  },
  mounted() {
    // console.log("我是账号信息组件，我被加载了")
    if (this.gasMeterCode) {
      this.getListData()
    }
  },
  methods: {
    //
    getListData() {
      this.searchData.model.gasmeterCode = this.gasMeterCode
      tabsApi.arrearsData(this.searchData).then(res => {
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
::v-deep .el-form-item {
  width: calc(100% / 2);
}

.listItem {
  ::v-deep .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
    overflow: hidden;
  }
}
</style>

