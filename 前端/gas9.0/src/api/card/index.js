//收费相关接口
import axiosApi from '@/api/AxiosApi.js'
import sockets from './socket.js'
import readCar from './readCar.js'
import recoverCard from './recoverCard.js'

const apiList = {
    // 缴费数据加载
    issueCard: {
        method: 'GET',
        url: `/bizcenter/card/issueCard`,
    },
    //是否显示开卡按钮
    watherIssueCard:{
        method: 'GET',
        url: `/bizcenter/card/watherIssueCard`,
    },
    // 读卡数据加载
    readCardLoad: {
        method: 'GET',
        url: `/bizcenter/card/readCardLoad`,
    },
    // 读卡回写
    readCardCallBack: {
        method: 'POST',
        url: `/bizcenter/card/readCardCallBack`,
    },
    // 写开户卡加载
    issueCardLoad: {
        method: 'POST',
        url: `/bizcenter/card/issueCardLoad`,
    },
    // 写开户卡回调
    issueCardCallBack: {
        method: 'POST',
        url: `/bizcenter/card/issueCardCallBack`,
    },
    // 购气写卡数据加载
    buyGasLoad: {
        method: 'POST',
        url: `/bizcenter/card/buyGasLoad`,
    },
    // 购气写卡完成回调
    buyGasCallBack: {
        method: 'POST',
        url: `/bizcenter/card/buyGasCallBack`,
    },
    // 补卡加载
    repCard: {
        method: 'POST',
        url: `/bizcenter/card/repCard`,
    },
    // 补卡写卡数据加载
    repCardLoad: {
        method: 'POST',
        url: `/bizcenter/card/repCardLoad`,
    },
    // 补卡写卡完成回调
    repCardCallBack: {
        method: 'POST',
        url: `/bizcenter/card/repCardCallBack`,
    },
    // 补卡保存
    repCardSave: {
        method: 'POST',
        url: `/bizcenter/card/repCardSave`,
    },
    // repGas: {
    //     method: 'POST',
    //     url: `/bizcenter/card/repGas`,
    // },  
    //补气前检查：是否已有记录、是否未上表
    repGascheck: {
        method: 'GET',
        url: `/bizcenter/supplementGas/check`,
    },
    //新增补气记录
    repGasAdd: {
        method: 'POST',
        url: `/bizcenter/supplementGas/add`,
    },
    //回收写卡数据加载
    recCardLoad: {
        method: 'POST',
        url: `/bizcenter/card/recCardLoad`,
    },
    //回收卡写卡完成回调
    recCardCallBack: {
        method: 'POST',
        url: `/bizcenter/card/recCardCallBack`,
    },
    //补气写卡数据加载
    repGasLoad: {
        method: 'POST',
        url: `/bizcenter/card/repGasLoad`,
    },
    //补气写卡完成回调
    repGasCallBack: {
        method: 'POST',
        url: `/bizcenter/card/repGasCallBack`,
    },
    //退气写卡数据加载 
    backGasLoad: {
        method: 'POST',
        url: `/bizcenter/card/backGasLoad`,
    },
    //退气写卡完成回调 
    backGasCallBack: {
        method: 'POST',
        url: `/bizcenter/card/backGasCallBack`,
    },
}
const CardApi = {
    recoverCard,
    readCar,
    sockets: sockets.sockets,
    shakeHandsSocket: sockets.shakeHandsSocket,
    issueCard(data) {
        return axiosApi({
            ...apiList.issueCard,
            data
        })
    },
    watherIssueCard(data) {
        return axiosApi({
            ...apiList.watherIssueCard,
            data
        })
    },
    readCardLoad() {
        return axiosApi({
            ...apiList.readCardLoad,
        })
    },
    readCardCallBack(data) {
        return axiosApi({
            ...apiList.readCardCallBack,
            data
        })
    },
    issueCardLoad({ id, customerCode, data }) {
        return axiosApi({
            ...apiList.issueCardLoad,
            url: apiList.issueCardLoad.url + `?id=${id}&customerCode=${customerCode}`,
            data
        })
    },
    issueCardCallBack({ id, data }) {
        return axiosApi({
            ...apiList.issueCardCallBack,
            url: apiList.issueCardCallBack.url + `?id=${id}`,
            data
        })
    },
    buyGasLoad({ gasMeterCode, data }) {
        return axiosApi({
            ...apiList.buyGasLoad,
            url: apiList.buyGasLoad.url + `?gasMeterCode=${gasMeterCode}`,
            data
        })
    },
    buyGasCallBack({ gasMeterCode, customerCode, data }) {
        return axiosApi({
            ...apiList.buyGasCallBack,
            url: apiList.buyGasCallBack.url + `?gasMeterCode=${gasMeterCode}&customerCode=${customerCode}`,
            data
        })
    },
    repCard({ gasMeterCode, customerCode }) {
        return axiosApi({
            ...apiList.repCard,
            url: apiList.repCard.url + `?gasMeterCode=${gasMeterCode}&customerCode=${customerCode}`,
        })
    },
    repCardSave(data) {
        return axiosApi({
            ...apiList.repCardSave,
            url: apiList.repCardSave.url + `?customerCode=${data.customerCode}&gasMeterCode=${data.gasMeterCode}`,
            data
        })
    },
    repCardLoad({ id, data }) {
        return axiosApi({
            ...apiList.repCardLoad,
            url: apiList.repCardLoad.url + `?id=${id}`,
            data
        })
    },
    repCardCallBack({ id, data }) {
        return axiosApi({
            ...apiList.repCardCallBack,
            url: apiList.repCardCallBack.url + `?id=${id}`,
            data
        })
    },
    // repGas({ gasMeterCode }) {
    //     return axiosApi({
    //         ...apiList.repGas,
    //         url: apiList.repGas.url + `?gasMeterCode=${gasMeterCode}`,
    //     })
    // },
    repGascheck({ gasMeterCode, customerCode }) {
        return axiosApi({
            ...apiList.repGascheck,
            url: apiList.repGascheck.url + `?gasMeterCode=${gasMeterCode}&customerCode=${customerCode}`,
        })
    },
    repGasAdd(data) {
        return axiosApi({
            ...apiList.repGasAdd,
            data
        })
    },
    recCardLoad(data) {
        return axiosApi({
            ...apiList.recCardLoad,
            data
        })
    },
    recCardCallBack({ cardNo, data }) {
        return axiosApi({
            ...apiList.recCardCallBack,
            url: apiList.recCardCallBack.url + `?cardNo=${cardNo}`,
            data
        })
    },
    repGasLoad({ gasMeterCode, bizIdOrNo, data }) {
        return axiosApi({
            ...apiList.repGasLoad,
            url: apiList.repGasLoad.url + `?gasMeterCode=${gasMeterCode}&bizIdOrNo=${bizIdOrNo}`,
            data
        })
    },
    repGasCallBack({ gasMeterCode, repGasRecordId, data }) {
        return axiosApi({
            ...apiList.repGasCallBack,
            url: apiList.repGasCallBack.url + `?gasMeterCode=${gasMeterCode}&repGasRecordId=${repGasRecordId}`,
            data
        })
    },
    backGasCallBack({ gasMeterCode, bizIdOrNo, customerCode, data }) {
        return axiosApi({
            ...apiList.backGasCallBack,
            url: apiList.backGasCallBack.url + `?gasMeterCode=${gasMeterCode}&customerCode=${customerCode}&bizIdOrNo=${bizIdOrNo}`,
            data
        })
    },
    backGasLoad({ gasMeterCode, bizIdOrNo, data }) {
        return axiosApi({
            ...apiList.backGasLoad,
            url: apiList.backGasLoad.url + `?gasMeterCode=${gasMeterCode}&bizIdOrNo=${bizIdOrNo}`,
            data
        })
    },
}
export default CardApi