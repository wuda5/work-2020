<template>
  <div class="DataStatusSearch-container">
    <el-button v-for="(v, k) in data" :key="k" :type="type" :name="`dataStatusSearch[${k}]`" :round="round" :plain="k !== value" @click.native="handleDataStatusChange(k)">{{ v }}</el-button>
  </div>
</template>

<script>
import { dataStatusSearchMap } from '@/enums/common'

export default {
  name: 'DataStatusSearch',
  components: {

  },
  props: {
    value: {
      type: [Boolean, String, Number],
      default: null
    },
    // 显示的搜索数据
    data: {
      type: [Array, Object],
      default: () => dataStatusSearchMap
    },
    type: {
      type: String,
      default: 'primary'
    },
    round: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {

    }
  },
  computed: {
  },
  watch: {
  },
  created() {

  },
  mounted() {
  },
  methods: {
    handleDataStatusChange(k) {
      // console.log(k)
      this.$emit('update:value', k)
      this.$emit('data-status-change', k)
    }
  }
}
</script>

<style scoped lang="scss">

</style>
