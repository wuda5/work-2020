<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">商品信息</div>
    </div>
    <div slot="default" class="frameBody">
      <template v-if="listData.length">
        <el-card v-for="(item,index) in listData" :key="index" shadow="never" class="listItem">
          <p>类型: 燃气灶<span>已售</span></p>
          <p>品牌: 美的</p>
          <p>型号: DDD-87545 </p>
          <p>数量: 1 </p>
        </el-card>
      </template>
      <el-alert
        v-else
        title="暂无商品信息"
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
  name: 'GoodsInfo',
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
  computed: {},
  watch: {
    gasMeterCode() {
      console.log(this.gasMeterCode);
      this.getListData()
    }
  },
  mounted() {
    // console.log("我是账号信息组件，我被加载了")
    if (this.gasmeterCode) {
      this.getListData()
    }
  },
  methods: {
    //  获取账户流水
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

<style scoped></style>
