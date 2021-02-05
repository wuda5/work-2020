<template>
  <div>
    <el-form
      ref="userForm"
      label-position="top"
      :model="form"
      :rules="rules"
      class="jh-text"
    >
      <el-form-item label="证明类型" prop="documentType">
        <el-select v-model="form.documentType" placeholder="">
          <el-option label="三证合一" :value="0"></el-option>
          <el-option label="企业营业执照" :value="1"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="证件">
        <el-upload
          :show-file-list="false"
          name="file"
          action=""
          :auto-upload="false"
          :on-change="getFile"
        >
          <el-button size="small" type="primary">选择证件</el-button>
          <span style="margin-left:10px">{{ form.fileName }}</span>
        </el-upload>
        <img class="width100" :src="imgSrc" />
      </el-form-item>

      <el-form-item label="签名内容" prop="signName">
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
          type="primary"
          class="width100"
          @click="submitForm('userForm')"
        >
          {{ $t("add") }}
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import apiSMS from '@/api/system/SMSConfig';
const defaultFormData = {
  documentType: '', // 证明类型：0：三证合一。 1：企业营业执照。
  picStr: '', // 证件
  international: 0, // 是否国际/港澳台短信： 0：表示国内短信。 1：表示国际/港澳台短信
  signName: '', // 签名内容
  signType: 0, // 签名类型 0：公司
  usedMethod: 1, // 签名用途： 0：自用。 1：他用。
  fileName: ''
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
        ? this.cloneFormData()
        : JSON.parse(JSON.stringify(defaultFormData)),
      rules: {
        documentType: [{ required: true, message: '必填', trigger: 'blur' }],
        signName: [{ required: true, message: '必填', trigger: 'blur' }]
      },
      imgSrc:''
    };
  },
  created() {},
  methods: {
    
    cloneFormData() {
      let data = JSON.parse(JSON.stringify(this.formData))
      data.fileName = ''
      return data 
    },

    // 添加
    addSgin() {
      apiSMS.signSave(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('添加成功', 'success');
          this.emitCloseDialog('close', 'showSign');
        }
      });
    },

    // 更新
    updateSgin() {
      apiSMS.signUpdate(this.form).then(res => {
        if (res.data.isSuccess) {
          this.msg('更新成功', 'success');
          this.emitCloseDialog('close', 'showSign');
        }
      });
    },

    // 提交
    submitForm(formName) {
      if (!this.form.picStr) {
        this.msg('请上传证件', 'error');
        return;
      }
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.id) {
            // 更新
            this.updateSgin();
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

    // 将上传图片转换成base64
    getBase64(file) {
      return new Promise(function(resolve, reject) {
        const reader = new FileReader();
        let imgResult = '';
        reader.readAsDataURL(file);
        reader.onload = function() {
          imgResult = reader.result;
        };
        reader.onerror = function(error) {
          reject(error);
        };
        reader.onloadend = function() {
          resolve(imgResult);
        };
      });
    },

    // 处理上传图片
    getFile(file, fileList) {
      this.form.fileName = file.name;
      this.getBase64(file.raw).then(res => {
        console.log(res);
        this.imgSrc = res
        let base64Img = res.replace('data:image/jpeg;base64,', '');
        this.form.picStr = base64Img;
        console.log('data:image/jpeg;base64,');
        console.log(base64Img);

      });
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
