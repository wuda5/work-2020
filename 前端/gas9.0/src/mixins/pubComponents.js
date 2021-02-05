// 公共组件
import temporaryApi from '@/api/temporary/index.js'
import QcFootMenu from '@/components/QcFootMenu/index.vue' // footMenu
// morInfo
import QcMeterInfo from '@/components/QcMeterInfo/index' // 表具信息
// other
import AcceptForInstall from '@/components/QcPopUpWindow/AcceptForInstall' // 报装受理
import CardReplacement from '@/components/QcPopUpWindow/CardReplacement' // 补卡
import CardToZero from '@/components/QcPopUpWindow/CardToZero' // 卡清零
import GasReplacement from '@/components/QcPopUpWindow/GasReplacement' // 补气
import SignWithholding from '@/components/QcPopUpWindow/SignWithholding' // 代扣签约
// 全局搜索头部
import SearchBox from '@/components/QcSearchBox'
import InfoFrame from '@/components/QcTabsInfo/InfoFrame.vue' // 右侧tabs 框架
// pop window---------
import QcWorkOrder from '@/components/QcWorkOrder' // 创建工单
import ChargeTable from '@/components/WujhTest/ChargeTable' // 收费列表表格
import { arrayColumn } from '@/utils/array'
import { initQueryParams } from '@/utils/commons'
import { checkPermission } from '@/utils/permissionDirect'
import { mapState } from 'vuex'

export default {
  components: {
    QcFootMenu, // footMenu
    InfoFrame, // 右侧tabs 框架
    SearchBox, // 全局搜索头部
    QcMeterInfo, // 表具信息

    // pop window
    QcWorkOrder, // 工单
    CardReplacement, // 补卡
    GasReplacement, // 补气
    SignWithholding, // 代扣签约
    ChargeTable, // 收费列表表格
    AcceptForInstall, // 受理报装
    CardToZero, // 卡清零
  },
  data() {
    return {
      emptyStr: '---',
      // 弹出相关
      showCard: false, // 显示补卡
      showGas: false, // 显示补气
      showWithhold: false, // 代扣签约
      showWorkOrder: false, // 代扣签约
      showReturnPremium: false, // 退费
      showAccountReturnPremium: false, // 退费
      showSettleAccounts: false, // 结账
      showChargeBox: false, // 收费
      showCardToZero: false, // 卡清零
      showInfoEdit: false, // 编辑
      showOpenGas: false, // 通气
      showGetCard: false, // 发卡
      showRemoteControl: false, // 远程控制
      showAcceptForInstall: false, // 报装受理
      showOpenAnAccount: false, // 开户
      showOpenMoreAccount: false, // 批量开户
      showReconciliation: false, // 对账

      //
      isTest: false // 显示测试 tips: 用于展示隐藏那些不用测试的模块

    }
  },

  methods: {
    // 权限判断
    checkPermission,
    initQueryParams,

    // q全局右侧TAB切换
    tabsChange(tab) {
      // console.log(tab);
      this.curTabsLabel = tab.name
    },

    // 打开弹出框
    dialogOpen(key) {
      // console.log(key);
      this[key] = true
    },

    // 关闭弹出框
    dialogClose(key) {
      this[key] = false
    },

    // emit 关闭弹窗
    emitCloseDialog(name) {
      this.$emit('close', name)
    },

    // msg封装
    msg(message, type, showClose, center, offset) {
      this.$message({
        message: message,
        type: type || 'info',
        showClose: showClose || false,
        center: center || false,
        offset: offset || 20
      });
    },

    // 确认框封装
    confirm(text, title, okText, cancelText, type) {
      return this.$confirm(text, title, {
        confirmButtonText: okText,
        cancelButtonText: cancelText,
        type: type
      })
    },

    // 获取指定code字典数据
    getDictionaryDataByCode(code) {
      return this.dict[code] || []
    },
    // 获取指定字典数据键值对映射
    getDictionaryMapByCode(code, value = 'name', key = 'code') {
      return arrayColumn(this.dict[code] || [], value, key)
    },

    // 格式化组织组件下选择组织的控件
    formatOrgList(orgList) {
      let strOrgList = JSON.stringify(orgList)
      // console.log(strOrgList);
      var subStr = new RegExp('"children":null', 'ig');
      let strOrgList1 = strOrgList.replace(subStr, '"children":""');
      // console.log(strOrgList1);
      let newOrgList = JSON.parse(strOrgList1)
      // console.log(newOrgList);
      return newOrgList
    },

    // 格式化组织组件下选择组织的控件(递归方式)
    recursiveFunction(list) {
      const getStr = function (list) {
        list.forEach(function (row) {
          if (row.children && row.children.length !== 0) {
            getStr(row.children)
          } else {
            row.children = ''
          }
        })
        return list
      }
      getStr(list)
      return list
    },

    // 判断各场景是否收费
    whetherSceneCharge(sceneCode) {
      return new Promise((resolve) => {
        temporaryApi.whetherSceneCharge(sceneCode).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess && data) {
            resolve(true)
          } else {
            resolve(false)
          }
        })
        .catch(() => (resolve(false)))
      })
    },
  },
  computed: {
    ...mapState({
      // 系统全局字典
      dict: state => state.common.dict,
      // 系统全局字典Map
      dictMap: state => {
        let dict = state.common.dict
        // 参数转换
        let paramsMap = {}
        for (let key in dict) {
          paramsMap[key] = {}
          let item = dict[key]
          for (let i = 0; i < item.length; i++) {
            const itemElement = item[i];
            paramsMap[key][itemElement.code] = itemElement.name
          }
        }
        return paramsMap
      }
    })
  },
}
