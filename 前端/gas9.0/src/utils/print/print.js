import apiTemplate from '@/api/system/printTemplate';
import {getLodop} from '@/utils/LodopFuncs.js';
import {Message} from 'element-ui';
import printTestData from './printTestData.js';

let LODOP

// 获取默认打样模板
export async function getDefaultTemplate(templateCode) {
  // 提交数据
  let reqData = {
    templateCode
  }
  //
  let retData = await apiTemplate.getDefaultTemplate(reqData)
  let {isSuccess, data} = retData.data

  //
  if (isSuccess) {
    if (data) {
      return data.itemContent.replace(/QcBody/g, 'body').replace(/QcScript/g, 'script')
    }
    Message.error({
      message: '检查模板是否存在'
    })
  } else {
    Message.error({
      message: '获取模板失败'
    })
  }
}

// 正则替换字段
function regReplace(str) {
  const ret = str.replace(/LODOP.ADD_PRINT_TEXTA\((.+?)\)/g, function (
    word,
    $1
  ) {
    const sr = $1.split(',')
    const lastSrt = sr[0].slice(1, -1)
    sr[5] = `data.${lastSrt}`

    const retStr = sr.join(',')
    $1 = retStr
    word = `LODOP.ADD_PRINT_TEXTA(${retStr});`
    return word
  })
  return ret
}

// 正则 LODOP.PRINT_INIT();
function regRemoveINIT(template) {
  const ret = template.replace('LODOP.PRINT_INITA();', '')
  return ret
}

// 金额大写
export function upMoney(n) {
  var fraction = ['角', '分']
  var digit = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖']
  var unit = [
    ['元', '万', '亿'],
    ['', '拾', '佰', '仟']
  ]
  var head = n < 0 ? '欠' : ''
  n = Math.abs(n)
  var s = ''
  for (var i = 0; i < fraction.length; i++) {
    s += (
      digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]
    ).replace(/零./, '')
  }
  s = s || '整'
  n = Math.floor(n)
  for (let i = 0; i < unit[0].length && n > 0; i++) {
    var p = ''
    for (var j = 0; j < unit[1].length && n > 0; j++) {
      p = digit[n % 10] + unit[1][j] + p
      n = Math.floor(n / 10)
    }
    s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s
  }
  return (
    head +
    s
      .replace(/(零.)*零元/, '元')
      .replace(/(零.)+/g, '零')
      .replace(/^整$/, '零元整')
  )
}

// 分页打印方法
function CreateAllPages(printTemplate, printData, printSize) {
  LODOP = getLodop()
  const itemArr = []
  const length = printData.chargeItemRecords.length
  const pages = Math.ceil(length / printSize)
  let data = printData
  data.pages = pages
  // console.log({ pages, length, size })
  for (let i = 0; i < pages; i++) {
    itemArr[i] = printData.chargeItemRecords.slice(i * printSize, (i + 1) * printSize)
    data.page = i + 1
    const chargeItemRecords = itemArr[i]
    // console.log(chargeItemRecords)
    LODOP.NewPage()
    eval(printTemplate)
  }
}

// 票据打印（分页）
async function GAS_BILL_1(orgData, tpl) {
  console.log(orgData);
  try {
    // 获取模板
    let template = ''
    if (tpl) {// 如果不是测试 （测试打印）
      template = tpl
    } else { // 如果没有传递模板（真实打印）
      template = await getDefaultTemplate('GAS_BILL')
    }
    template = regReplace(template)

    // 设置数据
    let data = orgData || printTestData['GAS_BILL']

    console.log(data)
    // 执行打印
    LODOP = getLodop()
    // console.log(data);
    // console.log(template);
    eval(template)
    // LODOP.PRINT()
    LODOP.PREVIEW()

    return Promise.resolve(true)
  } catch (error) {
    console.log(error)
    Message.error({
      message: '打印失败'
    })
    return Promise.resolve(false)
  }
}

async function GAS_BILL(printData, printTemplate) {

  // 获取模板(参数有模板，说明是测试，否则获取模板)
  let template = printTemplate || await getDefaultTemplate('GAS_BILL')
  template = regReplace(template)
  template = regRemoveINIT(template)

  // 设置数据
  let data = printData || printTestData['GAS_BILL']

  // 设置分页大小
  let printSize = 5
  try {
    // 分页打印设置
    CreateAllPages(template, data, printSize)
    LODOP.PREVIEW()
    return Promise.resolve(true)
  } catch (error) {
    console.log(error)
    Message.error({
      message: '打印失败'
    })
    return Promise.resolve(false)
  }
}

// 打印扎帐信息
async function SETTLE_ACCOUNTS(printData, printTemplate) {

  // 获取模板(参数有模板，说明是测试，否则获取模板)
  let template = printTemplate || await getDefaultTemplate('GAS_BILL')
  template = regReplace(template)
  template = regRemoveINIT(template)

  // 设置数据
  let data = printData || printTestData['GAS_BILL']

  // 设置分页大小
  let printSize = 5
  try {
    // 分页打印设置
    CreateAllPages(template, data, printSize)
    LODOP.PREVIEW()
    return Promise.resolve(true)
  } catch (error) {
    console.log(error)
    Message.error({
      message: '打印失败'
    })
    return Promise.resolve(false)
  }
}

export default {
  GAS_BILL
}
