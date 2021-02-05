<!-- 保险信息 -->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">保险信息</div>
    </div>
    <div slot="default" class="frameBody">
      <template v-if="listData.length">
        <el-card v-for="(item,index) in listData" :key="index" shadow="never" class="listItem">
          <div slot="header">
            ??? :
          </div>
          <el-form ref="form" label-position="top" class="jh-text">
            <el-form-item label="？？？">
              <p>---</p>
            </el-form-item>
          </el-form>
        </el-card>
      </template>
      <el-alert
        v-else
        title="开发中"
        type="error"
        show-icon
        :closable="false"
      >
      </el-alert>
    </div>
    <div v-if="listData.length" slot="page">
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
  name: 'InsuranceInfo',
  data(){
    return{
      listData:[],
      searchData:this.initQueryParams()
    }
  },
  methods:{
    getListData(){

    }
  }
}
</script>

<style scoped>

</style>
