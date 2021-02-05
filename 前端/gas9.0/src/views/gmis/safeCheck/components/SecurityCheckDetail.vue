<!--
 * @Description: 录入安检结果资料
 * @Author: lingw
 * @Date: 2020-11-20 13:43:57
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-26 19:47:57
-->
<template>
 <div>
   <el-form ref="form" :model="form" :rules="rules" label-position="top" class="jh-text">
      <el-form-item label="客户编号">
        <el-input v-model="form.customerCode" disabled></el-input>
      </el-form-item>
      <el-form-item label="客户名称">
        <el-input v-model="form.customerName" disabled></el-input>
      </el-form-item>
      <el-form-item label="安检任务编号">
        <el-input v-model="form.scNo" disabled></el-input>
      </el-form-item>
      <el-form-item label="安检日期" prop="securityCheckTime">
        <el-date-picker v-model="form.securityCheckTime"
        type="datetime" 
        format="yyyy-MM-dd HH:mm:ss"
        value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择安检日期"
>
        </el-date-picker>
      </el-form-item>
      <el-form-item label="安检员" prop="reciveUser">
       <el-input v-model="form.securityCheckUserName" disabled></el-input>
      </el-form-item>
      <el-form-item label="安检结果" prop="securityCheckResult">
        <el-select v-model="form.securityCheckResult">
          <el-option v-for="({ resultId, resultName }) in resultList" :key="resultId" :value="resultId" :label="resultName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="备注">
        <el-input v-model="form.remark"></el-input>
      </el-form-item>
   </el-form>
    <el-divider></el-divider>
    <el-table
      :data="allCheckInfos"
      border
      style="width: 100%"
>
      <el-table-column
        label="安检项"
        prop="scTermName"
        >   
      </el-table-column>
      <el-table-column
        label="隐患"
        prop="scItemList"
        >
        <template slot-scope="{row}">
          <el-checkbox-group v-model="checkList">
            <el-checkbox v-for="(item, index) in row.scItemList" :key="item.scTermItemsId" :label="item.scTermItemsId" @change="(val) => handleChange(row, val, index)">{{ item.scTermItemsName }}</el-checkbox>
          </el-checkbox-group>
        </template>
      </el-table-column>
    </el-table>
    <div style="text-align: right;">
      <el-button style="margin-top: 8px;" type="primary" :loading="loading" @click="handleSubmit">
        提交
      </el-button>
    </div>
 </div>
</template>

<script>
export default {
  name: 'SecurityCheckInput',
  props: {
    resultList: {
      type: Array,
      default: () => {
        return [
          {
            resultId: 0,
            resultName: '正常安检'
          },
          {
            resultId: 1,
            resultName: '到访不遇'
          },
          {
            resultId: 2,
            resultName: '拒绝安检'
          }
        ]
      }
    }
  },
  data () {
    return {
      loading: false,
      allCheckInfos: [],
      form: {
        customerCode: '',
        customerName: '',
        securityCheckUserId: '',
        securityCheckTime: '',
        securityCheckResult: '',
        remark: ''
      },
      checkList: [], // 选中的子项 id 列表， 供回显使用
      filterCheckList: [], // 选中的子项信息列表， 供接口使用
      rules: {
        securityCheckResult: [
          { required: true, message: '请选择安检结果', trigger: 'blur' }
        ],
        securityCheckTime: [
          { required: true, message: '请选择安检日期', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          const payload = {
            scResultDto: {
              ...this.form,
            },
            scItemsSaveDtoS: [...this.filterCheckList],
          }
          this.loading = true
          this.$emit('submit', payload)
        }
      })
    },
    handleChange(row, val, index) {
      if (val) {
        if (!this.filterCheckList.find(({ id }) => id === row.scItemList[index].id)) {
          this.filterCheckList.push(row.scItemList[index])
        }
      } else {
        this.filterCheckList = this.filterCheckList.filter(({ id }) => 
          row.scItemList[index].id !== id
        )
      }
    },
    reset() {
      this.$refs.form.resetFields()
    }
  }
}
</script>
