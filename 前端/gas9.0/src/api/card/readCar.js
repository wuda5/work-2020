import sockets from './socket.js'
import CardApi from './index.js'
import vue from '@/main.js'

//读卡操作   参数：成功后回调，失败后回调
const readCar = async (success, fail, isMeterInfo) => {
    //读卡数据加载
    const shakeHands_1 = await CardApi.readCardLoad().then(res => {
        return res.data.data
    })
    // console.log(shakeHands_1)
    const socketPromise = new Promise((resolve, reject) => {
        sockets.sockets(shakeHands_1, res => {
            resolve(res)
        }, () => { fail() })
    })
    //发送读卡器
    const shakeHands_2 = await socketPromise.then(res => {
        return res
    })
    // console.log(shakeHands_2)
    //读卡器返回数据传入后端接口
    await CardApi.readCardCallBack(JSON.parse(shakeHands_2.replace(/\.,/g, ','))).then(resp => {
        const { isSuccess, data } = resp.data
        if (isSuccess) {
            if (!data) {
                vue.$message({
                    message: '当前卡是新卡！',
                    type: 'warning'
                });
                fail()
            }
            if (data?.gasMeterCode) {
                if (isMeterInfo) {
                    success({ gasCode: data.gasMeterCode })
                    return
                }
                const readData = JSON.parse(shakeHands_2.replace(/\.,/g, ','))
                // console.log(readData)
                success(data.gasMeterCode, readData)
            }
        } else {
            fail()
        }
    })
}

export default readCar