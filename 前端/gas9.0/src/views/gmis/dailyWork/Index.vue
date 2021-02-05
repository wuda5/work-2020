<template>
  <div class="qc-main">
    <!--search-->
    <top-search-box
      :search-condition="searchCondition"
      :use-gas-type="useGasType"
      :search-loading="searchLoading"
      :search="search"
      :read-car-loading="readCarLoading"
      :search-default="searchDefault"
      :reset-search-condition="resetSearchCondition"
    />

    <!-- 日常综合 -->
    <el-row :gutter="10">
      <!--left-->
      <el-col :span="17">
        <div>
          <!-- 列表 -->
          <user-list
            v-loading="userListloading"
            element-loading-text="读卡中请稍后……"
            :table-data="tableData"
            :paginations="paginations"
            :search-by-current-page="searchByCurrentPage"
            :handle-charge-list="handleChargeList"
            :current-row="currentRow"
          />
          <!-- 收费列表 -->
          <el-card shadow="never" class="charge-list">
            <div slot="header">
              <span class="card-title">收费列表</span>
              <div class="card-tool-bar">
                <!-- 微信支付扫码框 -->
                <el-input
                  v-if="isPayCode"
                  v-model="payCode"
                  v-focusInput
                  class="payInput"
                  placeholder="请点击输入框扫码"
                  @keyup.enter.native="postWeChartPay"
                ></el-input>
                <el-button v-if="isPayCode" type="primary" class="payCancer" @click="cancerPay">取消</el-button>
                <!-- 微信支付扫码框 end -->
                <el-button class="balance">
                  个人账户余额：
                  <span class="redFont">
                    {{ chargeForm.accountMoney | moneyFormat(2) }}
                  </span>
                </el-button>
                <el-button
                  v-if="
                    orderSourceName === 'CENTER_RECHARGE' || orderSourceName === 'REMOTE_READMETER'
                  "
                  class="balance"
                >
                  气表余额：
                  <span class="redFont">
                    {{ (accountMeterMoney ? accountMeterMoney : '0.00') | moneyFormat(2) }}
                  </span>
                </el-button>
                <el-button class="balance">
                  操作员余额：
                  <span class="redFont">
                    {{ userBalance | moneyFormat(2) }}
                  </span>
                </el-button>
                <el-button class="balance">
                  营业余额：
                  <span class="redFont">
                    {{ bizHallBalance | moneyFormat(2) }}
                  </span>
                </el-button>
              </div>
            </div>
            <div v-loading="chargeLoading">
              <!-- 收费列表 -->
              <charge-table
                :height="150"
                :waite-append-item-list="waiteAppendItemList"
                :charge-item-list="chargeItemList"
                @setTotalMoney="setTotalMoney"
              />
              <!-- 收费表单 -->
              <charge-list
                ref="chargelist"
                :charge-form.sync="chargeForm"
                :total-money="totalMoney"
                :receivable-money="receivableMoney"
                :give-change="giveChange"
                :handle-covert="handleCovert"
                :handle-reset="handleReset"
                :gas-meter-code="gasMeterCode"
                :handle-charge="handleCharge"
                :dicts="dicts"
                :order-source-name="orderSourceName"
                :deduct-key="deductKey"
                :biz-hall-balance="bizHallBalance"
                :user-balance="userBalance"
                :is-limited="isLimited"
                :charge-item-list="chargeItemList"
                :amount-mark="amountMark"
                :manual-input="manualInput"
                :waite-append-item-list="waiteAppendItemList"
                :account-meter-money="accountMeterMoney"
                :is-open-insurance="isOpenInsurance"
              />
            </div>
          </el-card>
        </div>
      </el-col>

      <!--right-->
      <el-col :span="7">
        <!-- 右侧 -->
        <el-tabs
          v-model="curTabsLabel"
          class="workHeight moreInfo"
          tab-position="left"
          @tab-click="tabsChange"
        >
          <el-tab-pane label="客户信息" name="客户信息">
            <customer-details
              v-if="curTabsLabel === '客户信息'"
              :customer-code="currentRow ? currentRow.customerCode : null"
            ></customer-details>
          </el-tab-pane>
          <el-tab-pane label="表具信息" name="表具信息">
            <meter-details
              v-if="curTabsLabel === '表具信息'"
              :gas-meter-code="currentRow ? currentRow.gasCode : null"
            />
          </el-tab-pane>
          <el-tab-pane label="变更记录" name="变更记录">
            <change-records
              v-if="curTabsLabel === '变更记录'"
              :customer-code="currentRow ? currentRow.customerCode : ''"
              :gas-meter-code="gasMeterCode"
            />
          </el-tab-pane>
          <el-tab-pane label="IC卡信息" name="IC卡信息">
            <card-info v-if="curTabsLabel === 'IC卡信息'" ref="cardInfoRef" :options="currentRow" />
          </el-tab-pane>
          <el-tab-pane label="账户信息" name="账户信息">
            <account-info v-if="curTabsLabel === '账户信息'" :customer-code="customerCode" />
          </el-tab-pane>

          <el-tab-pane v-if="showHb" label="户表信息" name="户表信息">
            <account-meter
              v-if="curTabsLabel === '户表信息'"
              :customer-code="currentRow ? currentRow.customerCode : ''"
              :gas-meter-code="currentRow ? currentRow.gasCode : null"
            />
          </el-tab-pane>

          <el-tab-pane v-if="showQf" label="欠费明细" name="欠费明细">
            <arrearage-info v-if="curTabsLabel === '欠费明细'" :gas-meter-code="gasMeterCode" />
          </el-tab-pane>

          <!-- 缴费信息 -->
          <el-tab-pane label="缴费信息" name="缴费信息">
            <payment-records
              v-if="curTabsLabel === '缴费信息'"
              :gas-meter-code="gasMeterCode"
              :customer-code="customerCode"
            />
          </el-tab-pane>

          <!-- 充值记录 -->
          <el-tab-pane v-if="false" label="充值记录" name="充值记录">
            <recharge-records
              v-if="curTabsLabel === '充值记录'"
              :gas-meter-code="gasMeterCode"
              :customer-code="customerCode"
              :order-source-name="currentRow ? currentRow.orderSourceName : null"
            />
          </el-tab-pane>

          <!-- 保险信息 -->
          <el-tab-pane v-if="isTest" label="保险信息" name="保险信息">
            <insurance-info v-if="curTabsLabel === '保险信息'" />
          </el-tab-pane>

          <el-tab-pane label="气价方案" name="气价方案">
            <price-plan v-if="curTabsLabel === '气价方案'" :gas-meter-code="gasMeterCode" />
          </el-tab-pane>

          <!-- 气表状态 -->
          <el-tab-pane label="气表状态" name="气表状态">
            <meter-status-details
              v-if="curTabsLabel === '气表状态'"
              :gas-meter-code="currentRow ? currentRow.gasCode : null"
              :customer-code="customerCode"
            />
          </el-tab-pane>

          <el-tab-pane v-if="isTest" label="工单信息" name="工单信息">
            <work-order v-if="curTabsLabel === '工单信息'" />
          </el-tab-pane>

          <el-tab-pane v-if="isTest" label="限购信息" name="限购信息">
            <buy-limit
              v-if="curTabsLabel === '限购信息'"
              :options="{
                customerCode: currentRow ? currentRow.customerCode : null,
                gasMeterCode: currentRow ? currentRow.gasCode : null,
              }"
            />
          </el-tab-pane>

          <!-- 统计数据 -->
          <el-tab-pane label="统计数据" name="统计数据">
            <daily-work-statistics v-if="curTabsLabel === '统计数据'" />
          </el-tab-pane>
        </el-tabs>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div
        v-has-permission="['dailyWork:fagl']"
        class="footNav-item"
        @click="dialogOpen('showInvoiceManage')"
      >
        <div class="icon">
          <svg-icon icon-class="qc-fapiao" />
        </div>
        <p>发票管理</p>
      </div>

      <div
        v-has-permission="['dailyWork:zhazhang']"
        class="footNav-item"
        @click="dialogOpen('showSettleAccounts')"
      >
        <div class="icon">
          <svg-icon icon-class="zhazhang" />
        </div>
        <p>扎帐</p>
      </div>

      <div v-has-permission="['dailyWork:khs']" class="footNav-item" @click="recoverCard">
        <div class="icon">
          <svg-icon icon-class="cardZero" />
        </div>
        <p>卡回收</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->
    <!--补卡-->
    <qc-dialog
      v-if="showCard"
      :width="800"
      title="补卡"
      :visible="showCard"
      data-key="showCard"
      @close="dialogClose"
    >
      <card-replacement />
    </qc-dialog>

    <!--补气-->
    <qc-dialog
      v-if="showGas"
      :width="800"
      title="补气"
      :visible="showGas"
      data-key="showGas"
      @close="dialogClose"
    >
      <gas-replacement />
    </qc-dialog>

    <!--代扣签约-->
    <qc-dialog
      v-if="showWithhold"
      :width="400"
      title="代扣签约"
      :visible="showWithhold"
      data-key="showWithhold"
      @close="dialogClose"
    >
      <sign-withholding />
    </qc-dialog>

    <!--创建工单-->
    <qc-dialog
      :width="400"
      title="创建工单"
      :v-if="showWorkOrder"
      :visible="showWorkOrder"
      data-key="showWorkOrder"
      @close="dialogClose"
    >
      <qc-work-order />
    </qc-dialog>

    <!--退费-->
    <!--<qc-dialog
      :width="800"
      title="退费"
      :v-if="showReturnPremium"
      :visible="showReturnPremium"
      data-key="showReturnPremium"
      @close="dialogClose"
    >
      <return-premium />
    </qc-dialog>-->

    <!--发票管理-->
    <el-dialog width="1000px" title="票据/发票管理" :visible.sync="showInvoiceManage">
      <invoice-manage v-if="showInvoiceManage" />
    </el-dialog>

    <!--扎帐-->
    <el-dialog width="1200px" title="扎帐" :visible.sync="showSettleAccounts">
      <settle-accounts v-if="showSettleAccounts" />
    </el-dialog>

    <!--收费-->
    <qc-dialog
      v-if="showChargeBox"
      :width="1200"
      title="收费"
      :visible="showChargeBox"
      data-key="showChargeBox"
      @close="dialogClose"
    >
      <charge-box />
    </qc-dialog>

    <!--卡回收-->
    <qc-dialog
      v-if="showCardToZero"
      :width="350"
      title="卡回收"
      :visible="showCardToZero"
      data-key="showCardToZero"
      @close="dialogClose"
    >
      <card-to-zero />
    </qc-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./dailyWork.js"></script>
<style lang="scss" scoped>
.pagination-container {
  padding: 10px 0;
}

::v-deep .el-input-group__append {
  padding: 0 5px !important;
}

/* 收费列表 */
.charge-list {
  height: 558px;
  margin-top: 10px;

  ::v-deep .el-card__body {
    padding-top: 10px;
  }

  .balance {
    background: #ebeef5;
    border: none;

    ::v-deep .el-input-group__append {
      // padding: 0 5px !important;
      padding: 0 10px !important;
    }

    .chargeForm {
      margin-top: 10px;

      ::v-deep .el-card__body {
        padding: 0;
      }

      .el-form-item {
        width: 20%;
      }

      /* 收费结果 */
      .rechargeResult {
        overflow: hidden;
        clear: both;
        width: 100%;

        .el-form-item {
          width: 24%;
          float: left;
        }
      }

      .btnBox {
        width: 100%;

        .el-button {
          float: left;
          width: 48%;
        }
      }
    }
  }

  .card-tool-bar {
    .el-button {
      margin-left: 10px;
    }
  }
}
.payInput {
  width: 300px;
  position: fixed;
  top: 50%;
  left: 50%;
  z-index: 9999;
  transform: translate(-180px, -50%);
  margin-top: 80px;
  ::v-deep input {
    font-size: 26px;
    height: 50px;
    line-height: 50px;
    // border: 1px solid #666;
  }
}
.payCancer {
  width: 80px;
  position: fixed;
  top: 50%;
  left: 50%;
  z-index: 9999;
  transform: translate(130px, -50%);
  margin-top: 80px;
  height: 50px;
  font-size: 18px;
}
</style>
