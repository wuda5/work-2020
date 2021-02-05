<template>
  <el-dialog :close-on-click-modal="false" :close-on-press-escape="true" :title="title" :type="type"
             :visible.sync="isVisible" :width="width" top="50px" v-el-drag-dialog>
    <el-form :model="commonLang" :rules="rules" label-position="right" label-width="100px" ref="form">
      <el-form-item :label="$t('键')" prop="langKey">
        <el-input type="" v-model="commonLang.langKey" placeholder=""/>
      </el-form-item>
      <el-form-item :label="$t('值')" prop="langValue">
        <el-input type="" v-model="commonLang.langValue" placeholder=""/>
      </el-form-item>
      <el-form-item :label="$t('语言类型')" prop="langType">
        <el-select v-model="langSelect" @change="currentLang">
          <el-option
            v-for="item in langOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item :label="$t('数据类型')" prop="dataType">
        <el-select v-model="dataSelect" @change="currentData">
          <el-option
            v-for="item in dataOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <div class="dialog-footer" slot="footer">
      <el-button @click="isVisible = false" plain type="warning">
        {{ $t("common.cancel") }}
      </el-button>
      <el-button @click="submitForm" :disabled="confirmDisabled" plain type="primary">
        {{ $t("common.confirm") }}
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
import elDragDialog from '@/directive/el-drag-dialog'
import commonLangApi from "@/api/CommonLang.js";

export default {
  name: "CommonLangEdit",
  directives: { elDragDialog },
  components: {  },
  props: {
    dialogVisible: {
      type: Boolean,
      default: false
    },
    type: {
      type: String,
      default: "add"
    }
  },
  data() {
    return {
      confirmDisabled: false,
      commonLang: this.initCommonLang(),
      screenWidth: 0,
      width: this.initWidth(),
      rules: {

      },
      langOptions: [{
        value: '1',
        label: '简体中文'
      }, {
        value: '2',
        label: 'English'
      }],
      langSelect: '简体中文',
      dataOptions: [{
        value: '0',
        label: '通知消息'
      }, {
        value: '1',
        label: '菜单'
      }, {
        value: '2',
        label: '其他'
      }],
      dataSelect: '通知消息',
      // 枚举
      enums: {
      },
      // 字典
      dicts: {
      }
    };
  },
  computed: {
    isVisible: {
      get() {
        return this.dialogVisible;
      },
      set() {
        this.close();
        this.reset();
      }
    },
    title() {
      return this.$t("common." + this.type);
    }
  },
  watch: {},
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth();
      })();
    };
  },
  methods: {
    initCommonLang() {
      return {
        id: "",
        langKey: '',
        langValue: '',
        langType: 1,
        dataType: 0,
      }
    },
    initWidth() {
      this.screenWidth = document.body.clientWidth;
      if (this.screenWidth < 991) {
        return "90%";
      } else if (this.screenWidth < 1400) {
        return "45%";
      } else {
        return "800px";
      }
    },
    setCommonLang(val = {}) {
      const vm = this;

      vm.dicts = val['dicts'];
      vm.enums = val['enums'];
      if (val['row']) {
        vm.commonLang = { ...val['row'] };
        if (this.commonLang.langType === 1) {
          this.langSelect = '简体中文'
        }
        if (this.commonLang.langType === 2) {
          this.langSelect = 'English'
        }
        if (this.commonLang.dataType === 0) {
          this.dataSelect = '通知消息'
        }
        if (this.commonLang.dataType === 1) {
          this.dataSelect = '菜单'
        }
        if (this.commonLang.dataType === 2) {
          this.dataSelect = '其他'
        }
      }
    },
    currentLang(selVal) {
      let obj = {}
      obj = this.langOptions.find((item)=>{ //这里的selectList就是上面遍历的数据源
        return item.value === selVal //筛选出匹配数据
      })
      this.commonLang.langType = obj.value
      this.langSelect = obj.label
    },
    currentData(selVal) {
      let objData = {}
      objData = this.dataOptions.find((item)=>{ //这里的selectList就是上面遍历的数据源
        return item.value === selVal //筛选出匹配数据
      })
      this.commonLang.dataType = objData.value
      this.dataSelect = objData.label
    },
    close() {
      this.$emit("close");
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate();
      this.$refs.form.resetFields();
      this.confirmDisabled = false;
      this.commonLang = this.initCommonLang();
    },
    submitForm() {
      const vm = this;
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.editSubmit();
        } else {
          return false;
        }
      });
    },
    editSubmit() {
      const vm = this;
      if (vm.type === "edit") {
          vm.update();
      } else {
          vm.save();
      }
    },
    save() {
      const vm = this;
      vm.confirmDisabled = true;
      commonLangApi.save(this.commonLang).then(response => {
        const res = response.data;
        if (res.isSuccess) {
          vm.isVisible = false;
          vm.$message({
            message: vm.$t("tips.createSuccess"),
            type: "success"
          });
          vm.$emit("success");
        }
      }).finally(()=> vm.confirmDisabled = false);
    },
    update() {
      const vm = this;
      vm.confirmDisabled = true;
      commonLangApi.update(this.commonLang).then(response => {
        const res = response.data;
        if (res.isSuccess) {
          vm.isVisible = false;
          vm.$message({
            message: this.$t("tips.updateSuccess"),
            type: "success"
          });
          vm.$emit("success");
        }
      }).finally(()=> vm.confirmDisabled = false);
    }
  }
};
</script>
<style lang="scss" scoped></style>
