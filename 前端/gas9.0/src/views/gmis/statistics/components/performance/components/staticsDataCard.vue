<!--统计分析数据卡片-->
<template>
  <div class="ts-data-card" :style="cardBgColor">
    <slot>
      <div class="counterTitle">{{ title }}</div>
      <div class="counterText">
        <el-row>
          <!-- 今日 -->
          <el-col class="counterLine">
            <span>{{ cardData.todayData }}</span>
            <span style="font-size:24px;">{{ cardData.data.today | filterEmpty }}</span>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <!-- 本月 -->
          <el-col :span="12" class="counterLine">
            <span>{{ cardData.monthData }}</span>
            <span>{{ cardData.data.month | filterEmpty }}</span>
          </el-col>
          <!-- 本年 -->
          <el-col :span="12" class="counterLine">
            <span>{{ cardData.yearData }}</span>
            <span>{{ cardData.data.year | filterEmpty }}</span>
          </el-col>
        </el-row>
        <el-row>
          <!-- 累计 -->
          <el-col class="counterLine">
            <span>{{ cardData.totalData }}</span>
            <span>{{ cardData.data.total | filterEmpty }}</span>
          </el-col>
        </el-row>
      </div>
      <div v-if="false" class="export" @click="exportData(title)">
        <div class="export-icon">
          <svg-icon icon-class="export_fill"></svg-icon>
        </div>
        <span>导出数据</span>
      </div>
      <span v-if="showTail" class="footerTail" :style="cardBdColor"></span>
    </slot>
    <!-- 导出数据 -->
    <el-dialog
      width="1000px"
      :title="exportTitle"
      :visible.sync="showexportData"
    >
      <export-data v-if="showexportData" />
    </el-dialog>
  </div>
</template>
<script>
import ExportData from '../../exportData'

export default {
  name: 'StaticsDataCard',
  components: {
    ExportData
  },
  filters: {
    filterEmpty(val) {
      if (val == null) {
        return '--'
      } else {
        return val
      }
    }
  },
  props: {
    bgColor: {
      type: String,
      default: '#8EA3FA'
    },
    title: {
      type: String,
      default: '你的标题呢!'
    },
    showTail: {
      type: Boolean,
    },
    cardData: {
      type: Object,
      default: function () {
        return {
          title: '客户量',
          todayData: '今日新增(户)',
          monthData: '本月新增(万户)',
          yearData: '本年新增(万户)',
          totalData: '累计客户量(万户)',
          data: {
            month: '0',
            today: '0',
            total: '79',
            year: '0',
          }
        }
      }
    }
  },
  data() {
    return {
      exportTitle: '',
      showexportData: false
    }
  },
  computed: {
    cardBgColor() {
      return {backgroundColor: this.bgColor}
    },
    cardBdColor() {
      return {borderTop: `10px solid ${this.bgColor}`}
    }
  },
  mounted() {
    // console.log(this.showTail.showTail);
  },
  methods: {
    exportData(title) {
      this.exportTitle = `${title}数据导出`
      this.showexportData = true
    }
  }
}
</script>

<style lang="scss">
.ts-data-card {
  height: 100%;
  border-radius: 10px;
  color: #fff;
  padding: 20px 10px;
  position: relative;

  .counterTitle {
    opacity: 0.9;
    font-size: 18px;
    text-align: left;
  }

  .counterText {
    opacity: 0.8;
    font-size: 12px;
    margin-top: 15px;
    height: 80%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-content: space-around;

    .counterLine {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-content: space-between;
    }

    span {
      margin-top: 5px;
    }
  }

  .export {
    font-size: 12px;
    width: 50px;
    cursor: pointer;
    position: absolute;
    top: 12px;
    right: 10px;
    opacity: .8;
    text-align: center;

    .export-icon {
      display: flex;
      justify-content: center;
      align-items: center;

      border-radius: 100%;
      width: 40px;
      height: 40px;
      opacity: 1;
      margin: 0 auto 5px;
      background-color: rgba(0, 0, 0, 0.15);
      text-align: center;
      overflow: hidden;

      .svg-icon {
        font-size: 16px;
      }
    }
  }

  .footerTail {
    width: 0;
    height: 0;
    border: 10px solid transparent;
    position: absolute;
    left: calc(50% - 10px);
    bottom: -20px;
  }

}
</style>

