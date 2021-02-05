//日常柜台
import axiosApi from '@/api/AxiosApi.js'
import chargesApi from '../charges/index'

const apiList = {
    // 用户分页查询
    list: {
        method: 'POST',
        url: `/bizcenter/archive/userarchive/customerGas/pagelist`
    },
}
export default {
    list(data) {
        return axiosApi({
            ...apiList.list,
            data
        })
    },
    load: chargesApi.load,
    convert: chargesApi.convert,
    charge: chargesApi.charge,
    printReceiptLoad: chargesApi.printReceiptLoad,
    limitLoad: chargesApi.limitLoad,
    getMeterVersionById:chargesApi.getMeterVersionById,
}
