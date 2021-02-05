<template>
  <el-dialog
    :close-on-click-modal="false"
    :close-on-press-escape="true"
    :title="title"
    :type="type"
    :visible.sync="isVisible"
    :width="width"
    top="50px"
  >
    <!--表单-->
    <el-form ref="form" :model="user" :rules="rules" label-position="right" label-width="100px">
      <!--账号-->
      <el-form-item :label="$t('table.user.account')" prop="account">
        <el-input v-model="user.account" :disabled="type === 'add' ? false : true" />
      </el-form-item>
      <!--姓名-->
      <el-form-item :label="$t('table.user.name')" prop="name">
        <el-input v-model="user.name" />
      </el-form-item>

      <!--密码-->
      <el-form-item :label="$t('table.user.password')" prop="password">
        <el-tooltip
          :content="$t('tips.defaultPassword')"
          class="item"
          effect="dark"
          placement="top-start"
        >
          <el-input v-model="user.password" type="password" />
        </el-tooltip>
      </el-form-item>

      <!--重复密码-->
      <el-form-item :label="$t('table.user.rePwd')" prop="rePwd">
        <el-input v-model="user.rePwd" type="password" />
      </el-form-item>
      <!--头像-->
      <el-form-item :label="$t('table.user.avatar')" prop="avatar">
        <imgUpload
          ref="imgFileRef"
          :accept="accept"
          :accept-size="2 * 1024 * 1024"
          :auto-upload="true"
          :data="user.avatar"
          :file-list="imgFileList"
          :show-file-list="false"
          list-type="picture-card"
          @setId="setIdAndSubmit"
        >
          <i class="el-icon-plus" />
        </imgUpload>
      </el-form-item>
      <!--组织ID-->
      <!-- :options="recursiveFunction(orgList)" -->
      <!-- :options="formatOrgList(orgList)" -->
      <el-form-item :label="$t('table.user.orgId')" prop="org.key">
        <treeselect
          v-model="user.org.key"
          :clear-value-text="$t('common.clear')"
          :load-options="loadListOptions"
          :multiple="false"
          :options="recursiveFunction(orgList)"
          :searchable="true"
          placeholder=" "
          no-results-text="无查询结果"
          style="width:100%"
        />
      </el-form-item>
      <!--岗位-->
      <el-form-item :label="$t('table.user.stationId')" prop="station.key">
        <el-select
          v-model="user.station.key"
          :loading="remoteStationLoading"
          :multiple="false"
          
          filterable
          placeholder="请输入关键词"
        >
          <el-option
            v-for="item in stationList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <!--邮箱-->
      <el-form-item :label="$t('table.user.email')" prop="email">
        <el-input v-model="user.email" />
      </el-form-item>
      <!--手机-->
      <el-form-item :label="$t('table.user.mobile')" prop="mobile">
        <el-input v-model="user.mobile" />
      </el-form-item>
      <!--性别-->
      <el-form-item :label="$t('table.user.sex')" prop="sex">
        <el-select v-model="user.sex.code" placeholder style="width:100%" value>
          <el-option v-for="item in dict.SEX" :key="item.id" :label="item.name" :value="item.code" />
        </el-select>
      </el-form-item>
      <!--民族-->
      <el-form-item :label="$t('table.user.nation')" prop="nation">
        <el-select
          v-model="user.nation.key"
          style="width:100%"
          :placeholder="$t('table.user.nation')"
          value
        >
          <el-option
            v-for="(item, key, index) in dicts.NATION"
            :key="index"
            :label="item"
            :value="key"
          />
        </el-select>
      </el-form-item>
      <!--学历-->
      <el-form-item :label="$t('table.user.education')" prop="education">
        <el-select
          v-model="user.education.key"
          style="width:100%"
          :placeholder="$t('table.user.education')"
          value
        >
          <el-option
            v-for="(item, key, index) in dicts.EDUCATION"
            :key="index"
            :label="item"
            :value="key"
          />
        </el-select>
      </el-form-item>
      <!--职位转态-->
      <el-form-item :label="$t('table.user.positionStatus')" prop="positionStatus">
        <el-select
          v-model="user.positionStatus.key"
          style="width:100%"
          :placeholder="$t('table.user.positionStatus')"
          value
        >
          <el-option
            v-for="(item, key, index) in dicts.POSITION_STATUS"
            :key="index"
            :label="item"
            :value="key"
          />
        </el-select>
      </el-form-item>
      <!--状态-->
      <el-form-item :label="$t('table.user.status')" prop="status">
        <el-radio-group v-model="user.status">
          <el-radio :label="true">{{ $t('common.status.valid') }}</el-radio>
          <el-radio :label="false">{{ $t('common.status.invalid') }}</el-radio>
        </el-radio-group>
      </el-form-item>
      <!--个人描述-->
      <el-form-item :label="$t('table.user.workDescribe')" prop="workDescribe">
        <el-input v-model="user.workDescribe" />
      </el-form-item>
    </el-form>
    <!--底部操作-->
    <div slot="footer" class="dialog-footer">
      <el-button type="warning" @click="isVisible = false">{{ $t('common.cancel') }}</el-button>
      <el-button :loading="confirmLoading" type="primary" @click="submitForm">{{ $t('common.confirm') }}</el-button>
    </div>
  </el-dialog>
</template>
<script>
import { numberAndLetterAndUnderscoreReg } from '@/utils/reg'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import imgUpload from '@/components/gmis/imgUpload'
import userApi from '@/api/User.js'
import stationApi from '@/api/Station.js'
import { checkPhone } from '@/utils/commons';
import { debounce } from '@/utils'

export default {
  name: 'UserEdit',
  components: { Treeselect, imgUpload },
  props: {
    dialogVisible: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: 'add',
    },
  },
  data() {
    /*验证用户密码*/
    var validatePass = (rule, value, callback) => {
      if (this.type === 'edit') {
        callback()
      } else {
        if (value === '') {
          callback(new Error('请输入密码'))
        } else {
          callback()
        }
      }
    }
    /*确认密码*/
    var validatePass2 = (rule, value, callback) => {
      if (this.type === 'edit') {
        if (this.user.password) {
          if (value === '') {
            callback(new Error('请再次输入密码'))
          } else if (value !== this.user.password) {
            callback(new Error('两次输入密码不一致!'))
          } else {
            callback()
          }
        }
        callback()
      } else {
        if (value === '') {
          callback(new Error('请再次输入密码'))
        } else if (value !== this.user.password) {
          callback(new Error('两次输入密码不一致!'))
        } else {
          callback()
        }
      }
    }

    /* 校验账户是否重复 */
    var accountCheck = (rule, value, callback) => {
      if (!numberAndLetterAndUnderscoreReg.test(value)) {
        callback('账户只能包含字母数字及下划线')
        return
      }
      if (this.type === 'edit') {
        callback()
        return
      }
      userApi.accountCheck({ account: value }).then(res => {
        let { isSuccess, data, msg } = res.data
        console.log({ res })
        console.log({ isSuccess, data, msg })
        if (isSuccess) {
          if (data) {
            callback('账户已存在')
          }
          callback()
        }
      })
    }

    let domain = window.location.hostname
    let protocol = window.location.protocol

    return {
      accept: 'image/jpeg, image/gif, image/png',
      confirmLoading: false,
      remoteStationLoading: false,
      user: this.initUser(),
      screenWidth: 0,
      width: this.initWidth(),
      orgList: [
        {
          id: '100',
          createTime: '2019-07-10 17:02:18',
          createUser: '1',
          updateTime: '2019-07-10 17:02:16',
          updateUser: '1',
          label: '秦川集团股份有限公司',
          parentId: '0',
          parentName: null,
          sortValue: 1,
          children: [
            {
              id: '101',
              createTime: '2019-08-06 09:10:53',
              createUser: '1',
              updateTime: '2019-11-12 11:36:48',
              updateUser: '3',
              label: '秦川集团股份有限公司广州子公司',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 0,
              children: [
                {
                  id: '1298137751668916224',
                  createTime: '2020-08-25 13:58:53',
                  createUser: '3',
                  updateTime: '2020-08-25 13:58:53',
                  updateUser: '3',
                  label: '管理服务平台',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 3,
                  children: '',
                  abbreviation: 'GLFWPT',
                  treePath: ',100,101,',
                  status: true,
                  describe: '管理服务平台',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '1300746839544299520',
                  createTime: '2020-09-01 18:46:28',
                  createUser: '3',
                  updateTime: '2020-09-08 10:31:38',
                  updateUser: '3',
                  label: '国际部',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 0,
                  children: [],
                  abbreviation: 'GJB',
                  treePath: ',100,101,',
                  status: true,
                  describe: 'GJB',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 1,
                },
                {
                  id: '1303899834289225728',
                  createTime: '2020-09-10 11:35:20',
                  createUser: '3',
                  updateTime: '2020-09-10 11:35:20',
                  updateUser: '3',
                  label: '运维部',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 0,
                  children: null,
                  abbreviation: 'YWB',
                  treePath: ',100,101,',
                  status: true,
                  describe: '运维管理部',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '1305392873935470592',
                  createTime: '2020-09-14 14:28:09',
                  createUser: '3',
                  updateTime: '2020-09-14 14:28:09',
                  updateUser: '3',
                  label: '成都营业厅',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 0,
                  children: null,
                  abbreviation: '成都',
                  treePath: ',100,101,',
                  status: true,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 1,
                },
                {
                  id: '643775612976106881',
                  createTime: '2019-11-12 11:34:27',
                  createUser: '3',
                  updateTime: '2020-09-21 16:21:04',
                  updateUser: '3',
                  label: '综合部',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 0,
                  children: [
                    {
                      id: '1307953529985433600',
                      createTime: '2020-09-21 16:03:17',
                      createUser: '3',
                      updateTime: '2020-09-21 16:03:17',
                      updateUser: '3',
                      label: 'test',
                      parentId: '643775612976106881',
                      parentName: '综合部',
                      sortValue: 0,
                      children: null,
                      abbreviation: '',
                      treePath: ',100,101,643775612976106881,',
                      status: true,
                      describe: '',
                      deleteTime: null,
                      deleteUser: null,
                      isBusinessHall: 0,
                    },
                  ],
                  abbreviation: '',
                  treePath: ',100,101,',
                  status: false,
                  describe: '前台&HR',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '643776633823564321',
                  createTime: '2019-11-12 11:38:31',
                  createUser: '3',
                  updateTime: '2020-09-10 11:11:52',
                  updateUser: '3',
                  label: '产品部',
                  parentId: '101',
                  parentName: '秦川集团股份有限公司广州子公司',
                  sortValue: 1,
                  children: [
                    {
                      id: '1307932263794606080',
                      createTime: '2020-09-21 14:38:47',
                      createUser: '3',
                      updateTime: '2020-09-21 14:38:47',
                      updateUser: '3',
                      label: '官方',
                      parentId: '643776633823564321',
                      parentName: '产品部',
                      sortValue: 0,
                      children: null,
                      abbreviation: '5',
                      treePath: ',100,101,643776633823564321,',
                      status: true,
                      describe: '13256',
                      deleteTime: null,
                      deleteUser: null,
                      isBusinessHall: 0,
                    },
                    {
                      id: '1307932670142971904',
                      createTime: '2020-09-21 14:40:23',
                      createUser: '3',
                      updateTime: '2020-09-21 14:40:23',
                      updateUser: '3',
                      label: '5656',
                      parentId: '643776633823564321',
                      parentName: '产品部',
                      sortValue: 0,
                      children: null,
                      abbreviation: '6+',
                      treePath: ',100,101,643776633823564321,',
                      status: true,
                      describe: '565+',
                      deleteTime: null,
                      deleteUser: null,
                      isBusinessHall: 0,
                    },
                  ],
                  abbreviation: '',
                  treePath: ',100,101,',
                  status: false,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
              ],
              abbreviation: '广州秦川集团',
              treePath: ',100,',
              status: true,
              describe: '初始化数据',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '102',
              createTime: '2019-11-07 16:13:09',
              createUser: '1',
              updateTime: '2019-11-07 16:13:12',
              updateUser: '1',
              label: '秦川集团股份有限公司北京分公司',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 1,
              children: [
                {
                  id: '643776668917305985',
                  createTime: '2019-11-12 11:38:39',
                  createUser: '3',
                  updateTime: '2019-11-12 11:38:39',
                  updateUser: '3',
                  label: '综合部',
                  parentId: '102',
                  parentName: '秦川集团股份有限公司北京分公司',
                  sortValue: 0,
                  abbreviation: '',
                  treePath: ',100,102,',
                  status: true,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '643776713909605089',
                  createTime: '2019-11-12 11:38:50',
                  createUser: '3',
                  updateTime: '2020-09-09 11:20:26',
                  updateUser: '3',
                  label: '研发部',
                  parentId: '102',
                  parentName: '秦川集团股份有限公司北京分公司',
                  sortValue: 0,
                  children: null,
                  abbreviation: '',
                  treePath: ',100,102,',
                  status: true,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '643776757199016769',
                  createTime: '2019-11-12 11:39:00',
                  createUser: '3',
                  updateTime: '2019-11-12 11:39:00',
                  updateUser: '3',
                  label: '销售部',
                  parentId: '102',
                  parentName: '秦川集团股份有限公司北京分公司',
                  sortValue: 2,
                  children: null,
                  abbreviation: '',
                  treePath: ',100,102,',
                  status: true,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
                {
                  id: '1302856996973707264',
                  createTime: '2020-09-07 14:31:29',
                  createUser: '3',
                  updateTime: '2020-09-07 14:32:32',
                  updateUser: '3',
                  label: '放大水电费',
                  parentId: '102',
                  parentName: '秦川集团股份有限公司北京分公司',
                  sortValue: 0,
                  children: null,
                  abbreviation: '',
                  treePath: ',100,102,',
                  status: true,
                  describe: '',
                  deleteTime: null,
                  deleteUser: null,
                  isBusinessHall: 0,
                },
              ],
              abbreviation: '北京秦川集团',
              treePath: ',100,',
              status: true,
              describe: '初始化数据',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '643775664683486689',
              createTime: '2019-11-12 11:34:39',
              createUser: '3',
              updateTime: '2019-11-12 11:36:16',
              updateUser: '3',
              label: '管理层',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 3,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '643775904077582049',
              createTime: '2019-11-12 11:35:37',
              createUser: '3',
              updateTime: '2019-11-12 11:36:52',
              updateUser: '3',
              label: '总经办',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 2,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '643776324342648929',
              createTime: '2019-11-12 11:37:17',
              createUser: '3',
              updateTime: '2019-11-12 11:37:40',
              updateUser: '3',
              label: '财务部',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 4,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '643776407691858113',
              createTime: '2019-11-12 11:37:37',
              createUser: '3',
              updateTime: '2019-11-12 11:37:37',
              updateUser: '3',
              label: '市场部',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 5,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '643776508795556193',
              createTime: '2019-11-12 11:38:01',
              createUser: '3',
              updateTime: '2019-11-12 11:38:01',
              updateUser: '3',
              label: '销售部',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 6,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '1303151576130519040',
              createTime: '2020-09-08 10:02:02',
              createUser: '3',
              updateTime: '2020-09-08 10:02:02',
              updateUser: '3',
              label: '都是',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 0,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
            {
              id: '1307953251294904320',
              createTime: '2020-09-21 16:02:10',
              createUser: '3',
              updateTime: '2020-09-21 16:02:10',
              updateUser: '3',
              label: '45',
              parentId: '100',
              parentName: '秦川集团股份有限公司',
              sortValue: 0,
              children: null,
              abbreviation: '',
              treePath: ',100,',
              status: true,
              describe: '',
              deleteTime: null,
              deleteUser: null,
              isBusinessHall: 0,
            },
          ],
          abbreviation: '秦川集团2',
          treePath: ',',
          status: true,
          describe: '初始化数据',
          deleteTime: null,
          deleteUser: null,
          isBusinessHall: 0,
        },
      ],
      stationList: [],
      imgFileList: [],
      imgFileData: {
        bizId: '',
        bizType: 'USER_AVATAR',
      },
      // 图片文件总数
      imgFileTotal: 0,
      // 上传成功数
      successNum: 0,
      enums: {
        Sex: {},
      },
      dicts: {
        NATION: {},
        POSITION_STATUS: {},
        EDUCATION: {},
      },
      rules: {
        account: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
          {
            min: 2,
            max: 10,
            message: this.$t('rules.range2to10'),
            trigger: 'blur',
          },
          {
            validator: accountCheck,
            trigger: 'blur',
          },
        ],

        name: [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],

        password: [{ validator: validatePass, trigger: 'blur' }],
        rePwd: [{ validator: validatePass2, trigger: 'blur' }],
        'org.key': {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
        'station.key': [
          {
            required: true,
            message: this.$t('rules.require'),
            trigger: 'blur',
          },
        ],
        email: {
          type: 'email',
          message: this.$t('rules.email'),
          trigger: 'blur',
        },
        mobile: {
          required: true,
          validator: (rule, value, callback) => {
            if (value === '') {
              callback(new Error(this.$t('rules.require')))
            } else if (!checkPhone(value)) {
              callback(new Error(this.$t('rules.mobile')))
            } else {
              callback()
            }
          },
          trigger: 'blur',
        },
        sex: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'change',
        },
        status: {
          required: true,
          message: this.$t('rules.require'),
          trigger: 'blur',
        },
      },
    }
  },

  computed: {
    isVisible: {
      get() {
        return this.dialogVisible
      },
      set() {
        this.close()
        this.reset()
      },
    },
    title() {
      return this.type === 'add' ? this.$t('common.add') : this.$t('common.edit')
    },
  },
  watch: {
    // 监听deptId
    'user.org.key': function(val, oldVal) {
      this.user.station.key = ''
      this.orgSelect(val)
    },
  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    // 头像
    myAvatar(avatar) {
      if (!avatar) {
        return require(`@/assets/avatar/default.jpg`)
      } else {
        if (avatar.startsWith('http://') || avatar.startsWith('https://')) {
          return avatar
        } else {
          return require(`@/assets/avatar/${avatar}`)
        }
      }
    },
    // 初始化用户表单数据
    initUser() {
      return {
        id: '',
        account: '',
        name: '',
        org: {
          key: null,
        },
        station: { key: null },
        email: '',
        mobile: '',
        sex: {
          code: '',
        },
        nation: {
          key: '',
        },
        education: {
          key: '',
        },
        positionStatus: {
          key: '',
        },
        status: true,
        avatar: '',
        workDescribe: '',
        password: '123456',
        rePwd: '123456',
      }
    },
    /*更改弹窗宽度*/
    initWidth() {
      this.screenWidth = document.body.clientWidth
      if (this.screenWidth < 991) {
        return '90%'
      } else if (this.screenWidth < 1400) {
        return '45%'
      } else {
        return '800px'
      }
    },

    loadListOptions({ callback }) {
      callback()
    },
    
    orgSelect(node) {
      this.loadStation(node)
    },

    loadStation(orgId) {
      // this.user.station.key = null;
      if (orgId) {
        stationApi
          .page({
            size: 10000,
            model: { orgId: { key: orgId }, status: true },
          })
          .then(response => {
            const res = response.data
            this.stationList = res.data.records
          })
      } else {
        this.stationList = []
      }
    },
    setIdAndSubmit(bizId, url) {
      const vm = this
      vm.successNum += 1
      vm.imgFileData.bizId = bizId
      vm.user.avatar = url
      vm.user.id = bizId

      if (vm.successNum === vm.imgFileTotal) {
        vm.$store.state.hasLoading = false
      }
    },
    setUser(val, orgs, dicts, enums) {
      const vm = this
      if (val) {
        vm.user = val
      }
      vm.dicts = dicts
      vm.enums = enums

      vm.orgList = orgs
      // vm.orgList = this.formatOrgList(orgs)
      vm.imgFileData.bizId = vm.user['id']
      vm.$nextTick(() => {
        vm.$refs.imgFileRef.init({
          bizId: vm.user['id'],
          bizType: vm.imgFileData.bizType,
          imageUrl: vm.myAvatar(vm.user['avatar']),
          isSingle: true,
          isDetail: false,
        })
      })
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.user = this.initUser()
      this.imgFileData.bizId = ''
      this.$refs.imgFileRef.init({
        bizId: '',
        bizType: '',
        imageUrl: '',
        isSingle: true,
        isDetail: false,
      })
    },
    submitForm: debounce(function() {
      const vm = this
      this.$refs.form.validate(valid => {
        if (valid) {
          vm.confirmLoading = true
          vm.editSubmit()
        } else {
          return false
        }
      })
    }, 300),
    editSubmit() {
      const vm = this
      if (vm.type === 'add') {
        vm.save()
      } else {
        vm.update()
      }
    },
    save() {
      const vm = this
      userApi.save(this.user).then(response => {
        const res = response.data
        if (res.isSuccess) {
          vm.isVisible = false
          vm.$message({
            message: vm.$t('tips.createSuccess'),
            type: 'success',
          })
          vm.$emit('success')
        }
      }).finally(() => {
        vm.confirmLoading = false
      })
    },
    update() {
      let submitUser = JSON.parse(JSON.stringify(this.user))
      if (!submitUser.password) {
        // delete submitUser.password
        // delete submitUser.rePwd
        submitUser.password = null
        submitUser.rePwd = null
      }

      userApi.update(submitUser).then(response => {
        const res = response.data
        if (res.isSuccess) {
          this.isVisible = false
          this.$message({
            message: this.$t('tips.updateSuccess'),
            type: 'success',
          })
          this.$emit('success')
        }
      }).finally(() => {
        this.confirmLoading = false
      })
    },
  },
}
</script>
<style lang="scss" scoped>
  .is-error {
    ::v-deep .vue-treeselect__control {
      border-color: #ff4949;
    }
  }

  ::v-deep .avatar-uploader {
    width: 80px;
    height: 80px;

    .el-upload--picture-card {
      width: 100% !important;
      height: 100% !important;
    }
  }
</style>
