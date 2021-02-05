<!-- 用户档案 -->
<template>
  <div class="qc-main customer-index-page">
    <!--搜索区域-->
    <search-box class="search-box operation-box">
      <el-form ref="searchFormRef" :model="queryParams.model" :inline="true" class="qc-search-form">
        <!-- 缴费编号 -->
        <el-form-item label="" prop="customerChargeNo">
          <el-input
            v-model="queryParams.model.customerChargeNo"
            name="customerChargeNo"
            clearable
            :placeholder="$t('meterInfo.customerChargeNo')"
          />
        </el-form-item>

        <!-- 客户姓名 -->
        <el-form-item label="" prop="customerName" style="width: 120px">
          <el-input
            v-model="queryParams.model.customerName"
            name="customerName"
            clearable
            :placeholder="$t('customerInfo.customerName')"
          />
        </el-form-item>
        <!-- 联系电话 -->
        <el-form-item label="" prop="telphone" style="width: 140px">
          <el-input
            v-model="queryParams.model.telphone"
            name="telphone"
            clearable
            :placeholder="$t('customerInfo.telphone')"
          />
        </el-form-item>
        <!-- 客户类型 -->
        <el-form-item label="" prop="customerTypeCode">
          <el-select
            v-model="queryParams.model.customerTypeCode"
            name="customerTypeCode"
            clearable
            :placeholder="$t('customerInfo.customerTypeCode')"
          >
            <el-option v-for="(value, key) in userTypeMap" :key="key" :label="value" :value="key" />
          </el-select>
        </el-form-item>
        <!-- 用气类型 -->
        <el-form-item label="" prop="useGasTypeId">
          <el-select
            v-model="queryParams.model.useGasTypeId"
            name="useGasTypeId"
            clearable
            :placeholder="$t('meterInfo.useGasTypeId')"
          >
            <el-option
              v-for="(item, index) in useGasTypeList"
              :key="index"
              :label="item.useGasTypeName"
              :value="item.id"
            />
          </el-select>
        </el-form-item>

        <!-- 黑名单 -->
        <el-form-item label="" prop="blackStatus">
          <el-select
            v-model="queryParams.model.blackStatus"
            name="blackStatus"
            clearable
            placeholder="黑名单"
          >
            <el-option
              label="否"
              :value="0"
            />
            <el-option
              label="是"
              :value="1"
            />
          </el-select>
        </el-form-item>

        <!-- 用户状态 -->
        <el-form-item label="" prop="customerStatus">
          <el-select
            v-model="queryParams.model.customerStatus"
            name="customerStatus"
            clearable
            placeholder="用户状态"
          >
            <el-option v-for="(value, key) in customerStatusMap" :key="key" :label="value" :value="key" />
          </el-select>
        </el-form-item>

        <el-form-item label="" prop="" style="marginleft: 10px">
          <el-button
            type="primary"
            name="userInfo-search"
            icon="el-icon-search"
            class="search-btn userInfo-search"
            @click.native="search"
          >{{ $t('search') }}
          </el-button>
          <el-button
            type="warning"
            name="userInfo-search-reset"
            icon="el-icon-refresh-left"
            class="search-reset-btn"
            @click.native="resetSearch('searchFormRef')"
          >{{ $t('reset') }}
          </el-button>
        </el-form-item>
      </el-form>
    </search-box>
    <!-- 档案列表 -->
    <el-row :gutter="15" style="margin-top: 10px">
      <!--left-->
      <el-col :span="10">
        <!-- 档案列表 -->
        <el-card
          shadow="never"
          style="height:calc(100vh - 145px)"
        >
          <div slot="header">
            <search-box>
              <div slot="left">
                <span class="card-title">{{ $t('customerInfo.title') }}</span>
              </div>
              <div slot="right">
                <!-- 添加 -->
                <el-button
                  v-has-permission="['userInfo:userAdd']"
                  type="success"
                  @click.native="handleUserinfo"
                >
                  {{ $t('add') }}
                </el-button>
                <!-- 批量导入客户 -->
                <el-button
                  v-has-permission="['userInfo:pldrkh']"
                  type="success"
                  @click.native="importUserinfoDialogVisible = true"
                >
                  {{ $t('customerInfo.importCustomer') }}
                </el-button>

                <!-- 移除黑名单 -->
                <el-button
                  v-has-permission="['userInfo:ychmd']"
                  :disabled="removeBlackList.length <= 0"
                  type="primary"
                  @click.native="removeFromBlacklist()"
                >
                  {{ $t('customerInfo.removeBlack') }}
                </el-button>
                <!-- 加入黑名单 -->
                <el-button
                  v-has-permission="['userInfo:jrhmd']"
                  :disabled="addBlackList.length <= 0"
                  type="primary"
                  @click.native="addToBlacklist()"
                >
                  {{ $t('customerInfo.addBlack') }}
                </el-button>

                <!-- 销户 -->
                <el-button
                  v-has-permission="['userInfo:xh']"
                  :disabled="multipleSelection.length === 0 || loading"
                  type="danger"
                  @click.native="accountCancellation"
                >
                  销户
                </el-button>
              </div>
            </search-box>
          </div>

          <el-table
            ref="customerTable"
            v-loading="loading"
            :data="userInfoData.records"
            tooltip-effect="dark"
            stripe
            border
            :highlight-current-row="true"
            height="calc(100vh - 290px)"
            @row-click="rowClick"
            @selection-change="handleSelectionChange"
          >
            <!-- 多选框 -->
            <el-table-column
              align="center"
              type="selection"
              width="40px"
              :reserve-selection="false"
            />

            <el-table-column prop="customerName" label="客户姓名" width="80" />
            <!-- 身份证号码 -->
            <el-table-column prop="idCard" label="身份证号码" show-overflow-tooltip width="150" />

            <!-- 联系电话 -->
            <el-table-column prop="telphone" label="联系电话" width="100" />
            <!-- 客户类型 -->
            <el-table-column prop="customerTypeName" label="客户类型" />
            <!-- 黑名单 -->
            <el-table-column prop="blackStatus" label="黑名单" width="60">
              <template slot-scope="scope">
                <span>{{ scope.row.blackStatus | blackStatusFilter }}</span>
              </template>
            </el-table-column>

            <!-- 状态 -->
            <el-table-column prop="blackStatus" label="状态" width="60">
              <template slot-scope="scope">
                <span>{{ customerStatusMap[scope.row.customerStatus] || emptyStr }}</span>
              </template>
            </el-table-column>

            <!-- 安装地址 -->
            <el-table-column
              prop="contactAddress"
              :label="$t('customerInfo.contactAddress')"
              width="150"
              show-overflow-tooltip
            />
            <!-- 操作 -->
            <el-table-column
              :label="$t('table.operation')"
              column-key="operation"
              fixed="right"
              width="80"
            >
              <template slot-scope="{ row }">
                <!-- <el-button v-if="row.blackStatus" type="success" @click.native="removeFromBlacklist(row)">
                  移出黑名单
                </el-button>
                <el-button v-else type="success" @click.native="addToBlacklist(row)">
                  加入黑名单
                </el-button> -->
                <!-- <el-button v-if="row.blackStatus" type="success" @click.stop="view(row)">
                  查看
                </el-button> -->
                <el-button v-has-permission="['userInfo:userUpdate']" type="primary" @click="edit(row)"> 编辑</el-button>
              </template>
            </el-table-column>
          </el-table>
          <pagination
            v-show="userInfoData.total > 0"
            :limit.sync="queryParams.size"
            :page.sync="queryParams.current"
            :total="Number(userInfoData.total)"
            @pagination="fetch"
          />
        </el-card>
      </el-col>

      <!-- 表具列表 -->
      <el-col :span="7">
        <el-card
          shadow="never"
          style="height:calc(100vh - 145px)"
        >
          <div slot="header">
            <search-box>
              <div slot="left">
                <span class="card-title">当前客户表具</span>
              </div>
              <div v-if="gasMeterData" slot="right">
                <el-input v-model="meterFilterKeywords" placeholder="输入地址关键字过滤" style="width: 100%"
                          @change="filterMeter"
                ></el-input>
              </div>
            </search-box>
          </div>
          <el-table
            v-if="currentItem"
            ref="gasMeterTableRef"
            v-loading="loading"
            :data="userMeterList"
            tooltip-effect="dark"
            stripe
            border
            :highlight-current-row="true"
            height="calc(100vh - 245px)"
            @row-click="meterRowClick"
          >
            <!-- 序号 -->
            <el-table-column
              type="index"
              label="序号"
            />
            <!-- 表身号 -->
            <el-table-column prop="gasMeterNumber" label="表身号" show-overflow-tooltip />
            <!-- 缴费编号 -->
            <el-table-column prop="customerChargeNo" label="缴费编号" />

            <!-- 安装地址 -->
            <el-table-column
              prop="moreGasMeterAddress"
              label="安装地址"
              width="400"
            />
            <!-- 操作 -->
            <el-table-column
              :label="$t('table.operation')"
              column-key="operation"
              width="90"
              fixed="right"
            >
              <template #default="{ row }">
                <el-button v-has-permission="['userInfo:meterUpdate']" type="primary" icon="el-icon-edit" title="编辑表具"
                           circle @click="showMeterFormDialog(row)"
></el-button>
                <el-button v-has-permission="['userInfo:meterUpload']" type="primary" icon="el-icon-folder-checked"
                           title="上传开户资料" circle @click="showUploadDialog(row)"
></el-button>
              </template>
            </el-table-column>
          </el-table>
          <no-select v-else tips="请选择客户" />
        </el-card>
      </el-col>

      <!--right-->
      <el-col :span="7">
        <el-tabs v-model="curTabsLabel" class="workHeight moreInfo" tab-position="left" @tab-click="tabsChange">
          <el-tab-pane label="客户信息" name="客户信息">
            <span slot="label"><i class="el-icon-user"></i>客户信息</span>
            <customer-details
              v-if="curTabsLabel === '客户信息'"
              :data="currentItem"
            />
          </el-tab-pane>

          <el-tab-pane label="变更记录" name="变更记录">
            <span slot="label">
              <i class="el-icon-document" />变更记录
            </span>
            <change-records v-if="curTabsLabel === '变更记录'" :customer-code="currentItem ? currentItem.customerCode : ''"
                            :gas-meter-code="currentMeter ? currentMeter.gasCode : null"
>
          </change-records></el-tab-pane>

          <el-tab-pane label="账户信息" name="账户信息">
            <span slot="label"><i class="el-icon-user"></i>账户信息</span>
            <account-info v-if="curTabsLabel === '账户信息'"
                          :customer-code="currentItem ? currentItem.customerCode : null"
            />
          </el-tab-pane>
          <!-- 限购信息 -->
          <el-tab-pane label="限购信息" name="限购信息">
            <span slot="label"><i class="el-icon-user"></i>限购信息</span>
            <buy-limit v-if="curTabsLabel === '限购信息'"
                       :options="{ customerCode: currentItem ? currentItem.customerCode : null, gasMeterCode: currentMeter ? currentMeter.gasCode : null}"
            />
          </el-tab-pane>

          <!-- 商品信息 -->
          <el-tab-pane v-if="isTest" label="商品信息" name="商品信息">
            <span slot="label"><i class="el-icon-user"></i>商品信息</span>
            <goods-info v-if="curTabsLabel === '商品信息'" />
          </el-tab-pane>

          <!-- 表具信息 -->
          <el-tab-pane label="表具信息" name="表具信息">
            <span slot="label"><i class="el-icon-stopwatch"></i>表具信息</span>
            <meter-details v-if="curTabsLabel === '表具信息'" :data="currentMeter" />
          </el-tab-pane>

          <el-tab-pane v-if="showQf" label="欠费明细" name="欠费明细">
            <span slot="label"><i class="el-icon-stopwatch"></i>欠费明细</span>
            <arrearage-info v-if="curTabsLabel === '欠费明细'"
                            :gas-meter-code="currentMeter ? currentMeter.gasCode : null"
            />
          </el-tab-pane>

          <!-- 缴费信息 -->
          <el-tab-pane label="缴费信息" name="缴费信息">
            <span slot="label"><i class="el-icon-stopwatch"></i>缴费信息</span>
            <payment-records v-if="curTabsLabel === '缴费信息'"
                             :gas-meter-code="currentMeter ? currentMeter.gasCode : null"
                             :customer-code="currentItem ? currentItem.customerCode : null"
            />
          </el-tab-pane>

          <el-tab-pane v-if="isTest" label="工单信息" name="工单信息">
            <span slot="label"><i class="el-icon-stopwatch"></i>工单信息</span>
            <work-order v-if="curTabsLabel === '工单信息'" />
          </el-tab-pane>

          <el-tab-pane label="统计数据" name="统计数据">
            <user-record-statistics v-if="curTabsLabel === '统计数据'" />
          </el-tab-pane>
        </el-tabs>

      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div v-has-permission="['userInfo:kh']" class="footNav-item" @click="openAccountDialogVisible = true">
        <div class="icon">
          <svg-icon icon-class="openAccount" />
        </div>
        <p>开户</p>
      </div>
      <!--<div class="footNav-item" @click="exportMsg('已导出')">
        <div class="icon">
          <svg-icon icon-class="OpenMoreAccount" />
        </div>
        <p>批量开户</p>
      </div>-->
      <div v-has-permission="['userInfo:drkh']" class="footNav-item" @click="importOpenAccountDialogVisible = true">
        <div class="icon">
          <svg-icon icon-class="user-import" />
        </div>
        <p>导入开户</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->

    <!-- 更新开户资料 -->
    <el-dialog
      width="800px"
      title="开户资料"
      :visible.sync="showUpload"
    >
      <qc-upload
        v-if="showUpload"
        :meter-number="currentMeter.gasMeterNumber"
        :gas-meter-code="currentMeter.gasCode"
        :customer-code="currentItem.customerCode"
      />
    </el-dialog>

    <!-- 编辑用户表具信息 -->
    <el-dialog
      width="70%"
      :title="$t('edit')"
      :visible.sync="showGasTabInfo"
      data-key="showGasTabInfo"
      :close-on-click-modal="false"
      @close="showGasTabInfo = false"
    >
      <meter-form
        v-if="showGasTabInfo"
        :customer-data="currentItem"
        :meter-data="currentMeter"
        @success="handleMeterSaveSuccess"
      ></meter-form>
    </el-dialog>

    <!-- 编辑用户信息 -->
    <qc-dialog
      :width="1000"
      :title="currentItem ? $t('customerInfo.edit') : $t('customerInfo.add')"
      :visible="editUserInfo"
      data-key="editUserInfo"
      @close="dialogClose"
    >
      <edit-user v-if="editUserInfo" :form-data="currentItem" @close="endEdit" />
    </qc-dialog>

    <!-- 导入客户档案信息弹框 -->
    <el-dialog
      width="1000"
      :title="$t('customerInfo.importTitle')"
      :visible="importUserinfoDialogVisible"
      data-key="importUserinfoDialogVisible"
      :close-on-click-modal="false"
      @close="importUserinfoDialogVisible = false"
    >
      <template #title>
        <span class="el-dialog__title">
          <span>{{ $t('customerInfo.importTitle') }}</span>
          <el-button
            type="primary"
            size="mini"
            class="download-btn"
            style="margin: auto 10px"
            @click.native="handleDownloadTemplateFile"
          >{{ $t('customerInfo.downloadMeterTemplate') }}</el-button>
        </span>
      </template>
      <import-user-info @success="handleImportUserInfoSuccess" />
    </el-dialog>

    <!-- 开户弹出框 -->
    <el-dialog
      width="70%"
      :title="$t('customerInfo.openAccount')"
      :visible.sync="openAccountDialogVisible"
      data-key="openAccountDialogVisible"
      :close-on-click-modal="false"
      @close="openAccountDialogVisible = false"
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

    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./userInfo.js"></script>
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

.pagination-container {
  padding-top: 15px;
}

.gas-table-btns {
  height: 60px;
  background-color: white;
  text-align: right;
  line-height: 60px;
  border-bottom: 1px solid #dfe4ed;
  border-left: 1px solid #dfe4ed;
  border-right: 1px solid #dfe4ed;
}

.no-data {
  height: 260px;
  margin-top: 10px;
  overflow: hidden;
  background-color: white;
  line-height: 240px;
  text-align: center;
}

.qc-search-form {
  .el-form-item {
    margin-bottom: 0;
  }
}

.meter-card {
  ::v-deep {
    .el-tabs__content {
      height: auto;
      padding-bottom: 0;
      margin-bottom: -18px;
    }

    .el-tabs--border-card {
      box-shadow: none !important;
    }

    .MeterDetails-page {
      .show-meterinfo-form {
        padding: 0;

        .el-form-item {
          width: calc(100% / 6);
        }
      }

      .el-card {
        border: none;

        .el-card__body {
          padding: 0;
        }
      }
    }
  }
}

::v-deep {
  .el-tabs__item {
    i {
      margin-right: 5px;
    }
  }
}
</style>
