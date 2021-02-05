<!-- 日常综合 --tabs统计 -->
<template>
  <info-frame>
    <template v-slot:title>
      <search-box>
        <div slot="left" class="subTitle">{{ $t('统计') }}</div>
        <div slot="right">
          <el-button-group>
            <el-button :type="timeType===1? 'primary':''" @click="changeTimeType(1)">当日</el-button>
            <el-button :type="timeType===2? 'primary':''" @click="changeTimeType(2)">当月</el-button>
          </el-button-group>
        </div>
      </search-box>
    </template>

    <div slot="default" class="frameBody">
      <!-- 收费金额统计 -->
      <chart-bar
        title="收费金额统计"
        unit="元"
        :width="curWidth"
        :total-amount="chargeAmount"
        :chart-data="chargeAmountData"
        :bar-width="20"
      />

      <!-- 退费金额统计 -->
      <chart-bar
        title="退费金额统计"
        unit="元"
        :width="curWidth"
        :total-amount="refundAmount"
        :chart-data="refundAmountData"
        :bar-width="20"
      />

      <!-- 发票数量统计 -->
      <chart-bar
        title="发票数量统计"
        unit="张"
        :width="curWidth"
        :total-amount="invoiceNumberAmount"
        :chart-data="invoiceNumberData"
        :legend-visible="true"
      />

      <!-- 发票金额统计 -->
      <chart-bar
        title="发票金额统计"
        unit="元"
        :width="curWidth"
        :total-amount="invoiceMoneyAmount"
        :chart-data="invoiceMoneyData"
        :legend-visible="true"
      />

    </div>
  </info-frame>
</template>

<script>
import ChartBar from '@/components/Charts/ChartBar' // 图表
import tjApi from '@/api/statistics/index.js'

export default {
  name: 'Chart',
  components: {
    ChartBar,
  },
  data() {
    return {
      curWidth: '250px',
      userId: this.$store.state.account.user.id, // 当前用户ID
      timeType: 1,
      // 收费金额统计
      chargeAmount: 0,
      chargeAmountData: {
        columns: ['来源', '金额'],
        rows: [
          /*{'来源': '支付宝', 金额: 5000},
          {'来源': '微信', 金额: 5000},
          {'来源': '银联', 金额: 5000},
          {'来源': '现金', 金额: 5000},
          {'来源': '其它', 金额: 5000},*/
        ],
      },

      // 退费金额统计
      refundAmount: 0,
      refundAmountData: {
        columns: ['来源', '金额'],
        rows: [
          /*{'来源': '支付宝', 金额: 5000},
          {'来源': '微信', 金额: 5000},
          {'来源': '银联', 金额: 5000},
          {'来源': '现金', 金额: 5000},
          {'来源': '其它', 金额: 5000},*/
        ],
      },

      // 发票数量统计
      invoiceNumberAmount: 0,
      invoiceNumberData: {
        columns: ['分类', '蓝票', '红票', '废票'],
        // columns: [
        //   this.$t('tjDailyWork.classify'),
        //   this.$t('tjDailyWork.blueTicket'),
        //   this.$t('tjDailyWork.redTicket'),
        //   this.$t('tjDailyWork.invalidatedTicket')
        // ],
        rows: [
          // {分类: '普票', 蓝票: 5000, 红票: 2000, 废票: 1010},
          // {分类: '专票', 蓝票: 1393, 红票: 2000, 废票: 100},
          // {分类: '电子票', 蓝票: 1093, 红票: 2000, 废票: 10},
        ],
      },

      // 发票金额统计
      invoiceMoneyAmount: 0,
      invoiceMoneyData: {
        columns: ['分类', '蓝票', '红票', '废票'],
        rows: [
          // {分类: '普票', 蓝票: 5000, 红票: 2000, 废票: 1010},
          // {分类: '专票', 蓝票: 1393, 红票: 2000, 废票: 100},
          // {分类: '电子票', 蓝票: 1093, 红票: 2000, 废票: 10},
        ],
      },

    }
  },
  watch: {},
  mounted() {
    this.getWidth()
    window.onresize = () => {
      return (() => {
        this.getWidth()
      })();
    };
  },
  created() {
    this.getInvoiceData()
    this.getChargeData()
    this.chargeRefundData()
    // this.initData()
  },
  beforeDestroy() {
    window.onresize = null
  },
  methods: {
    // get width
    getWidth() {
      let width = document.getElementsByClassName('infoFrame')[0].clientWidth;
      this.curWidth = width - 15 + 'px'
    },

    // 获取发票数量、金额
    getInvoiceData() {
      // 查询条件
      let params = {
        createUserId: this.userId,
        dataMap: {
          timeType: this.timeType
        }
      }
      tjApi.DInvoiceData(params).then((res) => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          // 发票数量统计
          this.invoiceNumberAmount = data.totalNum
          this.invoiceNumberData.rows = [
            {
              分类: '普票',
              蓝票: data.general.kindList[1].amount,
              红票: data.general.kindList[0].amount,
              废票: data.general.kindList[2].amount
            },
            {
              分类: '专票',
              蓝票: data.special.kindList[1].amount,
              红票: data.special.kindList[0].amount,
              废票: data.special.kindList[2].amount
            },
            {
              分类: '电子票',
              蓝票: data.electronic.kindList[1].amount,
              红票: data.electronic.kindList[0].amount,
              废票: data.electronic.kindList[2].amount
            },
          ]

          // 发票金额统计
          this.invoiceMoneyAmount = parseFloat(data.totalMoney)
          this.invoiceMoneyData.rows = [
            {
              分类: '普票',
              蓝票: parseFloat(data.general.kindList[1].totalAmount),
              红票: parseFloat(data.general.kindList[0].totalAmount),
              废票: parseFloat(data.general.kindList[2].totalAmount),
            },
            {
              分类: '专票',
              蓝票: parseFloat(data.special.kindList[1].totalAmount),
              红票: parseFloat(data.special.kindList[0].totalAmount),
              废票: parseFloat(data.special.kindList[2].totalAmount),
            },
            {
              分类: '电子票',
              蓝票: parseFloat(data.electronic.kindList[1].totalAmount),
              红票: parseFloat(data.electronic.kindList[0].totalAmount),
              废票: parseFloat(data.electronic.kindList[2].totalAmount),
            },
          ]
        }
      })
    },

    // 收费金额
    getChargeData() {
      // 查询条件
      let params = {
        createUserId: this.userId,
        dataMap: {
          timeType: this.timeType
        }
      }

      tjApi.DChargeData(params).then((res) => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          // 遍历，取到总金额
          let total = 0
          let charData = []
          for (let i = 0; i < data.length; i++) {
            const item = data[i];
            total += parseFloat(item.amount)
            const row = {
              '来源': item.typeName,
              '金额': item.amount
            }
            charData.push(row)
            this.chargeAmount = total
            this.chargeAmountData.rows = charData
          }
        }
      })
    },

    // 退费金额
    chargeRefundData() {
      // 查询条件
      let params = {
        createUserId: this.userId,
        dataMap: {
          timeType: this.timeType
        }
      }
      tjApi.DChargeRefundData(params).then((res) => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          // 遍历，取到总金额
          let total = 0
          let charData = []
          for (let i = 0; i < data.length; i++) {
            const item = data[i];
            total += parseFloat(item.amount)
            const row = {
              '来源': item.typeName,
              '金额': item.amount
            }
            charData.push(row)
            this.refundAmount = total
            this.refundAmountData.rows = charData
          }
        }
      })
    },

    // 切换时间
    changeTimeType(type) {
      this.timeType = type
      this.getInvoiceData()
      this.getChargeData()
      this.chargeRefundData()
    }
  },

// ★★★★★★
// const langMap = this.$i18n.messages[this.$i18n.locale]
// this.$message({
//   // message: langMap.navbar.switchLanguage,
//   message: this.$t('navbar.switchLanguage'),
//   type: 'success'
// })
}
</script>
