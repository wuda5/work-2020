
<!--调价补差核算-->
<template>
    <div class="CheckPrice-container">
        <el-tabs v-model="currentTab" type="border-card">
            <el-tab-pane label="自动核算" name="zdhs">
                <keep-alive>
                    <auto-check-price v-if="IS_ZDHS" :use-gas-type-list="useGasTypeList" @change-step="handleChangeStep"></auto-check-price>
                </keep-alive>
            </el-tab-pane>
            <el-tab-pane label="人工录入核算" name="rglr">
                <keep-alive>
                    <manual-check-price v-if="!IS_ZDHS" :use-gas-type-list="useGasTypeList" @change-step="handleChangeStep"></manual-check-price>
                </keep-alive>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import AutoCheckPrice from './AutoCheckPrice.vue'
import ManualCheckPrice from './ManualCheckPrice.vue'

export default {
    name:'CheckPriceChange',
    components: {
        AutoCheckPrice,
        ManualCheckPrice,
    },
    filters: {
    },
    mixins: [commonMixin],
    props: {
        // 用气类型列表
        useGasTypeList: Array,
    },
    data(){
        return {
            currentTab: 'zdhs',
        }
    },
    computed: {
        // 是否自动核算tab
        IS_ZDHS() {
            return this.currentTab === 'zdhs'
        },
    },
    created() {
     this.initData()
    },
    mounted(){
        
    },
    activated() {
    },
    methods:{
        async initData() {

        },
        handleChangeStep(flag, data) {
            this.$emit('change-step', flag, data);
        }
    },
}
</script>

<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}

// 设置表格头部背景
::v-deep .el-table th {
  background-color: #f5f7fa !important;
}

.tableDelete {
  margin-top: 15px;
  border-top: 1px solid #eee;
  padding: 15px;
  text-align: right;
  overflow: hidden;

  b {
    float: left;
  }

//   .el-button {

//   }
}

.el-table {
  border: 1px solid #ccc;
}

.jh-text {
  .el-form-item {
    width: calc(100% / 5);
    margin-bottom: 18px;
  }
}
.bottom {
    margin-top: 13px;
    line-height: 12px;
  }

  .button {
    float: right;
  }
</style>
