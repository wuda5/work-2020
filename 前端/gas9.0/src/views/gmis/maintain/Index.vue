<!-- 运行维护 -->
<template>
  <div class="qc-main">
    <!--search-->
    <top-search
      @search="search($event)"
    />

    <!-- 安检列表 -->
    <el-row :gutter="10">

      <!--center-->
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 10px">
        <div style="height: 690px;">
          <!-- 安检列表 -->
          <el-card v-if="curMenu===1" shadow="never" style="height: 340px">
            <div slot="header">
              <span class="card-title">节点列表</span>

              <!-- 操作按钮 -->
              <div class="fr butGroup">
                <el-button type="primary" plain @click="dialogOpen('showWorkOrder')">创建工单</el-button>
                <el-button type="primary" plain @click="dialogOpen('showNodeSwitch')">更换</el-button>
                <el-button type="primary" plain @click="dialogOpen('showNodeRemove')">拆除</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showRemoteControl')">远程控制</el-button>
              </div>
            </div>
            <div class="clearfix"></div>
            <el-table
              ref="multipleTable"
              :data="tableData"
              tooltip-effect="dark"
              style="width: 100%; border: 1px solid #eee"
              :border="false"
              :highlight-current-row="true"
              :height="220"
              @row-click="rowClick"
            >
              <el-table-column
                type="selection"
                width="50"
                label="序号"
              />
              <el-table-column
                prop="1"
                label="节点编号"
                width="80"
              />
              <el-table-column
                prop="2"
                label="节点姓名"
                width="150"
              />
              <el-table-column
                prop="3"
                label="安装地址"
                width="200"
              />
              <el-table-column
                prop="4"
                label="设备厂家"
                width="120"
              />
              <el-table-column
                prop="5"
                label="设备型号"
                width="100"
              />
              <el-table-column
                prop="6"
                label="管口路径"
                width=""
              />
            </el-table>
            <Pagination
              layout="prev, pager, next"
              :page="2"
              :limit="2"
              :total="4"
            />
          </el-card>

          <!-- 客户列表 -->
          <el-card v-if="curMenu===2" shadow="never" style="height: 340px">
            <div slot="header">
              <span class="card-title">客户列表</span>

              <!-- 操作按钮 -->
              <div class="fr butGroup">
                <el-button type="primary" plain @click="dialogOpen('showWorkOrder')">创建工单</el-button>
                <el-button type="primary" plain @click="dialogOpen('showOpenGas')">通气</el-button>
                <el-button type="primary" plain @click="dialogOpen('showGas')">补气</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showRemoteControl')">远程控制</el-button>
                <el-button type="primary" plain @click.native="barPrint('showRemoteControl')">条码打印</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showSwitchMeter')">换表</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showDismantleMeter')">拆表</el-button>
              </div>
            </div>
            <div class="clearfix"></div>
            <el-table
              ref="multipleTable"
              :data="userTableData"
              tooltip-effect="dark"
              style="width: 100%; border: 1px solid #eee"
              :border="false"
              :highlight-current-row="true"
              :height="220"
              @row-click="rowClick"
            >
              <el-table-column
                type="selection"
                width="50"
                label="序号"
              />
              <el-table-column
                prop="1"
                label="客户编号"
                width="80"
              />
              <el-table-column
                prop="2"
                label="客户姓名"
                width="80"
              />
              <el-table-column
                prop="3"
                label="证件类型"
                width="80"
              />
              <el-table-column
                prop="4"
                label="证件号码"
                width="150"
              />
              <el-table-column
                prop="5"
                label="联系电话"
                width="100"
              />
              <el-table-column
                prop="6"
                label="客户分类"
                width="80"
              />
              <el-table-column
                prop="7"
                label="客户类型"
                width="80"
              />
              <el-table-column
                prop="8"
                label="黑名单"
                width=""
              />
            </el-table>
            <Pagination
              layout="prev, pager, next"
              :page="2"
              :limit="2"
              :total="4"
            />
          </el-card>

          <!-- 工单列表 -->
          <el-card shadow="never" style="height: 340px; margin-top: 10px">
            <div slot="header">
              <span class="card-title">工单列表</span>

              <!-- 操作按钮 -->
              <div class="fr butGroup">
                <el-button type="primary" plain @click.native="check">审核</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showRejectReason')">驳回</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showSendOrder')">派单</el-button>
                <el-button type="primary" plain>打印</el-button>
                <el-button type="primary" plain @click.native="dialogOpen('showNodeWorkOrderEnd')">结单</el-button>
              </div>
            </div>
            <div class="clearfix"></div>
            <!-- 工单信息 -->
            <div class="butGroup" style="margin: -10px 0 10px 0 ">
              <el-button type="primary" plain>待审</el-button>
              <el-button type="primary" plain>待派</el-button>
              <el-button type="primary" plain>待结单</el-button>
              <el-button type="primary" plain>全部</el-button>
            </div>
            <div class="clearfix"></div>
            <el-table
              ref="multipleTable"
              :data="workOrderList"
              tooltip-effect="dark"
              style="width: 100%; border: 1px solid #eee"
              :border="false"
              :highlight-current-row="true"
              :height="200"
              @row-click="rowClick"
            >
              <el-table-column
                type="selection"
              />
              <el-table-column
                type="index"
                width="50"
                label="序号"
              />
              <el-table-column
                prop="1"
                label="工单类型"
                width="80"
              />
              <el-table-column
                prop="2"
                label="紧急程度"
                width="80"
              />
              <el-table-column
                prop="3"
                label="更新时间"
                width="120"
              />
              <el-table-column
                prop="4"
                label="联系电话"
                width="180"
              />
              <el-table-column
                prop="5"
                label="工单内容"
                width="150"
              />
              <el-table-column
                prop="6"
                label="接单人"
                width="80"
              />
              <el-table-column
                prop="7"
                label="处理结果"
                width=""
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
          <!-- 节点信息 -->
          <node-info :my-data="nodeInfoData" />
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
              <change-record />
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
      <el-col :lg="{span:12,push:5}" :xs="24" :sm="24" style="margin-top: 10px">
        <!-- 运行维护统计 -->
        <el-card shadow="never" class="counter">
          <div slot="header">
            <span class="card-title">运行维护统计</span>
          </div>
          <maintain-statistics height="200px" />
        </el-card>
      </el-col>
      <!--位置信息-->
      <el-col :lg="{span:5, pull:12}" :xs="24" :sm="12" style="margin-top: 10px">
        <qc-meter-location />
      </el-col>
    </el-row>

    <!--dock菜单-->
    <qc-foot-menu>
      <div class="footNav-item" :class="curMenu === 1 ? 'NavActive' : ''" @click="curMenu=1">
        <div class="icon">
          <svg-icon icon-class="nodeMaintain" />
        </div>
        <p>节点运维</p>
      </div>
      <div class="footNav-item" :class="curMenu === 2 ? 'NavActive' : ''" @click="curMenu=2">
        <div class="icon">
          <svg-icon icon-class="gasMeter" />
        </div>
        <p>气表维护</p>
      </div>

      <div class="myDivider"></div>
      <!-- 节点维护 -->
      <template v-if="curMenu===1">
        <div class="footNav-item" @click="addNode('已导出')">
          <div class="icon">
            <svg-icon icon-class="add" />
          </div>
          <p>新增节点</p>
        </div>
        <div class="footNav-item" @click="exportMsg('已导出')">
          <div class="icon">
            <svg-icon icon-class="addMore" />
          </div>
          <p>批量新增调压箱</p>
        </div>
        <div class="footNav-item" @click="exportMsg('已导出')">
          <div class="icon">
            <svg-icon icon-class="money" />
          </div>
          <p>输差结算</p>
        </div>
      </template>
      <!-- 气表维护 -->
      <template v-if="curMenu===2">
        <div class="footNav-item" @click="cardRecycle">
          <div class="icon">
            <svg-icon icon-class="recycle" />
          </div>
          <p>卡回收</p>
        </div>
        <div class="footNav-item" @click="dialogOpen('showCardToZero')">
          <div class="icon">
            <svg-icon icon-class="cardZero" />
          </div>
          <p>卡清零</p>
        </div>
        <div class="footNav-item" @click="exportMsg('已导出')">
          <div class="icon">
            <svg-icon icon-class="toolCard" />
          </div>
          <p>工具卡制作</p>
        </div>
      </template>
    </qc-foot-menu>

    <!-- region  弹窗 start-->

    <!-- 更换节点 -->
    <qc-dialog
      v-if="showNodeSwitch"
      :width="550"
      title="更换节点"
      :visible="showNodeSwitch"
      data-key="showNodeSwitch"
      @close="dialogClose"
    >
      <node-switch />
    </qc-dialog>

    <!-- 拆除节点 -->
    <qc-dialog
      v-if="showNodeRemove"
      :width="400"
      title="拆除节点"
      :visible="showNodeRemove"
      data-key="showNodeRemove"
      @close="dialogClose"
    >
      <node-remove />
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

    <!--远程控制-->
    <qc-dialog
      v-if="showRemoteControl"
      :width="800"
      title="远程控制"
      :visible="showRemoteControl"
      data-key="showRemoteControl"
      @close="dialogClose"
    >
      <remote-control />
    </qc-dialog>

    <!-- 驳回 -->
    <qc-dialog
      v-if="showRejectReason"
      :width="400"
      title="驳回"
      :visible="showRejectReason"
      data-key="showRejectReason"
      @close="dialogClose"
    >
      <reject-reason />
    </qc-dialog>

    <!-- 结单 -->
    <qc-dialog
      v-if="showNodeWorkOrderEnd"
      :width="400"
      title="结单"
      :visible="showNodeWorkOrderEnd"
      data-key="showNodeWorkOrderEnd"
      @close="dialogClose"
    >
      <node-work-order-end />
    </qc-dialog>

    <!-- 派单 -->
    <qc-dialog
      v-if="showSendOrder"
      :width="400"
      title="派单"
      :visible="showSendOrder"
      data-key="showSendOrder"
      @close="dialogClose"
    >
      <send-order />
    </qc-dialog>

    <!--卡清零-->
    <qc-dialog
      v-if="showCardToZero"
      :width="350"
      title="卡清零"
      :visible="showCardToZero"
      data-key="showCardToZero"
      @close="dialogClose"
    >
      <card-to-zero />
    </qc-dialog>

    <!--通气-->
    <qc-dialog
      v-if="showOpenGas"
      :width="400"
      title="通气登记"
      :visible="showOpenGas"
      data-key="showOpenGas"
      @close="dialogClose"
    >
      <open-gas />
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

    <!-- 换表 -->
    <qc-dialog
      v-if="showSwitchMeter"
      :width="1000"
      title="物联网换表"
      :visible="showSwitchMeter"
      data-key="showSwitchMeter"
      @close="dialogClose"
    >
      <switch-meter />
    </qc-dialog>

    <!-- 拆表 -->
    <qc-dialog
      v-if="showDismantleMeter"
      :width="800"
      title="拆表"
      :visible="showDismantleMeter"
      data-key="showDismantleMeter"
      @close="dialogClose"
    >
      <dismantle-meter />
    </qc-dialog>
    <!-- endregion  弹窗 end-->
  </div>
</template>

<script src="./maintain.js"></script>
<style lang="scss" scoped>
// 导航分割
.myDivider {
  display: inline-block;
  border-right: 1px solid #eee;
  height: 32px;
  width: 2px;
  position: relative;
  top: -10px;
  background: #666;
}

.NavActive {
  background: #0a76a4;

  p {
    color: #fff;
  }

}

</style>
