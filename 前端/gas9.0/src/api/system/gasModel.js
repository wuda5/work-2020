//气表型号
import axiosApi from '@/api/AxiosApi.js'
const apiList = {
    // 分页查询
    page: {
        method: 'POST',
        url: `/bizcenter/gasmeter/GasMeterModel/page`
    },
    update: {
        method: 'PUT',
        url: `/bizcenter/gasmeter/GasMeterModel/update`
    },
    //批量修改表具型号状态-是否启用
    updateBatch:{
        method: 'PUT',
        url: `/bizcenter/gasmeter/GasMeterModel/updateBatch`
    },
    save: {
        method: 'POST',
        url: `/bizcenter/gasmeter/GasMeterModel/add`
    },
    //查询气表生产厂商
    queryGasProduct:{
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterFactory/query`
    },
    //查询气表版号
    queryGasVersion: {
        method: 'POST',
        url: `/bizcenter/gasmeter/gasMeterVersion/query`
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
            url: `/bizcenter/gasmeter/GasMeterModel/query`,
            data
        })
    },
    update(data) {
        return axiosApi({
            ...apiList.update,
            data
        })
    },
    updateBatch(data) {
        return axiosApi({
            ...apiList.updateBatch,
            data
        })
    },
    save(data) {
        return axiosApi({
            ...apiList.save,
            data
        })
    },
    queryGasProduct(data){
        return axiosApi({
            ...apiList.queryGasProduct,
            data
        })
    },
    queryGasVersion(data){
        return axiosApi({
            ...apiList.queryGasVersion,
            data
        }) 
    }

}
