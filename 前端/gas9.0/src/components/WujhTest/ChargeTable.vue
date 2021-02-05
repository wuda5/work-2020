<!-- 收费列表 -->
<template>
  <div class="chargeTable" :style="border">
    <table cellspacing="0" cellpadding="0" border="0">
      <tr>
        <th>名称</th>
        <th>数量</th>
        <th>单价</th>
        <th>金额</th>
        <th>操作</th>
      </tr>
      <tr>
        <td>
          <el-select v-model="emptyCategory.category">
            <el-option v-for="category in categories" :key="category.value" :value="category.label" :label="category.label" />
          </el-select>
        </td>
        <td>
          <el-input v-model.number="emptyCategory.value" type="number" placeholder="数量" />
        </td>
        <td>
          <el-input v-model.number="emptyCategory.price" type="number" placeholder="单价" />
        </td>
        <td>
          <!--{{ emptyCategory.value * emptyCategory.price || '-&#45;&#45;' }}-->
          {{ emptyCategory.sum || '---' }}
          <!--<el-input v-model="emptyCategory.sum" type="number"  placeholder="金额"/>-->
        </td>
        <td>
          <el-button type="primary" plain :disabled="canAddNew" @click="addCategory">新增</el-button>
        </td>
      </tr>
    </table>
    <div :style="heightStyle">
      <table cellspacing="0" cellpadding="0" border="0">
        <tr v-for="(item,index) in categoryList" :key="index">
          <td>
            {{ item.category }}
          </td>
          <td>
            {{ item.value }}
          </td>
          <td>
            {{ item.price | moneyFormat }}
          </td>
          <td>
            <!--{{ item.value * item.price }}-->
            {{ item.sum | moneyFormat }}
          </td>
          <td>
            <el-button type="danger" plain @click="removeCategory(index)">删除</el-button>
          </td>
        </tr>
      </table>
    </div>
    <!--<span>total:{{ totalMoney }}</span>-->
  </div>
</template>

<script>
export default {
  name: 'ChargeTable',
  props: {
    height: {
      type: Number,
      default: 300
    },
    isBorder: {
      type: Boolean,
      default: false
    }

  },
  data() {
    return {
      // 收费类目
      categories: [
        {
          value: '选项1',
          label: '黄金糕'
        }, {
          value: '选项2',
          label: '双皮奶'
        }, {
          value: '选项3',
          label: '蚵仔煎'
        }, {
          value: '选项4',
          label: '龙须面'
        }, {
          value: '选项5',
          label: '北京烤鸭'
        }
      ],
      emptyCategory: {
        category: '', // 名称
        value: NaN, // 气量
        price: NaN, // 价格
        sum: this.curTotal // 金额
      },
      categoryList: [
        {
          category: '充气',
          value: 100,
          price: 3.5,
          sum: 350
        },
        {
          category: '充气',
          value: 100,
          price: 3.5,
          sum: 350
        }

      ]
    }
  },
  computed: {
    canAddNew: function () {
      return !(this.emptyCategory.price && this.emptyCategory.value && this.emptyCategory.category)
    },
    totalMoney: function () {
      let total = 0
      this.categoryList.forEach(function (item, index, array) {
        total += item.value * item.price
      })
      return total
    },
    heightStyle: function () {
      return {
        height: this.height ? `${this.height - 74}px` : 'auto',
        overflow: 'auto'
      }
    },

    border: function () {
      let tempVar = {}
      if (this.isBorder) {
        tempVar = {
          border: '1px solid #eee'
        }
      }
      return tempVar
    }

  },
  watch: {
    // 监听新增 ，计算当前新增总价格
    emptyCategory: {
      handler: function (val, oldval) {
        this.emptyCategory.sum = val.value * val.price
        // console.log(val)
      },
      deep: true// 对象内部的属性监听，也叫深度监听
    },
    // 监听total的变化
    totalMoney(totalMoney) {
      const d = {
        totalMoney,
        categoryList: this.categoryList
      }
      console.log(d)
    }

  },
  methods: {
    // 还原默认值
    initDefaultCategory() {
      this.emptyCategory = {
        category: '', // 名称
        value: NaN, // 气量
        price: NaN, // 价格
        sum: NaN // 金额
      }
    },
    addCategory() {
      this.categoryList.unshift(this.emptyCategory)
      this.initDefaultCategory()
    },
    removeCategory(index) {
      this.categoryList.splice(index, 1)
    }
  }
}
</script>

<style lang="scss" scoped>
  .chargeTable {
    border-bottom: 1px solid #eee;
  }

  table {
    /*border: 1px solid #eee;*/
    text-align: center;
    width: 100%;

    tr {
      height: 26px;
      line-height: 26px;
    }

    tr:nth-child(odd) {
      background: #f5f7fa;
    }

    td, th {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      font-size: 12px;
      width: 25%;
      padding: 5px;
    }
  }

  .tableBody {
    height: 100px;
    overflow: auto;
  }
</style>
