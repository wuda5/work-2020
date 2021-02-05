<!--组织-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">组织管理</span>
      </div>
      <el-row :gutter="20">
        <el-col :sm="11" :xs="24">
          <el-card class="orgCard">
            <!-- head -->
            <div>
              <!-- search -->
              <search-box>
                <div slot="left">
                  <el-input v-model="label" :placeholder="$t('table.org.label')" />
                  <el-button type="primary" @click="search">{{ $t('table.search') }}</el-button>
                  <!-- 重置 -->
                  <el-button type="warning" @click="reset">{{ $t('table.reset') }}</el-button>
                </div>
                <div slot="right">
                  <!-- 添加 -->
                  <el-button
                    v-has-permission="['org:add']"
                    type="success"
                    @click="add"
                  >{{ $t('table.add') }}</el-button>
                  <!-- 删除 -->
                  <!--<el-button
                    v-has-permission="['org:delete']"
                    type="danger"
                    @click="deleteOrg"
                  >
                    {{ $t('table.delete') }}
                  </el-button>-->
                </div>
              </search-box>
            </div>
            <div class="clearfix"></div>
            <!-- orgTree -->
            <div class="treeBox">
              <el-tree
                ref="orgTree"
                :check-strictly="true"
                :data="orgTree"
                :filter-node-method="filterNode"
                default-expand-all
                highlight-current
                node-key="id"
                show-checkbox
                @node-click="nodeClick"
              />
            </div>
          </el-card>
        </el-col>

        <el-col :sm="13" :xs="24">
          <el-card v-show="org.parentId!==''" class="orgEditCard">
            <div slot="header" class="clearfix">
              <span>{{ org.id === '' ? this.$t('common.add') : this.$t('common.edit') }}</span>
            </div>
            <!-- 编辑表单 -->
            <div class="editForm">
              <el-form ref="form" :model="org" :rules="rules" label-position="top" class="jh-text">
                <!-- 上级组织ID -->
                <el-form-item v-show="false" :label="$t('table.org.parentId')" prop="parentId">
                  <el-tooltip
                    :content="$t('tips.topId')"
                    class="item"
                    effect="dark"
                    placement="top-start"
                  >
                    <el-input v-model="org.parentId" disabled readonly />
                  </el-tooltip>
                </el-form-item>

                <!-- 上级组织名称 -->
                <el-form-item :label="$t('table.org.parentName')">
                  <el-tooltip
                    :content="org.parentName"
                    class="item"
                    effect="dark"
                    placement="top-start"
                  >
                    <el-input v-model="org.parentName" disabled readonly />
                  </el-tooltip>
                </el-form-item>

                <!-- 组织名称 -->
                <el-form-item :label="$t('table.org.label')" prop="label">
                  <el-input v-model="org.label" />
                </el-form-item>

                <!-- 简称 -->
                <el-form-item :label="$t('table.org.abbreviation')" prop="abbrevi ati on">
                  <el-input v-model="org.abbreviation" />
                </el-form-item>

                <!-- 描述 -->
                <el-form-item :label="$t('table.org.describe')" prop="de scribe">
                  <el-input v-model="org.describe" />
                </el-form-item>

                <!-- 排序 -->
                <el-form-item :label="$t('table.org.sortValue')" prop="sortValue">
                  <el-input-number
                    v-model="org.sortValue"
                    :max="100"
                    :min="0"
                    @change="handleNumChange"
                  />
                </el-form-item>

                <!-- 组织状态（启用|禁止） -->
                <el-form-item :label="$t('table.org.status')" prop="status">
                  <el-radio-group v-model="org.status">
                    <el-radio-button :label="true">{{ $t('common.status.valid') }}</el-radio-button>
                    <el-radio-button :label="false">{{ $t('common.status.invalid') }}</el-radio-button>
                  </el-radio-group>
                </el-form-item>

                <!-- 是否是营业厅 -->
                <el-form-item :label="$t('table.org.isBusinessHall')" prop="status">
                  <!--
                  编辑：org.id.length>0 && !org.isBusinessHall

                  -->
                  <!--<el-radio-group v-model="org.isBusinessHall" :disabled="org.id.length>0 && !org.isBusinessHall">-->
                  <el-radio-group v-model="org.isBusinessHall" :disabled="org.id.length > 0">
                    <el-radio-button :label="1">{{ $t('common.yes') }}</el-radio-button>
                    <el-radio-button :label="0">{{ $t('common.no') }}</el-radio-button>
                  </el-radio-group>
                </el-form-item>

                <!-- 营业厅信息 -->

                <template v-if="org.isBusinessHall === 1">
                  <el-divider></el-divider>
                  <!-- 营业厅名 -->
                  <el-form-item
                    :label="$t('system.serviceHall.name')"
                    prop="hall.businessHallName"
                  >
                    <el-input disabled :value="org.label" />
                  </el-form-item>
                  <!-- 营业厅地址 -->
                  <el-form-item :label="$t('system.serviceHall.addr')" prop="businessHallAddress">
                    <el-input v-model="org.hall.businessHallAddress" name="businessHallAddress" />
                  </el-form-item>
                  <!-- 营业厅电话 -->
                  <el-form-item :label="$t('system.serviceHall.hallTel')" prop="businessHallPhone">
                    <el-input v-model="org.hall.businessHallPhone" name="businessHallPhone" />
                  </el-form-item>
                  <!-- 联系人 -->
                  <el-form-item :label="$t('system.serviceHall.contact')" prop="contacts">
                    <el-input v-model="org.hall.contacts" name="contacts" />
                  </el-form-item>
                  <!-- 联系人电话 -->
                  <el-form-item :label="$t('system.serviceHall.tel')" prop="telphone">
                    <el-input v-model="org.hall.telphone" name="telphone" />
                  </el-form-item>
                  <!-- 是否代理 -->
                  <el-form-item :label="$t('system.serviceHall.agency')" prop="isSale">
                    <el-radio-group v-model="org.hall.isSale">
                      <el-radio-button :label="1">{{ $t('common.yes') }}</el-radio-button>
                      <el-radio-button :label="0">{{ $t('common.no') }}</el-radio-button>
                    </el-radio-group>
                  </el-form-item>
                </template>
              </el-form>
            </div>

             <!-- 提交按钮 -->
          <el-button
            :loading="confirmLoading"
            type="primary"
            class="submitBtn"
            @click="submit"
          >{{ org.id === '' ? this.$t('common.add') : this.$t('common.edit') }}</el-button>
          </el-card>

        </el-col>
      </el-row>
    </el-card>

    <file-import
      ref="import"
      :dialog-visible="fileImport.isVisible"
      :type="fileImport.type"
      :action="fileImport.action"
      accept=".xls, .xlsx"
      @close="importClose"
      @success="importSuccess"
    />
    <el-dialog
      v-el-drag-dialog
      :close-on-click-modal="false"
      :close-on-press-escape="true"
      title="预览"
      width="80%"
      top="50px"
      :visible.sync="preview.isVisible"
    >
      <el-scrollbar>
        <div v-html="preview.context" />
      </el-scrollbar>
    </el-dialog>
  </div>
</template>
<script>
import orgApi from '@/api/Org.js'
import apiServiceHall from '@/api/system/serviceHall'
import elDragDialog from '@/directive/el-drag-dialog'
import FileImport from '@/components/gmis/Import'
import { downloadFile } from '@/utils/commons'
import { debounce } from '@/utils'

export default {
  name: 'OrgManager',
  directives: {
    elDragDialog,
  },
  components: {
    FileImport,
  },
  data() {
    return {
      confirmLoading: false,
      label: '',
      orgTree: [],
      org: this.initOrg(),
      preview: {
        isVisible: false,
        context: '',
      },
      fileImport: {
        isVisible: false,
        type: 'import',
        action: `${process.env.VUE_APP_BASE_API}/authority/org/import`,
      },
      rules: {
        // 组织名
        label: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
          {
            min: 3,
            max: 20,
            message: this.$t('rules.range3to20'),
            trigger: 'blur',
          },
        ],
      },
    }
  },
  watch: {
    'org.id': {
      handler(id, oldId) {
        if (id && this.org.isBusinessHall === 1) {
          // console.log('我是营业厅')
          this.getServiceHallInfoByID(id)
        } else {
          // console.log('不是')
        }
        // console.log(newName,oldName)
      },
      deep: true,
      immediate: true,
    },
  },
  mounted() {
    this.initOrgTree()
  },
  methods: {
    initOrg() {
      return {
        id: '',
        abbreviation: '',
        label: '',
        parentId: 0,
        parentName: '',
        status: true,
        describe: '',
        sortValue: 0,
        isBusinessHall: 0,

        hall: {
          orgId: '',
          orgName: '',
          businessHallName: '',
          businessHallAddress: '',
          businessHallPhone: '',
          contacts: '',
          telphone: '',
          isSale: 0,
        },
      }
    },
    initOrgTree() {
      orgApi.allTree({}).then(response => {
        const res = response.data
        this.orgTree = res.data
      })
    },
    exportExcelPreview() {
      const queryParams = {
        model: {},
        map: {
          fileName: '导出组织数据',
        },
        size: 10000,
      }
      orgApi.preview(queryParams).then(response => {
        const res = response.data
        this.preview.isVisible = true
        this.preview.context = res.data
      })
    },
    exportExcel() {
      const queryParams = {
        model: {},
        map: {
          fileName: '导出组织数据',
        },
        size: 10000,
      }
      orgApi.export(queryParams).then(response => {
        downloadFile(response)
      })
    },
    importExcel() {
      this.fileImport.type = 'upload'
      this.fileImport.isVisible = true
      this.$refs.import.setModel(false)
    },
    importSuccess() {
      this.initOrgTree()
    },
    importClose() {
      this.fileImport.isVisible = false
    },
    handleNumChange(val) {
      this.org.sortValue = val
    },
    filterNode(value, data) {
      if (!value) return true
      return data.label.indexOf(value) !== -1
    },
    nodeClick(data) {
      data.hall = {} //this.initOrg().hall
      this.org = {
        ...data,
      }

      this.$refs.form.clearValidate()
    },
    add() {
      this.resetForm()
      const checked = this.$refs.orgTree.getCheckedKeys()
      const checkedNodes = this.$refs.orgTree.getCheckedNodes()
      // 选择数大于1
      if (checked.length > 1) {
        this.org.parentId = ''
        this.$message({
          message: this.$t('tips.onlyChooseOne'),
          type: 'warning',
        })
      }
      // 一个的适合
      else if (checked.length === 1) {
        this.org.parentId = checked[0]
        this.org.parentName = checkedNodes[0].label

      } else if (checked.length === 0) {
        this.org.parentId = 0
      }
    },
    deleteOrg() {
      const checked = this.$refs.orgTree.getCheckedKeys()
      if (checked.length === 0) {
        this.$message({
          message: this.$t('tips.noNodeSelected'),
          type: 'warning',
        })
      } else {
        this.$confirm(this.$t('tips.confirmDeleteNode'), this.$t('common.tips'), {
          confirmButtonText: this.$t('common.confirm'),
          cancelButtonText: this.$t('common.cancel'),
          type: 'warning',
        })
          .then(() => {
            orgApi
              .delete({
                ids: checked,
              })
              .then(response => {
                const res = response.data
                if (res.isSuccess) {
                  this.$message({
                    message: this.$t('tips.deleteSuccess'),
                    type: 'success',
                  })
                }
                this.reset()
              })
          })
          .catch(() => {
            this.$refs.orgTree.setCheckedKeys([])
          })
      }
    },
    search() {
      this.$refs.orgTree.filter(this.label)
    },
    reset() {
      this.initOrgTree()
      this.label = ''
      this.resetForm()
    },

    // 表单提交
    submit: debounce(function() {
      this.$refs.form.validate(valid => {
        if (valid) {
          // 处理提交时的数据
          this.org.hall.orgId = this.org.id
          this.org.hall.orgName = this.org.label
          this.org.hall.businessHallName = this.org.label
          this.confirmLoading = true
          if (this.org.id) {
            this.update()
          } else {
            this.save()
          }
        } else {
          return false
        }
      })
    }, 300),

    // 添加营业厅
    addServiceHall() {
      apiServiceHall.add(this.org.hall).then(res => {

        if (res.data.isSuccess) {
          this.reset()
          // this.msg('营业添加成功', 'success')
        }
      })
    },

    // 更新营业厅
    updateServiceHall() {
      apiServiceHall.update(this.org.hall).then(res => {
        if (res.data.isSuccess) {
          this.reset()
          this.msg('营业更新成功', 'success')
        }
      })
    },

    // 根据orgID获取营业厅信息
    getServiceHallInfoByID(id) {
      apiServiceHall.getById(id).then(res => {
        // ★★★ 这个地方直接给org添加hall无法监听数据，故在点击组织的地方内置了默认空数据
        this.org.hall = res.data
      })
    },

    // 保存组织
    save() {
      orgApi
        .save({
          ...this.org,
        })
        .then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.$message({
              message: this.$t('tips.createSuccess'),
              type: 'success',
            })
            let id = res.data.id
            this.org.hall.orgId = id

            this.org.hall.businessHallName = this.org.label

            // 如果是营业厅，还需提交营业厅信息
            if (this.org.isBusinessHall === 1) {
              this.addServiceHall()
            }

            this.reset()
          }

          // this.reset();
        }).finally(() => {
        this.confirmLoading = false
      })
    },

    // 更新组织
    update() {
      orgApi
        .update({
          ...this.org,
        })
        .then(response => {
          const res = response.data
          if (res.isSuccess) {
            this.$message({
              message: this.$t('tips.updateSuccess'),
              type: 'success',
            })

            // 如果是营业厅，还需提交营业厅信息
            if (this.org.isBusinessHall === 1) {
              this.updateServiceHall()
            }
             this.reset()
          }
        }).finally(() => {
        this.confirmLoading = false
      })
    },

    // 重置表单
    resetForm() {
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.org = this.initOrg()
    },
  },
}
</script>
<style lang="scss" scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 3);
      margin-bottom: 15px;
    }

    .el-input-number {
      width: 100% !important;
    }
  }

  // left
  .orgCard {
    ::v-deep .el-card__body {
      padding: 0 !important;
    }

    .treeBox {
      height: calc(100vh - 230px);
      border: 1px solid #eee;
      margin: 15px 0 0;
      overflow-y: scroll;
      border-radius: 3px;
    }
  }

  // right
  .orgEditCard {
    ::v-deep .el-card__body {
      padding: 0 !important;
    }

    .editForm {
      border: 1px solid #eee;
      margin: 15px 0 0;
      padding: 0 15px;
      overflow-y: scroll;
      border-radius: 3px;
    }
  }

  .submitBtn {
    width: 150px;
    float: right;
    margin-top: 20px;
  }

  .el-card.is-always-shadow {
    box-shadow: none;
  }

  .el-card {
    border: none;
  }
</style>
