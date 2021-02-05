//生产厂商服务
import axiosApi from '@/api/AxiosApi.js'
const apiList={
    // 分页查询
    page: {
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterFactory/page`
    },
    save: {
        url: `/bizcenter/gasmeter/gasMeterFactory/add`,
        method: 'POST'
    },
    update: {
        url: `/bizcenter/gasmeter/gasMeterFactory/update`,
        method: 'PUT'
    },
    updateBatch:{
        url: `/bizcenter/gasmeter/gasMeterFactory/updateBatch`, 
        method: 'PUT'
    },
    check:{
        url: `/bizcenter/gasmeter/gasMeterFactory/check`, 
        method: 'POST'
    }
}

export default {
    page(data) {
        return axiosApi({
            ...apiList.page,
            data
        })
    },
    // 不分页查询
    query(data) {
        return axiosApi({
            method: 'POST',
            url: `/bizcenter/gasmeter/gasMeterFactory/query`,
            data
        })
    },
    save(data) {
        return axiosApi({
            ...apiList.save,
            data
        })
    },
    update(data) {
        return axiosApi({
            ...apiList.update,
            data
        })
    },
    updateBatch(data){
        return axiosApi({
            ...apiList.updateBatch,
            data
        })
    },
    check(data){
        return axiosApi({
            ...apiList.check,
            data
        })
    }
}
