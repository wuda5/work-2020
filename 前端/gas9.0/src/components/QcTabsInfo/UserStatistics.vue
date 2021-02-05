<!--欠费明细-->
<template>
  <el-card class="no-border">
    <div class="counterStatistics">
      <!-- 抄表率 -->
      <qc-count-card bg-color="#1ac9ac">
        <p class="title">抄表率</p>
        <p class="num">99%</p>
        <div class="more">
          <span class="moreTitle">抄表数</span>
          <span class="moreNum">2248</span>
        </div>
      </qc-count-card>
      <!-- 遗漏 -->
      <qc-count-card bg-color="#55b9ff">
        <p class="title">遗漏</p>
        <p class="num">824</p>
        <div class="more">
          <span class="counterBar"></span>
        </div>
      </qc-count-card>
      <!-- 结算率 -->
      <qc-count-card bg-color="#ffc021">
        <p class="title">结算率</p>
        <p class="num">99%</p>
        <div class="more">
          <span class="moreTitle">结算</span>
          <span class="moreNum">8122</span>
        </div>
      </qc-count-card>
      <!-- 审核率 -->
      <qc-count-card bg-color="#ff6696">
        <p class="title">审核率</p>
        <p class="num">98%</p>
        <div class="more">
          <span class="moreTitle">审核</span>
          <span class="moreNum">8122</span>
        </div>
      </qc-count-card>
      <!-- 发票 -->
      <qc-count-card bg-color="#1ac9ac">
        <p class="title">发票</p>
        <p class="num">754</p>
        <div class="more">
          <span class="counterBar"></span>
        </div>
      </qc-count-card>
      <!-- 收费 -->
      <qc-count-card bg-color="#1ac9ac">
        <p class="title">收费</p>
        <p class="num">8990</p>
        <div class="more">
          <span class="counterBar"></span>
        </div>
      </qc-count-card>
    </div>
  </el-card>
</template>
<script>
import QcCountCard from '@/components/QcCountCard/index'
export default {
  name: 'ArrearageInfo',
  components: {
    QcCountCard,
  },
}
</script>

<style lang="scss" scoped>
.counterStatistics {
  overflow-y: auto;
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
  margin-top: 15px;
  .qc-cont-card {
    padding: 20px 0;
    width: 45%;
    height: 230px;
    margin-bottom: 15px;
    .title {
      height: 40px;
      margin: 0;
    }
    .num {
      height: 80px;
      line-height: 80px;
      margin: 0;
      font-size: 20px;
    }
    .more {
      .moreNum {
        margin-top: 10px;
      }
    }
  }
}
 ::v-deep.el-tabs__content{
    height: 750px;
  }
</style>

