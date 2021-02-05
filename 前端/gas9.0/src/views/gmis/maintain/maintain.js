/**
 * 运行维护页面
 */

import maintainStatistics from './components/maintainStatistics' // 统计模块
import nodeInfo from './components/nodeInfo' // 节点信息
import nodeRemove from './components/nodeRemove' // 节点信息
import nodeSwitch from './components/nodeSwitch' // 节点信息
import NodeWorkOrderEnd from './components/nodeWorkOrderEnd' // 结单
import sendOrder from './components/sendOrder' // 派单
import topSearch from './components/topSearch' // 顶部搜索

export default {
  name: 'MeterInfo',
  components: {
    topSearch,
    nodeInfo,
    nodeSwitch,
    nodeRemove,
    maintainStatistics,
    NodeWorkOrderEnd,
    sendOrder
  },
  data() {
    return {
      curMenu: 1, // footMenu 1:为节点运维 2:气表维护

      // 用户信息
      nodeInfoData: {
        1: 'cd100102',
        2: '通惠门站点',
        3: '通惠门路53号',
        4: '254789129874568745',
        5: '秦川',
        6: 'QC65478',
        7: '150mm',
        8: '120度-0度',
        9: '160帕-0帕',
        10: '800方-0方',
        11: '东经102º54’',
        12: '北纬30º05‘',
        13: '13589742589',
        14: '王俊'
      },
      // 表具信息
      meterInfoData: {
        meterNo: 124545,
        meterType: '卡表',
        meterCompany: '秦川',
        model: 'v1.5',
        version: '5A',
        gasDerection: '左近',
        regulatorBox: 'QC1.1',
        accountOpeningTime: '2011-11-17',
        gasUseTotal: 300,
        circleUse: 55,
        expiryDateInsurance: '2020-08-08',
        addr: '龙泉驿区3栋1单元25号'
      },
      // 表状态
      meterStatus: {
        1: '233',
        2: '3500',
        3: '开阀',
        4: '无',
        5: '1阶',
        6: '3.5',
        7: '2010.01.23',
        8: '345',
        9: '已通气',
        10: '无'
      },
      // 阶梯价格信息
      tieredPricing: {
        1: '100',
        2: '200',
        3: '300',
        4: '400',
        5: '0',
        6: '0',
        7: '3.50',
        8: '4.00',
        9: '4.50',
        10: '5.00',
        11: '0',
        12: '0'
      },
      // 应收金额
      amountReceivable: 360,
      // 实收金额
      theSumReceived: '',
      // 找零
      changeMoney: 0,

      // 收费列表
      tableData: [
        {
          1: 'CD4545',
          2: '成都青羊区站点',
          3: '通惠门路108号',
          4: '秦川',
          5: 'QC101',
          6: '20cm'
        },
        {
          1: 'CD4545',
          2: '成都青羊区站点',
          3: '通惠门路108号',
          4: '秦川',
          5: 'QC101',
          6: '20cm'
        },
        {
          1: 'CD4545',
          2: '成都青羊区站点',
          3: '通惠门路108号',
          4: '秦川',
          5: 'QC101',
          6: '20cm'
        },
        {
          1: 'CD4545',
          2: '成都青羊区站点',
          3: '通惠门路108号',
          4: '秦川',
          5: 'QC101',
          6: '20cm'
        }

      ],
      // 客户列表
      userTableData: [
        {
          1: '454545',
          2: '谢丹丹',
          3: '省份证',
          4: '511232188812547854',
          5: '18712587854',
          6: '民用',
          7: '个人',
          8: '黑名单'
        }
      ],
      // 工单列表
      workOrderList: [
        {
          1: '运维工单',
          2: '紧急',
          3: '2020.3.14',
          4: '13845874587',
          5: '运维',
          6: '王贝贝',
          7: '待完成'
        },
        {
          1: '运维工单',
          2: '紧急',
          3: '2020.3.14',
          4: '13845874587',
          5: '运维',
          6: '王贝贝',
          7: '待完成'
        }
      ],
      total: 360,
      showNodeSwitch: false, // 节点更换
      showNodeRemove: false, // 节点移除
      showNodeWorkOrderEnd: false, // 节点-结单
      showSendOrder: false // 派单
    }
  },
  methods: {
    exportMsg(msg) {
      this.$message({
        message: msg,
        type: 'success'
      })
    },

    search(dd) {
      console.log(dd)
    },
    
    // 实收金额
    receivedChange(val) {
      const receivedMoney = parseFloat(val)
      this.changeMoney = receivedMoney - this.amountReceivable
      console.log(val)
    },

    // 客户列表表格行点击
    rowClick(row, column, event) {
      console.log(row.userID)
      console.log(row, column, event)
    },

    // 表格赛选
    tableSelect(selection) {
      console.log(selection)
    },

    // 已处理
    done() {
      this.$message.success('已处理')
    },

    // 提审
    tishen() {
      this.$message.success('已提审')
    },

    // 审核
    check() {
      this.$message.success('已审核')
    },

    // 撤回
    recall() {
      this.$message.success('已撤回')
    },

    // 打印条码
    barPrint() {
      this.$message.success('已打印条码')
    },

    // 卡回收
    cardRecycle() {
      // todo 卡回收
      this.$message.success('卡回收')
    }

  }
}
