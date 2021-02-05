// 打印测试数据
export default {

  COMMODITY_INVOICE: [
    {
      name: '商品发票',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
    {
      name: '苹果',
      num: 12,
      value: 52
    }
  ],

  // 商品收费票据
  COMMODITY_CHARGE_BILL: [
    {
      name: '商品收费票据1',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
    {
      name: '商品收费票据2',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
    {
      name: '商品收费票据3',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
    {
      name: '商品收费票据4',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
  ],

  // 燃气收费票据
  GAS_BILL: {
    'customerChargeNo'
      :
      '5555555', 'customerName'
      :
      '历史', 'chargeNo'
      :
      'CC202012100000000684', 'invoiceNo'
      :
      'RCPT202012100000000015', 'receivableMoney'
      :
      '226.02', 'actualIncomeMoney'
      :
      '227.00', 'giveChange'
      :
      '0.98', 'totalMoney'
      :
      '226.02', 'totalMoneyChinese'
      :
      '贰佰贰拾陆元零贰分',
    'chargeItemRecords'
      :
      [
        {
        'id': '1336900955152580608',
        'createTime': '2020-12-10 13:10:01',
        'createUser': '3',
        'updateTime': '2020-12-10 13:10:01',
        'updateUser': '3',
        'companyCode': '0000',
        'companyName': '秦川的内置企业',
        'orgId': '100',
        'orgName': '秦川集团股份有限公司',
        'businessHallId': null,
        'businessHallName': null,
        'customerCode': 'BC202012090000000005',
        'customerName': '历史',
        'gasmeterCode': 'BM202012090000000016',
        'gasmeterName': null,
        'tollItemScene': 'OTHER',
        'tollItemId': '1321353106616745984',
        'chargeItemName': '附加费-未启用-一次性-不固定',
        'chargeItemTime': null,
        'chargeItemSourceCode': 'OTHER',
        'chargeItemSourceName': '其他收费项',
        'chargeNo': 'CC202012100000000684',
        'chargeItemSourceId': '1321353106616745984',
        'chargeItemMoney': '10.0000',
        'chargeItemGas': '0.0000',
        'chargeFrequency': 'ONE_TIME',
        'moneyMethod': 'unfixed',
        'rechargeGiveGas': null,
        'rechargeGiveMoney': null,
        'isReductionItem': false,
        'createUserId': '3',
        'createUserName': '平台超管',
        'remark': null,
        'dataStatus': 1,
        'totalCount': 1,
        'price': '0.0000',
        'isLadderPrice': null,
        'leadderPriceDetail': null
      },
        {
        'id': '1336900955202912256',
        'createTime': '2020-12-10 13:10:01',
        'createUser': '3',
        'updateTime': '2020-12-10 13:10:01',
        'updateUser': '3',
        'companyCode': '0000',
        'companyName': '秦川的内置企业',
        'orgId': '100',
        'orgName': '秦川集团股份有限公司',
        'businessHallId': null,
        'businessHallName': null,
        'customerCode': 'BC202012090000000005',
        'customerName': '历史',
        'gasmeterCode': 'BM202012090000000016',
        'gasmeterName': null,
        'tollItemScene': 'OTHER',
        'tollItemId': '1321352893671931904',
        'chargeItemName': '附加费-未启用-一次性',
        'chargeItemTime': null,
        'chargeItemSourceCode': 'OTHER',
        'chargeItemSourceName': '其他收费项',
        'chargeNo': 'CC202012100000000684',
        'chargeItemSourceId': '1321352893671931904',
        'chargeItemMoney': '24.0000',
        'chargeItemGas': '0.0000',
        'chargeFrequency': 'ONE_TIME',
        'moneyMethod': 'fixed',
        'rechargeGiveGas': null,
        'rechargeGiveMoney': null,
        'isReductionItem': false,
        'createUserId': '3',
        'createUserName': '平台超管',
        'remark': null,
        'dataStatus': 1,
        'totalCount': 1,
        'price': '24.0000',
        'isLadderPrice': null,
        'leadderPriceDetail': null
      },
        {
        'id': '1336900955207106560',
        'createTime': '2020-12-10 13:10:01',
        'createUser': '3',
        'updateTime': '2020-12-10 13:10:01',
        'updateUser': '3',
        'companyCode': '0000',
        'companyName': '秦川的内置企业',
        'orgId': '100',
        'orgName': '秦川集团股份有限公司',
        'businessHallId': null,
        'businessHallName': null,
        'customerCode': 'BC202012090000000005',
        'customerName': '历史',
        'gasmeterCode': 'BM202012090000000016',
        'gasmeterName': null,
        'tollItemScene': 'OTHER',
        'tollItemId': '134',
        'chargeItemName': '移动用气',
        'chargeItemTime': null,
        'chargeItemSourceCode': 'OTHER',
        'chargeItemSourceName': '其他收费项',
        'chargeNo': 'CC202012100000000684',
        'chargeItemSourceId': '134',
        'chargeItemMoney': '0.0200',
        'chargeItemGas': '0.0000',
        'chargeFrequency': 'ONE_TIME',
        'moneyMethod': 'fixed',
        'rechargeGiveGas': null,
        'rechargeGiveMoney': null,
        'isReductionItem': false,
        'createUserId': '3',
        'createUserName': '平台超管',
        'remark': null,
        'dataStatus': 1,
        'totalCount': 1,
        'price': '0.0200',
        'isLadderPrice': null,
        'leadderPriceDetail': null
      },
        {
        'id': '1336900955207106561',
        'createTime': '2020-12-10 13:10:01',
        'createUser': '3',
        'updateTime': '2020-12-10 13:10:01',
        'updateUser': '3',
        'companyCode': '0000',
        'companyName': '秦川的内置企业',
        'orgId': '100',
        'orgName': '秦川集团股份有限公司',
        'businessHallId': null,
        'businessHallName': null,
        'customerCode': 'BC202012090000000005',
        'customerName': '历史',
        'gasmeterCode': 'BM202012090000000016',
        'gasmeterName': null,
        'tollItemScene': 'OTHER',
        'tollItemId': '1321362347482152960',
        'chargeItemName': '家兵用气类型',
        'chargeItemTime': null,
        'chargeItemSourceCode': 'OTHER',
        'chargeItemSourceName': '其他收费项',
        'chargeNo': 'CC202012100000000684',
        'chargeItemSourceId': '1321362347482152960',
        'chargeItemMoney': '41.0000',
        'chargeItemGas': '0.0000',
        'chargeFrequency': 'ONE_TIME',
        'moneyMethod': 'fixed',
        'rechargeGiveGas': null,
        'rechargeGiveMoney': null,
        'isReductionItem': false,
        'createUserId': '3',
        'createUserName': '平台超管',
        'remark': null,
        'dataStatus': 1,
        'totalCount': 1,
        'price': '41.0000',
        'isLadderPrice': null,
        'leadderPriceDetail': null
      },
        {
        'id': '1336900955211300864',
        'createTime': '2020-12-10 13:10:01',
        'createUser': '3',
        'updateTime': '2020-12-10 13:10:01',
        'updateUser': '3',
        'companyCode': '0000',
        'companyName': '秦川的内置企业',
        'orgId': '100',
        'orgName': '秦川集团股份有限公司',
        'businessHallId': null,
        'businessHallName': null,
        'customerCode': 'BC202012090000000005',
        'customerName': '历史',
        'gasmeterCode': 'BM202012090000000016',
        'gasmeterName': null,
        'tollItemScene': 'OTHER',
        'tollItemId': '1321362347486347264',
        'chargeItemName': '家兵用气类型',
        'chargeItemTime': null,
        'chargeItemSourceCode': 'OTHER',
        'chargeItemSourceName': '其他收费项',
        'chargeNo': 'CC202012100000000684',
        'chargeItemSourceId': '1321362347486347264',
        'chargeItemMoney': '41.0000',
        'chargeItemGas': '0.0000',
        'chargeFrequency': 'ONE_TIME',
        'moneyMethod': 'fixed',
        'rechargeGiveGas': null,
        'rechargeGiveMoney': null,
        'isReductionItem': false,
        'createUserId': '3',
        'createUserName': '平台超管',
        'remark': null,
        'dataStatus': 1,
        'totalCount': 1,
        'price': '41.0000',
        'isLadderPrice': null,
        'leadderPriceDetail': null
      },

      ]
  },

  // 缴费通知单
  PAYMENT_NOTICE:
    {
      name: '草莓',
      num: 15,
      value: 10
    },

  // 包装工单
  WORK_ORDER: [
    {
      name: '包装工单',
      num: 5,
      value: 3
    },
    {
      name: '草莓',
      num: 15,
      value: 10
    },
  ]
}
