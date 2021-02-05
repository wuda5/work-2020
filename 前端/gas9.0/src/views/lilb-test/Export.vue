<template>
  <div class="export-page">
    <el-button
      type="primary"
      @click.native="baseExport"
    >
      基本导出demo
    </el-button>
    <el-button
      type="primary"
      @click.native="mergeHeaderExport"
    >
      多级表头导出demo
    </el-button>
    <el-button
      type="primary"
      @click.native="setStyleExport"
    >
      设置表格样式导出demo
    </el-button>
  </div>
</template>

<script>
import commonMixin from '@/mixins/common'
import { parseTime, createUniqueString, randomNum } from '@/utils/index'

console.log('1'.replace(/^([a-z]+)\d+$/i, '$1'));

export default {
  name: 'ExportTest',
  components: {

  },
  filters: {},
  mixins: [commonMixin],
  props: {

  },
  data() {
    return {

    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {

  },
  destroyed() {

  },
  methods: {
    async initData() {

    },
    // 基础导出
    baseExport() {
      import('@/vendor/Export2Excel').then(async(excel) => {
        const { ceil, random } = Math
        const data = Array.from({ length: ceil(random() * 10) + 1 }, () => ({
          id: randomNum(4),
          conetent: createUniqueString(),
          author: 'boblee',
          date: new Date()
        }))
        console.log(data)
        const header = Object.keys(data[0])
        const filename = `基本导出模板${parseTime(new Date(), '{y}{m}{d}{h}{i}{s}')}`
        const fields = Object.keys(data[0])
        excel.export_json_to_excel({
          header,
          data: excel.formatJsonData(data, fields),
          filename,
          bookType: 'xlsx',
          autoWidth: true
        })
      })
    },
    // 多级表头导出
    mergeHeaderExport() {
      import('@/vendor/Export2Excel').then(async(excel) => {
        const { ceil, random } = Math
        const data = Array.from({ length: ceil(random() * 10) + 1 }, () => ({
          id: randomNum(4),
          name: `boblee${ceil((random() * 10) + (random() * 10) + (random() * 10))}`,
          no: null,
          math: ceil(random() * 100),
          english: ceil(random() * 100),
          chinese: ceil(random() * 100)
        }))
        console.log(data)
        const mapFields = {
          id: 'id',
          no: '学号',
          name: '姓名',
          math: '数学',
          english: '英语',
          chinese: '语文'
        }
        const header = Object.values(mapFields)
        const multiHeader = [
          ['班级成绩公布', '', '', '', '', ''],
          ['id', '学号', '姓名', '成绩信息', '', '']
        ]
        const merges = ['A1:F1', 'A2:A3', 'B2:B3', 'C2:C3', 'D2:F2']
        const filename = `多级表头导出模板${parseTime(new Date(), '{y}{m}{d}{h}{i}{s}')}`
        const fields = Object.keys(mapFields)
        excel.export_json_to_excel({
          header,
          multiHeader,
          merges,
          data: excel.formatJsonData(data, fields),
          filename,
          bookType: 'xlsx',
          autoWidth: true
        })
      })
    },
    // 设置表格样式导出
    setStyleExport() {
      import('@/vendor/Export2Excel').then(async(excel) => {
        const { ceil, random } = Math
        const data = Array.from({ length: ceil(random() * 10) + 1 }, () => ({
          id: randomNum(4),
          name: `boblee${ceil((random() * 10) + (random() * 10) + (random() * 10))}`,
          no: null,
          math: ceil(random() * 100),
          english: ceil(random() * 100),
          chinese: ceil(random() * 100)
        }))
        const mapFields = {
          id: 'id',
          no: '学号',
          name: '姓名',
          math: '数学',
          english: '英语',
          chinese: '语文'
        }
        const header = Object.values(mapFields)
        const multiHeader = [
          ['班级成绩公布', '', '', '', '', ''],
          ['id', '学号', '姓名', '成绩信息', '', '']
        ]
        const merges = ['A1:F1', 'A2:A3', 'B2:B3', 'C2:C3', 'D2:F2']
        const filename = `多级表头导出模板${parseTime(new Date(), '{y}{m}{d}{h}{i}{s}')}`
        const fields = Object.keys(mapFields)
        excel.export_json_to_excel({
          header,
          multiHeader,
          merges,
          data: excel.formatJsonData(data, fields),
          // 默认全局单元格样式设置
          defaultCellOptions: {
            s: {
              fill: {
                bgColor: {
                  indexed: 36
                }
              },
              font: {
                size: 14,
                underline: true
              }
            }
          },
          // 单独设置单元格的样式
          cellOptions: {
            // 设置一个单元格
            'A1': {
              s: {
                font: {
                  sz: 22,
                  bold: true,
                  color: {
                    rgb: 'be1480'
                  }
                }
              }
            },
            // 设置一列的单元格
            'C': {
              s: {
                fill: {
                  bgColor: {
                    rgb: '00FA9A'
                  }
                },
                font: {
                  sz: 18,
                  bold: true,
                  color: {
                    rgb: 'DC143C'
                  }
                }
              }
            }
          },
          customExcelOptionsFun: (ws) => {
            console.log('需要修改的表格实例：', ws);
            return Promise.resolve(ws)
          },
          filename,
          bookType: 'xlsx',
          autoWidth: true
        })
      })
    }
  }
}
</script>

<style scoped lang="scss">
  .export-page {
    background-color: $danger;
  }
</style>
