/**
 * 客户档案页面
 */
// tools
import getUserInfoApi, {
  downloadOpenAccountTemplete,
  getUseGasTypeList
} from '@/api/userInfo/index'
import NoSelect from '@/components/QcNoSelect/index.vue' // 未选择数据提示
// 业务组件
import MeterForm from '@/components/QcOpenAccount/Form' // 客户和表具关联后的气表信息表单
import ImportOpenAccount from '@/components/QcOpenAccount/Import.vue' // 导入开户
// import QcOpenAccount from '@/components/QcOpenAccount/Index.vue' // 单个开户
import QcOpenAccount from '@/components/QcOpenAccount/Step.vue' // 单个开户(按步骤)
import AccountInfo from '@/components/QcTabsInfo/AccountInfo' // 账户信息
import ArrearageInfo from '@/components/QcTabsInfo/ArrearageInfo' // 欠费明细
import BuyLimit from '@/components/QcTabsInfo/BuyLimit.vue' // 购气限制信息
import ChangeRecords from '@/components/QcTabsInfo/ChangeRecords.vue' // 变更记录
// tabs
import CustomerDetails from '@/components/QcTabsInfo/CustomerDetails.vue' // 客户信息
import InsuranceInfo from '@/components/QcTabsInfo/InsuranceInfo.vue' // 保险信息
import MeterDetails from '@/components/QcTabsInfo/MeterDetails' // 表具信息
import PaymentRecords from '@/components/QcTabsInfo/PaymentRecords' // 缴费记录
import WorkOrder from '@/components/QcTabsInfo/WorkOrder' // 工单信息
import QcUpload from '@/components/QcUpload/index.vue' // 资料上传
import { dataStatusField } from '@/enums/common'
import { blackStatusField, blackStatusMap } from '@/enums/customerInfo'
import { dictionaryCodeMap } from '@/enums/dictionary'
import hobbyMixin from '@/mixins/hobby.js'
import { initQueryParams } from '@/utils/commons'
import { cloneDeep } from 'lodash'
import editGasMeterInfo from './components/editGasMeterInfo' // 编辑客户气表信息
import editUser from './components/editUserInfo.vue'
import ImportUserInfo from './components/ImportUserInfo.vue'
import GoodsInfo from './components/tabs/GoodsInfo.vue' // 商品信息
import UserRecordStatistics from './components/userRecordStatistics.vue' //统计数据

export default {
  name: 'UserInfo',
  components: {
    editGasMeterInfo,
    editUser,
    ImportUserInfo,
    QcOpenAccount,
    ImportOpenAccount,
    MeterForm,
    NoSelect,
    QcUpload,

    // tabs
    CustomerDetails,
    MeterDetails,
    InsuranceInfo, // 保险信息
    AccountInfo,
    ArrearageInfo,
    PaymentRecords,
    WorkOrder,
    BuyLimit,
    GoodsInfo,
    UserRecordStatistics, // 统计
    ChangeRecords
  },
  mixins: [hobbyMixin],
  data() {
    return {
      activeMeterId: null, // 气表tabs当前激活的气表id
      currentMeter: {}, // 当前激活的气表信息
      meterFilterKeywords: '', // 表具过滤关键字
      multipleSelection: [], // 多选的数据
      importUserinfoDialogVisible: false, // 导入客户档案信息弹出框标识
      openAccountDialogVisible: false, // 开户弹出框标识
      importOpenAccountDialogVisible: false, // 导入开户弹出框标识
      useGasTypeList: [], // 用气类型列表

      showGasTabInfo: false,
      showSwitchMeter: false,
      showEditMeterInfoToStore: false,
      showPreAccountOpening: false,
      showSecurityCheck: false,
      meterFormDialogVisible: false,
      showScanMeterToStore: false,
      showPriceChange: false,
      showUpload: false,
      isChickBtn: true,     // 客户列表的按钮是否可以点击，只有选择客户列表时可以点击;true-代表不可点击,false-代表可以点击

      //气表信息动
      userInfoData: [], //档案用户数据

      //查询参数设置
      queryParams: initQueryParams({
        model: {
          customerCode: null,
          customerName: null,
          telphone: null,
          customerTypeCode: null,
          useGasTypeId: null,
          gasCode: null,
          moreGasMeterAddress: null,
          customerChargeNo: null, // 缴费编号
          gasMeterNumber: null, // 表身号
          blackStatus: '', // 黑名单
          customerStatus: '' // 用户状态

        },
        // size:6
      }),
      userViewVisible: false,
      gasMeterData: [],

      //统计数据
      staticsData: {
        'suranceList': {},
        'customList': {},
        'purchaseLimitList': {},
        'customAddList': {}
      },
      currentItem: null,  //选中的当前客户
      editUserInfo: false,
      loading: false,
      meterListLoading: false, // 表具信息加载状态

      // 表具点击相关
      // curMeter: null,

      // 过户============================================
      showMeterTransfer: false, // 过户
      curMetersIndex: 0, // 默认为0，表具tabs切换，可更改此值
      transferStep: 1,

      stsSearchParam: {
        businessHallId: 0,
        companyCode: '',
        createUserId: 0,
        endDay: '',
        orgId: 0,
        startDay: '',
        stsDay: '',
        tcode: ''
      },

      curTabsLabel: '客户信息', // 右侧当前点击标签名

      // 开户组件props
      openAccountProps: {
        step: 1,
        customerCode: null,
        gasMeterCode: null,
      },

    }

  },
  filters: {
    emptyStr(val) {
      return !val ? '---' : val
    },
    blackStatusFilter(val) {
      return blackStatusMap[+val] ?? ''
    }
  },
  computed: {
    // 客户类型枚举
    userTypeMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.USER_TYPE)
    },
    // 选中的需要加入黑名单列表
    addBlackList() {
      return this.multipleSelection.filter((item) => +item.blackStatus === blackStatusField.NO)
    },
    // 选中的需要移出的黑名单列表
    removeBlackList() {
      return this.multipleSelection.filter((item) => +item.blackStatus === blackStatusField.YES)
    },
    // 用户表具数据列表(过滤)
    userMeterList() {
      return this.gasMeterData.filter((item) => {
        item.moreGasMeterAddress = item.moreGasMeterAddress || ''
        return item.moreGasMeterAddress.includes(this.meterFilterKeywords)
      })
    },

    // 客户状态map
    customerStatusMap() {
      return this.getDictionaryMapByCode(dictionaryCodeMap.CUMSTOMER_STATE)
    }

  },
  created() {
    // 获取用气类型列表
    this.getValidUseGasTypeList()

  },
  mounted() {
    this.fetch()
  },
  methods: {
    exportMsg(msg) {
      this.$message({
        message: msg,
      })
    },

    // 客户列表表格行点击
    rowClick(row, column, event) {
      // 点击当前行，默认不显示欠费信息，点击表具再判断
      this.showQf = false
      this.currentItem = row
      // 先清空选择，然后在选中该行多选
      this.$refs.customerTable?.clearSelection()
      this.$refs.customerTable?.toggleRowSelection(row, true)
      this.isChickBtn = false
      this.gasMeterData = []
      this.queryGasMeterFunc(row)
      this.curTabsLabel = '客户信息'
    },

    // 表具表格行点击
    meterRowClick(row, column, event) {

      // 处理欠费显示
      this.handleQf(row.orderSourceName)

      this.currentMeter = row
      this.curTabsLabel = '表具信息'
    },

    filterMeter() {
      console.log(this.meterFilterKeywords)

    },

    // 表格赛选
    tableSelect(selection) {
      console.log(selection)
    },

    // 加入黑名单
    addToBlacklist() {
      if (this.addBlackList.length <= 0) {
        this.$message.error('请选择需要移出黑名单客户')
      }
      this.loading = true
      const cloneAddBlackList = cloneDeep(this.addBlackList).map((item) => {
        item.blackStatus = blackStatusField.YES
        return item
      })
      getUserInfoApi.addBlacklist(cloneAddBlackList).then(response => {
        const res = response.data
        this.loading = false
        if (res.isSuccess) {
          this.$message({
            message: this.$t('tips.updateSuccess'),
            type: 'success',
          })
          this.$emit('success')
          this.userInfoData.records.forEach(item => {
            if (this.addBlackList.find((item1) => item1.id === item.id)) {
              item.blackStatus = blackStatusField.YES
            }
          })
        }
      })
    },

    // 移除黑名单
    removeFromBlacklist() {
      if (this.removeBlackList.length <= 0) {
        this.$message.error('请选择需要移出黑名单客户')
      }
      this.loading = true
      const cloneRemoveBlackList = cloneDeep(this.removeBlackList).map((item) => {
        item.blackStatus = blackStatusField.NO
        return item
      })
      getUserInfoApi.removeBlacklist(cloneRemoveBlackList).then(response => {
        this.loading = false
        const res = response.data
        if (res.isSuccess) {
          this.$message({
            message: this.$t('tips.updateSuccess'),
            type: 'success',
          })
          this.$emit('success')
          this.userInfoData.records.forEach(item => {
            if (this.removeBlackList.find((item1) => item1.id === item.id)) {
              item.blackStatus = blackStatusField.NO
            }
          })
        }
      })
    },

    // 打印条码
    printBarCode() {
      this.$message.success('打印条码')
    },
    /**
     * 用户档案列表查询
     */
    fetch(params = {}) {
      this.loading = true
      getUserInfoApi
        .getListData({ pageNo: this.queryParams.current, pageSize: this.queryParams.size, ...this.queryParams.model })
        .then(response => {
          this.loading = false
          const res = response.data
          if (res.isSuccess) {
            const data = res.data
            this.userInfoData = data
            this.$nextTick(() => {
              this.loadData()
            })
          }
        })
        .finally(() => (this.loading = false))
    },

    // 获取客户档案之后加载其它数据
    loadData() {
      // 如果当前选中的数据不存在于data中，则设置选中行高亮,气表数据置空
      const currentItem = this.userInfoData.records.find((item) => item.customerCode === this.currentItem?.customerCode)
      if (currentItem) {
        // 设置选中行高亮
        this.$refs?.customerTable?.setCurrentRow(currentItem)
        this.currentItem = currentItem
        this.queryGasMeterFunc(currentItem)
      } else {
        // 气表数据置空
        this.currentItem = null
        this.gasMeterData = []
      }
    },
    /**
     * 根据用户ID查询气表信息
     */
    queryGasMeterFunc(row) {
      this.meterListLoading = true
      const params = {
        customerCode: row.customerCode
      }
      getUserInfoApi
        .queryGasMeter(params)
        .then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.meterListLoading = false
            this.gasMeterData = res.data

            this.activeMeterId = res.data[0]?.id ?? null
            this.$nextTick(() => {
              this.afterGetMeterListLoadData()
            })
          }
        })
        .finally(() => (this.meterListLoading = false))
    },

    // 获取表具档案之后加载其它数据
    afterGetMeterListLoadData() {
      // 如果当前选中的数据不存在于data中，则设置选中行高亮,气表数据置空
      const currentItem = this.gasMeterData.find((item) => item.gasCode === this.currentMeter?.gasCode)
      if (currentItem) {
        // 设置选中行高亮
        this.$refs?.gasMeterTableRef?.setCurrentRow(currentItem)
        this.currentMeter = currentItem
      } else {
        // 当前气表数据置空
        this.currentMeter = null
      }
    },
    /**
     * 关闭详情页面
     */
    viewClose() {
      this.userViewVisible = false
    },
    /**
     * 暂时详情页面
     * @param row  选中的数据
     */
    view(row) {
      this.$refs.view.setUser(row)
      this.userViewVisible = true
    },
    /**
     * 客户档案搜索
     */
    search() {
      // 重置分页
      this.queryParams.current = 1
      this.fetch({
        ...this.queryParams,
      })
    },
    // 点击新增用户按钮
    handleUserinfo() {
      this.currentItem = null
      this.dialogOpen('editUserInfo')
    },
    edit(row) {
      this.currentItem = row
      this.dialogOpen('editUserInfo');
    },
    // 结束编辑
    endEdit() {
      this.dialogClose('editUserInfo');
      this.fetch();
    },

    // 重置筛选
    resetSearch(ref, isRefreshData = true) {
      ref = ref || this.searchFormRef
      this.$refs[ref]?.resetFields?.()
      this.queryParams.current = 1
      this.$nextTick(() => {
        isRefreshData && this.search?.()
      })
    },

    // 表格选择change
    handleSelectionChange(selection) {
      this.multipleSelection = selection
    },

    // 下载导入客户信息模板
    handleDownloadTemplateFile() {
      getUserInfoApi.downloadCustomerInfoTemplete().then((result) => {
        console.log('result', result)
      }).catch(() => {
      })
    },

    //导入客户信息成功
    handleImportUserInfoSuccess() {
      this.currentItem = null
      this.multipleSelection = []
      this.importUserinfoDialogVisible = false
      this.$nextTick(() => {
        this.resetSearch('searchFormRef')
      })
    },

    // 获取用气类型列表
    getValidUseGasTypeList() {
      return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({ model: { dataStatus: dataStatusField.VALID }, size: 10000 })).then((result) => {
          const { isSuccess, data } = result.data
          if (isSuccess) {
            const { records } = data
            this.useGasTypeList = records
            resolve(records)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        })
      })
    },
    // 开户成功后的回调
    handleOpenAccountSuccess(data) {
      // console.log('开户成功后的回调', data)
      const customerCode = data?.customerCode ?? null
      // 如果是当前用户正在开户，则刷新表具信息
      if (customerCode && customerCode === this?.currentItem?.customerCode) {
        this.queryGasMeterFunc(this.currentItem)
      }
      // 关闭弹框
      this.openAccountDialogVisible = false
    },

    // 开户信息保存成功
    handleOpenAccountSaveSuccess(data) {
      // console.log('data', data)
      // this.fetch()
    },

    // 开户信息保存成功
    handleOpenAccountDialogClose(isRefresh) {
      // console.log('data', data)
      this.openAccountDialogVisible = false
      if (isRefresh) {
        this.fetch()
      }
    },

    // 下载导入开户信息模板
    handleDownloadOpenAccountTemplateFile() {
      downloadOpenAccountTemplete().then((result) => {
        console.log('result', result)
      }).catch(() => {
      })
    },

    // 导入开户信息成功
    handleImportOpenAccountSuccess() {
      this.currentItem = null
      this.multipleSelection = []
      this.gasMeterData = []
      this.resetSearch('searchFormRef')
      this.$nextTick(() => {
        this.importOpenAccountDialogVisible = false
      })
    },

    // 打开客户和表具关联信息弹出框
    showMeterFormDialog(row) {
      this.currentMeter = row
      this.showGasTabInfo = true
    },

    // 打开开户资料弹窗
    showUploadDialog(row) {
      this.currentMeter = row
      this.showUpload = true
    },

    // 客户和表具关联信息保存成功回调
    handleMeterSaveSuccess(data) {
      console.log('客户和表具关联信息保存成功回调', data)
      this.queryGasMeterFunc(this.currentItem)
      this.$nextTick(() => {
        this.showGasTabInfo = false
      })
    },

    // 销户
    accountCancellation() {
      // let params = {
      //   customerCode: this.multipleSelection.map((item) => item.customerCode)
      // }
      this.$prompt('请输入销户原因', '提示', {
        inputValidator: (value) => {
          if (value === '' || value === null || value === undefined) {
            return '请输入销户原因'
          }
        },
      }).then(({ value }) => {
        this.loading = true
        const generateData = this.multipleSelection.map((item) => {
          return {
            ...item,
            reason: value,
          }
        })
        getUserInfoApi.batchCancelAccount(generateData).then(res => {
          const { isSuccess } = res.data
          if (isSuccess) {
            this.msg('销户成功', 'success')
            this.fetch()
          }
        }).finally(() => (this.loading = false))
      }).catch((err) => {
        console.log('err', err)
      })

    }
  }
}
