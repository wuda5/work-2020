<!-- 未选择提示 -->
<template>
  <div class="noSelect" :style="boxStyle">
    <span :style="fontStyle">{{ tips }}</span>
  </div>
</template>
<script>
  export default {
    name: 'NoSelect',
    props: {
      tips: {
        type: String,
      },
      color: {
        type: String,
        default: '#f4d4a6',
      },
      size: {
        type: Number,
        default: 28,
      },
      top: {
        type: Number,
        default: 0,
      },
      height: {
        type: Number
      },
      minusHeight: {
        type: Number,
        default: 230,
      }
    },
    data() {
      return {}
    },
    computed: {
      fontStyle() {
        return {
          color: this.color,
          'font-size': this.size + 'px',
        }
      },
      boxStyle() {
        return {
          'margin-top': this.top + 'px',
          height: this.height ? `${this.height}px` : `calc(100vh - ${this.minusHeight}px)`
        }
      },
    },

    methods: {},
  }
</script>
<style lang="scss" scoped>
  // 未选择
  .noSelect {
    height: calc(100vh - 230px);
    box-sizing: border-box;
    border: 1px solid #e6ebf5;
    border-radius: 3px;
    margin-top: 38px;
    display: flex;
    align-items: center;
    justify-content: center;

    span {
      font-weight: 400;
    }
  }
</style>
