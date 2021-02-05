<!--
 * @Description: 单表、安检统计、输差统计、节点输送范围
 * @Author: lingw
 * @Date: 2020-10-16 15:17:49
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 11:09:06
-->
<template>
  <el-card class="card-info-container">
    <div slot="header">
      <span class="card-title">{{ cardInfo.title }}</span>
    </div>
    <el-form v-model="cardInfo" label-position="top" class="jh-text">
      <el-form-item :label="cardInfo.subTitleOne">
        <p class="card-content">
          {{ cardInfo.itemOne | emptyStr }}
        </p>
      </el-form-item>
      <el-form-item :label="cardInfo.subTitleTwo">
        <p class="card-content">
          {{ cardInfo.itemTwo | emptyStr }}
        </p>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'CardInfo',
  props: {
    cardInfo: {
      type: Object,
      default() {
        return {
          subTitleOne: '',
          subTitleTwo: '',
          itemOne: '',
          itemTwo: ''
        }
      }
    }
  },
  data () {
    return {

    }
  },
  mounted () {

  },
  methods: {

  }
}
</script>

<style lang='scss' scoped>
  ::v-deep .card-title, .card-content {
    font-size: 16px;
    font-weight: 600;
  }
  .card-info-container {
    width: 200px;
    box-shadow: 1px 1px 5px 2px #C0C4CC;
  }
</style>
