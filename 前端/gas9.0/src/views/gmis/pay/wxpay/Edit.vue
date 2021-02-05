<template>
  <el-dialog :close-on-click-modal="false" :close-on-press-escape="true" :title="title" :type="type"
             :visible.sync="isVisible" :width="width" top="50px" v-el-drag-dialog>
    <el-form :model="wxPay" :rules="rules" label-position="right" label-width="100px" ref="form">
      <el-form-item :label="$t('table.wxPay.payNotes')" prop="payNotes">
        <el-input type="" v-model="wxPay.payNotes" placeholder="支付备注"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.pay')" prop="pay">
        <el-input type="" v-model="wxPay.pay" placeholder="支付金额"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.payOpenid')" prop="payOpenid">
        <el-input type="" v-model="wxPay.payOpenid" placeholder="支付人唯一标识"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.payState')" prop="payState">
        <el-input type="" v-model="wxPay.payState" placeholder="支付状态（1：已支付，0：待支付）"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.payTime')" prop="payTime">
        <el-date-picker
          v-model="wxPay.payTime"
          placeholder="支付时间"
          :start-placeholder="$t('table.wxPay.payTime')"
          value-format="yyyy-MM-dd HH:mm:ss"
          format="yyyy-MM-dd HH:mm:ss"
          class="filter-item date-range-item"
          type="datetime"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.notify')" prop="notify">
        <el-input type="" v-model="wxPay.notify" placeholder="通知(1:已通知,0:未通知)"/>
      </el-form-item>
      <el-form-item :label="$t('table.wxPay.notifyConten')" prop="notifyConten">
        <el-input type="" v-model="wxPay.notifyConten" placeholder="通知内容"/>
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
import wxPayApi from "@/api/WxPay.js";

export default {
  name: "WxPayEdit",
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
      wxPay: this.initWxPay(),
      screenWidth: 0,
      width: this.initWidth(),
      rules: {

      },
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
    initWxPay() {
      return {
        id: "",
        payNotes: '',
        pay: null,
        payOpenid: '',
        payState: null,
        payTime: null,
        notify: null,
        notifyConten: '',
      };
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
    setWxPay(val = {}) {
      const vm = this;

      vm.dicts = val['dicts'];
      vm.enums = val['enums'];
      if (val['row']) {
        vm.wxPay = { ...val['row'] };

      }
    },
    close() {
      this.$emit("close");
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate();
      this.$refs.form.resetFields();
      this.confirmDisabled = false;
      this.wxPay = this.initWxPay();
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
      wxPayApi.save(this.wxPay).then(response => {
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
      wxPayApi.update(this.wxPay).then(response => {
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
