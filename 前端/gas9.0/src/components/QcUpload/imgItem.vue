<template>
  <div class="imgBox">
    <img :src="src" alt="">
    <div class="imgMask">
      <i class="myDelete el-icon-delete" @click="deleteImg"/>
      <i class="myView el-icon-zoom-in" @click="viewImg"/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ImgItem',
  props: {
    src: {
      type: String,
      default: null
    }
  },
  methods: {
    deleteImg() {
      this.$emit('deleteImg')
    },
    viewImg() {
      this.$emit('viewImg')
    }
  }

}
</script>

<style lang="scss" scoped>
.imgBox {
  display: block;
  position: relative;
  margin-bottom: 5px;
  min-height: 30px;

  img {
    display: block;
    width: 100%;
  }

  .imgMask {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    opacity: 0.6;
    background: #000;
    display: none;

    i {
      position: absolute;
      left: 50%;
      top: 50%;
      font-size: 24px;
      color: #fff;
      transform: translate(-50%, -50%);
      cursor: pointer;
    }

    .myDelete {
      margin-left: -30px;
    }

    .myView {
      margin-right: -30px;
    }
  }

  &:hover {
    .imgMask {
      display: block;
    }
  }

}

</style>
