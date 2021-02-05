<!--物联网抄表业务-->
<template>
  <div class="qc-main iotReadMeter-page">
    <!--search-->
    <search-box>
      <!-- 缴费编号 -->
      <el-input v-model="searchForm.model.customerChargeNo" placeholder="缴费编号" />
      <!-- 表身号 -->
      <el-input v-model="searchForm.model.gasMeterNumber" placeholder="表身号" />
      <!-- 安装地址 -->
      <el-input v-model="searchForm.model.gasMeterAddress" class="gasMeterAddress-input" placeholder="安装地址" />
      <!-- 小区 -->
      <!-- 抄表员 -->
      <el-input v-model="searchForm.model.readMeterUserName" placeholder="抄表员" />
      <!-- 用气类型 -->
      <el-input v-model="searchForm.model.useGasTypeName" placeholder="用气类型" />
      <!-- 客户编号 -->
      <!-- <el-input v-model="searchForm.model.customerCode" placeholder="客户编号"/> -->
      <!-- <el-input v-model="searchCondition.meterNo" placeholder="气表编号" /> -->
      <!-- 客户姓名 -->
      <el-input v-model="searchForm.model.customerName" placeholder="客户名称" />
      <!-- 查询月份 -->
      <el-date-picker
        v-model="searchForm.model.readTime"
        type="month"
        placeholder="选择抄表年月"
        value-format="yyyy-MM"
        style="width: 150px"
      ></el-date-picker>

      <!-- 查询 -->
      <el-button type="primary" @click="handleSearch">查询</el-button>
    </search-box>

    <el-row :gutter="10">
      <!--left-->
      <el-col :span="17">
        <!-- 抄表数据审核 -->
        <el-card shadow="never" class="workHeight">
          <div slot="header">
            <search-box style="margin-bottom: 0">
              <div slot="left">
                <span class="card-title">抄表数据审核</span>
              </div>
              <div slot="right">
                <!-- <el-button v-if="curBtn === '-1'" type="primary">导出</el-button> -->
                <!--<el-button type="primary">开票</el-button>-->
                <!-- <el-button v-if="curBtn == -1" type="primary">补抄</el-button> -->
                <!-- 提审 -->
                <!-- <el-button
                  v-if="IS_SUBMIT_FOR_REVIEW"
                  v-has-permission="['readMeterIot:ts']"
                  :disabled="submitForReviewData.length === 0"
                  type="primary"
                  @click="handleSubmitForReview()"
                >
                  提审
                </el-button> -->
                <!-- 补抄数据纠正 -->
                <!-- <el-button
                  v-if="IS_FIX_READ_METER"
                  v-has-permission="['readMeterIot:jzsj']"
                  :disabled="fixReadMeterData.length === 0"
                  type="primary"
                  @click="handleOpenFixReadMeterDialog(true)"
                >
                  纠正数据
                </el-button> -->
                <!-- 撤回 -->
                <el-button
                  v-if="IS_WITHDRAW"
                  v-has-permission="['readMeterIot:ch']"
                  :disabled="withdrawData.length === 0"
                  type="primary"
                  @click="handleWithdraw()"
                >撤回
                </el-button>
                <!-- 驳回 -->
                <!-- <el-button
                  v-if="IS_REVIEW_REJECTED"
                  v-has-permission="['readMeterIot:bh']"
                  :disabled="reviewRejectedData.length === 0"
                  type="primary"
                  @click="showRejectReason = true"
                >
                  驳回
                </el-button> -->
                <!-- 审核 -->
                <!-- <el-button
                  v-if="IS_APPROVED"
                  v-has-permission="['readMeterIot:sh']"
                  :disabled="appovedData.length === 0"
                  type="primary"
                  @click="handleApproved()"
                >
                  审核
                </el-button> -->
                <!-- 结算 -->
                <!-- <el-button v-if="IS_SETTLEMENT" v-has-permission="['readMeterIot:js']" :disabled="settlementData.length === 0" type="primary" @click="handleSettlement()"> 结算 </el-button> -->
                <!-- <el-button v-if="curBtn == 'NO_CHARGE'" type="primary">收费</el-button> -->
                <!-- 打印缴费通知 -->
                <el-button v-if="IS_NO_CHARGE" v-has-permission="['readMeterIot:dyjftz']"
                           :disabled="noChargeData.length === 0" type="primary"
>打印缴费通知
                </el-button>
                <!-- 打印催款通知 -->
                <el-button v-if="IS_ARREARS" v-has-permission="['readMeterIot:dycktz']"
                           :disabled="arrearsData.length === 0" type="primary"
>打印催款通知
                </el-button>
              </div>
            </search-box>
          </div>

          <!-- list -->
          <div class="butGroup" style="margin: -10px 0 10px 0">
            <!-- <el-button type="primary" :plain="curBtn !== -1" @click="changeDataStatus(-1)">待抄</el-button> -->
            <!-- <el-divider direction="vertical"></el-divider> -->
            <!-- 进度显示切换按钮 -->
            <template v-for="(item, key) in filterProcessStatusBtns">
              <el-button :key="key" type="primary" :plain="curBtn !== key" @click="changeProcessStatus(key)">{{ item.text }}
              </el-button>
            </template>
            <!-- <el-divider direction="vertical"></el-divider> -->
            <!-- 收费状态显示切换按钮 -->
            <template v-for="(item, key) in filterChangeStatusBtns">
              <el-button :key="key" type="primary" :plain="curBtn !== key"@click="changeChargeStatus(key)">{{ item.text }}
              </el-button>
            </template>
            <!-- <el-divider direction="vertical"></el-divider> -->
            <!-- <el-button type="primary" plain @click="changeChargeStatus('CHARGED')">待出票</el-button>
            <el-button type="primary" plain @click="changeChargeStatus('INVOICED')>已出票</el-button> -->
            <el-button type="primary" :plain="curBtn !== 'all'" @click="queryAll">全部</el-button>
          </div>
          <el-table
            ref="multipleTable"
            v-loading="listLoading"
            :data="tableData"
            tooltip-effect="dark"
            border
            height="calc(100vh - 300px)"
            style="width: 100%"
            :highlight-current-row="true"
            @selection-change="tableSelect"
            @row-click="rowClick"
          >
            <el-table-column type="selection" width="45" :selectable="setSelectable" />
            <!-- <el-table-column type="index" label="#" width="45" /> -->
            <el-table-column prop="customerChargeNo" show-overflow-tooltip label="缴费编号" width="100" />
            <el-table-column prop="customerName" label="客户姓名" width="80" />
            <el-table-column prop="gasMeterNumber" label="表身号" width="120" />
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
            <el-table-column prop="useGasTypeName" label="用气类型名称	" width="100" />
            <el-table-column prop="gasMeterAddress" show-overflow-tooltip label="安装地址" />
            <el-table-column prop="lastTotalGas" label="上期止数" width="80" />
            <el-table-column prop="currentTotalGas" label="本期止数" width="80" />
            <el-table-column prop="monthUseGas" label="本期用量" width="80" />
            <!-- <el-table-column prop="readMeterUserName" label="抄表员名称		" width="100" /> -->
            <el-table-column prop="recordTime" label="抄表日期" width="80">
              <template slot-scope="{row}">
                {{ row.recordTime | parsedTime }}
              </template>
            </el-table-column>
            <el-table-column prop="processStatus" label="结算状态" width="80">
              <template slot-scope="{ row }">
                {{ row.processStatus ? row.processStatus.desc : '---' }}
              </template>
            </el-table-column>
            <!-- <el-table-column prop="reviewObjection" label="驳回原因" width="80" /> -->
            <el-table-column prop="useMoney" label="结算金额" width="80" />
            <el-table-column prop="settlementTime" label="结算日期" width="80">
              <template slot-scope="{row}">
                {{ row.settlementTime | parsedTime }}
              </template>
            </el-table-column>
            <el-table-column prop="chargeStatus" label="抄表收费状态" width="120">
              <template slot-scope="{ row }">
                {{ row.chargeStatus ? row.chargeStatus.desc : '---' }}
              </template>
            </el-table-column>
            <!-- 操作 -->
            <!-- <el-table-column
              v-if="curBtn === 'TO_BE_REVIEWED' || curBtn == 'REVIEW_REJECTED'"
              fixed="right"
              label="操作"
              width="120"
            >
              <template slot-scope="{ row }">
                <el-button type="primary" @click="handleOpenFixReadMeterDialog(true)">补抄数据</el-button>
              </template>
            </el-table-column> -->
          </el-table>
          <!-- 分页 -->
          <pagination
            :page-sizes="[10, 15, 20, 30]"
            :limit.sync="searchForm.size"
            :page.sync="searchForm.current"
            :total="total"
            @pagination="search()"
          />
        </el-card>
      </el-col>

      <!--right-->
      <el-col :span="7">
        <el-tabs v-model="curTabsLabel" class="workHeight moreInfo" tab-position="left" @tab-click="tabsChange">
          <!--
          客户信息
          表具信息
          抄表记录
          欠费明细
          缴费信息
          气价方案
          气表状态
          统计数据
          -->

          <el-tab-pane label="客户信息" name="客户信息">
            <customer-details
              v-if="curTabsLabel === '客户信息'"
              :customer-code="currentRow.customerCode || null"
            />
          </el-tab-pane>

          <el-tab-pane label="表具信息" name="表具信息">
            <meter-details v-if="curTabsLabel === '表具信息'" :gas-meter-code="currentRow.gasMeterCode || null" />
          </el-tab-pane>

          <!-- 抄表记录 -->
          <el-tab-pane v-if="isTest" label="抄表记录" name="抄表记录">
            <read-meter-records v-if="curTabsLabel === '抄表记录'" />
          </el-tab-pane>

          <el-tab-pane label="欠费明细" name="欠费明细">
            <arrearage-info v-if="curTabsLabel === '欠费明细'" :gas-meter-code="currentRow.gasMeterCode || null" />
          </el-tab-pane>

          <!-- 缴费信息 -->
          <el-tab-pane label="缴费信息" name="缴费信息">
            <payment-records
              v-if="curTabsLabel === '缴费信息'"
              :gas-meter-code="currentRow.gasMeterCode || null"
              :customer-code="currentRow.customerCode || null"
            />
          </el-tab-pane>

          <el-tab-pane label="气价方案" name="气价方案">
            <price-plan
              v-if="curTabsLabel === '气价方案'"
              :gas-meter-code="currentRow.gasMeterCode || null"
            />
          </el-tab-pane>

          <!-- 气表状态 -->
          <el-tab-pane label="气表状态" name="气表状态">
            <meter-status-details
              v-if="curTabsLabel === '气表状态'"
              :gas-meter-code="currentRow.gasMeterCode || null"
              :customer-code="currentRow.customerCode || null"
            />
          </el-tab-pane>

          <!-- 抄表统计 -->
          <el-tab-pane v-if="false" label="抄表统计" name="抄表统计">
            <read-meter-statistics v-if="curTabsLabel === '抄表统计'" />
          </el-tab-pane>

        </el-tabs>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>

      <div v-has-permission="['readMeterIot:ycsjtj']" class="footNav-item" @click="handleOpenFixReadMeterDialog(false)">
        <div class="icon">
          <svg-icon icon-class="add" />
        </div>
        <p>异常数据添加</p>
      </div>

      <div v-if="isTest" v-has-permission="['readMeterIot:cbdr']" class="footNav-item" @click="dialogOpen('showReadMeterImport')">
        <div class="icon">
          <svg-icon icon-class="readMeterImport" />
        </div>
        <p>抄表导入</p>
      </div>
      <div v-if="isTest" v-has-permission="['readMeterIot:dkdr']" class="footNav-item" @click="dialogOpen('showWithholdImport')">
        <div class="icon">
          <svg-icon icon-class="import" />
        </div>
        <p>代扣导入</p>
      </div>
      <div v-if="isTest" v-has-permission="['readMeterIot:dkdc']" class="footNav-item" @click="exportMsg('已导出')">
        <div class="icon">
          <svg-icon icon-class="export" />
        </div>
        <p>代扣导出</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->
    <!-- 驳回 -->
    <el-dialog width="400px" title="驳回" :visible.sync="showRejectReason">
      <reject-reason
        v-if="showRejectReason"
        v-model="rejectedMsg"
        @submit="handleReviewRejected()"
      />
    </el-dialog>

    <!-- 添加 -->
    <!-- <el-dialog width="1100px" title="添加" :visible.sync="fixReadMeterDialogVisible">
      <fix-read-meter v-if="fixReadMeterDialogVisible" @success="handleAddReadMeterSuccess"></fix-read-meter>
    </el-dialog> -->

    <!-- 添加、补抄数据 -->
    <el-dialog width="1100px" :title="fixReadMeterData.length > 0 ? '异常数据纠正' : '异常数据添加'"
               :visible.sync="fixReadMeterDialogVisible"
    >
      <fix-read-meter v-if="fixReadMeterDialogVisible" :read-meter-data="isEdit ? fixReadMeterData : []"
                      @success="handleFixReadMeterSuccess"
      ></fix-read-meter>
    </el-dialog>

    <!--抄表导入-->
    <el-dialog width="500px" title="抄表导入" :visible.sync="showReadMeterImport">
      <read-meter-import v-if="showReadMeterImport" />
    </el-dialog>
    <!-- 抄表导入 -->
    <el-dialog
      width="1000"
      title="抄表导入"
      :visible.sync="showReadMeterImport"
      :close-on-click-modal="false"
    >
      <template #title>
        <span class="el-dialog__title">
          <span>{{ $t('抄表导入') }}</span>
          <el-button type="primary" size="mini" class="download-btn" style="margin: auto 10px"
                     @click.native="handleDownloadTemplateFile"
          >{{ $t('下载抄表导入信息模板') }}</el-button>
        </span>
      </template>
      <read-meter-import />
    </el-dialog>

    <!--代扣导入-->
    <el-dialog width="1000px" title="代扣导入" :visible.sync="showWithholdImport">
      <withhold-import v-if="showWithholdImport" />
    </el-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./iot.js"></script>
<style lang="scss" scoped>
  .iotReadMeter-page {
    .gasMeterAddress-input {
      width: 200px;
    }
  }
</style>
