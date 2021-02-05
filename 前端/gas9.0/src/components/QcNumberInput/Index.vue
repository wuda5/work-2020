<!-- 数字精度控制输入框以el-input为基础修改版 -->
<template>
  <div class="qc-number-input el-input-number el-input-number--mini is-without-controls">
    <el-input v-model="currentValue" v-bind="$attrs" :min="min" :max="max" class="qc-number-input" v-on="inputListeners">
      <!-- 输入框头部内容 -->
      <template v-slot:prefix>
        <slot name="prefix"></slot>
      </template>
      <!-- 输入框尾部内容 -->
      <template v-slot:suffix>
        <slot name="suffix"></slot>
      </template>
      <!-- 输入框前置内容 -->
      <template v-slot:prepend>
        <slot name="prepend"></slot>
      </template>
      <!-- 输入框后置内容 -->
      <template v-slot:append>
        <slot name="append"></slot>
      </template>
    </el-input>
  </div>
</template>

<script>
import { maxMoney } from '@/settings'
import { numberReg, positiveIntegerReg } from '@/utils/reg'

export default {
  name: 'QcNumberInput',
  components: {

  },
  filters: {},
  mixins: [],
  model: {
    prop: 'value',
    event: 'change',
  },
  props: {
    // v-model绑定值
    value: [String, Number],
    // 最小值
    min: {
      type: Number,
      default: -maxMoney,
    },
    // 最大值
    max: {
      type: Number,
      default: maxMoney,
    },
    // 数值精度	
    precision: {
      type: Number,
      // validator: (value) => {
      //   return positiveIntegerReg.test(value) && value >= 0 && value <= 100
      // },
    },
  },
  data() {
    return {
      oldValue: '', // 上一次的有效值
      currentValue: '', // 当前值
    }
  },
  computed: {
    inputListeners() {
      const vm = this
      return Object.assign({}, this.$listeners, {
        // blur: function(e) {
        //   console.log('blue', e)
        // },
        change: function(currentValue) {
          vm.handleChange(currentValue)
        },
      })
    },
  },
  watch: {
    value: {
      handler(data, oldData) {
        // console.log(data, oldData)
        if (data !== oldData) {
          this.setCurrentValue(data)
        }
      },
      immediate: false,
    },
  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {
      this.handleChange(this.value)
    },
    setCurrentValue(currentValue) {
      let result = currentValue
      if (!numberReg.test(currentValue)) {
        if (currentValue !== null && currentValue !== '' ) {
          result = this.oldValue
        }
      } else {
        if (+currentValue < +this.min) {
          result = this.min
        } else if (+currentValue > +this.max) {
          result = this.max
        } else {
          result = currentValue
        }
        result = Number.parseFloat(result)
        const precision = this.precision
        if (positiveIntegerReg.test(precision) && precision >= 0 && precision <= 100) {
          result = result.toFixed(precision)
        }
      }
      // console.log('result', result)
      this.currentValue = result
      this.oldValue = result
      return result
    },
    handleChange(currentValue) {
      // console.log('handleChange', currentValue)
      const result = this.setCurrentValue(currentValue)
      this.$emit('change', (result === null || result === '') ? result : +result)
    },
  }
}
</script>

<style scoped lang="scss">
  .qc-number-input {
    width: 100%;
    ::v-deep {
      .el-input-group {
        display: inline-table;
      }
      .el-input__inner {
        text-align: left;
      }
    }
  }
</style>
