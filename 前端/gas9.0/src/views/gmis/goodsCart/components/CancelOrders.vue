<!--
 * @Description: 退货内容
 * @Author: lingw
 * @Date: 2020-10-23 08:45:54
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 09:22:43
-->
<template>
  <div>
    <!-- 购买信息 -->
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">购买信息</span>
      </div>
      <el-table highlight-current-row :data="purchaseList" :border="false" row-key="id" style="width: 100%;">
        <el-table-column
          type="selection"
          width="50"
        />
        <el-table-column type="index" width="50" label="序号" />
        <el-table-column label="类型">
          <template slot-scope="{row}">
            {{ row.type }}
          </template>
        </el-table-column>
        <el-table-column label="数量">
          <template slot-scope="{row}">
            {{ row.total }}
          </template>
        </el-table-column>
        <el-table-column label="已退数量">
          <template slot-scope="{row}">
            {{ row.cancelTotal }}
          </template>
        </el-table-column>
        <el-table-column label="单价">
          <template slot-scope="{row}">
            {{ row.price }}
          </template>
        </el-table-column>
        <el-table-column label="金额">
          <template slot-scope="{row}">
            {{ row.mount }}
          </template>
        </el-table-column>
        <el-table-column label="型号">
          <template slot-scope="{row}">
            {{ row.model }}
          </template>
        </el-table-column>
        <el-table-column label="品牌">
          <template slot-scope="{row}">
            {{ row.brand }}
          </template>
        </el-table-column>
        <el-table-column label="状态">
          <template slot-scope="{row}">
            {{ row.status }}
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)"
            >退货</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 退货信息 -->
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">退货信息</span>
      </div>
      <el-table highlight-current-row :data="cancelList" :border="false">
        <el-table-column
          type="selection"
          width="50"
        />
        <el-table-column type="index" width="50" label="序号" />
        <el-table-column label="类型">
          <template slot-scope="{row}">
            {{ row.type }}
          </template>
        </el-table-column>
        <el-table-column label="数量">
          <template slot-scope="{row}">
            {{ row.total }}
          </template>
        </el-table-column>
        <el-table-column label="单价">
          <template slot-scope="{row}">
            {{ row.price }}
          </template>
        </el-table-column>
        <el-table-column label="金额">
          <template slot-scope="{row}">
            {{ row.mount }}
          </template>
        </el-table-column>
        <el-table-column label="型号">
          <template slot-scope="{row}">
            {{ row.model }}
          </template>
        </el-table-column>
        <el-table-column label="品牌">
          <template slot-scope="{row}">
            {{ row.brand }}
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="danger"
              @click="handleReset(scope.$index, scope.row)"
            >移除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 结算信息 -->
    <el-card shadow="never">
      <div slot="header">
        <span class="card-title">结算信息</span>
      </div>
      <div class="cancel-footer">
        <div class="cancel-cash">
          <span class="cancel-title">退款金额</span>
          <span class="cancel-mount">{{ cancelMount }}</span>
        </div>
        <el-button type="primary" @click="handleCancelOrders">
          退货
        </el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'CancelOrders',
  props: {
    purchaseList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      // 订单列表
      cancelMount: 0,
      // 退货列表
      cancelList: []
    }
  },
  mounted () {

  },
  methods: {
    // 从退货列表中移除选中的商品
    handleReset() {

    },
    // 添加商品到退货列表中
    handleDelete() {},
    // 退货
    handleCancelOrders() {

    }
  }
}
</script>

<style lang='scss' scoped>
  .cancel-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .cancel-cash {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      .cancel-title {
        color: #999999;
        font-size: 12px;
        margin-bottom: 6px;
      }
      .cancel-mount {
        color: #2B2B2B;
        font-size: 12px;
      }
    }
  }
</style>
