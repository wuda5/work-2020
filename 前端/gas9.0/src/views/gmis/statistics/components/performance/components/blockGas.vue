<!-- 售气数据 -->
<template>
  <div class="tabBox">
    <!--search-->
    <search-box>
      <div slot="left">
        <span class="card-title">售气数据</span>
      </div>
    </search-box>

    <!--售气数据 -->
    <div class="StaticsData">
      <st-data-card
        v-for="(item, key, index) in saleGas" :key="index"
        :bg-color="colors[index]"
        :title="saleGas[key].title"
        :card-data="saleGas[key]"
        :style="{width: width}"
      />
        <!-- @click.native="changeItem(index,item)" -->
    </div>
  </div>
</template>

<script>
import StDataCard from './staticsDataCard'
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'gas',
  components: {
    StDataCard
  },
  props: {
    propsData: {
      type: Object,
      default: function () {
        return {
          orgId: ''
        }
      }
    }
  },
  data() {
    return {
      // active: 0,  // 当前选中
      colors: [
        '#35D2B9',
        '#F5C60D',
        '#0FDBED',
        '#8EA3FA',
        '#55B9FF',
        
      ],

      /* 
      1、普表：用气量   
      2、IC卡表：售气量  
      3、物联网中心计费后付费表：用气量  
      4、物联网中心计费预付费表：售气量  
      5、物联网表端计费表：售气量
      */

      saleGas: {
        generalGasMeter: {
          title: '普表(用气)',
          todayData: '今日(方)',
          monthData: '本月(方)',
          yearData: '本年(方)',
          totalData: '累计用气量(方)',
          data: {}
        },
        cardGasMeter: {
          title: 'IC卡表(售气)',
          todayData: '今日(方)',
          monthData: '本月(方)',
          yearData: '本年(方)',
          totalData: '累计售气量(方)',
          data: {}
        },
        afterGasMeter: {
          title: '物联网后付费表(用气)',
          todayData: '今日(方)',
          monthData: '本月(方)',
          yearData: '本年(方)',
          totalData: '累计用气量(方)',
          data: {}
        },
        preGasMeter: {
          title: '物联网中心预付费表(用气) ',
          todayData: '今日(方)',
          monthData: '本月(方)',
          yearData: '本年(方)',
          totalData: '累计售气量(方)',
          data: {}
        },
        lastGasMeter: {
          title: '物联网表端计费表(售气)',
          todayData: '今日(方)',
          monthData: '本月(方)',
          yearData: '本年(方)',
          totalData: '累计售气量(方)',
          data: {}
        }
      },

      // 同比环比柱状图数据
      // barData: {
      //   columns: ['时间', '本期', '上期'],
      //   rows: []
      // },

      // 同比环比折线图数据
      // lineData: {
      //   columns: ['日期', '月数据'],
      //   rows: []
      // },
    }
  },
  computed: {
    width() {
      // return (100 / this.finaData.length - 1) + '%'
      return (100 / Object.keys(this.saleGas).length - 1) + '%'
    },
  },
  watch:{
    propsData() {
      this.getData()
    },
  },
  
  mounted() {
    this.getData()
  },
  methods: {
    // changeItem(index, item) {
    //   this.active = index
    //   this.formatChartData(item.data.compareData)
    // },

    getData() {
      let params = {
        orgId:this.propsData.orgId,
        endDay: '',
        startDay: '',
      }

      if (this.dataRange) {
        params.startDay = this.dataRange[0] + '-01'
        params.endDay = this.dataRange[1] + '-01'
      }

      tjApi.getStsGasDetail(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          for (let key in data) {
            if (this.saleGas[key]) {
              this.saleGas[key].data = {
                today: data[key].todayNum,
                month: data[key].monthNum,
                year: data[key].yearNum,
                total: data[key].allNum
              }
            }
          }
          // 设置第一组数据
          // this.formatChartData(this.saleGas.customer.data.compareData)

        }
      })
    },

    // 转换 同比环比柱状图数据 同比环比折线图数据
    // formatChartData(arr) {
    //   let barRows = []
    //   let lineRows = []

    //   arr.forEach(item => {
    //     let barDataItem = {
    //       '时间': item.monStr,
    //       '上期': item.lastYearNum,
    //       '本期': item.thisYearNum
    //     }
    //     let lineDataItem = {
    //       '日期': item.monStr,
    //       '月数据': item.thisYearNum
    //     }

    //     /* 模拟数据*/
    //     /*let barDataItem = {
    //       '时间': item.monStr,
    //       '本期': this.randomNum(10,90),
    //       '上期': this.randomNum(10,40)
    //     }

    //     let lineDataItem = {
    //       '日期': item.monStr,
    //       '月数据': this.randomNum(10,40)
    //     }*/
    //     barRows.push(barDataItem)
    //     lineRows.push(lineDataItem)

    //   })
    //   this.barData.rows = barRows
    //   this.lineData.rows = lineRows
    // },
  }
}
</script>

<style scoped>
.StaticsData {
  margin: 30px 0;
  height: 220px;
  display: flex;
  display: -webkit-flex;
  justify-content: space-between;
}
</style>
