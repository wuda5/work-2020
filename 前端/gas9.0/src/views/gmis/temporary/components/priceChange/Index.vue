<!-- 调价补差主页面 -->
<template>
  <div class="priceChange-page">
    <keep-alive include="CheckPriceChange">
      <check-price v-if="showCheckPrice" :use-gas-type-list="useGasTypeList" @change-step="changeStep" />
      <price-change v-else :use-gas-type-list="useGasTypeList" :use-gas-type-id="useGasTypeId" @change-step="changeStep" />
    </keep-alive>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import CheckPrice from './CheckPrice.vue'; // 调价补差生成核算
import PriceChange from './PriceChange.vue'; // 调价补差
import { initQueryParams } from '@/utils/commons'
// 引入业务运营配置下 燃气类型接口
import { getUseGasTypeList } from '@/api/operation/gasPrice'

export default {
  name: 'PriceChangeIndex',
  components: {
    CheckPrice,
    PriceChange
  },
  filters: {},
  mixins: [commonMixin],
  props: {
    // 显示核算步骤
    showCheckPrice: {
      type: Boolean,
      default: true,
    }
  },
  data() {
    return {
      useGasTypeList:[],//用气类型
      useGasTypeId: [],
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
      this.getUseGasTypeListData();
      await this.getData()
    },
    async getData(params = {}) {
       return new Promise((resolve) => {

       })
    },
    // 获取所有用气类型名称
    getUseGasTypeListData(params = {}) {
        if (this.useGasTypeList.length > 0) {
        return true
        }
        return new Promise((resolve) => {
        getUseGasTypeList(initQueryParams({ size: 10000, ...params })).then((result) => {
            const { isSuccess, data } = result.data
            if (isSuccess) {
            const { total, records } = data
            this.useGasTypeList = records
            resolve(records)
            } else {
            resolve(false)
            }
        }).catch(() => {
            resolve(false)
        })
        })
    },
    changeStep(flag, data) {
      this.useGasTypeId = data || []
      this.$emit('update:showCheckPrice', flag)
    },
  }
}
</script>

<style scoped lang="scss">
  .priceChange-page {
    ::v-deep {
      .change-step-box {
        .el-button {
          width: 150px;
        }
      }
    }
  }
</style>
