<!-- 公共模板 -->
<template>
  <div>
    <!-- 模板列表 -->
    <el-table ref="multipleTable" border="" :data="tableData" tooltip-effect="dark">
      <el-table-column type="index" label="序号" width="55"></el-table-column>
      <el-table-column prop="templateTitle" label="模板名"></el-table-column>
      <el-table-column prop="itemStatus" label="模板状态">
        <el-tag type="warning">公共模板</el-tag>
      </el-table-column>

      <el-table-column fixed="right" label="操作" min-width="260">
        <div slot-scope="{ row }">
          <!-- 测试模板 -->
          <el-button v-has-permission="['template:test']" type="primary" @click="testPrint(row)">预览</el-button>

          <!-- 添加到我的模板 -->
          <el-button
            v-has-permission="['template:test']"
            type="primary"
            @click="addToMyTemplate(row)"
            >添加到我的模板</el-button>
        </div>
      </el-table-column>
    </el-table>

    <!--分页-->
    <pagination
      name="pagination"
      :total="total"
      :page-sizes="[10, 20, 30]"
      :limit="search.size"
      @pagination="pagination"
    />
  </div>
</template>

<script>
// 打印测试数据
import apiPrintTemplate from '@/api/system/printTemplate.js'
import { getLodop } from '@/utils/LodopFuncs.js'
import dayjs from 'dayjs'
let LODOP

export default {
  name: 'PrintTemplate',
  components: {},
  props: {
    searchData: {
      type: Object,
    },
  },
  data() {
    return {
      // 查询数据
      search: this.searchData,
      total: 0,
      tableData: [],
      testTpl: '',
    }
  },
  created() {
    this.getPageList()
  },
  methods: {
    // 获取模板列表数据
    getPageList() {
      apiPrintTemplate.publicTemplate(this.searchData).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.tableData = data.records
          this.total = parseInt(data.total)
        }
      })
    },

    // 分页数据改变
    pagination(pageData) {
      this.search.size = pageData.size
      this.search.current = pageData.current
      this.getPageList()
    },

    // 测试
    testPrint(row) {
      let template = row.itemContent.replace(/QcBody/g, 'body').replace(/QcScript/g, 'script')
      
      try {
        LODOP = getLodop()
        eval(template)
        LODOP.PREVIEW()
      } catch {
        this.msg('该模板有误，请检查！', 'error')
      }
    },

    // 保存到我的模板库
    addToMyTemplate(row) {
      let curTemplate = JSON.parse(JSON.stringify(row))

      // 修改模板的分享状态为未分享
      curTemplate.dataStatus = -2
      // 修改模板名
      curTemplate.templateTitle = `【公共模板】 ${curTemplate.templateTitle} - (${dayjs().format(
        'YYYY-MM-DD'
      )})`
      // 去掉ID(这样新增的数据和平台脱离关系，后面该模板分享再修改，平台更新该条数据即可)
      curTemplate.id = null

      apiPrintTemplate.addNewTemplate(curTemplate).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.msg('添加成功', 'success')
          this.emitClose()
        }
      })
    },
    emitClose() {
      this.$emit('close')
    },
  },
}
</script>

<style lang="scss" scoped>
</style>
