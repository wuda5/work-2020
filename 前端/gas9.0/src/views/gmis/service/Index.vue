<!--客户服务-->
<template>
  <div class="qc-main">
    <!--search-->
    <qc-top-search
      @search="search($event)"
    />

    <!-- 档案列表 -->
    <el-row :gutter="10">

      <!--center-->
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 10px">
        <div style="height: 690px;">
          <!-- 档案列表 -->
          <el-card shadow="never" style="height: 340px">
            <div slot="header">
              <span class="card-title">档案列表</span>
              <!-- 操作按钮 -->
              <el-button type="primary" class="fr" @click="dialogOpen('showWorkOrder')">创建工单</el-button>
            </div>
            <!-- 工单信息 -->
            <el-table
              ref="multipleTable"
              :data="tableData"
              tooltip-effect="dark"
              style="width: 100%; border: 1px solid #eee"
              :border="false"
              :highlight-current-row="true"
              :height="230"
              @row-click="rowClick"
              @select-all="tableSelect"
              @selection-change="tableSelect"
            >
              @select="tableSelect"
              <!--@select-all="tableSelect"-->
              <!-- @selection-change="tableSelect"-->
              <el-table-column
                type="selection"
                width="45"
              />
              <el-table-column
                prop="userID"
                label="客户编号"
                width="80"
              />
              <el-table-column
                prop="name"
                label="客户姓名"
                width="80"
              />
              <el-table-column
                prop="tel"
                label="联系电话"
                width="100"
              />
              <el-table-column
                prop="userType"
                label="客户类型"
                width="80"
              />
              <el-table-column
                prop="gasType"
                label="用气类型"
                width="80"
              />
              <el-table-column
                prop="meterNo"
                label="气表编号"
                width="140"
              />
              <el-table-column
                prop="pressBoxNo"
                label="调压箱号"
              />

              <el-table-column
                prop="company"
                label="气表厂家"
              />
              <el-table-column
                prop="meterVer"
                label="气表版号"
              />
            </el-table>
            <Pagination
              layout="prev, pager, next"
              :page="2"
              :limit="2"
              :total="4"
            />
          </el-card>

          <!-- 工单信息 -->
          <el-card shadow="never" style="height: 338px; margin-top: 10px">
            <div slot="header">
              <span class="card-title">工单信息</span>
              <!-- 操作按钮 -->
              <el-button type="primary" class="fr" @click="dialogOpen('showReturnVisit')">登记回访</el-button>
            </div>
            <!-- 工单信息 -->
            <div class="butGroup" style="margin: -10px 0 10px 0 ">
              <el-button type="primary" plain>待回访</el-button>
              <el-button type="primary" plain>已回访</el-button>
              <el-button type="primary" plain>全部</el-button>
            </div>
            <div class="clearfix"></div>
            <el-table
              ref="multipleTable"
              :data="tableData"
              tooltip-effect="dark"
              style="width: 100%; border: 1px solid #eee"
              :border="false"
              :highlight-current-row="true"
              :height="200"
              @row-click="rowClick"
              @select-all="tableSelect"
              @selection-change="tableSelect"
            >
              @select="tableSelect"
              <!--@select-all="tableSelect"-->
              <!-- @selection-change="tableSelect"-->
              <el-table-column
                type="selection"
                width="45"
              />
              <el-table-column
                prop="userID"
                label="客户编号"
                width="80"
              />
              <el-table-column
                prop="name"
                label="客户姓名"
                width="80"
              />
              <el-table-column
                prop="tel"
                label="联系电话"
                width="100"
              />
              <el-table-column
                prop="userType"
                label="客户类型"
                width="80"
              />
              <el-table-column
                prop="gasType"
                label="用气类型"
                width="80"
              />
              <el-table-column
                prop="meterNo"
                label="气表编号"
                width="140"
              />
              <el-table-column
                prop="pressBoxNo"
                label="调压箱号"
              />

              <el-table-column
                prop="company"
                label="气表厂家"
              />
              <el-table-column
                prop="meterVer"
                label="气表版号"
              />
            </el-table>
            <Pagination
              layout="prev, pager, next"
              :page="2"
              :limit="2"
              :total="4"
            />
          </el-card>
        </div>
      </el-col>

      <!--left-->
      <el-col :lg="{span:5, pull:12}" :xs="24" :sm="12" style="margin-top: 10px">
        <div>
          <!-- 客户信息 -->
          <qc-user-info :my-data="userInfoData" />
          <!-- 表具信息 -->
          <qc-meter-info :my-data="meterInfoData" />
        </div>
      </el-col>

      <!--right-->
      <el-col :lg="7" :xs="24" :sm="12" style="margin-top: 10px">
        <!-- 更多信息 -->
        <div style="height: 690px">
          <el-tabs class="moreInfo" tab-position="left" style="height: 690px;" @tab-click="tabsChange">
            <!-- 缴费信息 -->
            <el-tab-pane label="缴费信息">
              <payment-records />
            </el-tab-pane>
            <el-tab-pane label="IC卡信息">
              <card-info />
            </el-tab-pane>
            <el-tab-pane :closable="true" label="安检信息">
              <security-info />
            </el-tab-pane>
            <el-tab-pane label="账户信息">
              <account-info />
            </el-tab-pane>
            <el-tab-pane :closable="true" label="欠费明细">
              <arrearage-info />
            </el-tab-pane>
            <el-tab-pane label="变更记录">
              <change-records />
            </el-tab-pane>
            <el-tab-pane label="气表状态">
              <meter-state />
            </el-tab-pane>
            <el-tab-pane label="气价方案">
              <price-plan />
            </el-tab-pane>
            <el-tab-pane :closable="true" label="工单信息">
              <work-order />
            </el-tab-pane>
            <el-tab-pane label="限购信息">
              <buy-limit />
            </el-tab-pane>
          </el-tabs>
        </div>
      </el-col>
    </el-row>

    <!-- 底部 -->
    <el-row :gutter="10">
      <!--客户服务统计-->
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 10px">
        <!-- 客户服务统计 -->
        <el-card shadow="never" class="counter">
          <div slot="header">
            <span class="card-title">客户服务统计</span>
          </div>
          <service-statistics height="200px" />
        </el-card>
      </el-col>
      <!--位置信息-->
      <el-col :lg="{span:5, pull:12}" :xs="24" :sm="12" style="margin-top: 10px">
        <qc-meter-location />
      </el-col>
    </el-row>

    <!-- region  弹窗 start-->
    <!-- 创建工单 -->
    <qc-dialog
      v-if="showWorkOrder"
      :width="400"
      title="创建工单"
      :visible="showWorkOrder"
      data-key="showWorkOrder"
      @close="dialogClose"
    >
      <qc-work-order />
    </qc-dialog>

    <!-- 登记回访 -->
    <qc-dialog
      v-if="showReturnVisit"
      :width="400"
      title="登记回访"
      :visible="showReturnVisit"
      data-key="showReturnVisit"
      @close="dialogClose"
    >
      <return-visit />
    </qc-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./data.js"></script>
<style lang="scss" scoped>

</style>
