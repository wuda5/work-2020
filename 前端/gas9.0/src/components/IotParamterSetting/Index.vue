<!-- 物联网表参数设置 -->
<template>
  <div class="IotParamterSetting-page">
    <!-- 物联网表列表 -->
    <iot-list></iot-list>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import IotList from './IotList.vue'

export default {
  name: 'IotParamterSetting',
  components: {
    IotList
  },
  filters: {},
  mixins: [commonMixin],
  props: {

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
    }
  }
}
</script>

<style scoped lang="scss">

</style>
