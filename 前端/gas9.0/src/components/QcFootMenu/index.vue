<!--footMenu-->
<template>
  <div class="footNav hidden-sm-only">
    <slot />
  </div>
</template>
<script>
export default {
  name: 'FootMenu'
}
</script>

<style lang="scss" scoped>
  @import "~@/styles/variables.scss";
  /* footNav */
  .footNav {
    background: #fff;
    box-shadow: 0 0 5px #666;
    display: inline-block;
    position: fixed;
    bottom: -30px;
    left: 50%;
    transform: translate(-50%);
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    text-align: center;
    padding: 0 10px;
    opacity: 0.4;
    z-index: 1000;
    white-space: nowrap;
    transition: all .2s;

    &:hover {
      opacity: 1;
      bottom: 0;
      transition: all .2s
    }

    .footNav-item {
      display: inline-block;
      padding: 5px;
      cursor: pointer;
      min-width: 80px;

      .icon {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: #FFF;
        text-align: center;
        display: inline-block;

        .svg-icon {
          font-size: 22px;
          color: $light-blue;
          position: relative;
          top: 7px;
        }
      }

      p {
        margin: 5px;
        font-size: 12px;
        transform: scale(0.9);
        color: #909399;
        letter-spacing: 2px;
      }

      &:hover {
        background: #eee;

        .svg-icon {
          color: $pink;
        }

        p {
          color: $pink;
        }
      }
    }
  }
</style>
