<!--
 * @Description:
 * @Author: lingw
 * @Date: 2020-09-27 08:46:06
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-27 17:17:21
-->
<!-- 添加 | 编辑 抄表册人员-->
<template>
  <div>
    <el-form label-position="top" :model="form" class="jh-text">
      <el-form-item label="抄表册">
        <el-input v-model="form.bookName" />
      </el-form-item>
      <el-form-item label="抄表员">
        <el-autocomplete
          v-model="form.readMeterUserName"
          :fetch-suggestions="querySearchAsync"
          placeholder="请输入内容"
          @select="handleSelect"
        ></el-autocomplete>
        <!-- <el-input v-model="form.readMeterUserName" /> -->
      </el-form-item>

      <div class="fr mt20">
        <el-button v-if="form.id" type="primary" @click="updateReadMeterBook">保存</el-button>
        <el-button v-else type="success" @click="addReadMeterBook">新增</el-button>
      </div>
    </el-form>
  </div>
</template>

<script>
  import apiReadMeterBook from '@/api/readMeter/readMeterBook'
  import { initQueryParams } from '@/utils/commons';

  export default {
    name: 'EditReadMeterBook',
    props: {
      bookInfo: {
        type: Object
      }
    },
    data() {
      return {
        // 表单信息
        form: this.bookInfo ? JSON.parse(JSON.stringify(this.bookInfo)) : this.initFormData(),
        // 用户列表
        userList: []
      }
    },
    mounted() {
      this.initUserList()
    },
    methods: {
      // 初始化表单数据
      initFormData() {
        return {
          'bookName': '',
          'readMeterUserName': ''
        }
      },

      // 添加
      addReadMeterBook() {
        let status = true
       for(let item of this.userList){
         if(this.form.readMeterUserName == item.userName){
           apiReadMeterBook.addReadMeterBook(this.form).then(res => {
            let {isSuccess, data} = res.data
            if (isSuccess) {
              this.msg('添加成功','success')
              this.$emit('close')
            }
          })
            status = false
            break
         }
        }
        if(status) {
          this.$message.error('请选择正确的抄表员')
        }
      },

      // 修改
      updateReadMeterBook() {
        let status = true
        for(let item of this.userList){
         if(this.form.readMeterUserName == item.userName){
           apiReadMeterBook.updateReadMeterBook(this.form).then(res => {
            let {isSuccess, data} = res.data
            if (isSuccess) {
              this.msg('更新成功','success')
              this.$emit('close')
            }
          })
            status = false
            break
         }
        }
        if(status) {
          this.$message.error('请选择正确的抄表员')
        }
      },
      async initUserList() {
        const queryParams = initQueryParams({
          model: {
            roleCode: 'METER_READER'
          }
        })
        const { data: res } = await apiReadMeterBook.getUserList(queryParams)
        if (res.isSuccess) {
          this.userList = res.data.records.map(item => ({
            ...item,
            value: item.userName
          }))
        }
      },
      querySearchAsync(queryString, cb) {
         const userList = this.userList;
         const results = queryString ? userList.filter(this.createStateFilter(queryString)) : userList;
         cb(results);
      },
      createStateFilter(queryString) {
        return (state) => {
          console.warn(state)
          return (state.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
        };
      },
      handleSelect(item) {
        this.form.readMeterUser = item.userId
      }
    }
  }
</script>

<style lang="scss" scoped>
  .mt20{
    margin-top: 20px;
    .el-button{
      width: 150px;
    }
  }
</style>
