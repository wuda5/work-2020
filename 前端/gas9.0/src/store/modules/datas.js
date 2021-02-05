//存放，柜台日常综合页，数据
export default {
    namespaced: true,
    state: {
        dailyWork: {
            chargeForm: {
                deduct: false, //是否使用账户抵扣
                deductMoney: 0, // 抵扣金额
                prechargeMoney: '', //预存金额 
                rechargeMoney: '', //充值金额
                rechargeGas: '', //充值气量
                rechargeActivityList: [], //充值活动
                rechargeActivityValueList: [], //选中的充值活动
                gives: 0, //活动赠送
                isBuyInsurance: false, //是否购买保险 true购买 false未购买
                insuranceIsExpire: false, //保险是否已过期 true已过期 false未过期
                insuranceExpireDate: '', //保险到期日期
                insuranceEndDate: '',	//保险到期日期
                insurancePremium: '',	//保费金额	
                insuranceStartDate: '',	//保险开始日期		
                insuranceFlag: false,//开启购买保险开关
                insuranceData: '', //保险日期绑定元素
                receivableMoney: '', //应收金额
                actualIncomeMoney: '', //实收金额
                invoiceType: [],//发票类型
                invoiceValue: { label: '票据', value: 'RECEIPT' },//当前选中的发票
                invoiceNo: '', //发票编号
                remark: '', //备注
                chargeType: { value: 'CASH', label: '现金' }, //收费方式
                giveChange: '',//找零
                accountMoney: 0, //个人账户余额
            },
        }
    },
    mutations: {
        update(state, value) {
            state.dailyWork.chargeForm = { ...state.dailyWork.chargeForm, ...value }
        },
    },
    actions: {
        update({ commit }, value) {
            commit('update', value)
        },
    }
}