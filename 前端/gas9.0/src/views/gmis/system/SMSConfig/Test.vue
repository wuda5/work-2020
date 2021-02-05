<template>
  <div>
    <el-form ref="userForm" label-position="top" :model="form" disabled class="jh-text">
      <el-form-item label="应用场景" prop="templateTypeId">
        <el-select v-model="form.templateTypeId" placeholder="选择场景名">
          <el-option
            v-for="item in dict.SMS_TYPE"
            :key="item.id"
            :label="item.name"
            :value="item.id"
            @click.native="sencesChange"
          ></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="模板名" prop="name">
        <el-input v-model="form.name" name="name" />
      </el-form-item>

      <!-- internatType: 0, // 0：表示国内短信。 1：表示国际/港澳台短信 -->
      <!-- <el-form-item label="短信类型" prop="internatType">
        <el-select
          v-model="form.internatType"
          name="internatType"
          placeholder="选择短信类型"
        >
          <el-option label="国内短信" :value="0"></el-option>
          <el-option label="国际/港澳台短信" :value="1"></el-option>
        </el-select>
      </el-form-item>-->

      <div class="clearfix" />
      <el-form-item class="width100" label="模板内容" prop="templateCode">
        <el-input v-model="form.templateCode" type="textarea" :rows="5" name="content" />
      </el-form-item>
    </el-form>

    <el-form ref="testForm" label-position="top" :model="testFrom" :rules="rules" class="jh-text">
      <el-form-item class="width100" label="手机号码" prop="tel">
        <el-input v-model="testFrom.receiver" name="tel" />
      </el-form-item>

      <div class="tips">
        <b class="redfont">请填入模板中使用到的变量</b>
        <br />
        <ul v-if="SMSData">
          <li v-for="item in dict.SMS_FIELD" :key="item.id">
            <span class="name">{{ `{${item.code}\}` }} :</span>
            <el-input v-model="SMSData[item.code]" :placeholder="item.name" class="code" />
          </li>
        </ul>
      </div>
      <el-form-item class="width100" label=" ">
        <el-button type="primary" class="width100" @click="submitForm('testForm')">测试</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import apiSMS from '@/api/system/SMSConfig'
import { getSMSTemplate, getSMSData } from '@/utils/sms'

const defaultFormData = {
  content: '', // 模板内容
  customCode: '', // 模板编码(--)
  internatType: 0, // 0：表示国内短信。 1：表示国际/港澳台短信
  name: '', // 模板名
  smsType: 0, // 短信类型，0表示普通短信, 1表示营销短信。(--)

  templateCode: '', // 模板CODE
  templateDescribe: '短信', // 模板描述
  templateTypeId: '', // 场景ID
  templateTypeName: '', // 模板场景名
}
export default {
  name: 'TestSMS',
  props: {
    formData: {
      type: Object,
    },
  },
  data() {
    return {
      form: this.formData ? this.formData : JSON.parse(JSON.stringify(defaultFormData)),
      rules: {
        templateTypeId: [{ required: true, message: '必填', trigger: 'blur' }],
        name: [{ required: true, message: '必填', trigger: 'blur' }],
        internatType: [{ required: true, message: '必填', trigger: 'blur' }],
        content: [{ required: true, message: '必填', trigger: 'blur' }],
      },
      testFrom: {
        templateId: this.formData.id,
        draft: false,
        receiver: '', // 电话号码
        templateParam: {},
      },
      SMSData: null,
    }
  },
  created() {
    let SMSData = {}
    for (let i = 0; i < this.dict.SMS_FIELD.length; i++) {
      const item = this.dict.SMS_FIELD[i]
      SMSData[item.code] = ''
    }
    this.SMSData = SMSData
  },
  methods: {
    // 测试发送
    sendTest() {
      let { smsTemplate, numKeyObj, dataOjb } = getSMSData(this.form.templateCode, this.SMSData)
      console.log(smsTemplate, numKeyObj, dataOjb)
      this.testFrom.templateParam = numKeyObj
      apiSMS.testSend(this.testFrom).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.msg('发送成功', 'success')
        }
        console.log(res)
      })
    },
    // 提交
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.sendTest()
        } else {
          this.msg('验证失败')
          return false
        }
      })
    },
  },
}
</script>

<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: clac(100%/2);
      margin-bottom: 15px;
    }
  }
  .tips {
    margin: 20px auto 0;
    ul {
      padding: 0;
      margin: 20px 0 0 0;
      border: 1px solid #eee;
      overflow: hidden;
      border-radius: 3px;
      li {
        list-style: none;
        margin: 8px 0;
        float: left;
        width: 50%;
        // margin-right: 2%;
        overflow: hidden;
        display: flex;
        align-items:center span.name {
          display: block;
          box-sizing: border-box;
          float: left;
        }
        .name {
          width: 50%;
          text-align: right;
          line-height: 28px;
        }
        .code {
          width: 50%;
          color: $danger;
          padding-left: 10px;
        }
      }
    }
  }
</style>
