<template>
  <el-tooltip v-if="showTooltip" :content="currentText" :placement="toolTipPlacement" :effect="toolTipEffect" popper-class="switch-tooltip-popper">
    <el-switch v-model="model" v-bind="$attrs" :active-value="activeValue" :inactive-value="inactiveValue" :active-text="showText ? activeText : ''" :inactive-text="showText ? inactiveText : ''" :active-color="activeColor" :inactive-color="inactiveColor" v-on="$listeners" />
  </el-tooltip>
  <el-switch v-else v-model="model" v-bind="$attrs" :active-value="activeValue" :inactive-value="inactiveValue" :active-text="showText ? activeText : ''" :inactive-text="showText ? inactiveText : ''" :active-color="activeColor" :inactive-color="inactiveColor" v-on="$listeners" />
</template>

<script>
import { dataStatusField, dataStatusDisableMap } from '@/enums/common'

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
    },
    activeText: {
      type: String,
      default: dataStatusDisableMap[dataStatusField.VALID],
    },
    inactiveText: {
      type: String,
      default: dataStatusDisableMap[dataStatusField.INVALID],
    },
    // 是否显示文字描述
    showText: {
      type: Boolean,
      default: false
    },
    // 是否显示文字提示工具
    showTooltip: {
      type: Boolean,
      default: true
    },
    // 工具提示主题
    toolTipEffect: {
      type: String,
      default: 'dark'
    },
    // 工具提示出现位置
    toolTipPlacement: {
      type: String,
      default: 'bottom'
    },

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
    },
    // 当前文字
    currentText() {
      return this.model ? this.activeText : this.inactiveText
    },
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

<style lang="scss">
  .switch-tooltip-popper {
    padding: 5px 10px;
  }
</style>
