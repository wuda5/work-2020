<!-- 表具统计 -->
<template>
  <info-frame>
    <template v-slot:title>
      <div class="subTitle">{{ $t('统计数据') }}</div>
    </template>
    <div class="frameBody counterStatistics">

      <!--<qc-count-card bg-color="#55b9ff">
        <span class="counterTitle">标量计统计</span>
        <div v-for="(item , index) in detailData.meterTypeList" :key="index">
          <div style="margin-top: -15px">
            <span class="counterText">{{ item.typeName }}</span>
            <span class="counterNum1">{{ item.amount }}</span>
          </div>
        </div>
      </qc-count-card>-->

      <qc-count-card bg-color="#9cb4ff" style="width: 100%; height: 290px;">
        <span class="counterTitle">表具状态统计</span>
        <el-divider />
        <el-row :gutter="10">
          <el-col span="12">
            <div style="margin-top: -15px">
              <span class="counterText">预建档</span>
              <span class="counterNum1">{{ meterData.preStatus }}</span>
            </div>
            <div style="margin-top: -15px">
              <span class="counterText">已安装（待开户）</span>
              <span class="counterNum1">{{ meterData.installStatus }}</span>
            </div>
            <div style="margin-top: -15px">
              <span class="counterText">已开户（待通气）</span>
              <span class="counterNum1">{{ meterData.openStatus }}</span>
            </div>
          </el-col>
          <el-col span="12">
            <div style="margin-top: -15px">
              <span class="counterText">已通气</span>
              <span class="counterNum1">{{ meterData.gasStatus }}</span>
            </div>
            <div style="margin-top: -15px">
              <span class="counterText">拆除</span>
              <span class="counterNum1">{{ meterData.removeStatus }}</span>
            </div>
            <span class="counterBar"></span>
          </el-col>
        </el-row>
      </qc-count-card>
      <qc-count-card bg-color="#35d2b9">
        <span class="counterTitle">表量统计</span>
        <div style="margin-top: -15px">
          <span class="counterText">卡表</span>
          <span class="counterNum1">{{ meterData.cardMeter }}</span>
        </div>
        <div style="margin-top: -15px">
          <span class="counterText">物联网表</span>
          <span class="counterNum1">{{ meterData.internetMeter }}</span>
        </div>
        <div style="margin-top: -15px">
          <span class="counterText">普表</span>
          <span class="counterNum1">{{ meterData.generalMeter }}</span>
        </div>
      </qc-count-card>
      <qc-count-card bg-color="#0fdbed">
        <span class="counterTitle">生产厂家统计</span>
        <span class="counterText">厂家统计</span>
        <span class="counterNum">{{ meterData.factoryNum }}</span>
        <span class="counterBar"></span>
      </qc-count-card>

    </div>
  </info-frame>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'
import tjApi from '@/api/statistics/index.js';

export default {
  name: 'MeterRecordStatistics',
  components: {
    QcCountCard
  },
  data() {
    return {
      nodata: '-',
      meterData: {},
    }
  },
  created() {
    this.getData()
  },
  methods: {
    // 获取统计数据
    getData() {
      tjApi.MeterSts({}).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.meterData = data
          for (let i = 0; i < data.meterTypeList.length; i++) {
            const item = data.meterTypeList[i];
            switch (item.type) {
              case '':
                break
            }
          }
          // this.sts = data[0]
        }
      })
    },

  }
}
</script>

<style lang="scss" scoped>
.frameBody {
  height: calc(100vh - 220px) !important;
}

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
