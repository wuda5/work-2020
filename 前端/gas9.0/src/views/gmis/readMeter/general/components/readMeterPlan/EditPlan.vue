<!--抄表计划 添加 | 修改-->
<template>
  <div>
    <el-form ref="planForm" label-position="top" :rules="rules" :model="planForm" class="jh-text">
      <!-- 抄表月 -->
      <!-- <el-form-item label="抄表月" prop="readMeteTime">
        <el-date-picker
          v-model="planForm.readMeteTime"
          type="month"
          placeholder="选择时间"
          value-format="yyyy-MM"
          :picker-options="start_Date"
        ></el-date-picker>
        <el-input type="text" v-model="planForm.planName" ></el-input>
      </el-form-item> -->
      
      <!-- 抄表频率 -->
      <el-form-item label="抄表频率" prop="planFrequency">
        <el-input v-model="planForm.planFrequency" type="text"></el-input>
      </el-form-item>
      <el-form-item label="频率单位" prop="planUnit">
        <el-select v-model="planForm.planUnit" placeholder="请选择">
          <el-option
            v-for="item in planUnits"
            :key="item.value"
            :label="item.label"
            :value="item.value"
            >
          </el-option>
        </el-select>
      </el-form-item>
      <!-- 开始时间 -->
      <el-form-item label="起始时间" prop="planStartTime" style="width:66.6%">
        <!-- <el-date-picker
          v-model="planForm.rangeTime"
          value-format="yyyy-MM-dd"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :picker-options="start_Date"
        ></el-date-picker> -->
        <el-date-picker
          v-model="planForm.planStartTime"
          value-format="yyyy-MM-dd"
          type="date"
          placeholder="选择日期"
          :picker-options="start_Date"
          >
        </el-date-picker>
      </el-form-item>

      <!-- 结束时间 -->
      <!-- <el-form-item label="结束时间" prop="planEndTime">
        <el-date-picker
          v-model="planForm.planEndTime"
          value-format="yyyy-MM-dd"
          placeholder
          :picker-options="start_Date"
        ></el-date-picker>
      </el-form-item>-->
    </el-form>
    <div class="text-right">
      <el-button v-if="formType==='add'" type="success" @click="saveData('add')">新增</el-button>
      <el-button v-if="formType==='edit'" type="primary" @click="saveData('update')">保存</el-button>
    </div>
  </div>
</template>

<script>
import apiReadMeterPlan from '@/api/readMeter/readMeterPlan'
import data from '@/views/gmis/service/data'
import { mounted } from 'v-charts/lib/core'
export default {
  name: 'EditPlan',
  props: {
    formType: {
      type: String,
    },
    curPlan: {
      type: Object,
    },
  },
  data() {
    return {
      // 计划表单
      planForm: this.initPlanForm(),
      rules: {
        planStartTime: [{ required: true, message: '必选', trigger: 'change' }],
        // rangeTime: [{ required: true, message: '必选', trigger: 'change' 0}],
        planFrequency:[{ required: true, message: '必选', trigger: 'blur' }],
        planUnit:[{ required: true, message: '必选', trigger: 'blur' }]
        // planEndTime: [{ required: true, message: '必选', trigger: 'blur' }],
        // readMeteTime: [{ required: true, message: '必选', trigger: 'blur' }],
      },

      start_Date: {
        //时间限制
        disabledDate(time) {
          return time.getTime() <= Date.now() - 3600 * 1000 * 24
        },
      },
      // end_Date: {
      //   disabledDate: time => {
      //     return time.getTime() <= Date.now() + 3600 * 1000 * 24 * 15
      //   },
      // },
      planUnits:[{
        label:'天',
        value:'Days'
      },{
        label:'月',
        value:'Months'
      },{
        label:'年',
        value:'Years'
      }]
    }
  },
  methods: {
    initPlanForm() {
      // 如果是修改
      if (this.curPlan) {
        return {
          id:this.curPlan.id,
          //如果抄表readMeterYear和readMeterMonth为空，则readMeteTime为null
          readMeteTime:this.curPlan.readMeterYear&&this.curPlan.readMeterMonth?this.curPlan.readMeterYear + '-' + this.curPlan.readMeterMonth:null,
          // readMeteTime: this.curPlan.readMeterYear + '-' + this.curPlan.readMeterMonth, // 抄表时间，年月 提交时拆分给下面使用
          // rangeTime: [this.curPlan.planStartTime || '', this.curPlan.planEndTime || ''],
          // planName:this.curPlan.planName,//抄表名称
          planStartTime: this.curPlan.planStartTime, // 开始时间
          planEndTime: this.curPlan.planEndTime, //结束时间
          planFrequency:'', //抄表频次
          planUnit:'', //频次单位
          // readMeterMonth: this.curPlan.readMeterMonth, // 抄表月
          // readMeterYear: this.curPlan.readMeterYear, // 抄表年
        }
      }
      // 新增
      return {
        readMeteTime: '',
        // planName:'',
        rangeTime: [],
        planEndTime: '', //结束时间
        planStartTime: '', // 开始时间
        readMeterMonth: '', // 抄表月
        readMeterYear: '', // 抄表年
      }
    },

    // 添加抄表计划
    add(submitData) {
      apiReadMeterPlan.addReadMeterPlanInfo(submitData).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.msg('添加成功', 'success')
          this.$emit('close')
        }
      })
    },
    beforeDestroy() {
      this.curPlan = null
    },
    update(submitData) {
      apiReadMeterPlan.updateReadMeterPlanInfo(submitData).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.msg('更新成功', 'success')
          this.$emit('close')
        }
      })
    },
    saveData(type) {
      // 处理时间,生成结束时间
      let date,year,month,day
      if(this.planForm.planUnit == 'Days'){
        date = new Date(this.planForm.planStartTime).getTime() + Number(this.planForm.planFrequency)*3600*24*1000
      }else if(this.planForm.planUnit == 'Months'){
        date = new Date(this.planForm.planStartTime).getTime() + Number(this.planForm.planFrequency)*3600*24*30*1000
      }else{
        date = new Date(this.planForm.planStartTime).getTime() + Number(this.planForm.planFrequency)*3600*24*30*12*1000
      }
        year = new Date(date).getFullYear()
        month = new Date(date).getMonth()+1
        day = new Date(date).getDate()
        month = month < 10 ? '0'+month:month;
        day = day < 10 ? '0'+day:day;
        this.planEndTime = year+'-'+month+'-'+day;
        console.log(this.planEndTime)
      //2020-11-16修改bug，注释抄表月条件判断
      // if (this.planForm.readMeteTime) {
        // 处理抄表月份
        //如果是修改，清空抄表月，则将readMeterYear和readMeterMonth置空，否则报split错
      //   if(type === 'update' && this.planForm.readMeteTime ==null){
      //      this.planForm.readMeterYear = '';
      //      this.planForm.readMeterMonth = ''
      //   }else{
      //     let timeArr = this.planForm.readMeteTime.split('-')
      //     this.planForm.readMeterYear = timeArr[0]
      //     this.planForm.readMeterMonth = timeArr[1]
      //   }
      //   // 处理开始结束时间
      //   this.planForm.planStartTime = this.planForm.rangeTime[0]
      //   this.planForm.planEndTime = this.planForm.rangeTime[1]
      // // }
      // let submitData = JSON.parse(JSON.stringify(this.planForm))
      // delete submitData.readMeteTime
      // delete submitData.rangeTime

      // 验证表单
      // this.$refs.planForm.validate(valid => {
      //   if (valid) {
      //     if (type === 'add') {
      //       this.add(submitData)
      //     } else if (type === 'update') {
      //       this.update(submitData)
      //     }
      //   }
      // })
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 3);
      margin-bottom: 18px;
    }
  }
</style>
