<!-- 收费列表上半部分表格 -->
<template>
  <div class="chargeTable">
    <table v-if="isCharge" cellspacing="0" cellpadding="0" border="0">
      <tr>
        <th>收费项</th>
        <th>金额</th>
        <th>操作</th>
      </tr>
      <tr class="addTr">
        <td>
          <el-select
            v-model="emptyChargeItem.chargeItemName"
            placeholder="请选择收费项"
            @change="chargeItemChange"
          >
            <el-option
              v-for="item in waiteAppendItemList"
              :key="item.chargeItemName"
              :value="item.chargeItemName"
              :label="item.chargeItemName"
            />
          </el-select>
        </td>
        <td>
          <!-- @blur="handleChargeItemBlur" -->
          <!-- @keyup.enter.native="handleChargeItemBlur" -->
          <el-input
            v-if="emptyChargeItem.moneyMethod === 'unfixed' && emptyChargeItem.isInput"
            v-model="emptyChargeItem.chargeItemMoney"
            v-focus
            type="number"
            style="width: 100px"
            @keyup.enter.native="addChargeItem"
            @input="val => formatter(val, 'chargeItemMoney')"
          ></el-input>
          <span v-else>
            {{
              emptyChargeItem.linkText === ''
                ? emptyChargeItem.chargeItemMoney
                : emptyChargeItem.linkText
            }}
          </span>
        </td>
        <td>
          <el-button type="primary" plain :disabled="canAddNew" @click="addChargeItem"
            >新增</el-button
          >
        </td>
      </tr>
    </table>
    <div :style="heightStyle">
      <table
        v-if="chargeItemList.length !== 0 && isCharge"
        cellspacing="0"
        cellpadding="0"
        border="0"
        class="chargeListTable"
        :class="chargeItemList.length > 5 ? 'bigger' : ''"
      >
        <tr v-for="(item, index) in chargeItemList" :key="index">
          <td>
            {{ item.chargeItemName }}
          </td>
          <td
            v-if="item.moneyMethod !== 'unfixed'"
            :class="item.isReductionItem ? 'text-success' : 'text-danger'"
          >
            {{ item.isReductionItem ? '-' : '+' }} {{ item.chargeItemMoney | moneyFormat }}
          </td>
          <td v-else>
            <!-- <input :value="item.chargeItemMoney" placeholder="请输入金额" class="input" @input="() => unFixedInput(index)" /> -->
            <input
              v-if="item.isInput"
              v-focusInput
              type="number"
              :value="item.chargeItemMoney"
              placeholder="请输入金额"
              class="input"
              onkeyup="this.value= this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : ''"
              @blur="() => unFixedBlur(index)"
              @keyup.enter="() => unFixedBlur(index)"
              @input="() => unFixedInput(index)"
            />
            <span
              v-if="!item.isInput"
              class="edit"
              :class="item.isReductionItem ? 'text-success' : 'text-danger'"
              @click="() => unFixedClick(index)"
            >
              {{ item.isReductionItem ? '-' : '+' }} {{ item.chargeItemMoney | moneyFormat }}
            </span>
          </td>
          <td>
            <el-button
              v-if="
                item.chargeItemSourceCode !== 'SCENEFEE' && item.chargeItemSourceCode !== 'GASFEE'
              "
              type="danger"
              plain
              @click="removeChargeItem(index)"
              >删除</el-button
            >
          </td>
        </tr>
      </table>
      <div v-else class="no-data"><i class="el-icon-warning-outline" />暂无数据</div>
    </div>
    <span v-show="false" class="hide"> (总金额{{ totals }}) </span>
  </div>
</template>

<script>
import BN from '@/utils/bigNumber'

export default {
  name: 'QcChargeTable',
  directives: {
    // 注册局部指令 v-focus  聚焦并选中内容
    focus: {
      inserted: function (el) {
        el.querySelector('input').focus()
        el.querySelector('input').select()
      },
    },
    focusInput: {
      inserted: function (el) {
        // console.log(el)
        el.focus()
        el.select()
      },
    },
  },
  props: {
    height: {
      type: Number,
      default: 300,
    },
    waiteAppendItemList: Array,
    chargeItemList: Array,
    scene: String,
    orderSourceName: String,
    isCharge: Boolean,
  },
  data() {
    return {
      //新增的收费项
      emptyChargeItem: {
        chargeItemName: '', // 收费项
        chargeItemMoney: '', // 金额
        moneyMethod: 'fixed', //金额方式
        isReductionItem: false, //是否是减免项
        isInput: false, //非固定金额时出现input框
        linkText: '', //联动项时展示文字
      },
      codeMap: ['GASFEE', 'LAYPAYFEE'],
    }
  },
  computed: {
    // 添加按钮禁用与否
    canAddNew: function () {
      return !this.emptyChargeItem.chargeItemName
    },
    // 总金额
    totals: function () {
      let total = 0
      this.chargeItemList.forEach((item, index, array) => {
        if (!item.isReductionItem) {
          // total += item.chargeItemMoney
          total = BN.plus([total, item.chargeItemMoney])
        } else {
          // total -= item.chargeItemMoney
          total = BN.minus(total, item.chargeItemMoney)
        }
      })
      this.$emit('setTotalMoney', total)
      return total
    },
    //收费项table 框高度
    heightStyle: function () {
      return {
        height: this.height ? `${this.height + 20}px` : 'auto',
        overflow: 'auto',
      }
    },
  },
  watch: {
    waiteAppendItemList() {
      this.emptyChargeItem = {
        chargeItemName: '',
        chargeItemMoney: '',
        moneyMethod: 'fixed',
        isReductionItem: false,
        isInput: false,
        linkText: '',
      }
    },
  },
  created() {
    // this.isShowList =
    //   (await this.whetherSceneCharge('issue_card'.toUpperCase())) && this.scene === 'issue_card'
    // if (this.scene === 'issue_card') {
    //   this.isShowList = this.isCharge
    // }
  },
  methods: {
    message(text) {
      this.$message({
        message: text,
        type: 'warning',
        offset: 400,
      })
    },
    //非固定收费项，失焦
    unFixedBlur(index) {
      const { chargeItemList, isReductionChargeItem } = this
      const target = chargeItemList[index]
      if (target.chargeItemSourceCode === 'REDUCTION') {
        //减免项
        if (target.tollItemScene === 'GASFEE') {
          //滞纳金
          let gasFeeTot = []
          chargeItemList.map(item => {
            if (item.chargeItemSourceCode === 'LAYPAYFEE') {
              gasFeeTot.push(item.chargeItemMoney)
            }
          })
          if (BN.gt(target.chargeItemMoney, BN.plus(gasFeeTot))) {
            //滞纳金减免项金额不能大于对应全部收费项的总和
            this.$message({
              showClose: true,
              message: '减免滞纳金金额不能大于收费项金额！',
              type: 'warning',
            })
            chargeItemList[index].chargeItemMoney = BN.plus(gasFeeTot)
          }
        } else {
          //非滞纳金减免项减免金额不能大于对应收费项金额
          const chargeItem = chargeItemList.filter(item => {
            if (
              item.tollItemId === target.tollItemId &&
              item.chargeItemSourceCode !== 'REDUCTION'
            ) {
              return item
            }
          })
          if (BN.gt(target.chargeItemMoney, chargeItem[0].chargeItemMoney)) {
            this.$message({
              showClose: true,
              message: '减免金额不能大于收费项金额！',
              type: 'warning',
            })
            chargeItemList[index].chargeItemMoney = chargeItem[0].chargeItemMoney
          }
        }
      }
      chargeItemList[index].isInput = false
    },
    //处理新增收费项不固定金额时输入框
    handleChargeItemBlur() {
      this.emptyChargeItem.isInput = false
      this.emptyChargeItem.chargeItemMoney = Number(this.emptyChargeItem.chargeItemMoney)
    },
    //非固定收费项，点击事件
    unFixedClick(index) {
      this.chargeItemList[index].isInput = true
    },
    //非固定收费项，输入框事件
    unFixedInput(index) {
      const { chargeItemList } = this,
        value = BN.toFixed(event.target.value, 2)
      chargeItemList[index].chargeItemMoney = Number(value)
    },
    // 收费项select框change事件
    chargeItemChange(v) {
      const target = this.waiteAppendItemList.filter(i => {
        return i.chargeItemName == v
      })
      if (this.codeMap.includes(target[0].chargeItemSourceCode)) {
        let flag = false
        this.waiteAppendItemList.forEach(item => {
          if (!item.chargeItemTime) {
            return
          }
          //判断是否为最新时间
          if (new Date(target[0].chargeItemTime) > new Date(item.chargeItemTime)) {
            flag = true
          }
        })
        if (flag) {
          this.message('该日期之前还有未缴纳的收费项！')
          this.initDefaultEmptyChargeItem()
          return
        }
      }
      this.emptyChargeItem.linkText = ''
      this.waiteAppendItemList.forEach(i => {
        if (
          this.codeMap.includes(target[0].chargeItemSourceCode) &&
          this.codeMap.includes(i.chargeItemSourceCode) &&
          target[0].chargeItemSourceId == i.chargeItemSourceId
        ) {
          this.emptyChargeItem.linkText += `（${i.chargeItemName} + ${i.chargeItemMoney}元) `
        }
        if (i.chargeItemName === v) {
          this.emptyChargeItem.chargeItemMoney = i.chargeItemMoney
          this.emptyChargeItem.moneyMethod = i.moneyMethod
          this.emptyChargeItem.isInput = i.isInput
          this.emptyChargeItem.isReductionItem = i.isReductionItem
        }
      })
    },
    // 还原默认值
    initDefaultEmptyChargeItem() {
      this.emptyChargeItem = {
        chargeItemName: '',
        chargeItemMoney: '',
        moneyMethod: 'fixed',
        isReductionItem: false,
        isInput: false,
        linkText: '',
      }
    },
    // 新增收费项
    addChargeItem() {
      const {
        codeMap,
        emptyChargeItem,
        waiteAppendItemList,
        chargeItemList,
        isReductionChargeItem,
        initDefaultEmptyChargeItem,
        addMain,
      } = this
      if (Number(emptyChargeItem.chargeItemMoney) < 0) {
        //输入负数时处理
        this.$message({
          showClose: true,
          message: '不能输入负数！',
          type: 'warning',
        })
        emptyChargeItem.isInput = true
        return
      }
      const target = waiteAppendItemList.filter(i => {
        return i.chargeItemName == emptyChargeItem.chargeItemName
      })
      const { chargeItemSourceCode } = target[0]
      switch (chargeItemSourceCode) {
        case 'GASFEE': //燃气费
        case 'LAYPAYFEE': //滞纳金
          // eslint-disable-next-line no-case-declarations
          let more = []
          more = waiteAppendItemList.filter(i => {
            return target[0].chargeItemSourceId == i.chargeItemSourceId
          })
          more.forEach(i => {
            i.isInput = false
            chargeItemList.unshift(i)
            waiteAppendItemList.forEach((j, idx) => {
              if (
                codeMap.includes(j.chargeItemSourceCode) &&
                j.chargeItemSourceId === i.chargeItemSourceId
              ) {
                waiteAppendItemList.splice(idx, 1)
              }
            })
          })
          initDefaultEmptyChargeItem()
          break
        case 'REDUCTION': //减免项
          // eslint-disable-next-line no-case-declarations
          const { targets: chargeItem, flag: reductionChargeItemFlag } = isReductionChargeItem(
            target[0]
          )
          if (!reductionChargeItemFlag) {
            this.message('请先添加对应的收费项！')
            return
          }
          if (isReductionChargeItem(chargeItem[0], true).flag) {
            this.message('已有其他减免项！')
            return
          }
          // if (Number(target[0].chargeItemMoney) > Number(chargeItem[0].chargeItemMoney)) {
          //   this.message('减免金额超额！')
          //   return
          // }
          // eslint-disable-next-line no-case-declarations
          let totalReduction = 0
          //如果是滞纳金减免项
          if (
            target[0].tollItemScene == 'GAS_FEE' &&
            target[0].chargeItemSourceCode == 'REDUCTION'
          ) {
            chargeItemList.forEach(i => {
              if (i.chargeItemSourceCode == 'LAYPAYFEE') {
                totalReduction += Number(i.chargeItemMoney)
              }
            })
          } else {
            //其他情况
            totalReduction = Number(chargeItem[0].chargeItemMoney)
          }
          if (BN.gt(emptyChargeItem.chargeItemMoney, totalReduction)) {
            this.message('减免金额不能大于收费项金额！')
            return
          }
          target[0].isInput = false
          addMain(target[0])
          break
        default:
          //其余
          target[0].isInput = false
          addMain(target[0])
      }
    },
    //删除收费项，收费项显示列表移除，移入待添加收费项
    removeChargeItem(index) {
      const {
        chargeItemList,
        waiteAppendItemList,
        deleteMain,
        isLatestItem,
        isLaypayFeeReduction,
        isOtherLaypay,
      } = this
      const target = chargeItemList[index]
      const { chargeItemSourceCode } = target
      const { targets: glTargets, flag: isLatestItemFlag } = isLatestItem(target)
      const { targets: lrTargets, flag: isLaypayFeeReductionFlag } = isLaypayFeeReduction()
      switch (chargeItemSourceCode) {
        case 'GASFEE': //燃气费
        case 'LAYPAYFEE': //滞纳金
          if (isLatestItemFlag) {
            //如果不是最新收费项
            return
          }
          if (!isLaypayFeeReductionFlag) {
            //如果不存在滞纳金减免项
            deleteMain(glTargets, index)
          } else {
            if (isOtherLaypay()) {
              //如果还有别的滞纳金收费项
              const targetLaypay = glTargets.filter(i => {
                return i.chargeItemSourceCode === 'LAYPAYFEE'
              })
              let redution =
                Number(lrTargets[0].chargeItemMoney) - Number(targetLaypay.chargeItemMoney)
              lrTargets[0].chargeItemMoney = redution < 0 ? 0 : redution
              deleteMain(glTargets, index)
            } else {
              deleteMain(glTargets.concat(lrTargets), index)
            }
          }
          // eslint-disable-next-line no-case-declarations
          let layPayeeReduction = {},
            layPayeeReductionIndex,
            layPayeeReductionTotal = 0
          chargeItemList.forEach((i, idx) => {
            if (i.tollItemScene == 'GAS_FEE' && i.chargeItemSourceCode == 'REDUCTION') {
              layPayeeReduction = i
              layPayeeReductionIndex = idx
            }
            if (i.tollItemScene == 'GAS_FEE' && i.chargeItemSourceCode == 'LAYPAYFEE') {
              layPayeeReductionTotal += Number(i.chargeItemMoney)
            }
          })
          //如果滞纳金减免项金额大于剩下所有滞纳金总和，则收费列表里删除滞纳金减免项
          if (BN.gt(layPayeeReduction.chargeItemMoney, layPayeeReductionTotal)) {
            deleteMain(layPayeeReduction, layPayeeReductionIndex)
          }
          break
        case 'REDUCTION': //减免项
          deleteMain(target, index)
          break
        default:
          //其余
          // eslint-disable-next-line no-case-declarations
          const { tollItemId } = target
          // eslint-disable-next-line no-case-declarations
          const dTargets = chargeItemList.filter(i => {
            return i.tollItemId === tollItemId
          })
          deleteMain(dTargets, index)
      }
    },
    //删除核心方法
    deleteMain(target, index) {
      const { chargeItemList, waiteAppendItemList } = this
      if (Array.isArray(target)) {
        target.forEach(i => {
          if (i.moneyMethod == 'unfixed') {
            i.isInput = true
          }
          waiteAppendItemList.push(i)
          chargeItemList.forEach((j, idx) => {
            if (
              j.chargeItemSourceId === i.chargeItemSourceId &&
              j.chargeItemSourceCode === i.chargeItemSourceCode
            ) {
              chargeItemList.splice(idx, 1)
            }
          })
        })
      } else {
        chargeItemList.splice(index, 1)
        waiteAppendItemList.push(target)
      }
    },
    //是否是最新的燃气收费项,返回:flag / 燃气费+滞纳金项
    isLatestItem(target) {
      let flag = false
      const { chargeItemList, codeMap } = this
      const targets = chargeItemList.filter(item => {
        //判断是否为最新时间
        if (new Date(target.chargeItemTime) < new Date(item.chargeItemTime)) {
          flag = true
        }
        if (codeMap.includes(item.chargeItemSourceCode)) {
          return target.chargeItemSourceId == item.chargeItemSourceId
        }
      })
      if (flag && codeMap.includes(target.chargeItemSourceCode)) {
        this.message('请选择最新日期的收费项！')
      }
      return { flag, targets }
    },
    //是否存在滞纳金减免项,返回:flag / 滞纳金减免项
    isLaypayFeeReduction() {
      const { chargeItemList } = this
      let flag = false
      const targets = chargeItemList.filter(i => {
        if (i.tollItemScene === 'READ_METER_CHARGE' && i.chargeItemSourceCode === 'REDUCTION') {
          flag = true
          return i
        }
      })
      return { flag, targets }
    },
    //是否还有别的滞纳金收费项，返回：flag
    isOtherLaypay(target) {
      const { chargeItemList } = this
      let flag = false
      chargeItemList.forEach(i => {
        if (
          i.chargeItemSourceCode === 'LAYPAYFEE' &&
          i?.chargeItemSourceId !== target?.chargeItemSourceId
        ) {
          flag = true
        }
      })
      return flag
    },
    //新增减免项时，是否有对应收费项 / 是否有对应减免项
    isReductionChargeItem(target, reduct) {
      const { chargeItemList } = this
      let flag = false
      const targets = chargeItemList.filter(i => {
        if (
          reduct &&
          i.chargeItemSourceCode === 'REDUCTION' &&
          i.tollItemId === target.tollItemId
        ) {
          flag = true
          return i
        }
        if (!reduct && i.tollItemId === target.tollItemId) {
          flag = true
          return i
        }
      })
      return { flag, targets }
    },
    //新增核心方法
    addMain(target) {
      const {
        chargeItemList,
        emptyChargeItem,
        waiteAppendItemList,
        initDefaultEmptyChargeItem,
      } = this
      target.chargeItemMoney = emptyChargeItem.chargeItemMoney
      chargeItemList.unshift(target)
      const idx = waiteAppendItemList.findIndex(
        i => i.chargeItemName === emptyChargeItem.chargeItemName
      )
      waiteAppendItemList.splice(idx, 1)
      initDefaultEmptyChargeItem()
    },
    //input框必须输入正整数，保留两位小数
    formatter(val, target) {
      this.emptyChargeItem[target] = this.emptyChargeItem[target]
        .replace(/[^\d.]/g, '')
        .replace(/\.{2,}/g, '.')
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3')
        .replace(/^\./g, '')
    },
  },
}
</script>

<style lang="scss" scoped>
.edit {
  border-radius: 3px;
  border: 1px dotted #ccc;
  padding: 3px 8px;
}
.input {
  height: 28px;
  line-height: 28px;
  border: 1px solid #c0c4cc;
  border-radius: 3px;
  outline: none;
  width: 80px;
  box-sizing: border-box;
  color: #606266;
  display: inline-block;
  font-size: inherit;
  text-align: center;
}
.chargeTable {
  flex: 0 0 60%;
  border-bottom: 1px solid #eee;
}
table {
  text-align: center;
  width: 100%;
  tr {
    height: 26px;
    line-height: 26px;
  }
  tr:nth-child(odd) {
    background: #f5f7fa;
  }
  td,
  th {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 12px;
    width: 25%;
    padding: 3px 5px;
  }
}
.tableBody {
  height: 100px;
  overflow: auto;
}
//没有数据时
.no-data {
  color: #909399;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  i {
    margin-right: 5px;
  }
}
// 处理收费项，超过两个出现滚动条导致的，按钮对不齐
.bigger {
  width: calc(100% + 5px);
}
</style>
