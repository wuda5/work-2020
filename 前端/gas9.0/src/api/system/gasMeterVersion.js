//气表版号服务
import axiosApi from '@/api/AxiosApi.js'
const apiList = {
    // 分页查询
    page: {
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterVersion/page`
    },
    //批量修改气表版本号状态-是否启用
    updateBatch:{
        method: 'PUT',
        url: `/bizcenter/gasmeter/gasMeterVersion/updateBatch`
    },
    //修改气表版本号
    update:{
        method: 'PUT',
        url: `/bizcenter/gasmeter/gasMeterVersion/update`
    },
    save:{
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterVersion/add`
    },
    //查询气表生产厂商
    queryGasProduct: {
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterFactory/query`
    },
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
            url: `/bizcenter/gasmeter/gasMeterVersion/query`,
            data
        })
    },
    updateBatch(data) {
        return axiosApi({
            ...apiList.updateBatch,
            data
        })
    },
    update(data) {
        return axiosApi({
            ...apiList.update,
            data
        })
    },
    save(data){
        return axiosApi({
            ...apiList.save,
            data
        })
    },
    queryGasProduct(data) {
        return axiosApi({
            ...apiList.queryGasProduct,
            data
        })
    },
    
}
