<!--
 * @Description: 设计方案界面
 * @Author: lingw
 * @Date: 2020-11-25 15:22:17
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 11:35:22
-->
<template>
 <el-card shadow="never">
   <div slot="header">
     <span class="card-title">
       设计方案详情
     </span>
   </div>
   <el-form ref="form" :model="design" class="jh-text" label-position="top">
     <el-form-item label="设计人">
       <p>{{ design.designUserName }}</p>
     </el-form-item>
     <el-form-item label="预算报价">
       <p>{{ design.budget }}</p>
     </el-form-item>
     <el-form-item label="施工工期">
       <p>{{ design.workload }}</p>
     </el-form-item>
     <el-form-item label="备注">
       <p>{{ design.remark }}</p>
     </el-form-item>
   </el-form>
   <div>
     <p class="design-subtitle">附件</p>
     <el-image 
        v-for="img in design.imageList"
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
  name: 'DesignSchemeShow',
  props: {
    design: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  computed: {
    list() {
      return this.design.imageList.map(({ url }) => url)
    }
  }
}
</script>

<style lang='scss' scoped>
  .design-subtitle {
    color: #909399;
    font-size: 10px;
  }
</style>
