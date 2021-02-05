<template>
  <div class="qc-main select-api-page">
    <div class="table-title">后台api列表</div>
    <!--数据-->
    <el-table
      :ref="listRef"
      v-loading="listLoading"
      stripe
      border
      style="width: 100% !important;"
      :data="list"
      :highlight-current-row="true"
      tooltip-effect="dark"
      @row-click="handleRowClick"
    >
      <el-table-column
        type="index"
        :label="$t('table.index')"
      >
      </el-table-column>
      <el-table-column
        prop="name"
        label="开发者"
      >
      </el-table-column>
      <el-table-column
        prop="url"
        label="后台api"
      >
      </el-table-column>
      <el-table-column
        fixed="right"
        :label="$t('table.operation')"
        width="180"
      >
        <template #default="{ row }">
          <el-button v-if="row.url !== url" type="primary" name="row-edit" @click.native="handleEnable(row)">启用
          </el-button>
          <el-button v-else type="danger">当前正在使用</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--分页-->
    <pagination
      :page-sizes="[ 15, 20, 30]"
      :page.sync="queryParams.current"
      :limit.sync="queryParams.size"
      :total="list.length"
      @pagination="handleGetList"
    />
  </div>
</template>

<script>
import {mapState} from 'vuex'
import commonMixin from '@/mixins/common'
import listMixin from '@/mixins/list'
import db from '@/utils/localstorage'
import {apis} from '@/enums/api'
import loginApi from '@/api/Login.js';

export default {
  name: 'SelectApi',
  components: {},
  filters: {},
  mixins: [commonMixin, listMixin],
  props: {},
  data() {
    return {
      list: apis,
    }
  },
  computed: {
    ...mapState({
      url: (state) => state.setting.apiUrl,
      token: (state) => state.account.token,
      user: (state) => state.account.user,
    })
  },
  watch: {},
  created() {
    this.initData()
  },
  mounted() {
    document.getElementById('app').style.minWidth = '100%'
  },
  destroyed() {
    document.getElementById('app').style.minWidth = ''
  },
  methods: {
    async initData() {
      await this.getList()
    },
    async getList(params = {}) {
    },

    // 启用url
    async handleEnable(row) {
      this.$store.commit('setting/setApiUrl', row.url)
      this.$message.success('切换后台api成功！')
      this.$nextTick(() => {
        db.clear()
        this.$router.push({path: '/login'})
      })
    },
  }
}
</script>

<style scoped lang="scss">
</style>
