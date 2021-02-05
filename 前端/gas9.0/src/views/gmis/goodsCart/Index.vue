<!--
 * @Description: 燃气商店
 * @Author: lingw
 * @Date: 2020-10-22 08:59:11
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-26 11:06:17
-->
<template>
  <div class="qc-main">
    <!-- 商品列表 -->
    <el-row :gutter="10">
      <!--center-->
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 10px">
        <div style="height: 810px;">
          <!--search-->
          <search
            @search="search($event)"
          />
          <!-- 销售单 & 订单列表 -->
          <el-card shadow="never" style="height: 420px">
            <div slot="header">
              <span v-Clipboard="'销售单'" class="card-title">销售单</span>
            </div>
            <!-- 销售单 -->
            <sell-list :sell-list="sellList" @charge-click="chargeVisible = true" />
          </el-card>
          <!-- 订单列表 -->
          <el-card shadow="never" style="height: 348px; margin-top: 10px">
            <div slot="header">
              <span v-Clipboard="'工单信息'" class="card-title">工单信息</span>
              <div class="butGroup fr">
                <el-button type="primary" plain>送货确认</el-button>
                <el-button type="primary" plain>安装确认</el-button>
                <el-button type="primary" plain>打印</el-button>
                <el-button type="primary" plain @click="handleSend">送货派工</el-button>
                <el-button type="primary" plain @click="handleIns">安装派工</el-button>
                <el-button type="primary" plain @click="cancelVisible = true">退货</el-button>
              </div>
            </div>
            <order-list :order-list="orderList" />
          </el-card>
        </div>
      </el-col>
      <!--left-->
      <el-col :lg="{span:5, pull:12}" :xs="24" :sm="12" style="margin-top: 10px">
        <!-- 商品列表 -->
        <goods-list :list="goodsList" />
      </el-col>
      <!--right-->
      <el-col :lg="7" :xs="24" :sm="12" style="margin-top: 10px">
        <!-- 更多信息 -->
        <div style="height: 810px">
          <work-process :work-info="workProcess" />
          <goods-detail style="margin-top: 12px;" :goods="products" />
        </div>
      </el-col>
    </el-row>
    <!-- 底部 -->
    <el-row :gutter="10">
      <!--燃气用品统计-->
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 12px">
        <!-- 燃气用品统计 -->
        <el-card shadow="never" class="counter">
          <div slot="header">
            <span class="card-title">燃气用品统计</span>
          </div>
          <goods-statistics height="200px" />
        </el-card>
      </el-col>
    </el-row>
    <!-- start 弹窗 start -->
    <!-- 送货、安装 -->
    <el-dialog :title="orderTitle" :visible.sync="orderVisible" width="400px">
      <el-form label-width="60px" :model="orderInfo" class="jh-text">
        <el-form-item label="接单人">
          <el-select v-model="orderInfo.worker" placeholder="请选择">
            <el-option
              v-for="({ value, label }) in workers"
              :key="value"
              :label="label"
              :value="value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="工作内容">
          <el-input v-model="orderInfo.content" size="mini" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogFormVisible = false">派 单</el-button>
      </div>
    </el-dialog>
    <!-- 退货弹框 -->
    <el-dialog :visible.sync="cancelVisible" title="退货">
      <cancel-orders :purchase-list="purchaseList" />
    </el-dialog>
    <!-- 缴费弹框 -->
    <el-dialog :visible.sync="chargeVisible" title="缴费">
      <charge :user-list="purchaseList" />
    </el-dialog>
    <!-- end 弹窗 end -->
  </div>
</template>

<script>
/**
 * 燃气商店 - 业务页面
 */
import GoodsStatistics from './components/GoodsStatistics' // 统计模块
import Search from './components/Search' // 中间模块搜索
import GoodsList from './components/GoodsList' // 商品列表
import GoodsDetail from './components/GoodsDetail' // 商品详情
import OrderList from './components/OrderList' // 订单列表
import SellList from './components/SellList' // 销售列表
import WorkProcess from './components/WorkProcess' // 工单流程
import CancelOrders from './components/CancelOrders' // 退货
import Charge from './components/Charge' // 缴费

const SEND = 1 // 送货派工
const INSTALL = 2 // 安装派工
export default {
  name: 'Service',
  components: {
    Search, // top search
    //
    GoodsStatistics, // 统计
    GoodsList, // 商品列表
    GoodsDetail, // 商品详情
    WorkProcess, // 工作流程
    CancelOrders, // 退货
    Charge, // 收费弹框
    OrderList, // 订单列表
    SellList // 销售类别
  },
  data() {
    return {
      // 商品列表
      goodsList: [
        {
          brand: '美的',
          type: '燃气灶',
          model: 'MTDH2254PX',
          id: 'PXTHL0001'
        },
        {
          brand: '美的',
          type: '抽油烟机',
          model: 'MPDH2254PX',
          id: 'PXTHL0002'
        },
        {
          brand: '美的',
          type: '微波炉',
          model: 'MLDH2254PX',
          id: 'PXTHL0003'
        },
        {
          brand: '方太',
          type: '微波炉',
          model: 'FLDH2254PX',
          id: 'PXTHL0004'
        }
      ],
      // 商品详情
      products: [
        {
          brand: '美的',
          model: 'MTDH2254PX',
          counts: 128,
          id: 'PXTHL0002'
        },
        {
          brand: '美的',
          model: 'MTDH2254PX',
          counts: 255,
          id: 'PXTHL0003'
        },
        {
          brand: '美的',
          model: 'MTDH2254PX',
          counts: '388',
          id: 'PXTHL0004'
        }
      ],
      workProcess: {
        type: '报装',
        emergency: '紧急',
        status: 1,
        phone: '13311112222',
        sendMan: 'FlashMan',
        sendTime: '2020-04-21 14:22:45',
        installMan: 'IronMan',
        installTime: '2020-04-21 16:22:45',
        remark: 'All is well'

      },
      // 购买信息
      purchaseList: [],
      // 退货信息
      cancelList: [],
      // 送货 安装 dialog title
      orderTitle: '',
      // 送货 安装 dialog visible
      orderVisible: false,
      // 退货 dialog  visible
      cancelVisible: false,
      // 缴费 dialog visible
      chargeVisible: false,
      workers: [
        {
          value: 'zky',
          label: '赵匡胤'
        },
        {
          value: 'zgy',
          label: '赵光义'
        },
        {
          value: 'zz',
          label: '赵祯'
        },
        {
          value: 'zj',
          label: '赵佶'
        }
      ],
      // 送货 安装 相关信息
      orderInfo: {
        worker: '',
        content: ''
      },
      // 销售单
      sellList: [],
      // 订单列表
      orderList: [],
      // 用户列表
      userList: []
    }
  },
  watch: {
    orderVisible(newVal, oldVal) {
      if (!newVal) {
        console.warn(1111)
        this.orderInfo = {}
      }
    }
  },
  methods: {

    search(dd) {
      console.log(dd)
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
    // 送货派工
    handleSend() {
      this.handleOrderVisible('送货派单')
    },
    // 安装派工
    handleIns() {
      this.handleOrderVisible('安装派单')
    },
    // order list dialog 框显示与隐藏
    handleOrderVisible(val) {
      this.orderTitle = val
      this.orderVisible = true
    }
  }
}

</script>
<style lang="scss" scoped>
  .card-title:hover {
    color: #409EFF;
    cursor: pointer;
  }
</style>
