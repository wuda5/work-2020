<!-- 临时综合 -->
<template>
  <div class="qc-main">
    <!--search-->
    <top-search-box
      :search-condition="searchCondition"
      :use-gas-type="useGasType"
      :search-loading="searchLoading"
      :read-car-loading="readCarLoading"
      :search="search"
      :search-default="searchDefault"
      :reset-search-condition="resetSearchCondition"
    />
    <el-row :gutter="10">
      <!--left-->
      <el-col :span="17">
        <!-- 档案列表 -->
        <el-card shadow="never" class="workHeight">
          <div slot="header">
            <search-box>
              <div slot="left"><span class="card-title">表具列表</span></div>
              <!-- 操作按钮 -->
              <div slot="right">
                <el-button
                  v-has-permission="['temporary:guohu']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="meterTransfer"
                  >过户
                </el-button>
                <el-button
                  v-has-permission="['temporary:chaibiao']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="dismantleMeterCheck"
                  >拆表
                </el-button>
                <el-button
                  v-has-permission="['temporary:hb']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="changeMeterCheck"
                  >换表
                </el-button>
                <!--<el-button type="primary" plain @click="dialogOpen('showOneMeterMultiFamily')">一户多表</el-button>-->
                <el-button
                  v-has-permission="['temporary:bk']"
                  type="primary"
                  plain
                  :disabled="!curMeter || isShowCardFlag"
                  @click="cardReplaceCheck"
                  >补卡
                </el-button>
                <el-button
                  v-has-permission="['temporary:bq']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="gasReplaceCheck"
                  >补气
                </el-button>
                <!-- 通气 -->
                <el-button
                  v-has-permission="['temporary:tq']"
                  :disabled="!isOpenGas(curMeter)"
                  plain
                  type="primary"
                  @click="openGasDialogVisible = true"
                >
                  {{ $t('button.openGas') }}
                </el-button>
                <el-button
                  v-has-permission="['temporary:fk']"
                  type="primary"
                  plain
                  :disabled="!curMeter || !isShowCardFlag"
                  @click="handleClick('showGetCard')"
                  >发卡
                </el-button>
                <!-- 用气类型变更 -->
                <el-button
                  v-has-permission="['temporary:yqlxbg']"
                  type="primary"
                  plain
                  :disabled="!curMeter || !isUseGasTypeChange(curMeter)"
                  @click="showChangeGasType = true"
                  >{{ $t('button.useGasTypeChange') }}
                </el-button>
                <!-- 远程控制 -->
                <el-button
                  v-has-permission="['temporary:yckz']"
                  type="primary"
                  :disabled="!isRemoteControl(curMeter)"
                  plain
                  @click.native="remoteControlDialogVisible = true"
                  >{{ $t('button.remoteControl') }}
                </el-button>

                <!-- 开户收费 -->
                <!-- <el-button
                  type="primary"
                  :disabled="!curMeter || openAccountChargeLoading"
                  :loading="openAccountChargeLoading"
                  plain
                  @click.native="handleOpenAccountDialog(true)"
                >{{ $t('button.openAccountCharge') }}
                </el-button> -->

                <el-button
                  v-has-permission="['temporary:khzl']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="dialogOpen('showUpload')"
                  >开户资料
                </el-button>
                <el-button
                  v-has-permission="['temporary:khs']"
                  type="danger"
                  plain
                  @click="recoverCard"
                  >卡回收
                </el-button>
                <el-button
                  v-if="isTest"
                  v-has-permission="['temporary:cjgd']"
                  type="primary"
                  plain
                  :disabled="!curMeter"
                  @click="dialogOpen('showWorkOrder')"
                  >创建工单
                </el-button>
              </div>
            </search-box>
          </div>

          <!-- 用户信息列表 -->
          <!-- :highlight-current-row="true" -->
          <!-- @select-all="tableSelect"
            @selection-change="tableSelect" -->
          <el-table
            ref="tableRef"
            :data="userList"
            tooltip-effect="dark"
            style="width: 100%"
            :border="true"
            height="calc(100vh - 330px)"
            highlight-current-row
            @row-click="rowClick"
          >
            <el-table-column type="index" label="#" width="45" />
            <!-- 缴费编号 -->
            <el-table-column
              prop="customerChargeNo"
              label="缴费编号"
              width="150"
              :show-overflow-tooltip="true"
            />
            <!-- 表身号 -->
            <el-table-column
              prop="gasMeterNumber"
              label="表身号"
              width="150"
              :show-overflow-tooltip="true"
            />
            <el-table-column prop="customerName" label="客户姓名" width="100" />
            <el-table-column prop="telphone" label="联系电话" width="100" />
            <el-table-column prop="customerTypeName" label="客户类型" width="100" />
            <el-table-column
              prop="useGasTypeName"
              label="用气类型"
              width="120"
              :show-overflow-tooltip="true"
            />

            <!-- 气表类型 -->
            <el-table-column
              prop="orderSourceName"
              :label="$t('meterInfo.gasMeterTypeName')"
              show-overflow-tooltip
            >
              <template #default="{ row }">
                {{ gasMeterTypeMap[row.orderSourceName] }}
              </template>
            </el-table-column>
            <!-- 气表状态 -->
            <el-table-column prop="dataStatus" label="气表状态" width="100">
              <template #default="{ row }">
                {{ dictMap.GAS_METER_STATE[row.dataStatus] }}
              </template>
            </el-table-column>
            <!-- <el-table-column label="调压箱号">
              <template slot-scope="scope">{{ !scope.row.nodeNumber ? '---' : scope.row.nodeNumber }}
              </template>
            </el-table-column> -->
            <el-table-column label="气表厂家" width="300">
              <template slot-scope="scope">{{ !scope.row.gasMeterFactoryName ? '---' : scope.row.gasMeterFactoryName }}
              </template>
            </el-table-column>
            <el-table-column label="气表版号">
              <template slot-scope="scope">{{ !scope.row.gasMeterVersionName ? '---' : scope.row.gasMeterVersionName }}
              </template>
            </el-table-column>
            <el-table-column prop="moreGasMeterAddress" label="安装地址" width="300" />
          </el-table>
          <pagination
            :page-sizes="[10, 15, 20, 30]"
            :page.sync="searchCondition.pageNo"
            :limit.sync="searchCondition.pageSize"
            :total="+userListTotal"
            @pagination="search()"
          />
        </el-card>
      </el-col>

      <!--right-->
      <el-col :span="7">
        <!-- 更多信息 -->
        <div>
          <el-tabs
            v-model="curTabsLabel"
            class="workHeight moreInfo"
            tab-position="left"
            @tab-click="tabsChange"
          >
            <el-tab-pane label="客户信息" name="客户信息">
              <customer-details
                v-if="curTabsLabel === '客户信息'"
                :customer-code="curMeter ? curMeter.customerCode : null"
              ></customer-details>
            </el-tab-pane>
            <el-tab-pane label="表具信息" name="表具信息">
              <meter-details
                v-if="curTabsLabel === '表具信息'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
              />
            </el-tab-pane>

            <el-tab-pane label="变更记录" name="变更记录">
              <change-records
                v-if="curTabsLabel === '变更记录'"
                :customer-code="curMeter ? curMeter.customerCode : null"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
              />
            </el-tab-pane>

            <el-tab-pane label="IC卡信息" name="IC卡信息">
              <card-info v-if="curTabsLabel === 'IC卡信息'" :options="curMeter" />
            </el-tab-pane>

            <el-tab-pane label="账户信息" name="账户信息">
              <account-info
                v-if="curTabsLabel === '账户信息'"
                :customer-code="curMeter ? curMeter.customerCode : null"
              />
            </el-tab-pane>

            <el-tab-pane v-if="showHb" label="户表信息" name="户表信息">
              <account-meter
                v-if="curTabsLabel === '户表信息'"
                :customer-code="curMeter ? curMeter.customerCode : ''"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
              />
            </el-tab-pane>

            <el-tab-pane v-if="showQf" label="欠费明细" name="欠费明细">
              <arrearage-info
                v-if="curTabsLabel === '欠费明细'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
              />
            </el-tab-pane>

            <!-- 缴费信息 -->
            <el-tab-pane label="缴费信息" name="缴费信息">
              <payment-records
                v-if="curTabsLabel === '缴费信息'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
                :customer-code="curMeter ? curMeter.customerCode : null"
              />
            </el-tab-pane>

            <!-- 充值记录 -->
            <el-tab-pane v-if="false" label="充值记录" name="充值记录">
              <recharge-records
                v-if="curTabsLabel === '充值记录'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
                :customer-code="curMeter ? curMeter.customerCode : null"
                :order-source-name="curMeter ? curMeter.orderSourceName : null"
              />
            </el-tab-pane>

            <el-tab-pane label="气价方案" name="气价方案">
              <price-plan
                v-if="curTabsLabel === '气价方案'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
              />
            </el-tab-pane>

            <!-- 气表状态 -->
            <el-tab-pane label="气表状态" name="气表状态">
              <meter-status-details
                v-if="curTabsLabel === '气表状态'"
                :gas-meter-code="curMeter ? curMeter.gasCode : null"
                :customer-code="curMeter ? curMeter.customerCode : null"
              />
            </el-tab-pane>

            <!-- 安检信息 -->
            <el-tab-pane v-if="isTest" label="安检信息" name="安检信息">
              <safe-check-info />
            </el-tab-pane>

            <el-tab-pane v-if="isTest" label="工单信息" name="工单信息">
              <work-order v-if="curTabsLabel === '工单信息'" />
            </el-tab-pane>

            <el-tab-pane v-if="isTest" label="限购信息" name="限购信息">
              <buy-limit
                v-if="curTabsLabel === '限购信息'"
                :options="{
                  customerCode: curMeter ? curMeter.customerCode : null,
                  gasMeterCode: curMeter ? curMeter.gasCode : null,
                }"
              />
            </el-tab-pane>

            <!-- 统计数据 -->
            <el-tab-pane label="统计数据" name="统计数据">
              <counter v-if="curTabsLabel === '统计数据'" />
            </el-tab-pane>
          </el-tabs>
        </div>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div
        v-if="isTest"
        v-has-permission="['temporary:bzsl']"
        class="footNav-item"
        @click="dialogOpen('showAcceptForInstall')"
      >
        <div class="icon">
          <svg-icon icon-class="installMeter" />
        </div>
        <p>报装受理</p>
      </div>

      <!-- <div class="footNav-item" @click="openAccountDialogVisible = true"> -->
      <div
        v-has-permission="['temporary:kh']"
        class="footNav-item"
        @click="handleOpenAccountDialog(false)"
      >
        <div class="icon">
          <svg-icon icon-class="openAccount" />
        </div>
        <p>开户</p>
      </div>

      <!--<div class="footNav-item" @click="dialogOpen('showOpenMoreAccount')">
        <div class="icon">
          <svg-icon icon-class="OpenMoreAccount" />
        </div>
        <p>批量开户</p>
      </div>-->

      <!-- 导入开户 -->
      <div
        v-has-permission="['temporary:drkh']"
        class="footNav-item"
        @click="importOpenAccountDialogVisible = true"
      >
        <div class="icon">
          <svg-icon icon-class="user-import" />
        </div>
        <p>导入开户</p>
      </div>

      <div
        v-has-permission="['temporary:dz']"
        class="footNav-item"
        @click="dialogOpen('showReconciliation')"
      >
        <div class="icon">
          <svg-icon icon-class="duizhang" />
        </div>
        <p>对账</p>
      </div>
      <div
        v-has-permission="['temporary:tjbc']"
        class="footNav-item"
        @click="dialogOpen('showPriceChange')"
      >
        <div class="icon">
          <svg-icon icon-class="priceChange" />
        </div>
        <p>调价补差</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->
    <!-- 一表多户 -->
    <!--<qc-dialog
      v-if="showOneMeterMultiFamily"
      :width="1000"
      title="一表多户"
      :visible="showOneMeterMultiFamily"
      data-key="showOneMeterMultiFamily"
      @close="dialogClose"
    >
      <one-meter-multi-family />
    </qc-dialog>-->

    <!-- 编辑 -->
    <!--<qc-dialog
      v-if="showInfoEdit"
      :width="1000"
      title="编辑"
      :visible="showInfoEdit"
      data-key="showInfoEdit"
      @close="dialogClose"
    >
      <info-edit />
    </qc-dialog>-->

    <!--调价补差-->
    <el-dialog
      width="70%"
      :title="showCheckPrice ? '生成调价补差核算' : '调价补差核算审核'"
      :visible.sync="showPriceChange"
    >
      <price-change v-if="showPriceChange" :show-check-price.sync="showCheckPrice" />
    </el-dialog>

    <!-- 过户 -->
    <el-dialog width="1000px" title="过户" :visible.sync="showMeterTransfer">
      <meter-transfer
        v-if="showMeterTransfer"
        :step="step"
        :is-charge="isCharge"
        :open-charge-flag="openChargeFlag"
        :customer-code="transferCustomerCode"
        :cur-meter="curMeter"
        @success="handleMeterTransferSuccess"
        @close="showMeterTransfer = false"
      />
    </el-dialog>

    <!-- 拆表 -->
    <el-dialog width="1000px" title="拆表" :visible.sync="showDismantleMeter">
      <dismantle-meter
        v-if="showDismantleMeter"
        :step="step"
        :cur-business-id="curBusinessId"
        :cur-meter="curMeter"
        :settlement-return="settlementReturn"
        @success="handleDismantleMeterSuccess"
        @close="showDismantleMeter = false"
      />
    </el-dialog>

    <!-- 换表 -->
    <el-dialog width="1000px" title="换表" :visible.sync="showChangeMeter">
      <change-meter
        v-if="showChangeMeter"
        :step="step"
        :cur-business-id="curBusinessId"
        :cur-meter="curMeter"
        :settlement-return="settlementReturn"
        @close="showChangeMeter = false"
        @success="handleChangeMeterSuccess"
      />
    </el-dialog>

    <!--补卡-->
    <el-dialog append-to-body :visible.sync="showCardReplacement" width="800px" title="补卡">
      <card-replacement
        v-if="showCardReplacement"
        :gas-meter-code="curMeter ? curMeter.gasCode : ''"
        :customer-code="curMeter ? curMeter.customerCode : ''"
        :charge-type="curMeter ? curMeter.chargeType : ''"
        :card-replace-data="cardReplaceData"
        :order-source-name="curMeter.orderSourceName"
        @cardReplacementClose="cardReplacementClose"
      />
    </el-dialog>

    <!--补气-->
    <el-dialog width="800px" title="补气" :visible.sync="showGasReplacement">
      <gas-replacement
        v-if="showGasReplacement"
        :gas-meter-code="curMeter ? curMeter.gasCode : ''"
        :customer-code="curMeter ? curMeter.customerCode : ''"
        :gas-replace-data="gasReplaceData"
        @gasReplacementClose="gasReplacementClose"
      />
    </el-dialog>

    <!--通气-->
    <el-dialog width="600px" title="通气" :visible.sync="openGasDialogVisible">
      <open-gas
        :form-data="curMeter"
        :customer-data="customerInfoData"
        @success="handleOpenGasSuccess"
      />
    </el-dialog>

    <!--发卡-->
    <!-- @close="dialogClose" -->
    <el-dialog width="1000px" title="发卡" :visible.sync="showGetCard">
      <get-card
        v-if="showGetCard"
        :gas-meter-code="curMeter.gasCode"
        :customer-code="curMeter.customerCode"
        :charge-type="curMeter.chargeType"
        :settlement-type="curMeter.settlementType"
        :use-gas-type-id="curMeter.useGasTypeId"
        @getCardClose="getCardClose"
      />
    </el-dialog>

    <!--用气类型变更-->
    <el-dialog width="800px" title="用气类型变更" :visible.sync="showChangeGasType">
      <change-gas-type
        v-if="showChangeGasType"
        :meter-info="curMeter"
        @success="handleSaveUseGasTypeChangeSuccess"
      />
    </el-dialog>

    <!--远程控制-->
    <el-dialog width="75%" title="远程控制" :visible.sync="remoteControlDialogVisible">
      <remote-control :meter-info="curMeter"></remote-control>
    </el-dialog>

    <!-- 开户资料 -->
    <el-dialog width="800px" title="开户资料" :visible.sync="showUpload">
      <qc-upload
        v-if="showUpload"
        :meter-number="curMeter.gasMeterNumber"
        :gas-meter-code="curMeter.gasCode"
        :customer-code="customerInfoData.customerCode"
      />
    </el-dialog>

    <!--创建工单-->
    <el-dialog width="500px" title="创建工单" :visible.sync="showWorkOrder">
      <work-order :v-if="showWorkOrder" />
    </el-dialog>

    <!--报装受理-->
    <qc-dialog
      :width="400"
      title="报装受理"
      :v-if="showAcceptForInstall"
      :visible="showAcceptForInstall"
      data-key="showAcceptForInstall"
      @close="dialogClose"
    >
      <accept-for-install />
    </qc-dialog>

    <!--开户-->
    <el-dialog
      width="1200px"
      top="15px"
      :title="$t('customerInfo.openAccount')"
      :visible.sync="openAccountDialogVisible"
      :close-on-click-modal="false"
    >
      <!-- <qc-open-account @success="handleOpenAccountSuccess" /> -->
      <!-- 按步骤开户 -->
      <qc-open-account
        v-if="openAccountDialogVisible"
        :step="openAccountProps.step"
        :customer-code="openAccountProps.customerCode"
        :gas-meter-code="openAccountProps.gasMeterCode"
        @save-success="handleOpenAccountSaveSuccess"
        @close="handleOpenAccountDialogClose"
      />
    </el-dialog>

    <!--批量开户-->
    <!--<qc-dialog
      v-if="showOpenMoreAccount"
      :width="400"
      title="批量开户"
      :visible="showOpenMoreAccount"
      data-key="showOpenMoreAccount"
      @close="dialogClose"
    >

      <open-more-account/>
    </qc-dialog>-->

    <!-- 导入开户弹框 -->
    <el-dialog
      :title="$t('customerInfo.importOpenAccount')"
      :visible="importOpenAccountDialogVisible"
      data-key="importOpenAccountDialogVisible"
      :close-on-click-modal="false"
      @close="importOpenAccountDialogVisible = false"
    >
      <template #title>
        <span class="el-dialog__title">
          <span>{{ $t('customerInfo.importOpenAccount') }}</span>
          <el-button
            type="primary"
            size="mini"
            class="download-btn"
            style="margin: auto 10px"
            @click.native="handleDownloadOpenAccountTemplateFile"
            >{{ $t('customerInfo.downloadOpenAccountTemplate') }}</el-button>
        </span>
      </template>
      <import-open-account @success="handleImportOpenAccountSuccess" />
    </el-dialog>

    <!--对账-->
    <qc-dialog
      :width="1000"
      title="对账"
      :visible="showReconciliation"
      data-key="showReconciliation"
      @close="dialogClose"
    >
      <reconciliation v-if="showReconciliation" />
    </qc-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./temporary.js"></script>
<style lang="scss" scoped>
.payInput {
  width: 300px;
  position: fixed;
  top: 50%;
  left: 50%;
  z-index: 9999;
  transform: translate(-50%, -50%);
  margin-top: 80px;
  ::v-deep input {
    font-size: 26px;
    height: 50px;
    line-height: 50px;
  }
}
</style>
