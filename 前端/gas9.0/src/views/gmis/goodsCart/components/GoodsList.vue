<!--
 * @Description: 商品列表
 * @Author: lingw
 * @Date: 2020-10-22 11:49:37
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-23 13:41:14
-->
<template>
  <el-card shadow="never" class="goods-list-container">
    <div slot="header">
      <span class="card-title">商品列表</span>
    </div>
    <el-input v-model="queryString" style="width: 200px;" placeholder="请输入内容" class="input-with-select">
      <el-button slot="append" icon="el-icon-search" @click="handleSearch"></el-button>
    </el-input>
    <el-table :data="list" :border="false" style="width: 100%; margin: 20px 0" row-key="id">
      <el-table-column label="品牌">
        <span slot-scope="{row}">
          {{ row.brand }}
        </span>
      </el-table-column>
      <el-table-column label="类型">
        <span slot-scope="{row}">
          {{ row.type }}
        </span>
      </el-table-column>
      <el-table-column label="型号">
        <span slot-scope="{row}">
          {{ row.model }}
        </span>
      </el-table-column>
    </el-table>
    <el-dialog :title="title" :visible.sync="visible" width="480px">
      <el-form :label-width="formLabelWidth" :model="goods" class="jh-text">
        <el-form-item label="品牌">
          <el-input v-model="goods.name" size="mini" class="goods-form-item" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商品类型">
          <el-input v-model="goods.name" size="mini" class="goods-form-item" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="商品型号">
          <el-input v-model="goods.name" size="mini" class="goods-form-item" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="最高单价">
          <el-input v-model="goods.name" size="mini" class="goods-form-item" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="最低单价">
          <el-input v-model="goods.name" size="mini" class="goods-form-item" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" class="goods-form-item" @click="dialogFormVisible = false">{{ title }}</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <div class="goods-btns">
      <el-button type="primary" @click="handleUp">
        上架
      </el-button>
      <el-button type="danger" @click="handleDown">
        下架
      </el-button>
      <el-button type="primary" plain @click="handleEdit">
        编辑
      </el-button>
    </div>
  </el-card>
</template>

<script>
export default {
  name: '',
  components: {

  },
  props: {
    list: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data () {
    return {
      queryString: '',
      visible: false,
      title: '',
      formLabelWidth: '60px',
      goods: {}
    }
  },
  mounted () {

  },
  methods: {
    handleSearch() {},
    // 上架
    handleUp() {
      this.dialogShow('上架')
    },
    // 下架
    handleDown() {
      this.dialogShow('下架')
    },
    // 编辑
    handleEdit() {
      this.dialogShow('编辑')
    },
    dialogShow(val) {
      this.title = val
      this.visible = true
    },
    dialogFormVisible() {}
  }
}
</script>

<style lang='scss' scoped>
  .goods-list-container {
    height: 810px;
    background: #fff;
    position: relative;
    .goods-form-item {
      width: 120px;
      margin-top: 8px;
    }
    .goods-btns {
      position: absolute;
      display: flex;
      justify-content: space-between;
      bottom: 12px;
      left: 50%;
      transform: translateX(-50%);
    }
  }
</style>
