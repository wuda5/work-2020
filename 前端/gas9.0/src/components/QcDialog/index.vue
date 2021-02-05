<!-- 弹出窗 -->
<template>
  <el-dialog
    :visible="visible"
    :title="title"
    :width="logWidth"
    custom-class="myDialog qc-dialog"
    :close-on-click-modal="false"
    v-bind="$attrs"
    :append-to-body="true"
    @close="close"
  >
    <slot>

    </slot>
  </el-dialog>

</template>

<script>
export default {
  name: 'QcDialog',
  props: {
    // data
    myData: {
      type: Object,
      default: function () {
        return {}
      }
    },
    width: {
      type: Number,
      default: NaN
    },
    visible: { // 是否可见
      type: Boolean
    },
    dataKey: { // 父级用到的key（data）
      type: String
    },
    title: { // 父级用到的key（data）
      type: String,
      default: '默认标题'
    }
  },
  data() {
    return {
      isShow: this.visible
    }
  },
  computed: {
    logWidth() {
      let str = ''
      if (this.width) {
        str = this.width + 'px'
      } else {
        str = ''
      }
      return str
    }

  },
  methods: {
    close() {
      this.$emit('close', this.dataKey)
    }
  }

}
</script>

<style lang="scss">
  .el-dialog{
    &.qc-dialog {
      /*display: flex;*/
      /*flex-direction: column;*/
       margin:0 !important;
       position:absolute;
       top:50%;
       left:50%;
       transform:translate(-50%,-50%);
       max-height:calc(100% - 30px);
       max-width:calc(100% - 30px);
       overflow: scroll;
       .el-dialog__body{
         flex:1;
         overflow: auto;
       }
    }
  }
</style>
