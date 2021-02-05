<!--
 * @Description: 录入验收资料
 * @Author: lingw
 * @Date: 2020-11-18 09:33:53
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 11:35:09
-->
<template>
 <el-card shadow="never">
   <div slot="header">
     <span class="card-title">
       验收资料详情
     </span>
   </div>
   <el-form :model="accept" class="jh-text" label-position="top">
    <el-form-item label="验收意见" prop="acceptSuggest">
      <p>{{ accept.acceptSuggest === '1' ? '通过' : '不通过' }}</p>
    </el-form-item>
    <el-form-item label="验证结论">
      <p>{{ accept.resultText || '--' }}</p>
    </el-form-item>
  </el-form>
  <div>
    <p class="accept-subtitle">附件</p>
    <el-image 
      v-for="img in accept.fileList"
      :key="img.id"
      style="width: 100px; height: 100px"
      :src="img.url"
      :preview-src-list="list"
    >
    </el-image>
   </div>
 </el-card>
</template>

<script>
export default {
  name: 'AcceptDetailShow',
  props: {
    accept: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  computed: {
    list() {
      return this.accept.fileList.map(({ url }) => url)
    }
  }
}
</script>

<style lang='scss' scoped>

</style>
