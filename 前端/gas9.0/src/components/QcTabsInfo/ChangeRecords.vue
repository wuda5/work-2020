<!-- 变更记录 -->
<template>
  <info-frame>
    <div slot="title">
      <div class="subTitle">变更记录</div>
    </div>

    <el-collapse v-if="hasRecords" v-loading="loading" accordion>
      <div v-for="(record, title) in records" :key="title">
        <el-collapse-item v-if="record.length">
          <template slot="title">
            {{ title }}
          </template>
          <div v-for="item in record" :key="item.id">
            <p><el-icon name="time" /> {{ item.updateTime | filterEmpty | parseTime }}</p>

            <el-form :model="item" label-position="top" class="jh-text">

              <template v-if="title === '补气记录'">
                <el-form-item label="补气方式">
                  <el-input :value="dictMap[dicts.REP_GAS_METHOD][item.repGasMethod]" />
                </el-form-item>
                <!-- <el-form-item label="表身号">
                  <p>{{ item.gasMeterNumber | filterEmpty }}</p>
                </el-form-item> -->
                <el-form-item v-if="item.amountMark === 'GAS'" label="补气气量">
                  <el-input :value="item.repGas" />
                </el-form-item>
                <el-form-item v-else label="补充金额">
                  <el-input :value="item.repMoney" />
                </el-form-item>
                <el-form-item label="原因" style="width: 100%">
                  <el-input rows="2" :value="item.repGasDesc" />
                </el-form-item>
              </template>

              <template v-else-if="title === '补换卡记录'">
                <el-form-item label="卡号">
                  <el-input :value="item.cardNo" />
                </el-form-item>
                <el-form-item label="卡类型">
                  <el-input :value="item.cardType" />
                </el-form-item>
                <el-form-item label="收费金额">
                  <el-input :value="item.totalMoney" />
                </el-form-item>
                <el-form-item label="补卡方式">
                  <el-input :value="dictMap[dicts.REP_CARD_METHOD][item.repCardMethod]" />
                </el-form-item>
                <el-form-item label="补卡类型">
                  <el-input :value="dictMap[dicts.REP_CARD_TYPE][item.repCardType]" />
                </el-form-item>
                <el-form-item label="原因" style="width: 100%">
                  <el-input rows="2" :value="item.repCardDesc" />
                </el-form-item>
              </template>

              <template v-else-if="title === '用气类型变更记录'">
                <el-form-item label="客户名称">
                  <el-input :value="item.customerName" />
                </el-form-item>
                <el-form-item label="表身号">
                  <el-input :value="item.gasMeterNumber" />
                </el-form-item>
                <el-form-item label="变更后用气类型">
                  <el-input :value="item.newGasTypeName" />
                </el-form-item>
                <el-form-item label="变更前用气类型">
                  <el-input :value="item.oldGasTypeName" />
                </el-form-item>
                <el-form-item label="收费金额">
                  <el-input :value="item.totalMoney" />
                </el-form-item>
              </template>

              <template v-else-if="title === '换表记录'">
                <el-form-item label="客户名称">
                  <el-input :value="item.customerName" />
                </el-form-item>

                <el-form-item label="变更前表身号">
                  <el-input :value="item.oldMeterNumber" />
                </el-form-item>
                <el-form-item label="变更后表身号">
                  <el-input :value="item.newMeterNumber" />
                </el-form-item>
                <el-form-item label="变更后气表版号">
                  <el-input :value="item.newMeterVersionName" />
                </el-form-item>
                <el-form-item label="变更后气表型号">
                  <el-input :value="item.newMeterModelName" />
                </el-form-item>
                <el-form-item label="变更后气表厂家" style="width: 100%">
                  <el-input :value="item.newMeterFactoryName" />
                </el-form-item>
                <el-form-item label="老表止数">
                  <el-input :value="item.oldMeterEndGas" />
                </el-form-item>
                <el-form-item label="新表底数">
                  <el-input :value="item.newMeterStartGas" />
                </el-form-item>
                <el-form-item v-if="endWith(item.changeType)" label="补充气量">
                  <el-input :value="item.supplementGas" />
                </el-form-item>
                <el-form-item v-else label="补充金额">
                  <el-input :value="item.supplementAmount" />
                </el-form-item>
                <el-form-item label="收费金额">
                  <el-input :value="item.totalMoney" />
                </el-form-item>
                <el-form-item label="原因" style="width: 100%">
                  <el-input rows="2" :value="item.changeReason" />
                </el-form-item>
              </template>

              <template v-else-if="title === '拆表记录'">
                <el-form-item label="客户名称">
                  <el-input :value="item.customerName" />
                </el-form-item>
                <el-form-item label="表身号">
                  <el-input :value="item.gasMeterNumber" />
                </el-form-item>
                <el-form-item label="气表型号">
                  <el-input :value="item.meterModelName" />
                </el-form-item>
                <el-form-item label="气表版号">
                  <el-input :value="item.meterVersionName" />
                </el-form-item>
                <el-form-item label="收费金额">
                  <el-input :value="item.totalMoney" />
                </el-form-item>
                <el-form-item label="气表止数">
                  <el-input :value="item.meterEndGas" />
                </el-form-item>
                <el-form-item label="表具余额/多抄金额">
                  <el-input :value="item.meterBalance" />
                </el-form-item>
                <el-form-item label="原因" style="width: 100%">
                  <el-input rows="2" :value="item.removeReason" />
                </el-form-item>
              </template>

              <template v-else-if="title === '过户记录'">
                <el-form-item label="前客户名称">
                  <el-input :value="item.oldCustomerName" />
                </el-form-item>
                <el-form-item label="新档客户">
                  <el-input :value="item.customerName" />
                </el-form-item>
                <el-form-item label="客户类型">
                  <el-input :value="item.customerTypeName" />
                </el-form-item>
                <el-form-item label="表身号">
                  <el-input :value="item.gasMeterNumber" />
                </el-form-item>
                <el-form-item label="客户证件号">
                  <el-input :value="item.idCard" />
                </el-form-item>
                <el-form-item label="性别">
                  <el-input :value="item.sex | filterGender" />
                </el-form-item>
                <el-form-item label="收费金额">
                  <el-input :value="item.totalMoney" />
                </el-form-item>
                <el-form-item label="备注" style="width: 100%">
                  <el-input rows="2" :value="item.remark" />
                </el-form-item>
              </template>
            </el-form>
          </div>
        </el-collapse-item>
      </div>
    </el-collapse>
    <el-alert
      v-else
      title="暂无相关变更信息"
      type="warning"
      show-icon
      :closable="false"
    >
    </el-alert>
  </info-frame>
</template>

<script>
import tabsApi from '@/api/tabsInfo';
import { dictionaryCodeMap } from '@/enums/dictionary'

export default {
  name: 'ChangeRecords',
  filters: {
    filterEmpty(val) {
      return val ?? '--'
    },
    filterGender(val) {
      switch (val) {
        case 'M':
          return '男'
        case 'W':
          return '女'
        default:
          return '未知'
      }
    }
  },
  props: {
    // 传递属性对象，包括gasMeterCode，customerCode
    customerCode: String,
    gasMeterCode: String,
  },
  data() {
    return {
      loading: false,
      hasRecords: false,
      records: {},
      // 字典数据
      dicts: {
        REP_GAS_METHOD: {}, // 补气方式
        REP_CARD_METHOD: {}, // 补卡方式
        REP_CARD_TYPE: {}, // 补卡类型
      }
    }
  },
  watch: {
    customerCode(val, oldVal) {
      if(!val){
        this.hasRecords = false
        this.records={}
      }
      if (val && val !== oldVal) {
        this.fetchChangeRecords()
      }
    },
    gasMeterCode(val, oldVal) {
      if(!val){
        this.hasRecords = false
        this.records={}
      }
      if (val && val !== oldVal) {
        this.fetchChangeRecords()
      }
    }
  },
  created() {
    if(this.customerCode){
      this.fetchChangeRecords()
    }
  },
  mounted() {
    //初始化数据字典
    this.dicts = {
      REP_GAS_METHOD: dictionaryCodeMap.REP_GAS_METHOD,
      REP_CARD_METHOD: dictionaryCodeMap.REP_CARD_METHOD,
      REP_CARD_TYPE: dictionaryCodeMap.REP_CARD_TYPE,
    }
  },
  methods: {
    endWith(val) {
      return val.endsWith('GAS')
    },
    fetchChangeRecords() {
      this.loading = true
      this.hasRecords = false
      let params ={
        customerCode:this.customerCode,
        gasMeterCode:this.gasMeterCode
      }
      tabsApi.getChangeRecord(params).then(res => {
        this.loading = false
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.records = data
          for (let key in this.records) {
            if (this.records[key].length > 0) {
              this.hasRecords = true
              return
            }
          }
        }
      }).catch(() => {
        this.loading = false
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.jh-text {
  border: 1px solid #eee;
  border-radius: 3px;
}

::v-deep .el-collapse-item__header {
  padding-left: 6px;
}
</style>
