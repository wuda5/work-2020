<template>
  <div>
    <el-form :model="form" :rules="rules" ref="templateEdit">
      <el-form-item hidden label="模板类型id">
        <el-input disabled :value="form.templateTypeId"></el-input>
      </el-form-item>
      <el-form-item hidden label="模板编码">
        <el-input disabled :value="form.templateCode"></el-input>
      </el-form-item>
      <el-form-item label="模板名" prop="templateTitle">
        <el-input v-model="form.templateTitle" placeholder="模板名"></el-input>
      </el-form-item>

      <el-form-item label="模板内容" prop="itemContent">
        <el-button style="display: block" type="primary" @click="design">设计模板</el-button>
        <el-input
          v-model="form.itemContent"
          class="textarea"
          type="textarea"
          :rows="10"
          placeholder="模板内容"
        ></el-input>
      </el-form-item>
      <el-form-item label="模板描述">
        <el-input v-model="form.itemDescribe" placeholder="模板描述"></el-input>
      </el-form-item>

      <el-button v-if="editInfo.type === 'add'" class="fr" type="success" @click="handleSubmit">新增模板</el-button>
      <el-button v-if="editInfo.type === 'edit'" class="fr" type="success" @click="handleSubmit">{{
          editInfo.itemStatus === 0 ? '更新模板' : '保存到我的模板库'
        }}
      </el-button>
    </el-form>
  </div>
</template>

<script>
import apiPrintTemplate from '@/api/system/printTemplate.js'
import {getLodop} from '@/utils/LodopFuncs.js'
import {upMoney} from '@/utils/print/print.js'
import printTestData from '@/utils/print/printTestData.js';

let LODOP
export default {
  name: 'templateEdit',
  props: {
    editInfo: {
      type: Object,
    },
  },
  data() {
    return {
      form: {
        templateTypeId: this.editInfo.templateTypeId, // 模板类型id
        templateCode: this.editInfo.templateCode, // 模板编码
        templateTitle: this.editInfo.templateTitle, // 模板名称
        itemContent: this.editInfo.itemContent, // 模板内容
        itemDescribe: '', // 模板描述
        id: this.editInfo.id,
      },
      rules: {
        templateTitle: [
          {required: true, message: this.$t('rules.require'), trigger: 'blur'},
        ],
        itemContent: [
          {required: true, message: this.$t('rules.require'), trigger: 'blur'},
        ]
      }
    }
  },
  created() {
  },
  computed: {
    // title: ()=> {
    //   if (this)
    //   //
    // }
  },
  methods: {
    design() {
      let LODOP = getLodop()
      LODOP.PRINT_INIT('打印控件Lodop功能演示_多页预览')
      LODOP.SET_PRINT_PAGESIZE(1, '297mm', '210mm', '')
      let data = printTestData[this.editInfo.templateCode]
      eval(this.form.itemContent)
      LODOP.PRINT_DESIGN()

      if (LODOP.CVERSION) {
        LODOP.On_Return = (TaskID, Value) => {
          // !保存完成要做的事情
          this.form.itemContent = Value
          // console.log(this.$refs.textarea.value)
          // alert(Value)
        }
      }
    },

    // 提交
    handleSubmit() {
      this.$refs['templateEdit'].validate((valid) => {
        if (valid) {
          // 添加
          if (this.editInfo.type === 'add') {
            this.save()
          }

          // 更新
          if (this.editInfo.type === 'edit') {
            this.submit()
          }
        } else {
          return false
        }
      })
    },

    // 保存模板
    save() {
      this.form.itemStatus = 0
      this.form.itemContent = this.form.itemContent
        .replace(/body/g, 'QcBody')
        .replace(/script/g, 'QcScript')
      apiPrintTemplate.addNewTemplate(this.form).then(res => {
        let {isSuccess, data} = res.data
        if (isSuccess) {
          this.msg('新增成功', 'success')
          this.emitClose()
        }
      })
    },

    // 更新模板
    update() {
      let thisForm = JSON.parse(JSON.stringify(this.form))

      thisForm.dataStatus = -2
      thisForm.itemContent = thisForm.itemContent
        .replace(/body/g, 'QcBody')
        .replace(/script/g, 'QcScript')
      apiPrintTemplate.update(thisForm).then(res => {
        let {isSuccess, data} = res.data
        if (isSuccess) {
          this.msg('更新成功', 'success')
          this.emitClose()
        }
      })
    },

    // 修改提交
    submit() {
      // 自定义模板 修改
      if (this.editInfo.itemStatus === 0) {
        this.update()
      }
      // 公共模板 保存为自定义模板
      else {
        this.form.itemStatus = 0
        this.save()
      }
    },

    emitClose() {
      this.$emit('close')
    },
  },
}
</script>

<style lang="scss" scoped>
.el-form {
  overflow: hidden;
}

.textarea {
  padding-top: 10px;
}
</style>
