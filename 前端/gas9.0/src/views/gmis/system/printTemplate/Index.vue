<!-- 打印模板配置-->
<template>
  <div class="qc-main">
    <el-card shadow="never" class="no-border">
      <div slot="header">
        <span class="card-title">打印模板配置</span>
      </div>

      <!-- 模板分类 -->
      <el-tabs v-model="pid" type="card" @tab-click="switchClassify">
        <template v-for="item in classify">
          <el-tab-pane :key="item.id" :label="item.templateTypeName" :name="item.id">
            <div class="subBox">
              <template v-for="subItem in item.children">
                <el-button
                  :key="subItem.id"
                  :subid="subItem.id"
                  :templatetypecode="subItem.templateTypeCode"
                  :type="subItem.id === subId ? 'primary' : ''"
                  @click="getPageList(subItem)"
                >
                  {{ subItem.templateTypeName }}
                </el-button>
              </template>
            </div>
          </el-tab-pane>
        </template>
      </el-tabs>

      <!-- 添加模板 -->
      <div v-if="classify.length" class="topBtn">
        <el-button type="success" @click="addNewTemplate">新增自定义模板</el-button>
        <el-button type="primary" @click="addFromPublicTemplate">从公共库获取模板</el-button>
      </div>

      <!-- 模板列表 -->
      <el-table ref="multipleTable" border="" :data="tableData" tooltip-effect="dark">
        <el-table-column type="index" label="序号" width="55"></el-table-column>
        <el-table-column prop="templateTitle" label="模板名"></el-table-column>
        <el-table-column prop="defaultStatus" label="使用中">
          <template slot-scope="{ row }">
            <el-tag v-if="row.defaultStatus === 0" type="success">使用中</el-tag>
            <el-tag v-if="row.defaultStatus === 1" type="info">未使用</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="dataStatus" label="审核状态">
          <template slot-scope="{ row }">
            <el-tag v-if="row.dataStatus === -2" type="info">未分享</el-tag>
            <el-tag v-if="row.dataStatus === 0" type="">待审</el-tag>
            <el-tag v-if="row.dataStatus === 1" type="success">通过</el-tag>
            <el-tag v-if="row.dataStatus === -1" type="danger">未通过</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="rejectReson" label="驳回原因">
          <template slot-scope="{ row }">
            {{ row.rejectReson }}
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="370">
          <div slot-scope="{ row }">
            <!-- 测试模板 -->
            <el-button v-has-permission="['template:test']" type="primary" @click="testPrint(row)">测试</el-button>
            <!-- 删除模板 -->
            <el-button
              v-has-permission="['template:delete']"
              type="danger"
              @click="deleteTemplate(row)"
              >删除</el-button>

            <!-- 编辑模板 -->
            <el-button type="warning" @click="editTempate(row)">编辑</el-button>

            <!-- 设置默认模板 -->
            <el-button v-if="row.itemStatus === 0" type="success" @click="setDefaultTemplate(row)">设为默认</el-button>

            <!-- 设置默认模板 -->
            <el-tooltip
              v-if="row.itemStatus === 0"
              content="我的模板很好，我要分享给别人使用"
              placement="top"
              effect="light"
            >
              <el-button
                v-if="row.dataStatus === -2 || row.dataStatus === -1"
                type="success"
                @click="share(row)"
                >分享</el-button>
            </el-tooltip>
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

      <!-- test -->
      <el-button type="success" @click="billPrint()">获取默认模板</el-button>
    </el-card>

    <!-- 弹窗 -->
    <!-- edit -->
    <el-dialog
      :visible.sync="showEdit"
      width="800px"
      :title="editInfo.type === 'add' ? '新增打印模板' : '编辑打印模板'"
      @close="editClose"
    >
      <template-edit v-if="showEdit" :edit-info="editInfo" @close="editClose"></template-edit>
    </el-dialog>

    <!-- 添加公共模板 -->
    <el-dialog :visible.sync="showPublic" width="800px" title="添加公共模板" @close="closePublic">
      <public-template
        v-if="showPublic"
        :search-data="search"
        @close="closePublic"
      ></public-template>
    </el-dialog>
  </div>
</template>

<script>
// 打印测试数据
import apiFile from '@/api/File.js'
import apiPrintTemplate from '@/api/system/printTemplate.js'
import { getLodop } from '@/utils/LodopFuncs.js'
import TemplateEdit from './Edit.vue'
import PublicTemplate from './publicTemplate.vue'
import print from '@/utils/print/print.js'
import {upMoney} from '@/utils/print/print.js'
let LODOP

export default {
  name: 'PrintTemplate',
  components: {
    TemplateEdit,
    PublicTemplate,
  },
  data() {
    return {
      pid: '', // 当前一级分类ID
      subId: '', // 当前二级分类ID
      classify: [], // 模板分类all
      curRow: null,
      // 查询数据
      search: this.initQueryParams({
        model: {
          templateCode: '',
        },
      }),
      total: 0,
      tableData: [],
      testTpl: '',

      //
      showEdit: false,
      editInfo: {
        type: 'add', // add | edit
        templateTypeId: '', // 一级模板分类ID
        templateCode: '', // 二级分类模板code
        itemContent: '', // 模板内容
        templateTitle: '', // 模板名
        itemStatus: '',
      },

      // ==========
      showPublic: false,
    }
  },
  created() {
    this.getTemplateClassify()
  },
  methods: {
    // 获取所有模板分类
    getTemplateClassify() {
      apiPrintTemplate.templateClassify().then(res => {
        let { isSuccess, data } = res.data
        if ((isSuccess, data)) {
          this.classify = data
          // 获取第一条数据 设置高亮
          this.pid = this.classify[0].id
          // 设置二级分类 高亮
          this.subId = this.classify[0].children[0].id
          this.search.model.templateCode = this.classify[0].children[0].templateTypeCode
          this.getPageList()
        }
      })
    },

    // 点击一级分类
    switchClassify(tabs) {
      // console.log(item.$children[0].$attrs)
      // 设置二级分类 高亮
      this.subId = tabs.$children[0].$attrs.subid
      this.search.model.templateCode = tabs.$children[0].$attrs.templatetypecode
      this.getPageList()
    },

    // 获取模板列表数据
    getPageList(item) {
      // 如果点击的是二级分类
      if (item) {
        this.subId = item.id
        this.search.model.templateCode = item.templateTypeCode
      }

      apiPrintTemplate.page(this.search).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.tableData = data.records
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

        print[row.templateCode](null,row.itemContent)

      } catch {
        this.msg('该模板有误，请检查！', 'error')
      }
    },

    // ==============================================
    addNewTemplate() {
      this.editInfo.type = 'add'
      this.editInfo.templateTypeId = this.pid
      this.editInfo.templateCode = this.search.model.templateCode
      this.editInfo.itemContent = ''
      this.editInfo.id = null
      this.editInfo.templateTitle = ''
      this.editInfo.itemDescribe = ''
      this.showEdit = true
    },

    // 编辑模板
    editTempate(row) {
      this.editInfo.type = 'edit'
      this.editInfo.templateTypeId = row.templateTypeId
      this.editInfo.templateCode = row.templateCode
      this.editInfo.itemContent = row.itemContent
        .replace(/QcBody/g, 'body')
        .replace(/QcScript/g, 'script')
      // console.log(this.editInfo.itemContent)
      this.editInfo.id = row.id
      this.editInfo.templateTitle = row.templateTitle
      this.editInfo.itemStatus = row.itemStatus
      this.editInfo.itemDescribe = row.itemDescribe
      this.showEdit = true
    },

    // 从公共库获取模板
    addFromPublicTemplate() {
      this.showPublic = true
    },

    // 删除模板
    deleteTemplate(row) {
      if (row.defaultStatus === 0) {
        this.msg('使用中的模板，不能删除', 'error')
        return false
      }

      this.$confirm('确认删除该模板？')
        .then(() => {
          let ids = [row.id]
          apiPrintTemplate.delete(ids).then(res => {
            let { isSuccess, data } = res.data
            if (isSuccess) {
              this.msg('删除成功', 'success')
              this.getPageList()
            }
          })
        })
        .catch(() => {
          return
        })
    },

    // 设为默认模板
    setDefaultTemplate(row) {
      let { id, templateCode, templateTypeId } = row
      apiPrintTemplate.setDefault({ id, templateCode, templateTypeId }).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.msg('设置成功', 'success')
          this.getPageList()
        }
      })
    },

    // 共享模板详情（需要平台管理员审核）
    share(row) {
      apiPrintTemplate.shareTemplate({ id: row.id }).then(res => {
        let { isSuccess, data } = res.data
        if (isSuccess) {
          this.msg('分享成功，等待平台审核', 'success')
          this.getPageList()
        }
      })
    },

    // editClose
    editClose() {
      this.showEdit = false
      this.search.model.itemStatus = 0
      this.getPageList()
    },

    // =======================================================================================
    // 公共模板编辑
    closePublic() {
      this.showPublic = false
      this.getPageList()
    },

    billPrint() {
      let data = {
        chargeRecord: {
          id: '1319229492887027712',
          createTime: '2020-10-22 18:49:55',
          createUser: '3',
          updateTime: '2020-10-22 18:49:55',
          updateUser: '3',
          companyCode: '0000',
          companyName: '秦川的内置企业',
          orgId: '100',
          orgName: '秦川集团股份有限公司',
          businessHallId: null,
          businessHallName: null,
          customerCode: 'BC202009090000000193',
          gasMeterCode: 'BMC202009080000000100',
          chargeChannel: 'GT',
          customerName: 'sanorol',
          chargeNo: 'CC202010220000000048',
          chargeMethodCode: 'CASH',
          chargeMethodName: '现金',
          payableMoney: '310',
          chargeMoney: '300',
          prechargeMoney: '0',
          rechargeMoney: '0',
          rechargeGas: '0.00',
          rechargeGiveGas: '0.00',
          rechargeGiveMoney: '0.00',
          reductionMoney: '10',
          prechargeDeductionMoney: '50',
          receivableMoney: '250',
          actualIncomeMoney: '250',
          giveChange: '0',
          insuranceContractNo: '',
          insurancePremium: '0',
          insuranceStartDate: null,
          insuranceEndDate: null,
          giveDeductionMoney: '0.00',
          giveBookPreMoney: '0.0000',
          giveBookAfterMoney: '0.0000',
          chargePreMoney: '100.0000',
          chargeAfterMoney: '50.0000',
          chargeStatus: 'CHARGED',
          invoiceStatus: 'NOT_OPEN',
          receiptStatus: 'NOT_OPEN',
          invoiceType: null,
          invoiceNo: null,
          createUserId: '3',
          createUserName: '平台超管',
          remark: '',
          dataStatus: 1,
        },
        sceneIds: ['1'],
        arrearIds: ['3'],
        chargeItemRecords: [
          {
            id: '1319229486322941952',
            createTime: '2020-10-22 18:49:54',
            createUser: '3',
            updateTime: '2020-10-22 18:49:54',
            updateUser: '3',
            companyCode: '0000',
            companyName: '秦川的内置企业',
            orgId: '100',
            orgName: '秦川集团股份有限公司',
            businessHallId: null,
            businessHallName: null,
            customerCode: 'BC202009090000000193',
            customerName: 'sanorol',
            gasmeterCode: 'BMC202009080000000100',
            gasmeterName: '金额气量表',
            tollItemScene: 'READ_METER_CHARGE',
            tollItemId: '1316941040078291001',
            chargeItemName: '2020-05燃气费****',
            chargeItemTime: '2020-09-15 11:21:25',
            chargeItemSourceCode: 'GASFEE',
            chargeItemSourceName: '燃气费收费项',
            chargeNo: 'CC202010220000000048',
            chargeItemSourceId: '3',
            chargeItemMoney: '100.0000',
            chargeItemGas: '100.0000',
            chargeFrequency: 'BY_MONTH',
            moneyMethod: 'fixed',
            rechargeGiveGas: '0.00',
            rechargeGiveMoney: '0.00',
            isReductionItem: false,
            createUserId: '3',
            createUserName: '平台超管',
            remark: null,
            dataStatus: 1,
          },
          {
            id: '1319229486364884992',
            createTime: '2020-10-22 18:49:54',
            createUser: '3',
            updateTime: '2020-10-22 18:49:54',
            updateUser: '3',
            companyCode: '0000',
            companyName: '秦川的内置企业',
            orgId: '100',
            orgName: '秦川集团股份有限公司',
            businessHallId: null,
            businessHallName: null,
            customerCode: 'BC202009090000000193',
            customerName: 'sanorol',
            gasmeterCode: 'BMC202009080000000100',
            gasmeterName: '金额气量表',
            tollItemScene: 'READ_METER_CHARGE',
            tollItemId: '1316941040078291001',
            chargeItemName: '2020-05滞纳金',
            chargeItemTime: '2020-09-15 11:21:25',
            chargeItemSourceCode: 'LAYPAYFEE',
            chargeItemSourceName: '滞纳金收费项',
            chargeNo: 'CC202010220000000048',
            chargeItemSourceId: '3',
            chargeItemMoney: '100.0000',
            chargeItemGas: '100.0000',
            chargeFrequency: 'BY_MONTH',
            moneyMethod: 'fixed',
            rechargeGiveGas: '0.00',
            rechargeGiveMoney: '0.00',
            isReductionItem: false,
            createUserId: '3',
            createUserName: '平台超管',
            remark: null,
            dataStatus: 1,
          },
          {
            id: '1319229486369079296',
            createTime: '2020-10-22 18:49:54',
            createUser: '3',
            updateTime: '2020-10-22 18:49:54',
            updateUser: '3',
            companyCode: '0000',
            companyName: '秦川的内置企业',
            orgId: '100',
            orgName: '秦川集团股份有限公司',
            businessHallId: null,
            businessHallName: null,
            customerCode: 'BC202009090000000193',
            customerName: 'sanorol',
            gasmeterCode: 'BMC202009080000000100',
            gasmeterName: '金额气量表',
            tollItemScene: 'INSTALL',
            tollItemId: '1316941040078290944',
            chargeItemName: '报装费1',
            chargeItemTime: null,
            chargeItemSourceCode: 'SCENEFEE',
            chargeItemSourceName: '场景收费项',
            chargeNo: 'CC202010220000000048',
            chargeItemSourceId: '1',
            chargeItemMoney: '100.0000',
            chargeItemGas: '0.00',
            chargeFrequency: 'ONE_TIME',
            moneyMethod: 'fixed',
            rechargeGiveGas: '0.00',
            rechargeGiveMoney: '0.00',
            isReductionItem: false,
            createUserId: '3',
            createUserName: '平台超管',
            remark: null,
            dataStatus: 1,
          },
          {
            id: '1319229486381662208',
            createTime: '2020-10-22 18:49:54',
            createUser: '3',
            updateTime: '2020-10-22 18:49:54',
            updateUser: '3',
            companyCode: '0000',
            companyName: '秦川的内置企业',
            orgId: '100',
            orgName: '秦川集团股份有限公司',
            businessHallId: null,
            businessHallName: null,
            customerCode: 'BC202009090000000193',
            customerName: 'sanorol',
            gasmeterCode: 'BMC202009080000000100',
            gasmeterName: '金额气量表',
            tollItemScene: 'OTHER',
            tollItemId: '3',
            chargeItemName: '按需非固定附加费',
            chargeItemTime: null,
            chargeItemSourceCode: 'OTHER',
            chargeItemSourceName: '其他收费项',
            chargeNo: 'CC202010220000000048',
            chargeItemSourceId: '3',
            chargeItemMoney: '10',
            chargeItemGas: '0.00',
            chargeFrequency: 'ON_DEMAND',
            moneyMethod: 'unfixed',
            rechargeGiveGas: '0.00',
            rechargeGiveMoney: '0.00',
            isReductionItem: false,
            createUserId: '3',
            createUserName: '平台超管',
            remark: null,
            dataStatus: 1,
          },
          {
            id: '1319229486381662209',
            createTime: '2020-10-22 18:49:54',
            createUser: '3',
            updateTime: '2020-10-22 18:49:54',
            updateUser: '3',
            companyCode: '0000',
            companyName: '秦川的内置企业',
            orgId: '100',
            orgName: '秦川集团股份有限公司',
            businessHallId: null,
            businessHallName: null,
            customerCode: 'BC202009090000000193',
            customerName: 'sanorol',
            gasmeterCode: 'BMC202009080000000100',
            gasmeterName: '金额气量表',
            tollItemScene: 'INSTALL',
            tollItemId: '1316941040078290944',
            chargeItemName: '报装收费项1减免1',
            chargeItemTime: null,
            chargeItemSourceCode: 'REDUCTION',
            chargeItemSourceName: '减免项',
            chargeNo: 'CC202010220000000048',
            chargeItemSourceId: '1301036857294848000',
            chargeItemMoney: '10.0000',
            chargeItemGas: '0.00',
            chargeFrequency: 'ON_DEMAND',
            moneyMethod: 'fixed',
            rechargeGiveGas: '0.00',
            rechargeGiveMoney: '0.00',
            isReductionItem: true,
            createUserId: '3',
            createUserName: '平台超管',
            remark: null,
            dataStatus: 1,
          },
        ],
        sysTollItems: null,
      }
      print['GAS_BILL'](data)
    },
  },
}
</script>

<style lang="scss" scoped>
  ::v-deep .el-tabs__header {
    margin: 0;
  }
  ::v-deep .el-tabs__content {
    height: auto;
  }
  .topBtn {
    position: absolute;
    right: 20px;
    top: 60px;
  }
  .subBox {
    padding: 15px 10px;
    .el-link {
      margin: 0 10px;
    }
  }
</style>
