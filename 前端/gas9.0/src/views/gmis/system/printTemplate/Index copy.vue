<!--打印模板配置-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">打印模板配置</span>
      </div>
      <!-- 模板分类 -->
      <div>
        <template v-for="item in classify">
          <el-button
            v-if="item.templateTypeCode"
            :key="item.id"
            :plain="templateTypeCode != item.templateTypeCode"
            type="primary"
            @click="switchClassify(item)"
            >{{ item.templateTypeName }}</el-button>
        </template>
      </div>

      <!-- 模板列表 -->
      <el-table
        ref="multipleTable"
        stripe
        :data="tableData"
        tooltip-effect="dark"
        style="width: 100%; margin-top: 15px"
      >
        <el-table-column type="index" label="序号" width="55"></el-table-column>
        <el-table-column prop="templateName" label="单据名称"></el-table-column>
        <el-table-column prop="itemStatus" label="模板状态">
          <template slot-scope="{ row }">
            <el-tag v-if="row.itemStatus === 0" type="success">自定义模板</el-tag>
            <el-tag v-if="row.itemStatus === 1" type="warning">默认模板</el-tag>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" min-width="260">
          <div slot-scope="{ row }">
            <el-upload
              v-has-permission="['template:upload']"
              style="display: inline; margin-right: 10px"
              action="22"
              :show-file-list="false"
              name="file"
              accept=".txt"
              :http-request="uploadTemplate"
            >
              <el-button type="success" @click="curRow = row">上传</el-button>
            </el-upload>
            <el-button v-has-permission="['template:test']" type="primary" @click="testPrint(row)">测试</el-button>
            <el-button
              v-has-permission="['template:delete']"
              type="danger"
              @click="deleteTemplate(row.id)"
              >删除</el-button>
            <el-button
              v-has-permission="['template:download']"
              type="success"
              @click="downloadTemplate(row)"
              >下载</el-button>
            <!-- 编辑模板 -->
            <el-button
              v-has-permission="['template:download']"
              type="warning"
              @click="editTempate(row)"
              >编辑</el-button>
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
    </el-card>
  </div>
</template>

<script>
// 打印测试数据
import apiFile from '@/api/File'
import apiPrintTemplate from '@/api/system/printTemplate'
import { getLodop } from '@/utils/LodopFuncs'

export default {
  name: 'PrintTemplate',
  data() {
    return {
      // 发票模板: 'INVOICE_TEMPLATE'
      // 票据模板: 'TICKET_TEMPLATE'
      // 单据模板: 'BILL_TEMPLATE'
      templateTypeCode: 'TICKET_TEMPLATE',

      // 模板分类数据
      classify: [],

      curRow: null,
      // 分页总体查询
      searchAll: {
        current: 1,
        map: {},
        model: {},
        order: 'descending',
        size: 1000,
        sort: 'id',
      },
      // 查询数据
      search: {
        current: 1,
        map: {},
        model: {
          templateTypeId: '',
          deleteStatus: 0,
        },
        order: 'descending',
        size: 10,
        sort: 'id',
      },
      total: 0,
      tableData: [],
      testTpl:''
    }
  },
  created() {
    this.getTemplateClassify()
  },
  methods: {
    // 获取所有模板分类
    getTemplateClassify() {
      apiPrintTemplate.pageAll(this.searchAll).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          let dataList = data.records
          this.classify = dataList
          // 获取第一条数据
          this.templateTypeCode = dataList[0].templateTypeCode
          this.search.model.templateTypeId = dataList[0].id
          this.getPageList()
        }
      })
    },

    // 切换模板分类
    switchClassify(item) {
      this.templateTypeCode = item.templateTypeCode
      this.search.model.templateTypeId = item.id
      this.getPageList()
    },

    // 获取模板列表数据
    getPageList() {
      apiPrintTemplate.page(this.search).then(res => {
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

    // 更新数据
    updateItem() {
      apiPrintTemplate.update(this.curRow).then(res => {
        let { isSuccess } = res.data
        if (isSuccess) {
          this.getPageList()
        }
      })
    },

    // 删除该条数据的模板
    deleteTemplate(id) {
      let ids = [id]
      apiPrintTemplate.delete({ ids }).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          this.getPageList()
        }
      })
    },

    // 上传模板
    uploadTemplate(params) {
      let file = params.file
      var formData = new FormData()
      formData.append('file', file)
      formData.append('bizType', 222)
      apiFile.upload(formData).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.curRow.fileId = data.id
          this.curRow.itemStatus = 0
          this.updateItem()
        }
      })
    },

    // 下载模板文件
    downloadTemplate(row) {
      console.log(row)
      let id = row.fileId || row.defaultFileId
      apiFile.download({ id }).then(res => {
        let res1 = res.data
        if (res1.isSuccess) {
          let fileUrl = res1.data

          apiFile.getFile(fileUrl).then(res => {
            //console.log(res);
            var eleLink = document.createElement('a')
            eleLink.download = row.templateName
            eleLink.style.display = 'none'

            // 字符内容转变成blob地址
            var blob = new Blob([res.data])
            eleLink.href = URL.createObjectURL(blob)

            // 触发点击
            document.body.appendChild(eleLink)
            eleLink.click()

            // 然后移除
            document.body.removeChild(eleLink)
          })
        }
      })
    },

    // 下载模板str
    downloadTemplateStr(id) {
      return new Promise((resolve, reject) => {
        apiPrintTemplate.getTemplateStr({ id }).then(res => {
          let { isSuccess, data } = res.data
          if (isSuccess) {
            resolve(data)
          }
        })
      })
    },

    // !打印测试
    async testPrint(row) {
      let that = this
      let tplStr = await this.downloadTemplateStr(row.id)
      // console.log(tplStr)
    
      let LODOP = getLodop()
      eval(eval(tplStr))
      // LODOP.PRINTA();
      LODOP.PREVIEW()
    },

    // !编辑模板
    async editTempate(row) {
      let that = this
      let tplStr = await this.downloadTemplateStr(row.id)
      let LODOP = getLodop()
      eval(eval(tplStr))

      // 如果安装了clodop
      if (LODOP.CVERSION) {
        LODOP.On_Return =  (TaskID, Value)=> {
          // console.log({ 1: Value })
          this.myWriteFile(LODOP, Value)
        }
      }

      // this.myWriteFile(LODOP.PRINT_DESIGN())
      console.log({ 2: LODOP.PRINT_DESIGN() })

      // LODOP.PRINTA();
      // LODOP.PREVIEW()
    },

    // 下载设计的模板
    myWriteFile(LODOP, strText) {
      if (LODOP.CVERSION) {
        LODOP.On_Return = function (TaskID, Value) {
          var strFilename = Value
          LODOP.On_Return = function (TaskID, Value) {
            // !保存完成要做的事情
            console.log(Value);
            // alert(Value)
          }
          LODOP.WRITE_FILE_TEXT(0, strFilename, strText)
        }
      }
      var strFilename = LODOP.GET_DIALOG_VALUE('LocalFileFullNameforSave', '保存的新文件名.txt')
      if (!LODOP.CVERSION) {
        alert(LODOP.WRITE_FILE_TEXT(0, strFilename, strText))
      }
    },

    //创建数据的方法
    CreateOneFormPage(LODOP, printArr) {
      let height = 28
      console.log(printArr)
      for (let i = 0; i < printArr.length; i++) {
        const item = printArr[i]
        LODOP.ADD_PRINT_TEXT(115 + i * height, 91, 148, 20, item.name)
        LODOP.ADD_PRINT_TEXT(115 + i * height, 267, 50, 20, item.num)
        LODOP.SET_PRINT_STYLEA(0, 'Alignment', 2)
        LODOP.ADD_PRINT_TEXT(115 + i * height, 334, 50, 20, item.value)
        LODOP.SET_PRINT_STYLEA(0, 'Alignment', 2)
        LODOP.ADD_PRINT_TEXT(
          115 + i * height,
          398,
          175,
          25,
          String(item.num * item.value).padStart(6, '⊗')
        )
        LODOP.SET_PRINT_STYLEA(0, 'LetterSpacing', 7)
      }
      LODOP.NEWPAGEA() //分页
    },

    //
    convertCurrency(money) {
      //汉字的数字
      let cnNums = new Array('零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖')
      //基本单位
      let cnIntRadice = new Array('', '拾', '佰', '仟')
      //对应整数部分扩展单位
      let cnIntUnits = new Array('', '万', '亿', '兆')
      //对应小数部分单位
      let cnDecUnits = new Array('角', '分', '毫', '厘')
      //整数金额时后面跟的字符
      let cnInteger = '整'
      //整型完以后的单位
      let cnIntLast = '元'
      //最大处理的数字
      let maxNum = 999999999999999.9999
      //金额整数部分
      let integerNum
      //金额小数部分
      let decimalNum
      //输出的中文金额字符串
      let chineseStr = ''
      //分离金额后用的数组，预定义
      let parts
      if (money == '') {
        return ''
      }
      money = parseFloat(money)
      if (money >= maxNum) {
        //超出最大处理数字
        return ''
      }
      if (money == 0) {
        chineseStr = cnNums[0] + cnIntLast + cnInteger
        return chineseStr
      }
      //转换为字符串
      money = money.toString()
      if (money.indexOf('.') == -1) {
        integerNum = money
        decimalNum = ''
      } else {
        parts = money.split('.')
        integerNum = parts[0]
        decimalNum = parts[1].substr(0, 4)
      }
      //获取整型部分转换
      if (parseInt(integerNum, 10) > 0) {
        let zeroCount = 0
        let IntLen = integerNum.length
        for (let i = 0; i < IntLen; i++) {
          let n = integerNum.substr(i, 1)
          let p = IntLen - i - 1
          let q = p / 4
          let m = p % 4
          if (n == '0') {
            zeroCount++
          } else {
            if (zeroCount > 0) {
              chineseStr += cnNums[0]
            }
            //归零
            zeroCount = 0
            chineseStr += cnNums[parseInt(n)] + cnIntRadice[m]
          }
          if (m == 0 && zeroCount < 4) {
            chineseStr += cnIntUnits[q]
          }
        }
        chineseStr += cnIntLast
      }
      //小数部分
      if (decimalNum != '') {
        let decLen = decimalNum.length
        for (let i = 0; i < decLen; i++) {
          let n = decimalNum.substr(i, 1)
          if (n != '0') {
            chineseStr += cnNums[Number(n)] + cnDecUnits[i]
          }
        }
      }
      if (chineseStr == '') {
        chineseStr += cnNums[0] + cnIntLast + cnInteger
      } else if (decimalNum == '') {
        chineseStr += cnInteger
      }
      return chineseStr
    },

    sum(list) {
      let total = 0
      list.forEach(function (item) {
        let money = parseFloat(item.money)
        total += money
      })
      return total.toFixed(2)
    },
  },
}
</script>

<style lang="scss" scoped>
  ::v-deep .el-table {
    border: 1px solid #eee;
    border-bottom: none;
  }

  ::v-deep thead {
    tr {
      background: #f5f7fa;

      th {
        background: transparent;
      }
    }
  }
</style>
