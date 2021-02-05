<!--vchart 柱状图 -->
<template>
  <el-card shadow="never" class="no-border" style="margin-top: 10px">
    <div slot="header">
      <span class="title">{{ title }}</span>
      <span class="right-text">共计：{{ totalAmount }} ({{ unit }})</span>
    </div>
    <ve-histogram
      :height="height"
      :width="width"
      :extend="extend"
      :legend-visible="legendVisible"
      :judge-width="true"
      :grid="grid"
      :data="chartData"
    />
  </el-card>
</template>

<script>
export default {
  name: 'ChartBar',
  props: {
    title: {
      type: String,
      default: '你的标题呢？'
    },
    legendVisible: {
      type: Boolean,
      default: false
    },
    height: {
      type: String,
      default: '200px'
    },
    width: {
      type: String,
      default: '250px'
    },
    totalAmount: {
      type:Number,
      default:0
    },
    barWidth: {
      type: Number
    },
    chartData: {
      type: Object,
      default: function () {
        return {}
      }
    },
    grid: {
      type: Object,
      default: function () {
        return { top: 40, bottom: 10 }
      }
    },
    unit: {
      type: String,
      default: ''
    }
  },
  // <ve-histogram  :extend="extend" :legend-visible="false" :judge-width="true" :grid="grid" :data="chartData"/>
  data() {
    return {
      curWidth: 250,
      // 扩展
      extend: {
        series: {
          barWidth: this.barWidth || 'auto' // 柱状图宽度
        }
      }
    }
  },
  mounted(){
    // console.log(this.totalAmount)
  },
  methods: {

  }
}
</script>
<style scoped lang="scss">
.title{
  font-weight: bold;
}
::v-deep{
  .el-card__body{
    padding: 10px 5px;
  }
}
</style>
