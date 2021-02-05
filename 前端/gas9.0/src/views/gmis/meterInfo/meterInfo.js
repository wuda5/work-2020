/**
 * 表具档案页面
 */
import { downloadMeterInfoTemplete, getCustomerByMeter, getListData, getStaticsData } from '@/api/meterInfo/index'
import RemoteControl from '@/components/QcPopUpWindow/RemoteControl' // 远程控制
import { formStatusField } from '@/enums/form'
import { dictionaryCodeMap } from '@/enums/dictionary'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import meterMixin from '@/mixins/meter'
import { cloneDeep, isNull, isUndefined, merge } from 'lodash'
import ImportMeterInfo from './components/ImportMeterInfo' // 导入表具信息
import MeterToStore from './components/MeterToStore' // 新增表具
import preAccountOpening from './components/preAccountOpening' // 预开户
import ScanMeterToStore from './components/ScanMeterToStore' // 扫描入库
import MeterForm from '@/components/QcOpenAccount/Form' // 客户和表具关联后的气表信息表单
import RegisterAgain from './components/RegisterAgain.vue' // 物联网重新注册
import IotParamterSetting from '@/components/IotParamterSetting/Index.vue' // 物联网表参数设置

// tabs
import ToStoreInfo from './components/tabs/ToStoreInfo.vue' // 入库信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails' // 表具信息
import CardInfo from '@/components/QcTabsInfo/CardInfo' // IC卡信息
import PricePlan from '@/components/QcTabsInfo/PricePlan' // 气价方案
import MeterStatusDetails from '@/components/QcTabsInfo/MeterStatusDetails.vue' // 气表状态
import SafeCheckInfo from '@/components/QcTabsInfo/SafeCheckInfo' // 安检信息
import WorkOrder from '@/components/QcTabsInfo/WorkOrder' // 工单信息
import ReadMeterRecords from '@/components/QcTabsInfo/ReadMeterRecords.vue' // 抄表记录
import DirectiveInfo from '@/components/QcTabsInfo/DirectiveInfo.vue' // 指令信息
import meterRecordStatistics from './components/meterRecordStatistics.vue' // 统计模块
// 读卡
import CardApi from '@/api/card/index'
import commandApi from '@/api/maintain/command'

export default {
  name: 'MeterInfo',
  components: {
    preAccountOpening,
    MeterToStore,
    ScanMeterToStore,
    ImportMeterInfo,
    RemoteControl,
    MeterForm,
    RegisterAgain,
    IotParamterSetting,

    // tabs
    ToStoreInfo,
    MeterDetails,
    MeterStatusDetails,
    CardInfo,
    PricePlan,
    WorkOrder,
    SafeCheckInfo,
    meterRecordStatistics,
    ReadMeterRecords,
    DirectiveInfo

  },
  mixins: [commonMixin, listMixin, meterMixin],
  filters: {},
  data() {
    this.formStatusField = formStatusField
    return {
      searchForm: {
        gasCode: null, // 气表表号
        gasMeterNumber: null, // 气表编号
        customerChargeNo: null, // 缴费编号
        gasMeterAddress: null, // 安装地址
        dataStatus: [], // 气表状态
        orderSourceName: [], // 订单来源
      },

      rightActiveTabName: 'meterInfo', // 右侧当前激活的tab name
      detailData: {}, //统计数据
      // 客户信息
      customerInfoData: null,
      // 表具信息
      meterInfoData: null,
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

      showPreAccountOpening: false,
      showSecurityCheck: false,
      meterFormDialogVisible: false, // 表具表单弹框标识
      meterImportDialogVisible: false, // 表具导入弹框标识
      scanMeterToStoreDialogVisible: false, // 扫码入库弹出框标识
      openGasDialogVisible: false, // 通气弹出框标识
      remoteControlDialogVisible: false, // 远程控制弹出框标识
      openAccountMeterFormDialogVisible: false, // 开户之后表具编辑
      registerAgainDialogVisible: false, // 物联网表重新注册弹框
      iotParamterSettingDialogVisible: false, // 物联网表参数设置弹框

      curTabsLabel: '表具信息', // 右侧当前点击标签名
      readCardLoading: false,
      removeMeterLoading: false, // 移除设备loading
    }
  },
  computed: {
    // 气表类型map
    gasMeterTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.ORDER_SOURCE_NAME)
    },
  },
  created() {
    this.initData()
  },
  methods: {
    // 初始化数据
    async initData() {
      await this.getList()

    },
    // 获取列表
    async getList(params = {}) {
      return new Promise((resolve) => {
        this.listLoading = true
        params = merge({ pageNo: this.queryParams.current, pageSize: this.queryParams.size }, this.searchForm, params)
        getListData(params).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { total, records } = data
            this.total = total
            this.list = records
            this.$nextTick(() => {
              this.loadData()
            })
          }
          resolve(isSuccess)
        }).catch(() => {
          resolve(false)
        }).finally(() => (this.listLoading = false))
      })
    },

    // 获取表具档案之后加载其它数据
    loadData() {
      const meter = this.list.find((item) => item.id === this.meterInfoData?.id) || (this.list.length === 1 ? this.list[0] : null)
      if (meter) {
        // 设置选中行高亮
        this.$refs[this.listRef]?.setCurrentRow(meter)
        this.meterInfoData = cloneDeep(meter)
        this.getCustomerInfoData()
      } else {
        this.meterInfoData = null
      }
    },

    exportMsg(msg) {
      this.$message({
        message: msg,
        type: 'success'
      })
    },

    // 读卡
    async handleReadCard() {
      this.readCardLoading = true
      const res = await CardApi.readCar(this.getList, () => {
        this.readCardLoading = false
      },true)
      this.readCardLoading = false
    },

    // 表具信息保存成功
    async handleMeterSaveSuccess() {
      await this.getList()
      this.meterFormDialogVisible = false
    },
    // 客户和表具关联信息保存成功回调
    async handleOpenAccountMeterSaveSuccess() {
      await this.getList()
      this.openAccountMeterFormDialogVisible = false
    },

    // 点击新增按钮
    handleAdd() {
      this.$refs[this.listRef]?.setCurrentRow()
      this.meterInfoData = null
      setTimeout(() => {
        this.meterFormDialogVisible = true
      }, 0)
    },
    // 点击编辑按钮
    handleEdit(row) {
      // this.meterFormDialogVisible = true
      setTimeout(() => {
        if (this.isAfterOpenAccount(row)) {
          // this.meterInfoData = row
          this.openAccountMeterFormDialogVisible = true
        } else {
          this.meterFormDialogVisible = true
        }
      })
    },

    // 下载导入客户信息模板
    handleDownloadTemplateFile() {
      downloadMeterInfoTemplete().then((result) => {
        console.log('result', result)
      }).catch(() => {
      })
    },

    //导入表具信息成功
    handleImportMeterInfoSuccess() {
      this.meterImportDialogVisible = false
      this.$nextTick(() => {
        this.resetSearch()
      })
    },

    // 扫码入库保存成功
    handleScanMeterInfoSuccess() {
      this.scanMeterToStoreDialogVisible = false
      this.$nextTick(() => {
        this.resetSearch()
      })
    },

    // 物联网表重新注册
    handleRegisterAgainSuccess() {
      this.registerAgainDialogVisible = false
      this.$nextTick(() => {
        this.resetSearch()
      })
    },

    // 当某一行被点击时会触发该事件
    handleRowClick(row, column, event) {
      // console.log('row', row)
      this.$nextTick(() => {
        this.meterInfoData = cloneDeep(row)
        this.getCustomerInfoData()
      })
    },

    // 获取客户信息
    getCustomerInfoData() {
      return new Promise((resolve) => {
        getCustomerByMeter({ gasMeterCode: this.meterInfoData?.gasCode ?? null }).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            this.customerInfoData = data
            resolve(data)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },

    // 通气信息保存成功,更新数据
    handleOpenGasSuccess(data) {
      // console.log('data', data)
      // const { id } = data
      // const index = this.list.findIndex((item) => item.id === id)
      // if (index !== -1) {
      //   this.list.splice(index, 1, data)
      //   this.meterInfoData = data
      // }
      // // 设置选中行高亮
      // this.$refs[this.listRef]?.setCurrentRow(data)
      // this.$nextTick(() => {
      //   this.openGasDialogVisible = false
      // })
      this.openGasDialogVisible = false
      this.resetSearch()
    },

    handleRemoveMeter() {
      this.removeMeterLoading = true
      commandApi.removeMeter({ gasMeterNumber: this.meterInfoData?.gasMeterNumber ?? '' }).then((response) => {
        const { isSuccess } = response.data
        if (isSuccess) {
          this.$message.success(this.$t('移除设备指令发送成功！'))
          this.handleGetList()
        }
      }).catch(() => {}).finally(() => (this.removeMeterLoading = false))
    },

  }
}
