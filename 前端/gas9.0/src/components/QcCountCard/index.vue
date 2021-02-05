<!--信息统计卡片-->
<template>
  <div class="qc-cont-card" :style="cardBgColor">
    <slot>
      <span class="counterTitle">发卡量统计</span>
      <span class="counterText">当月发卡量</span>
      <span class="counterNum">8728</span>
      <span class="counterBar"></span>
    </slot>
  </div>
</template>
<script>
export default {
  name: 'QcCountCard',
  props: {
    bgColor: {
      type: String,
      default: '#323232'
    }
  },
  data() {
    return {}
  },
  computed: {
    cardBgColor() {
      return { backgroundColor: this.bgColor }
    }
  }
}
</script>

<style lang="scss">
  .qc-cont-card {
    height: 100%;
    border-radius: 10px;
    color: #fff;
    overflow: hidden;
    text-align:center ;

    span {
      display: block;
      text-align: center;
      opacity: 0.95;
      position: relative;

      &.counterTitle {
        opacity: 0.9;
        font-size: 14px;
        margin-top: 25px;
      }

      &.counterText {
        opacity: 0.8;
        font-size: 12px;
        height: 12px;
        margin-top: 40px;
      }

      &.counterNum {
        font-size: 26px;
        margin-top: 10px;
      }

      &.counterBar {
        opacity: 0.5;
        border-radius: 2px;
        margin: 30px auto 0;
        width: 20px;
        height: 5px;
        background: #fff;
      }
    }
  }
</style>

