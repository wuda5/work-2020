<!-- 柜台统计 -->
<template>
  <info-frame>
    <template v-slot:title>
      <search-box>
        <div slot="left" class="subTitle">{{ $t('统计数据') }}</div>
        <div slot="right">
          <el-button-group>
            <el-button :type="params.dataMap.timeType===1? 'primary':''" @click="changeTimeType(1)">当日</el-button>
            <el-button :type="params.dataMap.timeType===2? 'primary':''" @click="changeTimeType(2)">当月</el-button>
          </el-button-group>
        </div>
      </search-box>
    </template>
    <div class="frameBody counterStatistics">
      <qc-count-card bg-color="#5f7eff">
        <span class="counterTitle">开户数据统计</span>
        <span class="counterText">开户</span>
        <span class="counterNum">{{ kh }}</span>
        <span class="counterBar"></span>
      </qc-count-card>

      <qc-count-card bg-color="#55b9ff">
        <span class="counterTitle">过户数据统计</span>
        <span class="counterText">过户</span>
        <span class="counterNum">{{ gh }}</span>
        <span class="counterBar"></span>
      </qc-count-card>

      <qc-count-card bg-color="#0fdbed">
        <span class="counterTitle">拆表统计</span>
        <span class="counterText">拆表</span>
        <span class="counterNum">{{ cb }}</span>
        <span class="counterBar"></span>
      </qc-count-card>
      <qc-count-card bg-color="#35d2b9">
        <span class="counterTitle">换表统计</span>
        <span class="counterText">换表</span>
        <span class="counterNum">{{ hb }}</span>
        <span class="counterBar"></span>
      </qc-count-card>
      <qc-count-card bg-color="#fcd10d">
        <span class="counterTitle">发卡量统计</span>
        <span class="counterText">发卡量</span>
        <span class="counterNum">{{ fk }}</span>
        <span class="counterBar"></span>
      </qc-count-card>
    </div>
  </info-frame>
</template>

<script>
import QcCountCard from '@/components/QcCountCard/index'
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'CounterStatistics',
  components: {
    QcCountCard,
  },
  data() {
    return {
      params: {
        dataMap: {
          timeType: 1, //日: 1; 月: 2;
        },
      },
      gh: '-', // 过户
      kh: '-', // 开户
      xh: '-', // 销户
      hb: '-', // 换表
      cb: '-', // 拆表
      fk: '-', // 发卡
    }
  },
  created() {
    this.getData()
  },
  methods: {
    // 获取统计数据
    getData() {
      tjApi.TaccountSts(this.params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          let that = this
          for (let i = 0; i < data.length; i++) {
            const item = data[i];
            switch (item.type) {
              case 1:
                that.kh = item.amount
                break
              case 2:
                that.gh = item.amount
                break
              case 3:
                that.xh = item.amount
                break
              case 4:
                that.cb = item.amount
                break
              case 5:
                that.fk = item.amount
                break
              case 6:
                that.hb = item.amount
                break
            }
          }
        }
      })
    },

    // 切换时间
    changeTimeType(type){
      this.params.dataMap.timeType = type
      this.getData()
    }
  },
}
</script>

<style lang="scss">
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
  }
}
</style>
