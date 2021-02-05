import { merge, cloneDeep, isEmpty } from 'lodash'
import { initQueryParams, initListData } from '@/utils/commons'
import { isEmptyObject } from '@/utils/object'
import { dataStatusfilters } from '@/enums/common'

export default {
  data() {
    return {
      // 加载默认列表信息数据
      ...initListData(),
      dataStatusfilters, // 数据状态过滤数组
    }
  },
  methods: {
    initQueryParams,
    initListData,

    // 翻页获取列表
    handleGetList() {
      this.getList()
    },

    // 根据查询条件筛选数据
    handleSearch(isReset = true) {
      if (isReset) {
        // 重新获取列表数据 清空选中，清空单击表格行
        this.currentRow = null
        this.isRowClick = false
      }
      // 重置分页
      this.queryParams.current = 1
      this.getList()
      this.$nextTick(function() {
      })
    },

    // 当表格的排序条件发生变化
    sortChange({ column, prop, order }) {
      console.log(column, prop, order)
    },
    // 重置筛选条件
    resetSearch(ref, isRefreshData = true) {
      ref = this.searchFormRef
      // console.log(ref, this.$refs[ref])
      this.$refs[ref]?.resetFields?.()
      if (isRefreshData) {
        // 重置分页
        this.queryParams.current = 1
        this.$nextTick(() => {
          isRefreshData && this.getList()
        })
      }
    },

    // 打开表单弹出框
    async showFormDialog(formStatus = 'add', row = null, e) {
      if (formStatus === 'add') {
        this.$refs[this.listRef]?.setCurrentRow()
        this.isRowClick = false
      }
      this.currentRow = row ? cloneDeep(row) : null
      setTimeout(() => {
        this.formDialogVisible = true
      })
    },

    /**
     * 组装获取列表的请求参数
     * @param {Object} params 传入参数
     * @param {*} deepMerge 是否深度合并
     */
    generateQueryParams(params = {}, listParams, deepMerge = true) {
      listParams = listParams || this
      const queryParams = listParams.queryParams || {}
      const searchForm = listParams.searchForm || {}
      if (deepMerge) {
        return merge(queryParams, { model: searchForm }, params)
      } else {
        return { ...queryParams, model: this.searchForm, ...params }
      }
    },

    // 当某一行被点击时会触发该事件	
    handleRowClick(row, column, event) {
      // console.log('handleRowClick', row)
      this.currentRow = row
      this.isRowClick = true
    },

    handleSelectionChange(selection) {
      // console.log(selection)
      this.multipleSelection = selection
    },

    // 当表格的筛选条件发生变化的时候会触发该事件
    filterChange(filters, searchForm) {
      searchForm = searchForm || (this.searchForm || {})
      if (isEmptyObject) {
        searchForm = this.queryParams?.model || {}
      }
      // console.log(filters)
      for (const key in filters) {
        searchForm[key] = filters[key][0] || null
      }
      this.getList()
    }
  }
}
