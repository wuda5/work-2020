<template>
  <div class="org">
    <el-row :gutter="10">
      <el-col
        :sm="12"
        :xs="24"
      >
        <div class="app-container">
          <div class="filter-container">
            <el-input
              v-model="label"
              :placeholder="$t('table.org.label')"
              class="filter-item search-item"
            />
            <el-button
              class="filter-item"
              plain
              type="primary"
              @click="search"
            >
              {{ $t('table.search') }}
            </el-button>
            <el-button
              class="filter-item"
              plain
              type="warning"
              @click="reset"
            >
              {{ $t('table.reset') }}
            </el-button>
            <el-button
              v-has-permission="['org:add']"
              class="filter-item"
              plain
              type="danger"
              @click="add"
            >
              {{
                $t("table.add") }}
            </el-button>
            <el-dropdown
              v-has-any-permission="['org:delete','org:export', 'org:import']"
              class="filter-item"
              trigger="click"
            >
              <el-button>
                {{ $t('table.more') }}
                <i class="el-icon-arrow-down el-icon--right" />
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item
                  v-has-permission="['org:delete']"
                  @click.native="deleteOrg"
                >
                  {{ $t('table.delete') }}
                </el-dropdown-item>
                <el-dropdown-item
                  v-has-permission="['org:export']"
                  @click.native="exportExcel"
                >
                  {{ $t("table.export") }}
                </el-dropdown-item>
                <el-dropdown-item
                  v-has-permission="['org:export']"
                  @click.native="exportExcelPreview"
                >
                  {{ $t("table.exportPreview") }}
                </el-dropdown-item>
                <el-dropdown-item
                  v-has-permission="['org:import']"
                  @click.native="importExcel"
                >
                  {{ $t("table.import") }}
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
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
      </el-col>
      <el-col
        :sm="12"
        :xs="24"
      >
        <el-card class="box-card">
          <div
            slot="header"
            class="clearfix"
          >
            <span>{{ org.id === '' ? this.$t('common.add') : this.$t('common.edit') }}</span>
          </div>
          <div>
            <el-form
              ref="form"
              :model="org"
              :rules="rules"
              label-position="right"
              label-width="100px"
            >
              <el-form-item
                :label="$t('table.org.parentId')"
                prop="parentId"
              >
                <el-tooltip
                  :content="$t('tips.topId')"
                  class="item"
                  effect="dark"
                  placement="top-start"
                >
                  <el-input
                    v-model="org.parentId"
                    readonly
                  />
                </el-tooltip>
              </el-form-item>
              <el-form-item
                :label="$t('table.org.label')"
                prop="label"
              >
                <el-input v-model="org.label" />
              </el-form-item>
              <el-form-item
                :label="$t('table.org.abbreviation')"
                prop="abbreviation"
              >
                <el-input v-model="org.abbreviation" />
              </el-form-item>
              <el-form-item
                :label="$t('table.org.describe')"
                prop="describe"
              >
                <el-input v-model="org.describe" />
              </el-form-item>
              <el-form-item
                :label="$t('table.org.status')"
                prop="status"
              >
                <el-radio-group v-model="org.status">
                  <el-radio :label="true">
                    {{ $t('common.status.valid') }}
                  </el-radio>
                  <el-radio :label="false">
                    {{ $t('common.status.invalid') }}
                  </el-radio>
                </el-radio-group>
              </el-form-item>
              <el-form-item
                :label="$t('table.org.isBusinessHall')"
                prop="status"
              >
                <el-radio-group v-model="org.isBusinessHall">
                  <el-radio :label="1">
                    {{ $t('common.yes') }}
                  </el-radio>
                  <el-radio :label="0">
                    {{ $t('common.no') }}
                  </el-radio>
                </el-radio-group>
              </el-form-item>
              <el-form-item
                :label="$t('table.org.sortValue')"
                prop="sortValue"
              >
                <el-input-number
                  v-model="org.sortValue"
                  :max="100"
                  :min="0"
                  @change="handleNumChange"
                />
              </el-form-item>
            </el-form>
          </div>
        </el-card>
        <el-card
          class="box-card"
          style="margin-top: -2rem;"
        >
          <el-row>
            <el-col
              :span="24"
              style="text-align: right"
            >
              <el-button
                plain
                type="primary"
                @click="submit"
              >
                {{ org.id === '' ? this.$t('common.add') :
                  this.$t('common.edit') }}
              </el-button>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>

    <file-import
      ref="import"
      :dialog-visible="fileImport.isVisible"
      :type="fileImport.type"
      :action="fileImport.action"
      accept=".xls,.xlsx"
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
  import elDragDialog from '@/directive/el-drag-dialog'
  import FileImport from '@/components/gmis/Import'
  import {downloadFile} from '@/utils/commons'

  export default {
    name: 'OrgManager',
    directives: {elDragDialog},
    components: {FileImport},
    data() {
      return {
        label: '',
        orgTree: [],
        org: this.initOrg(),
        isBusinessHall: '0',
        preview: {
          isVisible: false,
          context: ''
        },
        fileImport: {
          isVisible: false,
          type: 'import',
          action: `${process.env.VUE_APP_BASE_API}/authority/org/import`
        },
        rules: {
          label: [
            {required: true, message: this.$t('rules.require'), trigger: 'blur'},
            {min: 1, max: 255, message: this.$t('rules.range3to10'), trigger: 'blur'}
          ]
        }
      }
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
          status: true,
          describe: '',
          sortValue: 0
        }
      },
      initOrgTree() {
        orgApi.allTree({})
          .then((response) => {
            const res = response.data
            this.orgTree = res.data
          })
      },
      exportExcelPreview() {
        const queryParams = {
          model: {},
          map: {
            fileName: '导出组织数据'
          },
          size: 10000
        };
        orgApi.preview(queryParams).then(response => {
          const res = response.data;
          this.preview.isVisible = true;
          this.preview.context = res.data;
        });
      },
      exportExcel() {
        const queryParams = {
          model: {},
          map: {
            fileName: '导出组织数据'
          },
          size: 10000
        };
        orgApi.export(queryParams).then(response => {
          downloadFile(response);
        });
      },
      importExcel() {
        this.fileImport.type = 'upload';
        this.fileImport.isVisible = true;
        this.$refs.import.setModel(false);
      },
      importSuccess() {
        this.initOrgTree();
      },
      importClose() {
        this.fileImport.isVisible = false;
      },
      handleNumChange(val) {
        this.org.sortValue = val
      },
      filterNode(value, data) {
        if (!value) return true
        return data.label.indexOf(value) !== -1
      },
      nodeClick(data) {
        this.org = {...data}
        this.$refs.form.clearValidate()
      }
      ,
      add() {
        this.resetForm()
        const checked = this.$refs.orgTree.getCheckedKeys()
        if (checked.length > 1) {
          this.$message({
            message: this.$t('tips.onlyChooseOne'),
            type: 'warning'
          })
        } else if (checked.length > 0) {
          this.org.parentId = checked[0]
        } else {
          this.org.parentId = 0
        }
      },
      deleteOrg() {
        const checked = this.$refs.orgTree.getCheckedKeys()
        if (checked.length === 0) {
          this.$message({
            message: this.$t('tips.noNodeSelected'),
            type: 'warning'
          })
        } else {
          this.$confirm(this.$t('tips.confirmDeleteNode'), this.$t('common.tips'), {
            confirmButtonText: this.$t('common.confirm'),
            cancelButtonText: this.$t('common.cancel'),
            type: 'warning'
          }).then(() => {
            orgApi.delete({ids: checked})
              .then((response) => {
                const res = response.data
                if (res.isSuccess) {
                  this.$message({
                    message: this.$t('tips.deleteSuccess'),
                    type: 'success'
                  })
                }
                this.reset()
              })
          }).catch(() => {
            this.$refs.orgTree.setCheckedKeys([])
          })
        }
      }
      ,
      search() {
        this.$refs.orgTree.filter(this.label)
      }
      ,
      reset() {
        this.initOrgTree()
        this.label = ''
        this.resetForm()
      }
      ,
      submit() {
        this.$refs.form.validate((valid) => {
          if (valid) {
            if (this.org.id) {
              this.update()
            } else {
              this.save()
            }
          } else {
            return false
          }
        })
      }
      ,
      save() {
        orgApi.save({...this.org})
          .then((response) => {
            const res = response.data
            if (res.isSuccess) {
              this.$message({
                message: this.$t('tips.createSuccess'),
                type: 'success'
              })
            }

            this.reset()
          })
      }
      ,
      update() {
        orgApi.update({...this.org})
          .then((response) => {
            const res = response.data
            if (res.isSuccess) {
              this.$message({
                message: this.$t('tips.updateSuccess'),
                type: 'success'
              })
            }
            this.reset()
          })
      }
      ,
      resetForm() {
        this.$refs.form.clearValidate()
        this.$refs.form.resetFields()
        this.org = this.initOrg()
      }
    }
  }
</script>
<style lang="scss" scoped>
    .org {
        margin: 10px;

        .app-container {
            margin: 0 0 10px 0 !important;
        }
    }

    .el-card.is-always-shadow {
        box-shadow: none;
    }

    .el-card {
        border-radius: 0;
        border: none;

        .el-card__header {
            padding: 10px 20px !important;
            border-bottom: 1px solid #f1f1f1 !important;
        }
    }
</style>
