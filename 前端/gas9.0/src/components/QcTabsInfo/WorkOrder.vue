<!--工单信息-->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">工单信息</div>
    </div>
    <div slot="default" class="frameBody">
      <el-card shadow="never" class="listItem">
        <div slot="header">
          <span>
            工单类型：---
          </span>
          <span class="fr redFont">
            ---
          </span>
        </div>
        <el-form ref="form" label-position="top" class="jh-text">
          <el-form-item label="更新时间">
            <p title="开户缴费">---</p>
          </el-form-item>
          <el-form-item label="工单内容">
            <p>---</p>
          </el-form-item>
          <el-form-item label="状态">
            <p>---</p>
          </el-form-item>
          <el-form-item label="接单人">
            <p>---</p>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
    <div slot="page">
      <pagination
        :page-sizes="[5, 10, 15, 20]"
        :page.sync="searchData.current"
        :limit.sync="searchData.size"
        :total="total"
        layout="total ,prev, next,jumper"
        @pagination="getListData"
      />
    </div>
  </info-frame>
</template>
<script>
export default {
  name: 'WorkOrder',
  data(){
    return{
      listData:[],
      total:0,
      searchData:this.initQueryParams()
    }
  },
  methods:{
    getListData(){

    }
  }
}
</script>

<style lang="scss" scoped>

.listItem {
  ::v-deep .el-card__header {
    font-size: 12px;
    line-height: 20px;
  }

  ::v-deep .el-card__body {
    padding: 10px;
  }
}
</style>

