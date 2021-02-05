<!--发票管理-->
<template>
  <div>
    <el-tabs v-model="activeName" v-loading="loading" @tab-click="handleTabClick">
      <!-- 操作按钮 -->
      <div class="card-tool-bar">
        <!--search-->
        <el-input
          v-show="activeName === 'invoice'"
          v-model="queryParam.invoice.model.queryString"
          placeholder="请输入内容"
          class="input-with-select"
          style="margin-bottom: 12px; margin-right: 12px; width: 240px"
        >
          <el-button slot="append" type="primary" icon="el-icon-search" @click="handleSearch"></el-button>
        </el-input>
        <!--筛选-->
        <el-dropdown v-show="activeName === 'invoice'" :hide-on-click="false" @visible-change="handleVisibleChange">
          <el-button type="primary">
            发票筛选<i class="el-icon-arrow-down el-icon--right"></i>
          </el-button>
          <el-dropdown-menu slot="dropdown">
            <!-- <el-dropdown-item @click.native="handleSearch">重试</el-dropdown-item> -->
            <el-dropdown-item>
              <el-checkbox
                v-model="checkAll"
                :indeterminate="isIndeterminate"
                @change="handleCheckAllChange"
              >全选
              </el-checkbox>
            </el-dropdown-item>
            <!-- 发票类型 -->
            <el-checkbox-group
              v-model="queryParam.invoice.model.invoiceTypeList"
              @change="handleCheckedTypeChange"
            >
              <el-dropdown-item v-for="({label, value}) in filterTypes.invoiceType" :key="value">
                <el-checkbox :label="value">{{ label }}</el-checkbox>
              </el-dropdown-item>
            </el-checkbox-group>
            <!-- 发票种类 -->
            <el-checkbox-group
              v-model="queryParam.invoice.model.invoiceKindList"
              @change="handleCheckedKindChange"
            >
              <el-dropdown-item v-for="({label, value}) in filterTypes.invoiceKind" :key="value">
                <el-checkbox :label="value">{{ label }}</el-checkbox>
              </el-dropdown-item>
            </el-checkbox-group>
            <!-- 发票状态 -->
            <el-checkbox-group
              v-model="queryParam.invoice.model.invoiceStatusList"
              @change="handleCheckedStatusChange"
            >
              <el-dropdown-item v-for="({label, value}) in filterTypes.invoiceStatus" :key="value">
                <el-checkbox :label="value">{{ label }}</el-checkbox>
              </el-dropdown-item>
            </el-checkbox-group>
            <!-- 废票 -->
            <el-dropdown-item>
              <el-checkbox v-model="queryParam.invoice.model.invalidStatus" :true-label="1" :false-label="0">废票
              </el-checkbox>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>

      <el-tab-pane label="缴费记录" name="bill">
        <ChargeList
          ref="chargeListComponent"
          :search-charge-form="searchChargeForm"
          :charge-list="chargeList"
          :search="search"
          :get-charge-list="getChargeList"
          :handle-row-click="handleChargeRowClick"
        />
      </el-tab-pane>
      <el-tab-pane label="发票" name="invoice">
        <el-card shadow="never" class="no-border">
          <div slot="header">
            <span class="card-title">发票管理</span>
          </div>
          <invoice :invoice-list="invoiceList" @pagination="getInvoiceList" @row-click="handleRowClick" />
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <el-divider />
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">{{ activeName === 'bill' ? '缴费' : '发票' }}明细</span>
      </div>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-table
            :data="invoiceDetailList"
            :border="false"
            :stripe="true"
            height="300px"
            style="width: 100%"
          >
            <el-table-column
              prop="chargeItemName"
              label="商品名称"
              show-overflow-tooltip
            >
              <template slot-scope="{row}">
                <p v-if="activeName === 'bill'">
                  {{ row.chargeItemName | emptyStr }}
                </p>
                <p v-else>
                  {{ row.goodsName | emptyStr }}
                </p>
              </template>
            </el-table-column>
            <el-table-column
              v-if="activeName === 'bill'"
              prop="chargeItemGas"
              label="数量"
            >
              <template slot-scope="{row}">
                <p v-if="activeName === 'bill'">
                  {{ row.totalCount | emptyStr }}
                </p>
                <p v-else>
                  {{ row.number | emptyStr }}
                </p>
              </template>
            </el-table-column>
            <el-table-column
              prop="price"
              label="单价"
            >
              <span slot-scope="{row}">
                {{ row.price | emptyStr }}
              </span>
            </el-table-column>

            <el-table-column
              v-if="activeName === 'bill'"
              prop="price"
              label="气量"
            >
              <span slot-scope="{row}">
                {{ row.chargeItemGas | emptyStr }}
              </span>
            </el-table-column>
            <el-table-column
              prop="chargeItemMoney"
              label="金额"
            >
              <template slot-scope="{row}">
                <p v-if="activeName === 'bill'">
                  {{ row.chargeItemMoney | emptyStr }}
                </p>
                <p v-else>
                  {{ row.money | emptyStr }}
                </p>
              </template>
            </el-table-column>
          </el-table>
        </el-col>
        <el-col :span="12">
          <el-form ref="deitailForm" label-position="top" :rules="rules" :model="invoiceDetailForm" class="jh-text invoiceForm">
            <el-form-item label="发票类型" prop="invoiceType">
              <el-select v-model="invoiceDetailForm.invoiceType" :disabled="activeName === 'invoice'">
                <el-option
                  v-for="{ label, value } in filterTypes.invoiceType"
                  :key="value"
                  :value="value"
                  :label="label"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="发票编号">
              <el-input v-model="invoiceDetailForm.invoiceNumber" :disabled="invoiceNumberVisible"></el-input>
            </el-form-item>
            <template v-if="!editable">
              <el-form-item label="历史发票记录">
                <el-select
                  v-model="invoiceDetailForm.preBuyerName"
                  placeholder="请选择"
                  
                  clearable
                  filterable
                  allow-create
                  @change="handleBuyerName"
                >
                  <el-option
                    v-for="(item, idx) in invoiceFormList"
                    :key="item.buyerName"
                    :label="item.buyerName"
                    :value="idx"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="抬头类型">
                <el-select
                  v-model="buyerTypeValue"
                  clearable
                  placeholder="选择抬头类型"
                  @change="buyerTypeChange"
                >
                  <el-option
                    v-for="item in buyerType"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="发票抬头" prop="buyerName">
                <el-input v-model="invoiceDetailForm.buyerName"></el-input>
              </el-form-item>
              <el-form-item label="纳税人识别号">
                <el-input v-model="invoiceDetailForm.buyerTinNo"></el-input>
              </el-form-item>
              <el-form-item label="地址">
                <el-input v-model="invoiceDetailForm.buyerAddress"></el-input>
              </el-form-item>
              <el-form-item label="联系电话">
                <el-input v-model="invoiceDetailForm.buyerPhone"></el-input>
              </el-form-item>
              <el-form-item label="开户行">
                <el-input v-model="invoiceDetailForm.buyerBankName"></el-input>
              </el-form-item>
              <el-form-item label="账号">
                <el-input v-model="invoiceDetailForm.buyerBankAccount"></el-input>
              </el-form-item>
            </template>
            <div class="clearfix"></div>
            <div class="btnBox">
              <!-- 开票：限制条件为当前 发票/票据 的状态为未开票才可以调用 -->
              <!-- 发票补打的状态来自于打印机返回的错误码 -->

              <!--
                逻辑梳理：
                开票：
                未开票的（选择是非票据的），可以开票

                补打：
                开票失败的
                票据状态为失败的情况下，才能重开，只能在票据下显示

                重开：
                票据状态为成功的情况下，才能重开，只能在票据下显示

                打印：
                只在缴费记录模块下显示
              -->

              <!--开票-->
              <el-button
                v-if="!editable"
                type="primary"
                :loading="openLoading"
                :disabled="openBtnDisabled"
                @click="handleOpen"
              >开票
              </el-button>

              <!-- 重开发票 -->
              <el-button
                v-if="rePrintTickBill"
                :disabled="!isPrint"
                type="primary"
                @click="reMakeOutAnInvoice"
              >重开
              </el-button>

              <!-- 补打发票 -->
              <el-button
                v-if="activeName === 'invoice' && invoiceDetailForm.invoiceStatus === '3'"
                :disabled="!isPrint"
                type="primary"
                @click="rePrintInvoice"
              >补打
              </el-button>

              <!--打印票据-->
              <el-button :disabled="!isPrint" type="primary" @click="handlePrint">打印票据</el-button>
            </div>
          </el-form>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import {cloneDeep, debounce} from 'lodash'
import Invoice from './components/Invoice'
import ChargeList from '@/components/QcRefund/components/ChargeList'
import InvoiceApi from '@/api/dailyWork/invoiceManage'
import ChargeApi from '@/api/charges'
import Api from '@/api/invoice/index'
import {parseDate2Str, initQueryParams, checkPhone} from '@/utils/commons'
import print from '@/utils/print/print.js'
import { deepClone } from '@/utils'

export default {
  name: 'InvoiceManage',
  components: {
    Invoice,
    ChargeList,
  },
  data() {
    return {
      loading: false,
      openLoading: false,
      invoiceNumberEntry: false, // false 自动生成 true 人工输入
      // 打印机错误状态标识 - 控制按钮显示文本
      activeName: 'bill',
      queryParam: {
        invoice: initQueryParams({
          size: 3,
          model: {
            queryString: '',
            invoiceTypeList: [],
            invoiceKindList: [],
            invoiceStatusList: [],
            invalidStatus: 0, // 是否废票 1 是， 0 否
          },
        }),
      },
      searchChargeForm: {
        customerChargeNo: '',
        start: '',
        end: '',
        chargeNo: '',
        activeDate: null,
      },
      chargePrams: {
        model: {
          chargeNo: '',
          customerChargeNo: '',
          customerCode: '',
          end: '',
          gasMeterCode: '',
          start: '',
        },
        current: 1,
        size: 5,
      },
      chargeList: {},
      chargeDetailList: [],
      invoiceFormList: [],
      // 发票筛选条件
      filterTypes: {
        invoiceType: [
          {
            label: '普票',
            value: 'GENERAL_INVOICE',
          },
          {
            label: '专票',
            value: 'SPECIAL_INVOICE',
          },
          {
            label: '电子票',
            value: 'ELECTRONIC_INVOICE',
          },
          {
            label: '票据',
            value: 'RECEIPT',
          },
        ],
        invoiceKind: [
          {
            label: '红票',
            value: 0,
          },
          {
            label: '蓝票',
            value: 1,
          },
        ],
        invoiceStatus: [
          {
            label: '未开票',
            value: 0,
          },
        ],
      },
      // 发票、票据列表
      invoiceList: {
        records: [],
        total: 0,
      },
      // 发票/票据明细列表
      invoiceDetailList: [],
      // 表格行点击触发的当前票据、发票相关信息cache 当前选中的 票据、发票
      invoiceDetailForm: {
        preBuyerName: '', // 发票记录
        buyerName: '',
        invoiceType: undefined
      },
      // 发票管理搜索
      checkAll: false,
      isIndeterminate: true,
      rules: {
        invoiceType: [
          {required: true, message: '请选择发票类型', trigger: 'blur'},
        ],
        buyerPhone: [
          {required: false, message: '请输入手机号', trigger: 'blur'},
          {
            validator: (rule, value, callback) => {
              if (!checkPhone(value)) {
                callback('请输入正确的手机号')
              } else {
                callback()
              }
            }, trigger: 'blur'
          },
        ],
        invoiceNumber: [
          {required: false, message: '请输入手机号', trigger: 'blur'},
          {max: 30, message: '发票编号长度不能超过30个字符', trigger: 'blur'},
          {
            validator: async (rule, value, callback) => {
              if (!value) {
                callback()
                return
              }
              const {data: res} = await InvoiceApi.checkInvoiceNumber(value)
              if (!res.data) {
                callback('该发票编号已存在，请重新输入')
              } else {
                callback()
              }
            }, trigger: 'blur'
          }
        ],
        buyerName: [
          {required: true, message: '发票抬头', trigger: 'blur'},
          {max: 100, message: '购买方名称长度不能超过100个字符', trigger: 'blur'}
        ],
        buyerTinNo: [
          {required: false, message: '请输入纳税人识别号', trigger: 'blur'},
          {max: 30, message: '购买方纳税人识别号长度不能超过30个字符', trigger: 'blur'}
        ],
        buyerAddress: [
          {required: false, message: '请输入地址', trigger: 'blur'},
          {max: 100, message: '购买方地址长度不能超过100个字符', trigger: 'blur'}
        ],
        buyerBankName: [
          {required: false, message: '请输入开户行名称', trigger: 'blur'},
          {max: 100, message: '购买方开户行名称长度不能超过100个字符', trigger: 'blur'}
        ],
        buyerBankAccount: [
          {required: false, message: '请输入开户行账号', trigger: 'blur'},
          {max: 100, message: '购买方开户行账号长度不能超过100个字符', trigger: 'blur'},
        ]
      },
      // wujh add
      // 控制打印按钮是否可用 主要控制在未点击记录时，打印按钮可用
      isPrint: false,
      buyerType: [
        {
          label: '个人',
          value: 'person',
        },
        {
          label: '公司',
          value: 'company',
        },
      ],
      buyerTypeValue: 'person',
    }
  },
  computed: {
    openBtnDisabled() {
      /*
      * 无发票类型：返回true
      * 有发票类型，且等于 RECEIPT 返回true
      * */
      return this.invoiceDetailForm?.invoiceStatus !== 'NOT_OPEN'
      // 有发票类型
      // if (this.invoiceDetailForm.invoiceType) {
      //   return this.invoiceDetailForm.invoiceType === 'RECEIPT'
      // }
      // 无发票类型
      // else {
      //   return true
      // }
    },
    editable() {
      return this.invoiceDetailForm.invoiceType === 'RECEIPT'
    },
    invoiceNumberVisible() {
      // 当且仅当是缴费时可能会编辑
      if (this.activeName === 'invoice') {
        return true
      }
      // 当且仅当类型为票据时可能会编辑
      if (this.invoiceDetailForm.invoiceType === 'RECEIPT') {
        // 根据该字段判断 false 自动生成 true 人工收入
        return !this.invoiceNumberEntry
      }
      return true
    },
    rePrintTickBill() {
      if (this.activeName === 'invoice') {
        return this.invoiceDetailForm.invoiceStatus === '2' || this.invoiceDetailForm.invoiceStatus === '3'
      }
      return false
    }
  },
  created() {
    this.getReceipt()
    this.getChargeList()
  },
  methods: {
    async getReceipt() {
      const {data: res} = await InvoiceApi.getReceipt()
      if (res.isSuccess) {
        this.invoiceNumberEntry = res.data
      }
    },
    //抬头选择事件
    buyerTypeChange() {
      const { buyerTypeValue } = this
      if (buyerTypeValue === 'company') {
        this.invoiceDetailForm = {
          ...this.invoiceDetailForm,
          buyerTinNo: '', //纳税人识别号
          buyerBankName: '', //银行名称
          buyerBankAccount: '', //银行账户
          buyerAddress: '', //银行地址
        }
      }
    },
    // 发票类型选中
    handleCheckedTypeChange(value) {
      const currentCheckedCount =
        value.length +
        this.queryParam.invoice.model.invoiceKindList.length +
        this.queryParam.invoice.model.invoiceStatusList.length
      this.handleCheck(currentCheckedCount)
    },
    // 发票种类选中
    handleCheckedKindChange(value) {
      const currentCheckedCount =
        value.length +
        this.queryParam.invoice.model.invoiceTypeList.length +
        this.queryParam.invoice.model.invoiceStatusList.length
      this.handleCheck(currentCheckedCount)
    },
    // 发票状态选中
    handleCheckedStatusChange(value) {
      const currentCheckedCount =
        value.length +
        this.queryParam.invoice.model.invoiceKindList.length +
        this.queryParam.invoice.model.invoiceTypeList.length
      this.handleCheck(currentCheckedCount)
    },
    // 判断是否触发到全选中
    handleCheck(currentCheckedCount) {
      const allItemCount =
        this.filterTypes.invoiceType.length +
        this.filterTypes.invoiceKind.length +
        this.filterTypes.invoiceStatus.length
      this.checkAll = currentCheckedCount === allItemCount
      this.isIndeterminate = currentCheckedCount > 0 && currentCheckedCount < allItemCount
    },
    // 全选切换
    handleCheckAllChange(val) {
      const allCheck = {
        invoiceType: [],
        invoiceKind: [],
        invoiceStatus: [],
      }
      if (val) {
        this.filterTypes.invoiceType.forEach(({value}) => {
          allCheck.invoiceType.push(value)
        })
        this.filterTypes.invoiceKind.forEach(({value}) => {
          allCheck.invoiceKind.push(value)
        })
        this.filterTypes.invoiceStatus.forEach(({value}) => {
          allCheck.invoiceStatus.push(value)
        })
      }
      this.queryParam.invoice.model.invoiceStatusList = val ? allCheck.invoiceStatus : []
      this.queryParam.invoice.model.invoiceTypeList = val ? allCheck.invoiceType : []
      this.queryParam.invoice.model.invoiceKindList = val ? allCheck.invoiceKind : []
      this.isIndeterminate = false
      this.checkAll = val
    },
    // tabs 切换
    handleTabClick() {
      // 切换时应清除明细及表单中的数据
      this.invoiceDetailList = []
      this.invoiceDetailForm = {}
      this.$refs.deitailForm.resetFields()
      this.handleSearch()
      this.isPrint = false
    },
    handleVisibleChange(value) {
      if (!value) {
        this.handleSearch()
      }
    },
    // 搜索列表
    handleSearch: debounce(async function () {
      this.loading = true
      try {
        if (this.activeName === 'bill') {
          await this.getChargeList()
        } else {
          await this.getInvoiceList()
        }
      } catch (e) {
        console.warn(e)
      } finally {
        this.loading = false
      }
    }, 300),
    // 获取发票列表
    async getInvoiceList(params = {}) {
      const payload = cloneDeep(this.queryParam.invoice)
      payload.current = params.current || payload.current
      payload.size = params.size || payload.size
      if (this.checkAll) {
        payload.model.invoiceTypeList = []
        payload.model.invoiceKindList = []
        payload.model.invoiceStatusList = []
      }
      const {data: res} = await InvoiceApi.getInvoiceList(payload)
      if (res.data) {
        this.invoiceList = res.data
      }
    },
    // 获取发票明细
    async getInvoiceDetail(id) {
      const {data: res} = await InvoiceApi.getInvoiceDetail(id)
      if (res.isSuccess) {
        this.invoiceDetailList = res.data
      }
    },
    // 获取票据明细
    async getBillDetail(id) {
      const {data: res} = await InvoiceApi.getBillDetail(id)
      if (res.isSuccess) {
        this.invoiceDetailList = res.data
      }
    },
    // 表格行点击
    handleRowClick: debounce(function (row, column, event) {
      this.isPrint = true
      this.$refs.deitailForm.clearValidate()
      this.invoiceDetailForm = deepClone(row)
      this.getInvoiceDetail(row.id)
    }, 300),
    // 开票
    handleOpen() {
      if (this.activeName === 'bill') {
        this.$refs.deitailForm.validate(async (valid) => {
          if (!valid) {
            return
          }
          this.openLoading = true
          const payload = {
            ...this.invoiceDetailForm,
            chargeId: this.invoiceDetailForm.id,
          }
          const {data: res} = await InvoiceApi.printInvoiceBasedOnReceipt(payload)
          if (res.data) {
            this.$message({
              type: 'success',
              message: '开票成功'
            })
          }
          this.openLoading = false
        })
      }
    },
    // 调 打印发票
    async handlePrint() {
      const chargeNo = this.invoiceDetailForm.chargeNo
      if (!chargeNo) {
        this.$message({
          type: 'warning',
          message: '打印前请先选择相应的缴费记录或发票'
        })
        return
      }
      const {data: res} = await InvoiceApi.getPrintRecords(chargeNo)
      if (!res.isSuccess) {
        return
      }
      const {data: response} = await InvoiceApi.updateInvoiceStatus(chargeNo)
      this.$message({
        type: response.isSuccess ? 'success' : 'warning',
        message: response.msg
      })
      print.GAS_BILL(res.data)
    },

    // 重开发票
    reMakeOutAnInvoice() {
      let params = {
        invoiceId: this.invoiceDetailForm.id,
        buyerName: this.invoiceDetailForm.buyerName,
        buyerTinNo: this.invoiceDetailForm.buyerTinNo,
        buyerAddress: this.invoiceDetailForm.buyerAddress,
        buyerPhone: this.invoiceDetailForm.buyerPhone,
        buyerBankName: this.invoiceDetailForm.buyerBankName,
        buyerBankAccount: this.invoiceDetailForm.buyerBankAccount,
        invoiceType: this.invoiceDetailForm.invoiceType,
      }
      InvoiceApi.reMakeOutAnInvoice(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          if (data.code == '0') {
            this.msg('重开发票成功')
          } else {
            this.msg(data.message,'error')
          }
        }
      })
    },

    // 补打发票
    rePrintInvoice() {
      let params = {
        invoiceId: this.invoiceDetailForm.id
      }
      InvoiceApi.rePrintInvoice(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          if (data.code == '0') {
            this.msg('补打发票成功')
          } else {
            this.msg(data.message,'error')
          }
        }
      })

    },
    async getChargeList(params = {}) {
      const { chargePrams } = this
      chargePrams.current = params.current || chargePrams.current
      chargePrams.size = params.size || chargePrams.size
      chargePrams.model = { ...chargePrams.model, ...params.model }
      const { data: res } = await ChargeApi.pageList(chargePrams).finally(() => {
        this.$refs.chargeListComponent.closeLoading()
      })
      if (res.isSuccess) {
        this.chargeList = res.data
      }
    },
    // async checkRefundApply(row) {
    //   const res = await ChargeApi.checkRefundApply(row.chargeNo)
    //   return res.data.data
    // },
    // 收费列表 表格行点击
    handleChargeRowClick: debounce(async function (row, column, event) {
      // this.refund = false
      this.isPrint = true
      this.getBillDetail(row.chargeNo)
      this.getBuyerTaxInfo(row.customerCode)
      // console.warn(row)
      this.invoiceDetailForm = deepClone(row)
      // 添加拒绝原因 wujh
      this.curRow = row
    }, 300),
    search(status) {
      const { searchChargeForm } = this
      searchChargeForm.start = searchChargeForm.activeDate ? searchChargeForm.activeDate[0] : ''
      searchChargeForm.end = searchChargeForm.activeDate ? searchChargeForm.activeDate[1] : ''
      this.getChargeList({ model: searchChargeForm })
      this.resetinvoiceDetailForm()
    },
        //清空收费Detail 组件数据
    resetinvoiceDetailForm() {
      this.curRow = null
      this.chargeDetailList = []
      this.invoiceDetailForm = {}
    },
    getBuyerTaxInfo(customerCode) {
      Api.getBuyerTaxInfo({ customerCode: customerCode }).then(res => {
        const { isSuccess, data } = res.data
        if (isSuccess) {
          const { invoiceFormList } = this
          if (data.length) {
            data.forEach(i => {
              let invoiceForm = {}
              invoiceForm.buyerPhone = i.buyerPhone
              invoiceForm.buyerName = i.buyerName
              invoiceForm.buyerTinNo = i.buyerTinNo
              invoiceForm.buyerBankName = i.buyerBankName
              invoiceForm.buyerBankAccount = i.buyerBankAccount
              invoiceForm.buyerAddress = i.buyerAddress
              invoiceFormList.push(invoiceForm)
            })
            this.invoiceForm = {
              ...this.invoiceForm,
              ...invoiceFormList[invoiceFormList.length - 1],
            }
            this.buyerName = this.invoiceForm.buyerName
          }
          this.loading = false
        }
      })
    },
    //切换发票抬头
    handleBuyerName(val) {
      this.invoiceDetailForm = { ...this.invoiceDetailForm, ...this.invoiceFormList[val] }
      this.buyerName = this.invoiceDetailForm.buyerName
      this.buyerTypeValue = 'person'
    },
  },
}
</script>

<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: calc(100% / 2);
  }
}
::v-deep .el-table {
  border: 1px solid #eee;
  border-bottom: none;
}

::v-deep .el-tabs__content {
  height: 100%;
}

.invoiceForm {
  .el-form-item {
    margin-bottom: 10px;
  }
}

// 发票筛选
.card-tool-bar {
  .el-input {
    width: 250px;

    ::v-deep .el-input-group__append {
      padding-left: 0;
    }
  }
}

::v-deep thead {
  tr {
    background: #fafafa;

    th {
      background: transparent;
    }
  }
}

.btnBox {
  width: 100%;
  display: flex;
}
</style>
