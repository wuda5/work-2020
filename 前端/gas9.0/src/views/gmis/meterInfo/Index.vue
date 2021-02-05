<!--表具档案-->
<template>
  <div class="qc-main">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form :ref="searchFormRef" :model="searchForm" :inline="true" class="qc-search-form">
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input
            v-model="searchForm.customerChargeNo"
            clearable
            :placeholder="$t('meterInfo.customerChargeNo')"
          >
          </el-input>
        </el-form-item>
        <!-- 气表编号 -->
        <!-- <el-form-item label="" prop="gasCode">
          <el-input v-model="searchForm.gasCode" clearable :placeholder="$t('meterInfo.gasCode')">
          </el-input>
        </el-form-item> -->
        <!-- 气表表号 -->
        <el-form-item label="" prop="gasMeterNumber">
          <el-input
            v-model="searchForm.gasMeterNumber"
            clearable
            :placeholder="$t('meterInfo.gasMeterNumber')"
          >
          </el-input>
        </el-form-item>
        <!-- 安装地址 -->
        <el-form-item label="" prop="moreGasMeterAddress">
          <el-input
            v-model="searchForm.moreGasMeterAddress"
            clearable
            :placeholder="$t('meterInfo.moreGasMeterAddress')"
          >
          </el-input>
        </el-form-item>
        <!-- 气表类型 -->
        <el-form-item label="" prop="orderSourceName" class="orderSourceName-form-item">
          <el-select
            v-model="searchForm.orderSourceName"
            :placeholder="$t('meterInfo.gasMeterTypeName')"
            multiple
            filterable
            clearable
            collapse-tags
          >
            <el-option
              v-for="(value, key) in gasMeterTypeMap"
              :key="key"
              :label="value"
              :value="key"
            ></el-option>
          </el-select>
        </el-form-item>
        <!-- 气表状态 -->
        <el-form-item label="" prop="dataStatus" class="dataStatus-form-item">
          <el-select
            v-model="searchForm.dataStatus"
            :placeholder="$t('meterInfo.dataStatus')"
            multiple
            filterable
            clearable
            collapse-tags
          >
            <el-option
              v-for="(value, key) in meterStatusMap"
              :key="key"
              :label="value"
              :value="key"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="" prop="" style="marginleft: 10px">
          <el-button
            type="primary"
            name="meterInfo-search"
            icon="el-icon-search"
            class="search-btn meterInfo-search"
            @click.native="handleSearch"
          >{{ $t('search') }}
          </el-button>
          <el-button
            :loading="readCardLoading"
            type="success"
            name="readCard-search"
            icon="el-icon-folder"
            class="search-btn readCard-search"
            @click.native="handleReadCard"
          >{{ $t('meterInfo.readCard') }}
          </el-button>
          <el-button
            type="warning"
            name="meterInfo-search"
            icon="el-icon-refresh-left"
            class="search-reset-btn"
            @click.native="resetSearch(searchFormRef)"
          >{{ $t('reset') }}
          </el-button>
        </el-form-item>
      </el-form>
    </search-box>

    <!-- 档案列表 -->
    <el-row :gutter="10" style="margin-top: 10px">
      <!--left-->
      <el-col :span="17">
        <div>
          <!-- 档案列表 -->
          <el-card shadow="never" class="workHeight">
            <template v-slot:header>
              <search-box>
                <div slot="left"><span class="card-title">档案列表</span></div>
                <!-- 操作按钮 -->
                <div slot="right">
                  <!-- 移除设备 -->
                  <el-button
                    v-has-permission="['meterInfo:ycsb']"
                    type="primary"
                    plain
                    :loading="removeMeterLoading"
                    :disabled="!isRemoveMeter(meterInfoData) || removeMeterLoading"
                    @click.native="handleRemoveMeter"
                  >
                    {{ $t('button.removeMeter') }}
                  </el-button>
                  <!-- 远程控制 -->
                  <el-button
                    v-has-permission="['meterInfo:yckz']"
                    type="primary"
                    plain
                    :disabled="!isRemoteControl(meterInfoData)"
                    @click.native="remoteControlDialogVisible = true"
                  >
                    {{ $t('button.remoteControl') }}
                  </el-button>
                  <!-- 预开户 -->
                  <el-button
                    v-if="isTest"
                    v-has-permission="['meterInfo:ykh']" hidden type="primary"
                    plain
                    @click="dialogOpen('showPreAccountOpening')"
                  >
                    {{ $t('button.preOpenAccount') }}
                  </el-button>
                  <!--<el-button type="primary" plain @click="exportMsg('已打印')">打印条码</el-button>-->
                </div>
              </search-box>
            </template>

            <div class="clearfix"></div>
            <el-table
              :ref="listRef"
              v-loading="listLoading"
              :data="list"
              tooltip-effect="dark"
              stripe
              border
              :highlight-current-row="true"
              height="calc(100vh - 300px)"
              @row-click="handleRowClick"
            >
              <!-- 序号 -->
              <el-table-column type="index" :label="$t('table.index')"></el-table-column>
              <!-- 缴费编号 -->
              <el-table-column
                prop="customerChargeNo"
                :label="$t('meterInfo.customerChargeNo')"
                show-overflow-tooltip
                width="120"
              >
              </el-table-column>
              <!-- 气表编号 -->
              <!-- <el-table-column prop="gasCode" :label="$t('meterInfo.gasCode')" width="180">
              </el-table-column> -->
              <!-- 表身号 -->
              <el-table-column
                prop="gasMeterNumber"
                :label="$t('meterInfo.gasMeterNumber')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <!-- 报装编号	 -->
              <el-table-column prop="installNumber" :label="$t('meterInfo.installNumber')">
              </el-table-column>
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
              <!-- 气表厂家 -->
              <el-table-column
                prop="gasMeterFactoryName"
                :label="$t('meterInfo.gasMeterFactoryName')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <!-- 气表版号 -->
              <el-table-column
                prop="gasMeterVersionName"
                :label="$t('meterInfo.gasMeterVersionName')"
                show-overflow-tooltip
                width="90"
              >
              </el-table-column>
              <!-- 气表型号 -->
              <el-table-column
                prop="gasMeterModelName"
                :label="$t('meterInfo.gasMeterModelName')"
                show-overflow-tooltip
                width="90"
              >
              </el-table-column>
              <!-- 安装地址 -->
              <el-table-column
                prop="moreGasMeterAddress"
                :label="$t('meterInfo.gasMeterAddress')"
                show-overflow-tooltip
                width="150"
              >
              </el-table-column>
              <!-- 气表状态 -->
              <el-table-column prop="dataStatus" :label="$t('meterInfo.dataStatus')" width="100" fixed="right">
                <template #default="{ row }">
                  {{ meterStatusMap[+row.dataStatus] }}
                </template>
              </el-table-column>
              <!-- 操作 -->
              <el-table-column fixed="right" :label="$t('table.operation')" width="80">
                <template #default="{ row }">
                  <!-- 编辑 -->
                  <el-button
                    v-has-permission="['meterInfo:edit']"
                    type="primary"
                    name="row-edit"
                    @click="handleEdit(row)"
                  >{{ $t('edit') }}
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
            <!--分页-->
            <pagination
              :page.sync="queryParams.current"
              :limit.sync="queryParams.size"
              :total="+total"
              @pagination="handleGetList()"
            />
          </el-card>

          <!-- 气表状态 -->
          <el-card
            hidden
            shadow="never"
            class="setCardPadding"
            style="height: 160px; margin-top: 10px"
          >
            <div slot="header">
              <span class="card-title">气表状态</span>
            </div>
            <el-form label-position="top" class="jh-text">
              <el-form-item label="累计用气量">
                <p>{{ meterStatus[1] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="周期累计用气量">
                <p>{{ meterStatus[2] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="阈状态">
                <p>{{ meterStatus[3] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="报警器">
                <p>{{ meterStatus[4] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="当前阶段">
                <p>{{ meterStatus[5] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="当前价格">
                <p>{{ meterStatus[6] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="更新时间">
                <p>{{ meterStatus[7] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="气表余额">
                <p>{{ meterStatus[8] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="气表状态">
                <p>{{ meterStatus[9] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="异常信息">
                <p>{{ meterStatus[10] || emptyStr }}</p>
              </el-form-item>
            </el-form>
          </el-card>

          <!-- 阶梯用量信息 -->
          <el-card
            hidden
            shadow="never"
            class="setCardPadding"
            style="height: 170px; margin-top: 10px"
          >
            <div slot="header">
              <span class="card-title">阶梯用量信息</span>
            </div>
            <el-form label-position="top" class="jh-text">
              <el-form-item label="1阶梯用气量">
                <p>{{ tieredPricing[1] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="2阶梯用气量">
                <p>{{ tieredPricing[2] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="3阶梯用气量">
                <p>{{ tieredPricing[3] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="4阶梯用气量">
                <p>{{ tieredPricing[4] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="5阶梯用气量">
                <p>{{ tieredPricing[5] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="6阶梯用气量">
                <p>{{ tieredPricing[6] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="1阶梯用气价格">
                <p>{{ tieredPricing[7] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="2阶梯用气价格">
                <p>{{ tieredPricing[8] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="3阶梯用气价格">
                <p>{{ tieredPricing[9] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="4阶梯用气价格">
                <p>{{ tieredPricing[10] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="5阶梯用气价格">
                <p>{{ tieredPricing[11] || emptyStr }}</p>
              </el-form-item>
              <el-form-item label="6阶梯用气价格">
                <p>{{ tieredPricing[12] || emptyStr }}</p>
              </el-form-item>
            </el-form>
          </el-card>
        </div>
      </el-col>

      <!--right-->
      <el-col :span="7">
        <!-- 更多信息 -->
        <div class="workHeight moreInfo">
          <el-tabs
            v-model="curTabsLabel"
            class="workHeight moreInfo"
            tab-position="left"
            @tab-click="tabsChange"
          >
            <!-- 入库信息 -->
            <!-- <el-tab-pane label="入库信息" name="入库信息">
              <to-store-info v-if="curTabsLabel === '入库信息'"></to-store-info>
            </el-tab-pane> -->
            <!-- 表具信息 -->
            <el-tab-pane label="表具信息" name="表具信息">
              <meter-details v-if="curTabsLabel === '表具信息'" :data="meterInfoData" />
            </el-tab-pane>

            <!-- IC卡信息 -->
            <el-tab-pane label="IC卡信息" name="IC卡信息">
              <card-info 
                v-if="curTabsLabel === 'IC卡信息'"
                :options="meterInfoData"
              />
            </el-tab-pane>

            <!-- 气价方案 -->
            <el-tab-pane label="气价方案" name="气价方案">
              <price-plan v-if="curTabsLabel === '气价方案'"
                          :gas-meter-code="meterInfoData ? meterInfoData.gasCode : null"
              />
            </el-tab-pane>

            <!-- 气表状态 -->
            <el-tab-pane label="气表状态" name="气表状态">
              <meter-status-details
                v-if="curTabsLabel === '气表状态'"
                :gas-meter-code="meterInfoData ? meterInfoData.gasCode : null"
                :customer-code="meterInfoData ? meterInfoData.customerCode : null"
              />
            </el-tab-pane>

            <!-- 安检信息 -->
            <el-tab-pane v-if="isTest" label="安检信息" name="安检信息">
              <safe-check-info v-if="curTabsLabel === '安检信息'" />
            </el-tab-pane>

            <!-- 工单信息 -->
            <el-tab-pane v-if="isTest" label="工单信息" name="工单信息">
              <work-order v-if="curTabsLabel === '工单信息'" />
            </el-tab-pane>

            <!-- 抄表记录 -->
            <el-tab-pane v-if="isTest" label="抄表记录" name="抄表记录">
              <read-meter-records v-if="curTabsLabel === '抄表记录'" />
            </el-tab-pane>

            <!-- 指令信息 -->
            <el-tab-pane v-if="isTest" label="指令信息" name="指令信息">
              <directive-info v-if="curTabsLabel === '指令信息'" />
            </el-tab-pane>

            <!-- 统计数据 -->
            <el-tab-pane label="统计数据" name="统计数据">
              <meter-record-statistics v-if="curTabsLabel === '统计数据'" />
            </el-tab-pane>
          </el-tabs>
        </div>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <!-- 单个表具入库 -->
      <div v-has-permission="['meterInfo:bjrk']" class="footNav-item" @click="handleAdd()">
        <div class="icon">
          <svg-icon icon-class="meterStorage" />
        </div>
        <p>{{ $t('meterInfo.meterToStore') }}</p>
      </div>
      <!-- 批量导入表具 -->
      <div
        v-has-permission="['meterInfo:bjdr']"
        class="footNav-item"
        @click="meterImportDialogVisible = true"
      >
        <div class="icon">
          <svg-icon icon-class="import" />
        </div>
        <p>{{ $t('meterInfo.importToStore') }}</p>
      </div>

      <!-- 扫码入库 -->
      <div v-has-permission="['meterInfo:smrk']" class="footNav-item" @click="scanMeterToStoreDialogVisible = true">
        <div class="icon">
          <svg-icon icon-class="scan" />
        </div>
        <p>{{ $t('meterInfo.scanToStore') }}</p>
      </div>

      <!-- 物联网表重新注册 -->
      <div v-has-permission="['meterInfo:wlwbcxzc']" class="footNav-item" @click="registerAgainDialogVisible = true">
        <div class="icon">
          <svg-icon icon-class="addAgain" />
        </div>
        <p>{{ $t('物联网表重新注册') }}</p>
      </div>

      <!-- 物联网表参数设置 -->
      <!-- <div v-has-permission="['meterInfo:wlwbccsz']" class="footNav-item" @click="iotParamterSettingDialogVisible = true"> -->
      <div class="footNav-item" @click="iotParamterSettingDialogVisible = true">
        <div class="icon">
          <svg-icon icon-class="setting" />
        </div>
        <p>{{ $t('物联网表参数设置') }}</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->

    <!--表具入库-->
    <el-dialog
      width="800px"
      :title="meterInfoData ? $t('meterInfo.edit') : $t('meterInfo.add')"
      :visible.sync="meterFormDialogVisible"
    >
      <meter-to-store v-if="meterFormDialogVisible" :form-data="meterInfoData" @success="handleMeterSaveSuccess" />
    </el-dialog>

    <!-- 导入表具信息弹框 -->
    <el-dialog
      width="1000"
      :title="$t('meterInfo.importTitle')"
      :visible="meterImportDialogVisible"
      data-key="meterImportDialogVisible"
      :close-on-click-modal="false"
      @close="meterImportDialogVisible = false"
    >
      <template #title>
        <span class="el-dialog__title">
          <span>{{ $t('meterInfo.importTitle') }}</span>
          <el-button
            type="primary"
            size="mini"
            class="download-btn"
            style="margin: auto 10px"
            @click.native="handleDownloadTemplateFile"
          >{{ $t('meterInfo.downloadMeterTemplate') }}</el-button>
        </span>
      </template>
      <import-meter-info @success="handleImportMeterInfoSuccess" />
    </el-dialog>

    <!--扫码入库-->
    <el-dialog
      width="1000px"
      :title="$t('meterInfo.scanMeterTitle')"
      :visible.sync="scanMeterToStoreDialogVisible"
      data-key="scanMeterToStoreDialogVisible"
      @close="scanMeterToStoreDialogVisible = false"
    >
      <scan-meter-to-store @success="handleScanMeterInfoSuccess" />
    </el-dialog>

    <!--物联网表重新注册-->
    <el-dialog
      width="1200px"
      :title="$t('已拆除物联网表重新注册')"
      :visible.sync="registerAgainDialogVisible"
      @close="registerAgainDialogVisible = false"
    >
      <register-again @success="handleRegisterAgainSuccess" />
    </el-dialog>

    <!--物联网表参数设置-->
    <el-dialog
      width="1200px"
      :title="$t('物联网表参数设置')"
      :visible.sync="iotParamterSettingDialogVisible"
      @close="iotParamterSettingDialogVisible = false"
    >
      <iot-paramter-setting v-if="iotParamterSettingDialogVisible" />
    </el-dialog>

    <!--远程控制-->
    <el-dialog
      width="75%"
      title="远程控制"
      :visible.sync="remoteControlDialogVisible"
      @close="remoteControlDialogVisible = false"
    >
      <remote-control :meter-info="meterInfoData"></remote-control>
    </el-dialog>

    <!-- 编辑用户表具信息(已经开户的) -->
    <el-dialog
      width="70%"
      :title="$t('edit')"
      :visible.sync="openAccountMeterFormDialogVisible"
    >
      <meter-form v-if="openAccountMeterFormDialogVisible" :customer-data="customerInfoData" :meter-data="meterInfoData"
                  @success="handleOpenAccountMeterSaveSuccess"
      ></meter-form>
    </el-dialog>

    <!-- 预开户 -->
    <qc-dialog
      v-if="showPreAccountOpening"
      :width="350"
      title="预开户"
      :visible="showPreAccountOpening"
      data-key="showPreAccountOpening"
      @close="dialogClose"
    >
      <pre-account-opening />
    </qc-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./meterInfo.js"></script>
<style lang="scss" scoped>
.searchBox {
  margin-bottom: 0;

  .el-input,
  .el-select {
    width: 120px;
  }
}

.setCardPadding {
  ::v-deep .el-card__body {
    padding-top: 5px;
  }
}

.jh-text {
  .el-form-item {
    width: calc(100% / 6);
  }
}

.qc-search-form {
  .el-form-item {
    margin-bottom: 0;
  }
}
.orderSourceName-form-item {
  .el-select {
    max-width: 260px;
    width: auto;
  }
}
.dataStatus-form-item {
  .el-select {
    width: 160px;
  }
}
</style>
