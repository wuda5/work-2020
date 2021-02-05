<!--气价方案-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">气价方案</div>
    </div>
    <div slot="default" class="frameBody">
      <!-- 用气类型 -->
      <el-card shadow="never" class="listItem" style="background:#f7f7f7 ">
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="用气类型">
            <p>{{ useGasType.useGasTypeName || emptyStr }}</p>
          </el-form-item>
          <el-form-item label="价格类型">
            <p style="color: deeppink">{{ dictMap.PRICE_TYPE[useGasType.priceType] || emptyStr }}</p>
          </el-form-item>
        </el-form>
      </el-card>

      <template v-if="listData.length">
        <!-- 阶梯价格 -->
        <template v-if="useGasType.priceType === 'LADDER_PRICE'">
          <p class="tableTitle">阶梯价格</p>
          <table>
            <tr>
              <th>阶梯</th>
              <th>气量</th>
              <th>气价</th>
            </tr>
            <tr v-for=" i in 6" :key="i">
              <td>{{ i }}</td>
              <td>{{ listData[0][`gas${i}`] || emptyStr }}</td>
              <td>{{ listData[0][`price${i}`] || emptyStr }}</td>
            </tr>
          </table>
        </template>

        <!-- 固定价格 -->
        <template v-if="useGasType.priceType === 'FIXED_PRICE'">
          <p class="tableTitle">固定价格</p>
          <table>
            <tr>
              <th>气价</th>
            </tr>
            <tr>
              <td>{{ listData[0].fixedPrice }}</td>
            </tr>
          </table>
        </template>

        <!-- 采暖价格 -->
        <template v-if="useGasType.priceType === 'HEATING_PRICE'">
          <p class="tableTitle">采暖/非采暖价格</p>
          <table>
            <tr>
              <th>类型</th>
              <th>价格</th>
              <th>开始时间</th>
              <!--<th>结束时间</th>-->
            </tr>
            <tr>
              <td>采暖价</td>
              <td>{{ listData[0].price1 }}</td>
              <td>{{ listData[0].startTime }}</td>
              <!--<td>{{ listData[0].endTime }}</td>-->
            </tr>
            <tr>
              <td>非采暖价</td>
              <td>{{ listData[1].price1 }}</td>
              <td>{{ listData[1].startTime }}</td>
              <!--<td>{{ listData[1].endTime }}</td>-->
            </tr>
          </table>

        </template>
      </template>
      <el-alert
        v-else
        title="暂无数据"
        type="warning"
        show-icon
        :closable="false"
      >
      </el-alert>

    </div>
  </info-frame>
</template>
<script>
import tabsApi from '@/api/tabsInfo';

export default {
  name: 'PricePlan',
  props: {
    gasMeterCode: String
  },
  data() {
    return {
      // 用气类型
      useGasType: {},

      // 气价方案
      listData: [
        {
          level: '-',
          price: '-',
          value: '-',
          used: '-',
          unUsed: '-'
        }
      ],
    }
  },
  watch: {
    gasMeterCode() {
      if (this.gasMeterCode) {
        this.getPricePlan()
      }else {
        this.useGasType = {}
        this.listData = []
      }
    }
  },
  mounted() {
    if (this.gasMeterCode) {
      this.getPricePlan()
    }
  },
  methods: {
    //  获取账户流水
    getPricePlan() {
      let params = {
        gasMeterCode: this.gasMeterCode
      }

      tabsApi.priceScheme(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.useGasType = data.useGasType
          this.listData = data.priceSchemeList
        }
      })
    }
  }
}
</script>
<style lang="scss" scoped>

.frameBody {
  height: calc(100vh - 220px) !important;
}

.tableTitle {
  font-size: 16px;
  color: $primary;
}

table {
  width: 100%;
  text-align: center;
  border-collapse: collapse;
  padding: 2px;
  border: 1px solid #dfe6ec;

  tr {
    text-align: center;

    th, td {
      font-size: 14px;
      font-weight: normal;
      line-height: 30px;
      border: 1px solid #eee;
    }
  }
}

</style>

