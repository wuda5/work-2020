<template>
  <el-dialog :title="$t('common.view')" :visible.sync="isVisible" width="700px" class="user-view">
    <h2>{{ user.name }}</h2>

    <el-divider />
    <div class="infoList">
      <!-- 账号 -->
      <div class="view-item">
        <i class="el-icon-bank-card" />
        <span>{{ $t('table.user.account') +'：' }}</span>
        {{ user.account }}
      </div>

      <!-- 姓名 -->
      <div class="view-item">
        <i class="el-icon-user" />
        <span>{{ $t('table.user.name') +'：' }}</span>
        {{ user.name }}
      </div>

      <!-- 邮箱 -->
      <div class="view-item">
        <i class="el-icon-message" />
        <span>{{ $t('table.user.email') +'：' }}</span>
        {{ user.email }}
      </div>

      <!-- 电话 -->
      <div class="view-item">
        <i class="el-icon-phone-outline" />
        <span>{{ $t('table.user.mobile') +'：' }}</span>
        {{ user.mobile }}
      </div>

      <!-- 组织 -->
      <div class="view-item">
        <i class="el-icon-trophy" />
        <span>{{ $t('table.user.orgId') +'：' }}</span>
        {{ user.org && user.org.data ? user.org.data.label : "" }}
      </div>

      <!-- 岗位 -->
      <div class="view-item">
        <i class="el-icon-suitcase" />
        <span>{{ $t('table.user.stationId') +'：' }}</span>
        {{ user.station ? user.station.data :"" }}
      </div>

      <!-- 性别 -->
      <div class="view-item">
        <i class="el-icon-male" />
        <span>{{ $t('table.user.sex') +'：' }}</span>
        {{ user.sex.desc }}
      </div>

      <!-- 状态 -->
      <div class="view-item">
        <i class="el-icon-bangzhu" />
        <span>{{ $t('table.user.status') +'：' }}</span>
        {{ user.status ? $t('common.status.valid') : $t('common.status.invalid') }}
      </div>

      <!-- 创建时间 -->
      <div class="view-item">
        <i class="el-icon-time" />
        <span>{{ $t('table.user.createTime') +'：' }}</span>
        {{ user.createTime }}
      </div>

      <!-- 修改时间 -->
      <div class="view-item">
        <i class="el-icon-time" />
        <span>{{ $t('table.user.updateTime') +'：' }}</span>
        {{ user.updateTime }}
      </div>

      <!-- 最后登录时间 -->
      <div class="view-item">
        <i class="el-icon-date" />
        <span>{{ $t('table.user.lastLoginTime') +'：' }}</span>
        {{ user.lastLoginTime ? user.lastLoginTime: $t('tips.neverLogin') }}
      </div>

      <!-- 密码过期时间 -->
      <div class="view-item">
        <i class="el-icon-date" />
        <span>{{ $t('table.user.passwordExpireTime') +'：' }}</span>
        {{ user.passwordExpireTime }}
      </div>

      <!-- 最后一次输错密码时间 -->
      <div class="view-item">
        <i class="el-icon-date" />
        <span>{{ $t('table.user.passwordErrorLastTime') +'：' }}</span>
        {{ user.passwordErrorLastTime }}
      </div>

      <!-- 密码错误次数 -->
      <div class="view-item">
        <i class="el-icon-circle-close" />
        <span>{{ $t('table.user.passwordErrorNum') +'：' }}</span>
        {{ user.passwordErrorNum }}
      </div>

      <!-- 个人描述 -->
      <div class="view-item">
        <i class="el-icon-document" />
        <span>{{ $t('table.user.workDescribe') +'：' }}</span>
        {{ user.workDescribe ? user.workDescribe: $t('tips.nothing') }}
      </div>
    </div>
  </el-dialog>
</template>

<script>
export default {
  name: 'UserView',
  filters: {
    userAvatarFilter(name) {
      return name ? name.charAt(0) : '无'
    },
  },
  props: {
    dialogVisible: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      screenWidth: 0,
      width: this.initWidth(),
      user: {
        sex: {
          desc: '',
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
      },
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
    initWidth() {
      this.screenWidth = document.body.clientWidth
      if (this.screenWidth < 550) {
        return '95%'
      } else if (this.screenWidth < 990) {
        return '580px'
      } else if (this.screenWidth < 1400) {
        return '600px'
      } else {
        return '650px'
      }
    },
    setUser(val) {
      this.user = { ...val }
    },
    close() {
      this.$emit('close')
    },
  },
}
</script>
<style lang="scss" scoped>
  .user-view {
    h2 {
      font-weight: normal;
      color: $primary;
    }
    .infoList {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
    }

    .view-item {
      width: 45%;
      margin: 10px;

      i {
        font-size: 0.97rem;
        color: $primary;
      }

      span {
        margin-left: 10px;
      }
    }
  }
</style>
