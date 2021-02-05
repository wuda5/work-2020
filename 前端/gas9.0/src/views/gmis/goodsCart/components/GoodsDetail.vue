<!--
 * @Description: 商品详情
 * @Author: lingw
 * @Date: 2020-10-22 13:53:56
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 14:28:06
-->

<template>
  <!-- card -->
  <el-card shadow="never" class="no-border">
    <div slot="header">
      <span class="card-title">商品详情</span>
    </div>
    <div v-for="({ id, type, status, brand, model, counts, total }) in goods" :key="id" class="product-container product-layout">
      <div class="product-item">
        <span class=" product-title">类型：{{ type | emptyStr }}</span>
        <span class=" product-title">{{ status | emptyStr }}</span>
      </div>
      <p class="product-item">品牌： {{ brand }}</p>
      <p class="product-item">
        型号：{{ model | emptyStr }}
      </p>
      <div class="product-item">
        <span>数量：{{ counts | emptyStr }}</span>
        <span class="product-price">{{ total | emptyStr }}</span>
      </div>
    </div>
  </el-card>
</template>
<script>
export default {
  name: 'ProductDetail',
  props: {
    goods: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  methods: {
    viewMore() {
      // todo: 跳转地址
    }
  }

}
</script>

<style lang="scss" scoped>
  .product-container {
    padding: 12px;
    background: #F7F7F7;
    border-radius: 6px;
    .product-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 12px;
      color: #999999;
      .product-title {
        font-size: 14px;
        font-weight: bold;
        color: #2B2B2B;
      }
      .product-price {
        color: #ED57B1;
        font-size: 14px;
      }
    }
  }
    .product-layout:not(:last-child) {
      margin-bottom: 12px;
    }
</style>

