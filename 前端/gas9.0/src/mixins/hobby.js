/**
 * 用于右侧 户表信息，和欠费信息的处理
 */

export default {
  data() {
    return {
      showHb: false, // 显示右侧户表
      showQf: false, // 显示右侧欠费
    }
  },
  methods: {
    /* 
      欠费明细和户表信息的显示规则

      普表(READMETER_PAY):              欠费明细（显示）、  户表信息（不显示）
      IC卡表(IC_RECHARGE):              欠费明细（不显示）、户表信息（不显示）
      物联网后付费表(REMOTE_READMETER)： 欠费明细（显示）、  户表信息（显示）
      物联网预付费表(CENTER_RECHARGE)：  欠费明细（不显示）、户表信息（显示）
      物联网预付费表(REMOTE_RECHARGE)：  欠费明细（不显示）、户表信息（显示）
      */

    // 欠费明细
    handleQf(orderSourceName) {
      // console.log('欠费明细处理');
      if (['READMETER_PAY', 'REMOTE_READMETER'].includes(orderSourceName)) {
        this.showQf = true
      } else {
        this.showQf = false
        this.curTabsLabel = '客户信息'
      }
    },

    //户表信息
    handleHb(orderSourceName) {
      // console.log('户表信息处理');
      if (['REMOTE_READMETER', 'CENTER_RECHARGE', 'REMOTE_RECHARGE'].includes(orderSourceName)) {
        this.showHb = true
      } else {
        this.showHb = false
        this.curTabsLabel = '客户信息'
      }
    }
  }
}