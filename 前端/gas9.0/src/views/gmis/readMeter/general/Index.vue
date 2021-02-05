<!--抄表业务-->
<template>
  <div class="qc-main">
    <!--search-->
    <search-box>
      <!-- 表身号 -->
      <el-input v-model="searchForm.model.gasMeterNumber" placeholder="表身号" />
      <!-- 缴费编号 -->
      <el-input v-model="searchForm.model.customerChargeNo" placeholder="缴费编号" />
      <!-- 客户姓名 -->
      <el-input v-model="searchForm.model.customerName" placeholder="客户姓名" />
      <!-- 抄表员 -->
      <el-input v-model="searchForm.model.readMeterUserName" placeholder="抄表员" />
      <!-- 用气类型 -->
      <el-select v-model="searchForm.model.useGasTypeId" clearable filterable placeholder="用气类型">
        <el-option
          v-for="(item,index) in useGasTypeList"
          :key="index"
          :label="item.useGasTypeName"
          :value="item.id"
        >
        </el-option>
      </el-select>
      <!-- 地址 -->
      <el-input v-model="searchForm.model.address" style="width: auto" placeholder="安装地址" />

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
                <span class="card-title">抄表数据列表</span>
              </div>
              <div slot="right">
                <!-- <el-button v-if="curBtn === '-1'" type="primary">导出</el-button> -->
                <!--<el-button type="primary">开票</el-button>-->
                <!-- <el-button v-if="curBtn == -1" type="primary">补抄</el-button> -->

                <!-- 撤回 移除待提审数据 -->
                <el-button
                  v-if="IS_REMOVE_DATA"
                  v-has-permission="['readMeterGeneral:dtssjsc']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="removeReaderMeterData"
                >移除数据
                </el-button>

                <!-- 提审 -->
                <el-button
                  v-if="IS_SUBMIT_FOR_REVIEW"
                  v-has-permission="['readMeterGeneral:ts']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="handleSubmitForReview"
                >
                  提审
                </el-button>
                <!-- 撤回 -->
                <el-button
                  v-if="IS_WITHDRAW"
                  v-has-permission="['readMeterGeneral:ch']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="handleWithdraw"
                >撤回
                </el-button>
                <!-- 驳回 -->
                <el-button
                  v-if="IS_REVIEW_REJECTED"
                  v-has-permission="['readMeterGeneral:bh']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="rejectedHandle"
                >
                  驳回
                </el-button>
                <!-- 审核 -->
                <el-button
                  v-if="IS_APPROVED"
                  v-has-permission="['readMeterGeneral:sh']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="handleApproved"
                >
                  审核
                </el-button>
                <!-- 结算 -->
                <el-button
                  v-if="IS_SETTLEMENT"
                  v-has-permission="['readMeterGeneral:js']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                  @click="handleSettlement()"
                >结算
                </el-button>
                <!-- <el-button v-if="IS_NO_CHARGE" type="primary">收费</el-button> -->
                <!-- 打印缴费通知 -->
                <el-button
                  v-if="IS_PRINT_PAY"
                  v-has-permission="['readMeterGeneral:print']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                >打印缴费通知
                </el-button>
                <!-- 打印催款通知 -->
                <el-button
                  v-if="IS_PRINT_DUNNING"
                  v-has-permission="['readMeterGeneral:print']"
                  type="primary"
                  :disabled="btnDisable || multipleSelection.length === 0"
                >打印催款通知
                </el-button>
              </div>
            </search-box>
          </div>

          <!-- list -->
          <div class="butGroup" style="margin: -10px 0 10px 0">
            <!-- 数据筛选 -->
            <!-- 进度显示切换按钮 -->
            <template v-for="(item, key) in filterProcessStatusBtns">
              <el-button :key="key" type="primary" :plain="curBtn !== key" @click="changeProcessStatus(key)">{{ item.text }}
              </el-button>
            </template>
            <!-- 收费状态显示切换按钮 -->
            <template v-for="(item, key) in filterChangeStatusBtns">
              <el-button :key="key" type="primary" :plain="curBtn !== key" @click="changeChargeStatus(key)">{{ item.text }}
              </el-button>
            </template>
            <el-button type="primary" :plain="curBtn !== 'all'" @click="queryAll">全部</el-button>
          </div>
          <el-table
            ref="multipleTable"
            v-loading="listLoading"
            :data="tableData"
            tooltip-effect="dark"
            border
            height="calc(100vh - 320px)"
            style="width: 100%"
            :highlight-current-row="true"
            @row-click="rowClick"
            @selection-change="tableSelect"
          >
            <el-table-column type="selection" width="45" :selectable="setSelectable" />
            <el-table-column type="index" label="#" width="45" />
            <el-table-column prop="gasMeterNumber" label="表身号" width="120" />
            <el-table-column prop="customerChargeNo" label="缴费编号" width="120" />
            <el-table-column prop="customerName" label="客户姓名" width="80" />
            <el-table-column prop="useGasTypeName" show-overflow-tooltip label="用气类型名称	" width="100" />
            <el-table-column prop="moreGasMeterAddress" show-overflow-tooltip label="安装地址" />
            <el-table-column prop="lastReadTime" label="上期抄表时间" width="100" />
            <el-table-column prop="lastTotalGas" label="上期止数" width="80" />
            <el-table-column prop="currentTotalGas" label="本期止数" width="80" />
            <el-table-column prop="monthUseGas" label="本期用量" width="80" />
            <el-table-column prop="readMeterUserName" label="抄表员名称" width="100" />
            <el-table-column prop="readMeterYear" label="抄表年份" width="80" />
            <el-table-column prop="readMeterMonth" label="抄表月份" width="80" />
            <el-table-column prop="recordTime" label="抄表日期" width="100">
              <template slot-scope="{row}">
                {{ row.recordTime | parsedTime }}
              </template>
            </el-table-column>
            <el-table-column v-if="showSettlementTime" key="settlementTime" prop="settlementTime" label="结算日期" width="100">
              <template slot-scope="{row}">
                {{ row.settlementTime | parsedTime }}
              </template>
            </el-table-column>
            <el-table-column key="processStatus" prop="processStatus" label="审核状态" width="80">
              <template slot-scope="{ row }">
                {{ row.processStatus ? (row.processStatus.desc || '---') : '---' }}
              </template>
            </el-table-column>
            <el-table-column prop="reviewObjection" label="驳回原因" width="80" />
            <el-table-column prop="chargeStatus" label="抄表收费状态" width="120">
              <template slot-scope="{ row }">
                {{ row.chargeStatus ? (row.chargeStatus.desc || '---') : '---' }}
              </template>
            </el-table-column>
            <!-- 操作 -->
            <el-table-column
              v-if="IS_UPDATE"
              fixed="right"
              label="操作"
              width="60"
            >
              <template slot-scope="{ row }">
                <el-button v-has-permission="['readMeterGeneral:update']" icon="el-icon-edit" circle type="primary" title="纠正数据" @click="edit(row)"></el-button>
              </template>
            </el-table-column>
          </el-table>
          <!--分页-->
          <pagination
            :page-sizes="[10, 15, 20, 30]"
            :page.sync="searchForm.current"
            :limit.sync="searchForm.size"
            :total="+total"
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
              :customer-code="currentItem.customerCode || null"
            />
          </el-tab-pane>

          <el-tab-pane label="表具信息" name="表具信息">
            <meter-details v-if="curTabsLabel === '表具信息'" :gas-meter-code="currentItem.gasMeterCode || null" />
          </el-tab-pane>

          <!-- 抄表记录 -->
          <el-tab-pane v-if="isTest" label="抄表记录" name="抄表记录">
            <read-meter-records v-if="curTabsLabel === '抄表记录'" />
          </el-tab-pane>

          <el-tab-pane label="欠费明细" name="欠费明细">
            <arrearage-info v-if="curTabsLabel === '欠费明细'" :gas-meter-code="currentItem.gasMeterCode || null" />
          </el-tab-pane>

          <!-- 缴费信息 -->
          <el-tab-pane label="缴费信息" name="缴费信息">
            <payment-records
              v-if="curTabsLabel === '缴费信息'"
              :gas-meter-code="currentItem.gasMeterCode || null"
              :customer-code="currentItem.customerCode || null"
            />
          </el-tab-pane>

          <el-tab-pane label="气价方案" name="气价方案">
            <price-plan
              v-if="curTabsLabel === '气价方案'"
              :gas-meter-code="currentItem.gasMeterCode || null"
            />
          </el-tab-pane>

          <!-- 气表状态 -->
          <el-tab-pane label="气表状态" name="气表状态">
            <meter-status-details
              v-if="curTabsLabel === '气表状态'"
              :gas-meter-code="currentItem.gasMeterCode || null"
              :customer-code="currentItem.customerCode || null"
            />
          </el-tab-pane>

          <!-- 抄表统计 -->
          <el-tab-pane label="抄表统计" name="抄表统计">
            <read-meter-statistics v-if="curTabsLabel === '抄表统计'" />
          </el-tab-pane>

        </el-tabs>
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div v-has-any-permission="['readMeterGeneral:meterBook', 'readMeterGeneral:readMeterBookView']" class="footNav-item" @click="dialogOpen('showReadMeterBook')">
        <div class="icon">
          <svg-icon icon-class="manual" />
        </div>
        <p>抄表册</p>
      </div>

      <!-- 2020/12/1版本暂时隐藏 -->
      <!-- <div class="footNav-item" @click="dialogOpen('showReadMeterPlan')">
        <div class="icon">
          <svg-icon icon-class="plan"/>
        </div>
        <p>抄表计划</p>
      </div> -->

      <div v-has-permission="['readMeterGeneral:plan']" class="footNav-item" @click="dialogOpen('showAdd')">
        <div class="icon">
          <svg-icon icon-class="add" />
        </div>
        <p>抄表数据录入</p>
      </div>

      <div v-has-permission="['readMeterGeneral:import']" class="footNav-item" @click="dialogOpen('showReadMeterImport')">
        <div class="icon">
          <svg-icon icon-class="readMeterImport" />
        </div>
        <p>抄表导入</p>
      </div>
      <div v-if="isTest" v-has-permission="['readMeterGeneral:dkdr']" class="footNav-item" @click="dialogOpen('showWithholdImport')">
        <div class="icon">
          <svg-icon icon-class="import" />
        </div>
        <p>代扣导入</p>
      </div>
      <div v-if="isTest" v-has-permission="['readMeterGeneral:dkdc']" class="footNav-item" @click="exportMsg('已导出')">
        <div class="icon">
          <svg-icon icon-class="export" />
        </div>
        <p>代扣导出</p>
      </div>
    </qc-foot-menu>

    <!-- region  弹窗 start-->
    <!-- 驳回 -->
    <el-dialog width="400px" title="驳回" :visible.sync="showRejectReason" @close="btnDisable = false">
      <reject-reason
        v-if="showRejectReason"
        v-model="rejectedMsg"
        @submit="handleReviewRejected"
      />
    </el-dialog>

    <!--抄表册-->
    <el-dialog width="1100px" title="抄表册" :visible.sync="showReadMeterBook">
      <read-meter-book v-if="showReadMeterBook" />
    </el-dialog>

    <!-- 添加 -->
    <el-dialog width="75%" title="抄表数据录入" :visible.sync="showAdd">
      <add v-if="showAdd" @success="handleAddSuccess" />
    </el-dialog>

    <!-- 纠正数据 -->
    <el-dialog width="500px" title="纠正数据" :visible.sync="showEdit">
      <edit v-if="showEdit" :cur-plan="curPlan" @close="handleEditSuccess" />
    </el-dialog>

    <!-- 抄表计划-->
    <el-dialog width="1100px" title="抄表计划" :visible.sync="showReadMeterPlan">
      <read-meter-plan v-if="showReadMeterPlan" />
    </el-dialog>

    <!--抄表导入-->
    <el-dialog width="1000px" title="抄表导入" :visible.sync="showReadMeterImport">
      <read-meter-import v-if="showReadMeterImport" />
    </el-dialog>

    <!--代扣导入-->
    <el-dialog width="1000px" title="代扣导入" :visible.sync="showWithholdImport">
      <withhold-import v-if="showWithholdImport" />
    </el-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>
<script src="./general.js">

</script>
<style lang="scss" scoped>
</style>
