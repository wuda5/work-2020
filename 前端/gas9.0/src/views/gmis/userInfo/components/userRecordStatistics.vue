<!-- 用户档案统计 -->
<template>
  <info-frame>
    <template v-slot:title>
      <search-box>
        <div slot="left" class="subTitle">{{ $t('档案统计') }}</div>
        <!-- <div slot="right">
          <el-button-group>
            <el-button :type="params.dataMap.timeType===1? 'primary':''" @click="changeTimeType(1)">当日</el-button>
            <el-button :type="params.dataMap.timeType===2? 'primary':''" @click="changeTimeType(2)">当月</el-button>
          </el-button-group>
        </div> -->
      </search-box>
    </template>

    <div slot="default" class="frameBody counterStatistics">
      <!-- 客户总量统计 -->
      <qc-count-card bg-color="#1ac9ac">
        <span class="counterTitle">客户总量统计</span>
        <span class="counterText" style="height: 15px"></span>
        <span class="counterNum">{{ stat.totalNum | formatStatisticsNum }}</span>
        <span class="counterBar"></span>
      </qc-count-card>

      <!-- 客户增量统计 -->
      <qc-count-card bg-color="#55b9ff">
        <span class="counterTitle">客户状态统计</span>
        <div style="margin-top: 0px">
          <span class="counterText">在用</span>
          <span class="counterNum">{{ stat.userNum | formatStatisticsNum }}</span>
        </div>
        <div style="margin-top: -10px">
          <span class="counterText">销户</span>
          <span class="counterNum">{{ stat.closeNum | formatStatisticsNum }}</span>
        </div>
      </qc-count-card>
      <!-- 客户新增统计 -->
      <qc-count-card bg-color="#6e85e5">
        <span class="counterTitle">客户增量统计</span>
        <div style="margin-top: 0px">
          <span class="counterText">当日新增</span>
          <span class="counterNum">{{ stat.dayAddNum | formatStatisticsNum }}</span>
        </div>
        <div style="margin-top: -10px">
          <span class="counterText">当月新增</span>
          <span class="counterNum">{{ stat.monthAddNum | formatStatisticsNum }}</span>
        </div>
      </qc-count-card>

      <!-- 保险购买分类统计 -->
      <!--<qc-count-card bg-color="#ffc021">
        <span class="counterTitle">保险购买统计</span>
        <div style="margin-top: -15px" class="">
          <span class="counterText">新增</span>
          <span class="counterNum1">{{ stat.addInsuranceNum | formatStatisticsNum }}</span>
        </div>
        <div style="margin-top: -15px">
          <span class="counterText">续保</span>
          <span class="counterNum1">{{ stat.renewalNum | formatStatisticsNum }}</span>
        </div>
        <div style="margin-top: -15px">
          <span class="counterText">购买</span>
          <span class="counterNum1">{{ stat.buyInsuranceNum | formatStatisticsNum }}</span>
        </div>
      </qc-count-card>-->

      <!-- 限购统计 -->
      <!--<qc-count-card bg-color="#ff6696">
        <span class="counterTitle">限购统计</span>
        <div style="margin-top: 0px">
          <span class="counterText">安检</span>
          <span class="counterNum">{{ stat.safeCheckNum | formatStatisticsNum }}</span>
        </div>
        <div style="margin-top: -10px">
          <span class="counterText">黑名单</span>
          <span class="counterNum">{{ stat.blacklistNum | formatStatisticsNum }}</span>
        </div>
      </qc-count-card>-->
    </div>
  </info-frame>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'
import tjApi from '@/api/statistics/index.js';

export default {
  name: 'UserRecordStatistics',
  components: {
    QcCountCard
  },
  data() {
    return {
      noData: '-',
      stat: {},
      params: {
        dataMap: {
          timeType: 1, //日: 1; 月: 2;
        },
      },
    }
  },

  created() {
    this.getData()
  },
  methods: {
    // 获取统计数据
    getData() {
      tjApi.UCustomer(this.params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.stat = data
        }
      })
    },

    // 切换时间
    changeTimeType(type) {
      this.params.dataMap.timeType = type
      this.getData()
    }
  }
}
</script>

<style lang="scss" scoped>

.counterStatistics {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  align-content: flex-start;

  .qc-cont-card {
    width: calc((100% - 15px) / 2);
    height: 230px;
    margin-bottom: 15px;

    .counterTitle {
      margin-top: 20px;
    }

    .counterNum1 {
      font-size: 24px;
      margin-top: 4px;
    }

    .counterNum {
      margin-top: 5px;
      font-size: 24px;
    }

    .counterText {
      margin-top: 30px;
    }

    .counterBar {
      margin-top: 40px;
    }
  }
}

</style>
