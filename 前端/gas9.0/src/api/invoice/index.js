//发票收据相关接口
import axiosApi from '@/api/AxiosApi.js'

/*
    GAS_BILL：燃气收费票据;
    COMMODITY_CHARGE_BILL：商品收费票据;
    SCENARIO_CHARGE_TICKET：场景收费票据;
    ACCESSORY_FEE_BILL：附件费票据;
    PREMIUM_NOTE：保险费票据
*/

const apiList = {
    // 获取打印模板
    getPrintTemplate: {
        method: 'GET',
        url: `/bizcenter/receiptPrint/getPrintTemplate`,
    },
    //查询购买方纳税人信息列表
    getBuyerTaxInfo: {
        method: 'POST',
        url: `/bizcenter/taxPayerInfo/getBuyerTaxInfo`,
    },
    //通过缴费订单生成发票 
    printInvoiceByCharge: {
        method: 'POST',
        url: `/bizcenter/bill/printInvoiceByCharge`,
    },
}
export default {
    getPrintTemplate(data) {
        return axiosApi({
            ...apiList.getPrintTemplate,
            data
        })
    },
    getBuyerTaxInfo(data){
        return axiosApi({
            ...apiList.getBuyerTaxInfo,
            data
        })
    },
    printInvoiceByCharge(data) {
        return axiosApi({
            ...apiList.printInvoiceByCharge,
            data
        })
    },
}
