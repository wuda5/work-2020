import readCar from './readCar.js'
import cardApi from './index.js'
import sockets from './socket.js'
import vue from '@/main.js'

//卡回收、卡清零
const recover = async () => {
    //读卡数据加载
    const shakeHands_1 = await cardApi.readCardLoad().then(res => {
        return res.data.data
    })
    if (!shakeHands_1) { vue.$loading().close(); return false }
    const socketPromise = new Promise((resolve, reject) => {
        sockets.sockets(shakeHands_1, res => {
            resolve(res)
        })
    })
    //发送读卡器
    const shakeHands_2 = await socketPromise.then(res => {
        return res
    })
    if (!shakeHands_2) { vue.$loading().close(); return false }
    // readCar(async (code, data) => {
    await cardApi.recCardLoad(JSON.parse(shakeHands_2.replace(/\.,/g, ','))).then(res => {
        if (!res.data.isSuccess) { return }
        const { data } = res.data
        if (data.isRecCard) {
            vue.$confirm(
                `卡上余额：<span class='el-link el-link--danger is-underline'>${data.cardBalance}</span><br/>  
                卡上次数：<span class='el-link el-link--primary is-underline'>${data.cardChargeCount}</span><br/>
                卡号：<span class="el-link el-link--primary is-underline">${data.cardNo}</span>`,
                '是否回收该卡？',
                {
                    confirmButtonText: '回收',
                    cancelButtonText: '取消',
                    dangerouslyUseHTMLString: true,
                }
            ).then(() => {
                recCardCallBack(data.cardNo, data.recCardJsonData)
            }).catch(() => {
                //取消、错误处理
            });
        } else {
            vue.$message({
                type: 'warning',
                message: `${data.msg}`
            });
        }
    })
    // })
}

const recCardCallBack = async (cardNo, recCardJsonData) => {
    vue.$loading({
        lock: true,
        text: '回收中……',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.4);',
    })
    const socketPromise = new Promise((resolve, reject) => {
        cardApi.sockets(recCardJsonData, res => {
            resolve(res)
        })
    })
    const datas = await socketPromise.then(res => {
        return res
    })
    if (!datas) { vue.$loading().close() }
    await cardApi.recCardCallBack({
        cardNo: cardNo,
        data: JSON.parse(datas.replace(/\.,/g, ',')),
    }).then(res => {
        if (res.data.isSuccess) {
            vue.$message({
                type: 'success',
                message: `回收成功！`
            });
        }
    }).finally(() => {
        vue.$loading().close()
    })
}

export default recover