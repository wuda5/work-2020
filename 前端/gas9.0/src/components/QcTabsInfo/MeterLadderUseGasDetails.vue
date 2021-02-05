<!--气表阶梯用量信息-->
<template>
  <div class="info-page MeterLadderUseGasDetails-page">
    <!-- card -->
    <el-card shadow="never" class="no-border">
      <slot name="header">
        <div slot="header">
          <span class="card-title">{{ $t('meterInfo.ladder.detailsTitle') }}</span>
        </div>
      </slot>
      <el-form label-position="top" class="qc-form clearfix show-info-form show-meterinfo-form" :inline="true">
      </el-form>
    </el-card>
  </div>
</template>
<script>
import { getGasMeterDetails } from '@/api/meterInfo/index'

export default {
  name: 'MeterLadderUseGasDetails',
  filters: {
  },
  mixins: [],
  // data 和 id prop属于互斥关系
  props: {
    // 展示的信息
    data: {
      type: Object,
      default: function () {
        return {}
      }
    },
    // 展示的信息id
    id: {
      type: [String, Number],
      default: null
    },
    // 气表编号
    gasMeterCode: {
      type: [String, Number],
      default: null
    },
    // 是否全部显示信息
    showAll: {
      type: Boolean,
      default: true
    },
  },
  data() {
    return {
      showData: {}, // 最终显示的数据
      meterInfo: {}, // 气表基本信息
      loading: true, // 页面加载状态
      emptyStr: '--',
      showMore: false
    }
  },
  computed: {
  },
  watch: {
    id: {
      handler() {
        this.initData()
      }
    },
    gasMeterCode: {
      handler() {
        this.initData()
      }
    },
    data: {
      handler() {
        this.initData()
      }
    },
  },
  created() {
    this.initData()
  },
  methods: {
    async initData() {
      if (this.id) {
        await this.getData()
      } else if (this.gasMeterCode) {
        await this.getLadderDetails()
      } else {
        this.showData = this.data ?? {}
      }
      this.loading = false
    },

    // 需要获取数据
    getData() {
      return new Promise((resolve) => {
        // 获取数据，给model赋值
        resolve(true)
      })
    },

    // 获取气表阶梯用量信息
    getLadderDetails() {
      return new Promise((resolve) => {
        getGasMeterDetails(this.gasMeterCode).then((response) => {
          const { isSuccess, data } = response.data
          if (isSuccess) {
            this.showData = data
            resolve(true)
          } else {
            resolve(false)
          }
        }).catch(() => {
          resolve(false)
        }).finally(() => {

        })
      })
    },
    viewMore() {
      // todo: 跳转地址
    }
  }

}
</script>

<style lang="scss" scoped>
  .show-info-form {
    .el-form-item {
      width: calc(100% / 2);
    }
  }
</style>

