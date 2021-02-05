<!--
 * @Descripttion: 区域
 * @Author: lingw
 * @Date: 2020-10-16 10:19:07
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-20 15:54:39
-->
<template>
  <div :style="{height: `${height}px`}" class="area-container">
    <el-card shadow="never" class="no-border" style="margin-top: 10px">
      <div slot="header">
        <span class="card-title">区域</span>
      </div>
      <template>
        <el-input v-model="queryString" style="width: 200px;" placeholder="请输入内容" class="input-with-select">
          <el-button slot="append" icon="el-icon-search" @click="handleSearch"></el-button>
        </el-input>
        <el-cascader
          v-model="queryValue"
          :options="options"
          :props="{ expandTrigger: 'hover' }"
          @change="handleChange"
        ></el-cascader>
      </template>
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="表具" name="meter">
          <el-table
            :data="tableData.meter.records"
            style="width: 100%;margin-bottom: 20px;"
            row-key="id"
            :border="false"
          >
            <el-table-column label="表具" prop="meter">
              <span slot-scope="{row}">
                {{ row.meter | emptyStr }}
              </span>
            </el-table-column>
            <el-table-column label="表具编号" prop="meterNumber">
              <span slot-scope="{row}">
                {{ row.meterNumber | emptyStr }}
              </span>
            </el-table-column>
          </el-table>
        </el-tab-pane>
        <el-tab-pane label="节点" name="node">
          <el-table
            :data="tableData.node.records"
            style="width: 100%;margin-bottom: 20px;"
            row-key="id"
            :border="false"
          >
            <el-table-column label="节点" prop="node">
              <span slot-scope="{row}">
                {{ row.node | emptyStr }}
              </span>
            </el-table-column>
            <el-table-column label="节点编号" prop="nodeNumber">
              <span slot-scope="{row}">
                {{ row.nodeNumber | emptyStr }}
              </span>
            </el-table-column>
          </el-table>
          <Pagination
            v-if="tableData[activeName].records.length"
            layout="prev, pager, next"
            :page="tableData[activeName].current"
            :limit="tableData[activeName].size"
            :total="tableData[activeName].total"
            @pagination="handlePageChange"
          />
        </el-tab-pane></el-tabs>
      <meter-tools v-if="activeName === 'meter'" :meter-info="meterInfo" />
      <node-tools v-else :meter-info="meterInfo" />
    </el-card>
  </div>
</template>
<script>
import { debounce } from 'lodash'
import MeterTools from './MeterTools'
import NodeTools from './NodeTools'
export default {
  name: 'Area',
  components: {
    MeterTools,
    NodeTools
  },
  props: {
    meterInfo: {
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  data() {
    return {
      queryString: '', // 搜索条件
      queryValue: [], // 选择器
      activeName: 'meter',
      tableData: {
        meter: {
          total: 0,
          size: 10,
          records: []
        },
        node: {
          total: 0,
          size: 10,
          records: []
        }
      },
      showMore: false,
      options: [{
        value: 'zhinan',
        label: '指南',
        children: [{
          value: 'shejiyuanze',
          label: '设计原则',
          children: [{
            value: 'yizhi',
            label: '一致'
          }, {
            value: 'fankui',
            label: '反馈'
          }, {
            value: 'xiaolv',
            label: '效率'
          }, {
            value: 'kekong',
            label: '可控'
          }]
        }, {
          value: 'daohang',
          label: '导航',
          children: [{
            value: 'cexiangdaohang',
            label: '侧向导航'
          }, {
            value: 'dingbudaohang',
            label: '顶部导航'
          }]
        }]
      }, {
        value: 'zujian',
        label: '组件',
        children: [{
          value: 'basic',
          label: 'Basic',
          children: [{
            value: 'layout',
            label: 'Layout 布局'
          }, {
            value: 'color',
            label: 'Color 色彩'
          }, {
            value: 'typography',
            label: 'Typography 字体'
          }, {
            value: 'icon',
            label: 'Icon 图标'
          }, {
            value: 'button',
            label: 'Button 按钮'
          }]
        }, {
          value: 'form',
          label: 'Form',
          children: [{
            value: 'radio',
            label: 'Radio 单选框'
          }, {
            value: 'checkbox',
            label: 'Checkbox 多选框'
          }, {
            value: 'input',
            label: 'Input 输入框'
          }, {
            value: 'input-number',
            label: 'InputNumber 计数器'
          }, {
            value: 'select',
            label: 'Select 选择器'
          }, {
            value: 'cascader',
            label: 'Cascader 级联选择器'
          }, {
            value: 'switch',
            label: 'Switch 开关'
          }, {
            value: 'slider',
            label: 'Slider 滑块'
          }, {
            value: 'time-picker',
            label: 'TimePicker 时间选择器'
          }, {
            value: 'date-picker',
            label: 'DatePicker 日期选择器'
          }, {
            value: 'datetime-picker',
            label: 'DateTimePicker 日期时间选择器'
          }, {
            value: 'upload',
            label: 'Upload 上传'
          }, {
            value: 'rate',
            label: 'Rate 评分'
          }, {
            value: 'form',
            label: 'Form 表单'
          }]
        }, {
          value: 'data',
          label: 'Data',
          children: [{
            value: 'table',
            label: 'Table 表格'
          }, {
            value: 'tag',
            label: 'Tag 标签'
          }, {
            value: 'progress',
            label: 'Progress 进度条'
          }, {
            value: 'tree',
            label: 'Tree 树形控件'
          }, {
            value: 'pagination',
            label: 'Pagination 分页'
          }, {
            value: 'badge',
            label: 'Badge 标记'
          }]
        }, {
          value: 'notice',
          label: 'Notice',
          children: [{
            value: 'alert',
            label: 'Alert 警告'
          }, {
            value: 'loading',
            label: 'Loading 加载'
          }, {
            value: 'message',
            label: 'Message 消息提示'
          }, {
            value: 'message-box',
            label: 'MessageBox 弹框'
          }, {
            value: 'notification',
            label: 'Notification 通知'
          }]
        }, {
          value: 'navigation',
          label: 'Navigation',
          children: [{
            value: 'menu',
            label: 'NavMenu 导航菜单'
          }, {
            value: 'tabs',
            label: 'Tabs 标签页'
          }, {
            value: 'breadcrumb',
            label: 'Breadcrumb 面包屑'
          }, {
            value: 'dropdown',
            label: 'Dropdown 下拉菜单'
          }, {
            value: 'steps',
            label: 'Steps 步骤条'
          }]
        }, {
          value: 'others',
          label: 'Others',
          children: [{
            value: 'dialog',
            label: 'Dialog 对话框'
          }, {
            value: 'tooltip',
            label: 'Tooltip 文字提示'
          }, {
            value: 'popover',
            label: 'Popover 弹出框'
          }, {
            value: 'card',
            label: 'Card 卡片'
          }, {
            value: 'carousel',
            label: 'Carousel 走马灯'
          }, {
            value: 'collapse',
            label: 'Collapse 折叠面板'
          }]
        }]
      }, {
        value: 'ziyuan',
        label: '资源',
        children: [{
          value: 'axure',
          label: 'Axure Components'
        }, {
          value: 'sketch',
          label: 'Sketch Templates'
        }, {
          value: 'jiaohu',
          label: '组件交互文档'
        }]
      }]
    }
  },
  computed: {
    height() {
      return document.body.clientHeight - 104
    }
  },
  methods: {
    viewMore() {
      // todo: 跳转地址
    },
    handleClick: debounce(function (a) {
      this.$emit('tab-click', this.activeName)
    }, 300),
    handleChange() {

    },
    // 点击搜索触发
    handleSearch() {
      const payload = {
        queryString: this.queryString,
        queryValue: this.queryValue
      }
      this.$emit('search', payload)
    },
    // 翻页
    handlePageChange(params) {
      if (this.activeName === 'meter') {
        this.$emit('meterPagination', params)
      } else {
        this.$emit('nodePagination', params)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  ::v-deep .el-tabs__content {
    height: 100%;
  }
  .area-container {
    height: 780px !important;
    background: #fff;
    box-shadow: 1px 1px 5px 2px #C0C4CC;
    .card-title {
      font-size: 16px;
      font-weight: 600;
    }
  }
</style>
