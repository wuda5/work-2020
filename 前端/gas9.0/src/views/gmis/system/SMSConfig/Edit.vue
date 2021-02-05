<template>
  <el-form
    ref="userForm"
    label-position="top"
    :model="form"
    :rules="rules"
    class="jh-text"
  >
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
    </el-form-item> -->

    <div class="clearfix" />
    <el-form-item class="width100" label="模板内容" prop="templateCode">
      <el-input
        v-model="form.templateCode"
        type="textarea"
        :rows="5"
        name="content"
      />
    </el-form-item>
    <div class="clearfix" />
    <div class="tips">
      <div class="redFont"> 变量替换规则（使用红色代码包含大括号代替前面的变量）</div>
      <ul>
        <li v-for="item in dict.SMS_FIELD" :key="item.id">
          <span class="name">{{ item.name }} : </span><span class="code">{{ `{${item.code}\}` }} </span>
        </li>
      </ul>
    </div>

    <div class="clearfix" />

    <el-form-item label=" " class="width100">
      <el-button
        v-if="form.id"
        name="save"
        type="primary"
        class="width100"
        @click="submitForm('userForm')"
      >
        {{ $t("save") }}
      </el-button>
      <el-button
        v-else
        name="edit"
        type="primary"
        class="width100"
        @click="submitForm('userForm')"
      >
        {{ $t("add") }}
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import apiSMS from '@/api/system/SMSConfig';
import { getSMSTemplate } from '@/utils/sms';
const defaultFormData = {
  content: '', // 模板内容 转换过后的短信模板
  customCode: '', // 模板编码(--)
  internatType: 0, // 0：表示国内短信。 1：表示国际/港澳台短信
  name: '', // 模板名
  smsType: 0, // 短信类型，0表示普通短信, 1表示营销短信。(--)

  templateCode: '', // 模板CODE  现用于存储用模板
  templateDescribe: '短信', // 模板描述
  templateTypeId: '', // 场景ID
  templateTypeName: '' // 模板场景名
};
export default {
  name: 'Add',
  props: {
    formData: {
      type: Object
    }
  },
  data() {
    return {
      form: this.formData
        ? this.formData
        : JSON.parse(JSON.stringify(defaultFormData)),
      rules: {
        templateTypeId: [{ required: true, message: '必填', trigger: 'blur' }],
        name: [{ required: true, message: '必填', trigger: 'blur' }],
        internatType: [{ required: true, message: '必填', trigger: 'blur' }],
        templateCode: [{ required: true, message: '必填', trigger: 'blur' }]
      },
      orgTree: [],
      defaultProps: {
        children: 'children',
        label: 'label'
      }
    };
  },
  created() {},
  methods: {
    // 添加
    addSMS() {
      let smsTemplate = getSMSTemplate(this.form.templateCode);
      this.form.content = smsTemplate;
      apiSMS.add(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('添加成功', 'success');
          this.emitCloseDialog('close', 'showSMSEdit');
        }
      });
    },

    // 更新
    updateSMS() {
      let smsTemplate = getSMSTemplate(this.form.templateCode);
      this.form.content = smsTemplate;
      apiSMS.update(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('更新成功', 'success');
          this.emitCloseDialog('close', 'showSMSEdit');
        }
      });
    },

    // close(name){
    //   this.$emit('closeDialog',name)
    // },

    // 场景改变
    sencesChange(e) {
      let name = e.target.innerText;
      this.form.templateTypeName = name;
    },

    // 提交
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.id) {
            // 更新
            this.updateSMS();
          } else {
            // 新增
            this.addSMS();
          }
        } else {
          this.msg('验证失败');
          return false;
        }
      });
    }
  }
};
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
      span.name {
        display: block;
        box-sizing: border-box;
        float: left;
      }
      .name {
        width: 40%;
        text-align: right;
      }
      .code {
        width: 60%;
        color: $danger;
        padding-left: 10px;
      }
    
    }
  }
}
</style>
