
import vue from '@/main.js'
import CardApi from './index.js'

const socketIP = 'ws://localhost:11360'
let socket = null
//新建socket对象
const socketOpen = async (error) => {
    socket = new WebSocket(socketIP)
    socket.onclose = () => {
        console.log('websocket 11360 断开连接')
    }
    socket.onerror = () => {
        // console.log(error)
        error()
        console.log('%c websocket 11360 连接错误', 'background:#F56C6C ; padding: 1px; border-radius: 0 3px 3px 0;  color: #fff')
        vue.$message.error('请检查是否连接读卡器')
        vue.$loading().close()
    }
    await new Promise((resolve) => {
        socket.onopen = function () {
            console.log('websocket 11360 连接成功！')
            resolve(true)
        }
    })
}
//关闭
const socketClose = () => {
    socket.close()
}

// websocket交互
const sockets = async (data, func, error) => {
    const socket = new WebSocket(socketIP)
    socket.data = data
    socket.func = func
    socket.error = error ? error : () => { }
    //成功
    socket.onopen = function () {
        console.log('websocket 11360 连接成功！')
        socket.send(JSON.stringify(this.data))
    }
    //接收
    socket.onmessage = function (event) {
        this.func(event.data)
        this.close()
    }
    //报错
    socket.onerror = function () {
        this.error()
        console.log('%c websocket 11360 连接错误', 'background:#F56C6C ; padding: 1px; border-radius: 0 3px 3px 0;  color: #fff')
        vue.$loading().close()
        vue.$message.error('请连接读卡器')
    }
    //断开
    socket.onclose = function () {
        console.log('websocket 11360 断开连接')
    }
}

/*
websocket 五次握手，读卡写卡
shakeHands_1 读卡数据加载 /api/bizcenter/card/readCardLoad 
shakeHands_2 发送读卡器 websocket 11360
shakeHands_3 读卡响应数据传入后端接口，默认：/api/bizcenter/card/issueCardLoad
shakeHands_4 后端接口返回数据发送读卡器 websocket 11360
shakeHands_5 读卡器返回数据传入后端接口，默认：/api/bizcenter/card/issueCardCallBack
参数：
    {
        shakeOne = CardApi.issueCardLoad,       //握手函数1
        shakeTwo = CardApi.issueCardCallBack,   //握手函数2
        code,       //gasmetesCode
        callBack    //成功执行函数
        error       //错误执行函数
    }
*/
const shakeHandsSocket = async (...args) => {
    const error = args[0].error ? args[0].error : () => { }
    await socketOpen(error)
    vue.$loading().setText('交互中，请稍后……')
    const key = args[0].code ? { gasMeterCode: args[0].code } : { id: args[0].id }
    args[0].bizIdOrNo ? key.bizIdOrNo = args[0].bizIdOrNo : null
    //从后端获取到，需要给读卡的数据shakeHands_1
    const shakeHands_1 = await CardApi.readCardLoad().then(res => {
        catchErr(res, shakeHandsSocket, args)
        return res.data.data
    }).catch(() => { error() })
    cns('1.取到要发给读卡器的数据', shakeHands_1)
    if (!shakeHands_1) { return fail() }
    //将从后端获取到的shakeHands_1，发送给读卡器,得到读卡器响应数据shakeHands_2
    const shakeHands_2 = await sockPromise(shakeHands_1)
    cns('2.发给读卡器后响应的数据', shakeHands_2)
    //将读卡器响应数据shakeHands_2输入后端，得到响应数据shakeHands_3
    args[0].customerCode ? key.customerCode = args[0].customerCode : null
    const shakeHands_3 = await args[0].shakeOne({
        ...key,
        data: JSON.parse(shakeHands_2.replace(/\.,/g, ',')),
    }).then(resp => {
        catchErr(resp, shakeHandsSocket, args)
        return resp.data.data
    }).catch(() => { error() })
    if (!shakeHands_3) { return fail() }
    cns(`3.传入${args[0].shakeOne.name}接口后响应数据`, shakeHands_3)
    //将后端响应数据shakeHands_3发送给读卡器，得到读卡器响应数据shakeHands_4
    let shakeHands_4
    if (shakeHands_3.repCardData) {
        shakeHands_4 = await sockPromise(shakeHands_3.repCardData)
        if (shakeHands_3.repGasData) {
            shakeHands_4 = await sockPromise(shakeHands_3.repGasData)
        }
    } else {
        shakeHands_4 = await sockPromise(shakeHands_3)
    }
    cns('4.响应数据传入读卡器后返回数据', shakeHands_4)
    if (!shakeHands_4) { return fail() }
    //将读卡器响应数据shakeHands_4传入后端回调函数  补气时需要传入repGasRecordId
    const shakeTwoParam = args[0].id ? {
        ...key,
        repGasRecordId: args[0].id,
        data: JSON.parse(shakeHands_4.replace(/\.,/g, ',')),
    } : {
            ...key,
            data: JSON.parse(shakeHands_4.replace(/\.,/g, ',')),
        }
    const rebackData = await args[0].shakeTwo(shakeTwoParam).then(resp => {
        catchErr(resp, shakeHandsSocket)
        args[0].callBack()
        return resp.data.data
    }).catch(() => { error() })
    cns(`5.最后回调${args[0].shakeTwo.name}接口`, shakeHands_4)
    socketClose()
    return rebackData
}
//获取读卡器返回数据
const sockPromise = async (shakeHands) => {
    socket.send(JSON.stringify(shakeHands))
    return await new Promise((resolve) => {
        socket.onmessage = function (event) {
            resolve(event.data)
        }
    })
}
//服务器isSuccess 为false时
const catchErr = (res, callBack, args) => {
    if (!res.data.isSuccess) {
        vue.$confirm(res.data.msg, '提示', {
            confirmButtonText: '重试',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            callBack(...args)
        }).catch(() => {
            vue.$loading().close()
            args[0].error && args[0].error()
            return
        });
    }
}
//打印每一步骤
const cns = (txt, value) => {
    console.log(
        `%c ${txt}`,
        'background:#E6A23C ; padding: 1px; border-radius: 3px 0 0 3px;  color: #fff',
    )
    console.groupCollapsed('结果：')
    console.log(value)
    console.groupEnd()
}
//读写卡操作失败
const fail = () => {
    vue.$loading().close();
    vue.$message({
        message: '读写卡失败',
        type: 'error',
    })
    return false
}
export default {
    sockets,
    shakeHandsSocket,
}
// vue.$router.go(0)
// vue.$message({
//     type: 'info',
//     message: '功能开发中……'
// });
