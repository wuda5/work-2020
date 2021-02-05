<template>
  <div class="scan-box" @keydown="handleKeydown">
    <el-input ref="inputRef" v-model="value" class="test" placeholder="此处进行扫码"></el-input>
  </div>
</template>

<script>
export default {
  data() {
    return {
      value: null
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.$refs.inputRef?.focus()
    })
  },
  methods: {
    handleKeydown(e) {
      console.log(e)
       e = e||event;
      const keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
        if(keyCode === 13){
          console.log('keyCode')
            e.preventDefault();            
            //do something
            return false;
      }
    }
  },
}
</script>

<style>
  .scan-box {
    height: 100%;
    width: 100%;
  }
  .test {
    opacity: 0;
  }
</style>