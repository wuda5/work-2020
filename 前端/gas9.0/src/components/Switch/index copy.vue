<template>
  <el-switch v-model="model" :title="model ? $t('enable') : $t('disable')" v-bind="$attrs" :active-value="activeValue" :inactive-value="inactiveValue" :active-color="activeColor" :inactive-color="inactiveColor" v-on="$listeners" />
</template>

<script>
export default {
  name: 'QcSwitch',
  components: {

  },
  props: {
    value: {
      type: [Boolean, String, Number],
      default: 0
    },
    activeValue: {
      type: [String, Boolean, Number],
      default: 1
    },
    inactiveValue: {
      type: [String, Boolean, Number],
      default: 0
    },
    activeColor: {
      type: String,
      default: '#67C23A'
    },
    inactiveColor: {
      type: String,
      default: '#909399'
    }
  },
  data() {
    return {

    }
  },
  computed: {
    model: {
      get() {
        let model = ''
        const valueTypeOf = typeof this.activeValue
        // 根据激活状态的值是类型，则将传入的props值转换为相对应的类型
        if (valueTypeOf === 'boolean') {
          model = !!this.value
        } else if (valueTypeOf === 'number') {
          model = +this.value
        } else {
          model = this.value?.toString() || ''
        }
        return model
      },
      set(val) {
        // this.$emit('update:value', val)
      }
    }
  },
  watch: {
    value: {
      handler(value) {
        // console.log('value', value)
      },
      immediate: true
    }
  },
  created() {

  },
  mounted() {
    // console.log(this)
  },
  methods: {

  }
}
</script>

<style scoped lang="scss">

</style>
