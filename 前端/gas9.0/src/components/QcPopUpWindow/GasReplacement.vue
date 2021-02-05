<!--补气 -->
<template>
  <div v-loading="loading">
    <el-steps :active="active" finish-status="success">
      <el-step title="开始"></el-step>
      <!-- <el-step title="待写卡"></el-step> -->
      <el-step
        v-if="orderSourceName === 'IC_RECHARGE' || orderSourceName === 'READMETER_PAY'"
        title="待写卡"
      ></el-step>
      <el-step title="待上表"></el-step>
    </el-steps>
    <el-card shadow="never" class="h195">
      <div slot="header">
        <span class="card-title">业务信息</span>
      </div>
      <el-form v-if="active != 3" label-position="top" class="jh-text">
        <el-form-item label="累计充值金额">
          <p>{{ formData.totalChargeMoney || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值气量">
          <p>{{ formData.totalChargeGas || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="累计充值次数">
          <p>{{ formData.totalChargeCount || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上次充值量">
          <p>{{ formData.value1 || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上上次充值量">
          <p>{{ formData.value2 || emptyStr }}</p>
        </el-form-item>
        <el-form-item label="上上上次充值量">
          <p>{{ formData.value3 || emptyStr }}</p>
        </el-form-item>
        <el-form-item v-if="repGasStatus == 'WAIT_OPERATE'" label=" ">
          <el-button type="primary" @click="readCardLoad()">读写卡</el-button>
        </el-form-item>
      </el-form>
      <div v-if="active == 3">
        <h1 class="success">
          <i class="el-icon-success"></i>
          业务办理成功!
        </h1>
        <p class="success-text">即将返回……</p>
      </div>
      <el-form v-if="repGasStatus === ''" label-position="top" class="jh-text">
        <el-form-item v-if="orderSourceName === 'IC_RECHARGE'" label="补气方式">
          <el-select
            v-model="repGasData.repGasMethod"
            clearable
            placeholder=""
            @change="repGasMethodChange"
          >
            <el-option
              v-for="item in repGasMethodOption"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-if="amountMark === 'GAS'" label="补气量">
          <el-input
            v-model="repGasData.repGas"
            type="number"
            placeholder=""
            clearable
            @input="val => formatter(val, 'repGas')"
          >
          </el-input>
          <!-- <el-input-number v-model="repGasData.repGas" :min="0" :controls="false" :precision="2"></el-input-number> -->
        </el-form-item>
        <el-form-item v-else label="补金额">
          <el-input v-model="repGasData.repMoney" type="number" placeholder="" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="补气原因">
          <el-input v-model="repGasData.repGasDesc" placeholder="" clearable> </el-input>
        </el-form-item>
        <el-form-item label=" ">
          <el-button
            :disabled="!isrepGas"
            :loading="repGasLoading"
            type="primary"
            @click="repGasSave"
            >补气
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import Api from '@/api/card/index'
import { dictionaryCodeMap } from '@/enums/dictionary'

export default {
  name: 'GasReplacement',
  props: {
    gasMeterCode: String,
    customerCode: String,
    gasReplaceData: null,
  },
  data() {
    return {
      repGasLoading: false,
      loading: true,
      emptyStr: '-',
      supplementGasRecord: null,
      repGasMethodOption: [
        {
          value: 'REP_PRE_RECHARGE',
          label: '补上次充值',
        },
        {
          value: 'NOT_REP_RECHARGE',
          label: '不补气量',
        },
      ],
      repGasData: {
        repGasDesc: '', //补气原因
        repGas: '', //补气量
        repMoney: '', //补金额
        repGasMethod: '', //补气方式
      },
      formData: {
        totalChargeCount: '', //累计充值次数
        totalChargeGas: '', //累计充值气量
        totalChargeMoney: '', //累计充值金额
        value1: '', //上/上上/上上上次充值量
        value2: '',
        value3: '',
      },
      repGasStatus: '', //状态
      repGasStatusText: '待操作', //状态文本
      statusMap: {
        WAIT_OPERATE: '待操作',
        WAIT_TO_METER: '待上表',
        REP_GAS_SUCCESS: '补气完成',
      },
      //数据字典
      dicts: {
        REP_GAS_METHOD: {},
      },
      amountMark: null,
      orderSourceName: null,
      repGasRecordId: null,
    }
  },
  computed: {
    isrepGas() {
      return (
        this.repGasData.repGasMethod !== '' &&
        this.repGasData.repGasDesc !== '' &&
        (this.repGasData.repGas !== '' || this.repGasData.repMoney !== '')
      )
    },
    active() {
      let active = 1
      switch (this.repGasStatus) {
        case '':
          active = 1
          break
        case 'WAIT_OPERATE':
          active = 2
          break
        case 'WAIT_TO_METER':
          active = 3
          break
        default:
          active = 1
      }
      return active
    },
  },
  watch: {
    gasReplaceData(n, o) {
      console.log(n, o)
      this.repGasData = {
        repGasDesc: '',
        repGas: '',
        repMoney: '',
        repGasMethod: '',
      }
    },
  },
  mounted() {
    //初始化数据字典
    this.dicts = {
      REP_GAS_METHOD: this.dictMap[dictionaryCodeMap.REP_GAS_METHOD],
    }
    this.handleDicts(this.dicts.REP_GAS_METHOD, 'repGasMethodOption')
  },
  created() {
    this.getCardData()
  },
  methods: {
    //input框必须输入正整数，保留两位小数
    formatter(val, target) {
      this.repGasData[target] = this.repGasData[target]
        .replace(/[^\d.]/g, '')
        .replace(/\.{2,}/g, '.')
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3')
        .replace(/^\./g, '')
    },
    handleDicts(dict, target) {
      const temp = []
      for (let i in dict) {
        temp.push({
          value: i,
          label: dict[i],
        })
      }
      this[target] = temp
    },
    getCardData(reGive) {
      // Api.repGascheck({ gasMeterCode: this.gasMeterCode })
      //   .then(res => {
      const { gasMeterInfo: data, supplementGasRecord } = reGive ? reGive : this.gasReplaceData
      this.amountMark = this.gasReplaceData.amountMark
      this.orderSourceName = this.gasReplaceData.orderSourceName
      data ? (this.formData = data) : null
      this.supplementGasRecord = supplementGasRecord
      // this.repGasStatusText = this.statusMap[supplementGasRecord?.repGasStatus]
      if (supplementGasRecord) {
        const { repGasDesc, repGas, repMoney, repGasMethod } = supplementGasRecord
        this.repGasRecordId = supplementGasRecord.id
        this.repGasData = { repGasDesc, repGas, repMoney, repGasMethod }
        this.repGasStatus = supplementGasRecord.repGasStatus
      }
      this.loading = false
      // })
      // .catch(err => {
      //   this.dialogCloses('showGas')
      // }).finally(()=>{
      //   this.loading = false
      // })
    },
    /* 补气change方法 */
    repGasMethodChange() {
      if (this.repGasData.repGasMethod === 'REP_PRE_CHARGE') {
        this.amountMark === 'GAS'
          ? (this.repGasData.repGas = this.formData.value1)
          : (this.repGasData.repMoney = this.formData.value1)
      } else {
        this.repGasData.repGas = ''
      }
    },
    //获取补气最新状态
    reGasReplaceCheck() {
      Api.repGascheck({ gasMeterCode: this.gasMeterCode, customerCode: this.customerCode }).then(
        res => {
          if (res.data.isSuccess) {
            this.getCardData(res.data.data)
          }
        }
      )
    },
    //读写卡
    async readCardLoad(id) {
      id = id ? id : this.repGasRecordId
      const reback = await Api.shakeHandsSocket({
        shakeOne: Api.repGasLoad,
        shakeTwo: Api.repGasCallBack,
        code: this.gasMeterCode,
        id,
        bizIdOrNo: id,
        callBack: () => {
          this.loading = false
          this.$loading().close()
          this.reGasReplaceCheck()
          setTimeout(() => {
            this.$emit('gasReplacementClose')
          }, 3000)
        },
        error: () => {
          this.loading = false
          this.$loading().close()
          this.reGasReplaceCheck()
        },
      })
      // console.log(reback)
      // .catch(res=>{
      //   console.log(res)
      // }).finally(()=>{
      //   this.repGasLoading = false
      //   this.$loading().close()
      //   this.repGasStatus = 'WAIT_TO_METER'
      // })
    },
    // 补气保存按钮
    repGasSave() {
      this.repGasLoading = true
      const params = this.repGasData
      params.gasMeterCode = this.gasMeterCode
      params.customerCode = this.customerCode
      if (params.repGas <= 0 && params.repMoney <= 0) {
        this.$message({
          message: '请输入正确的气量或金额',
          type: 'warning',
        })
        this.repGasLoading = false
        return
      }
      // console.log(params)
      Api.repGasAdd(params)
        .then(res => {
          const {
            isSuccess,
            data: { supplementGasRecord },
          } = res.data
          if (isSuccess) {
            this.repGasRecordId = supplementGasRecord.id
            this.repGasLoading = false
            this.$message({
              message: '补气保存成功',
              type: 'success',
            })
            if (this.orderSourceName === 'IC_RECHARGE') {
              //如果是IC卡，读写卡操作
              this.readCardLoad(supplementGasRecord.id)
              // Api.shakeHandsSocket({
              //   shakeOne: Api.repGasLoad,
              //   shakeTwo: Api.repGasCallBack,
              //   code: this.gasMeterCode,
              //   id: supplementGasRecord.id,
              //   callBack: () => {
              //     this.$message({
              //       message: '读写卡成功，补气完成！',
              //       type: 'success',
              //     })
              //   },
              // })
              this.repGasStatus = 'WAIT_OPERATE'
            } else {
              this.repGasStatus = 'WAIT_TO_METER'
              setTimeout(() => {
                this.$emit('gasReplacementClose')
              }, 3000)
            }
          }
        })
        .finally(() => {
          this.repGasLoading = false
        })
    },
  },
}
</script>

<style lang="scss" scoped>
.success {
  color: #13ce66;
  text-align: center;
  padding-top: 50px;
}

.success-text {
  font-size: 16px;
  color: #666;
  text-align: center;
  padding-bottom: 50px;
}
.btn {
  margin-left: 75%;
  button {
    width: 100%;
  }
}
.text-primary {
  color: #1890ff !important;
}
.text-danger {
  color: #ff4949 !important;
}
.text-success {
  color: #13ce66 !important;
}
.mt15 {
  margin-top: 15px;
}
.el-form-item {
  width: 25% !important;
  padding: 0 5% 0 0 !important;
}
.item2 {
  .el-form-item {
    width: 50%;
  }
}
.jh-text {
  padding-left: 3px;
  .el-form-item {
    width: calc(100% / 5);
    margin-bottom: 15px;
  }
}
</style>
