<!-- 数字精度控制输入框（旧版）以el-input-number为基础修改版 -->
<template>
  <el-input-number v-bind="$attrs" :controls="controls" :max="max" :value="value" class="qc-number-input" v-on="$listeners" @change="handleChange"></el-input-number>
</template>

<script>
import { maxMoney } from '@/settings'

export default {
  name: 'QcNumberInput',
  components: {

  },
  filters: {},
  mixins: [],
  props: {
    // v-model绑定值
    value: [String, Number],
    // 最大值
    max: {
      type: Number,
      default: maxMoney,
    },
    controls: {
      type: Boolean,
      default: false,
    }
  },
  data() {
    return {

    }
  },
  computed: {

  },
  watch: {
    value: {
      handler(data, oldData) {
        if (data === '' || data === null) {
          setTimeout(() => {
            this.$emit('input', undefined)
          })
        }
      },
      immediate: true,
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
       await this.getData()
    },
    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },
    handleChange(currentValue, oldValue) {
      this.$emit('input', currentValue)
    },
  }
}
</script>

<style scoped lang="scss">
  .qc-number-input {
    width: 100%;
    ::v-deep {
      .el-input__inner {
        text-align: left;
      }
    }
  }
</style>
