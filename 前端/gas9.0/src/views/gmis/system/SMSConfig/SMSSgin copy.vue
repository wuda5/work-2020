<template>
  <el-form
    ref="userForm"
    label-position="top"
    :model="form"
    :rules="rules"
    class="jh-text"
    enctype="multipart/form-data"
  >
    <el-form-item label="证明类型" prop="documentType">
      <el-select v-model="form.documentType" placeholder="">
        <el-option label="三证合一" :value="0"></el-option>
        <el-option label="企业营业执照" :value="1"></el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="证件" prop="documentType">
      <input type="file" placeholder="" />
    </el-form-item>

    <el-form-item label="签名内容" prop="documentType">
      <el-input v-model="form.signName" placeholder=""></el-input>
    </el-form-item>

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
const defaultFormData = {
  documentType: '', // 证明类型：0：三证合一。 1：企业营业执照。
  file: '', // 证件
  international: 0, // 是否国际/港澳台短信： 0：表示国内短信。 1：表示国际/港澳台短信
  signName: '', // 签名内容
  signType: 0, // 签名类型 0：公司
  usedMethod: 1 // 签名用途： 0：自用。 1：他用。
};
export default {
  name: 'SMSSgin',
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
      }
    };
  },
  created() {},
  methods: {
    // 添加
    addSgin() {
      apiSMS.signSave(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('添加成功', 'success');
          this.emitCloseDialog('close', 'showSMSEdit');
        }
      });
    },

    // 更新
    updateSgin() {
      apiSMS.signUpdate(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('更新成功', 'success');
          this.emitCloseDialog('close', 'showSMSEdit');
        }
      });
    },

    // 更新
    updateSgin1() {
      this.$post('/bizcenter/msgs/sms/sign/update11', this.form, {
        headers: { 'Content-Type': 'multipart/form-data' }
      }).then(res => {
        console.log(res);
      });
    },

    // 提交
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.id) {
            // 更新
            this.updateSgin1();
          } else {
            // 新增
            this.addSgin();
          }
        } else {
          this.msg('验证失败');
          return false;
        }
      });
    },

    //
    inputUpload(e) {
      console.log(e);
    }
  }
};
</script>

<style lang="scss" scoped>
.jh-text {
  .el-form-item {
    width: 100%;
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
