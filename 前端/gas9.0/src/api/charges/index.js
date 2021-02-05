//收费相关接口
import axiosApi from '@/api/AxiosApi.js'

const apiList = {
    //缴费数据加载
    load: {
        method: 'POST',
        url: `/bizcenter/charges/charge/load`,
    },
    //气量金额换算
    convert: {
        method: 'POST',
        url: `/bizcenter/charges/calculate/convert`,
    },
    //发起收费
    charge: {
        method: 'POST',
        url: `/bizcenter/charges/charge`,
    },
    //打印票据数据加载
    printReceiptLoad: {
        method: 'GET',
        url: `/bizcenter/charges/charge/printReceiptLoad`,
    },
    //个人及营业厅限额加载
    limitLoad: {
        method: 'GET',
        url: `/bizcenter/charges/charge/limitLoad`,
    },
    //不同场景数据加载
    loadByScene: {
        method: 'POST',
        url: `/bizcenter/charges/charge/loadByScene`,
    },
    //根据ID查询版号信息
    getMeterVersionById: {
        method: 'GET',
        url: `/bizcenter/gasmeter/gasMeterVersion/getById`,
    },
    //根据气表档案号，获取厂家，版号，型号相关配置数据
    findGasMeterConfInfoByCode: {
        method: 'GET',
        url: `/bizcenter/archive/devicearchive/findGasMeterConfInfoByCode`,
    },
    //分页查询缴费记录带是否申请退费标识
    pageList: {
        method: 'POST',
        url: `/bizcenter/charges/charge/pageList`,
    },
    //申请退费
    refundApply: {
        method: 'POST',
        url: `/bizcenter/charges/refund/apply`,
    },
    //退费列表
    refundPage: {
        method: 'POST',
        url: `/bizcenter/charges/refund/page`,
    },
    //根据收费编号加载项明细
    getItemDetailsByChargeNo: {
        method: 'GET',
        url: `/bizcenter/charges/charge/getItemDetailsByChargeNo`,
    },
    //发起退费
    refundExcute: {
        method: 'POST',
        url: `/bizcenter/charges/refund/excute`,
    },
    //审核退费
    audit: {
        method: 'POST',
        url: `/bizcenter/charges/refund/audit`,
    },
    //检测是否可以退费申请
    checkRefundApply: {
        method: 'POST',
        url: `/bizcenter/charges/refund/checkRefundApply`,
    },
    //根据收费单号查询收费信息
    getChargeInfoByNo: {
        method: 'GET',
        url: `/bizcenter/charges/charge/getChargeInfoByNo`,
    },
    //取消退费
    cancelRefund: {
        method: 'POST',
        url: `/bizcenter/charges/refund/cancelRefund`,
    },
    //退费加载信息接口
    loadRefundAllInfo: {
        method: 'GET',
        url: `/bizcenter/charges/refund/loadRefundAllInfo`,
    },
    //微信扫码支付(返回支付二维码) 
    wechatScanCode: {
        method: 'POST',
        url: `/bizcenter/pay/onlinepay/onlinepay/wechatScanCode`,
    },
    //微信付款码支付 
    wechatMicropay: {
        method: 'POST',
        url: `/bizcenter/pay/onlinepay/onlinepay/wechatMicropay`,
    },
    //订单查询接口
    orderquery: {
        method: 'POST',
        url: `/bizcenter/pay/onlinepay/orderquery`,
    },
    //账户退费相关api： 分页查询客户账户信息 
    custPageList: {
        method: 'POST',
        url: `/bizcenter/accountRefund/custPageList`,
    },
    //账户退费相关api： 分页查询账户退费记录
    accountPageList: {
        method: 'POST',
        url: `/bizcenter/accountRefund/pageList`,
    },
    //账户退费相关api：检测是否可以退费申请 
    checkAccountRefundApply: {
        method: 'GET',
        url: `/bizcenter/accountRefund/checkRefundApply`,
    },
    //账户退费相关api：申请退费 
    accountRefundApply: {
        method: 'POST',
        url: `/bizcenter/accountRefund/apply`,
    },
    // 
    //账户退费相关api：审核退费
    accountRefundAudit: {
        method: 'POST',
        url: `/bizcenter/accountRefund/audit`,
    },
    //账户退费相关api：取消退费
    accountRefundCancelRefund: {
        method: 'POST',
        url: `/bizcenter/accountRefund/cancelRefund`,
    },
    //账户退费相关api：退费 
    accountRefund: {
        method: 'POST',
        url: `/bizcenter/accountRefund/refund`,
    },
}
export default {
    load(data) {
        return axiosApi({
            ...apiList.load,
            url: apiList.load.url,
            data
        })
    },
    convert(data) {
        return axiosApi({
            ...apiList.convert,
            data
        })
    },
    charge(data) {
        return axiosApi({
            ...apiList.charge,
            data
        })
    },
    printReceiptLoad(data) {
        return axiosApi({
            ...apiList.printReceiptLoad,
            url: apiList.printReceiptLoad.url + `?chargeNo=${data}`
        })
    },
    limitLoad() {
        return axiosApi({ ...apiList.limitLoad })
    },
    loadByScene(data) {
        return axiosApi({
            ...apiList.loadByScene,
            // url: apiList.loadByScene.url + `/${customerCode}/${gasMeterCode}/${sceneType}/${bizNoOrId}`,
            url: apiList.loadByScene.url,
            data,
        })
    },
    getMeterVersionById(id) {
        return axiosApi({
            ...apiList.getMeterVersionById,
            url: apiList.getMeterVersionById.url + `/${id}`
        })
    },
    findGasMeterConfInfoByCode(gasMeterCode) {
        return axiosApi({
            ...apiList.findGasMeterConfInfoByCode,
            url: apiList.findGasMeterConfInfoByCode.url + `/${gasMeterCode}`
        })
    },
    pageList(data) {
        return axiosApi({
            ...apiList.pageList,
            data
        })
    },
    custPageList(data) {
        return axiosApi({
            ...apiList.custPageList,
            data
        })
    },
    refundApply(data) {
        return axiosApi({
            ...apiList.refundApply,
            data
        })
    },
    accountRefundApply(data) {
        return axiosApi({
            ...apiList.accountRefundApply,
            data
        })
    },
    refundPage(data) {
        return axiosApi({
            ...apiList.refundPage,
            data
        })
    },
    accountPageList(data) {
        return axiosApi({
            ...apiList.accountPageList,
            data
        })
    },
    getItemDetailsByChargeNo(chargeNo) {
        return axiosApi({
            ...apiList.getItemDetailsByChargeNo,
            url: apiList.getItemDetailsByChargeNo.url + `?chargeNo=${chargeNo}`,
        })
    },
    refundExcute(data) {
        return axiosApi({
            ...apiList.refundExcute,
            url: apiList.refundExcute.url,
            data
        })
    },
    audit(data) {
        return axiosApi({
            ...apiList.audit,
            data,
        })
    },
    accountRefundAudit(data) {
        return axiosApi({
            ...apiList.accountRefundAudit,
            data,
        })
    },
    checkRefundApply(chargeNo) {
        return axiosApi({
            ...apiList.checkRefundApply,
            url: apiList.checkRefundApply.url + `?chargeNo=${chargeNo}`,
        })
    },
    checkAccountRefundApply(customerCode) {
        return axiosApi({
            ...apiList.checkAccountRefundApply,
            url: apiList.checkAccountRefundApply.url + `?customerCode=${customerCode}`,
        })
    },
    getChargeInfoByNo(chargeNo) {
        return axiosApi({
            ...apiList.getChargeInfoByNo,
            url: apiList.getChargeInfoByNo.url + `?chargeNo=${chargeNo}`,
        })
    },
    cancelRefund(refundId) {
        return axiosApi({
            ...apiList.cancelRefund,
            url: apiList.cancelRefund.url + `?refundId=${refundId}`,
        })
    },
    accountRefundCancelRefund(refundId) {
        return axiosApi({
            ...apiList.accountRefundCancelRefund,
            url: apiList.accountRefundCancelRefund.url + `?refundId=${refundId}`,
        })
    },
    accountRefund(refundId) {
        return axiosApi({
            ...apiList.accountRefund,
            url: apiList.accountRefund.url + `?refundId=${refundId}`,
        })
    },
    loadRefundAllInfo(refundId) {
        return axiosApi({
            ...apiList.loadRefundAllInfo,
            url: apiList.loadRefundAllInfo.url + `?refundId=${refundId}`,
        })
    },
    wechatScanCode(data) {
        return axiosApi({
            ...apiList.wechatScanCode,
            data,
        })
    },
    wechatMicropay(data) {
        return axiosApi({
            ...apiList.wechatMicropay,
            data,
        })
    },
    orderquery(data) {
        return axiosApi({
            ...apiList.orderquery,
            data,
        })
    },
}
