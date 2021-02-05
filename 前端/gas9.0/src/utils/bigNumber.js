import BigNumber from 'bignumber.js'

const BN = {
    //累加、减法  参数：([],[])  加数组/减数组
    plusAndMinus() {
        return total(arguments[0]).minus(total(arguments[1])).toNumber()
    },
    //累加  参数：[number数组]
    plus(list) {
        return total(list).toNumber()
    },
    //减法  参数：[number数组]
    minus(a, b) {
        return bn(a).minus(bn(b)).toNumber()
    },
    //是否相等
    eq(a, b) {
        return bn(a).eq(bn(b))
    },
    //是否大于
    gt(a, b) {
        return bn(a).gt(bn(b))
    },
    //绝对值下，是否大于
    agt(a, b) {
        return (bn(a).abs()).gt(bn(b).abs())
    },
    //是否大于等于
    gte(a, b) {
        return bn(a).gte(bn(b))
    },
    //绝对值下，是否大于等于
    agte(a, b) {
        return (bn(a).abs()).gte(bn(b).abs())
    },
    //是否小于
    lt(a, b) {
        return bn(a).lt(bn(b))
    },
    //是否小于等于
    lte(a, b) {
        return bn(a).lte(bn(b))
    },
    //百分比
    percent(n) {
        return bn(Number(n)).toFixed(2, 1) / 100
    },
    //乘法
    times(a, b) {
        return bn(a).times(bn(b))
    },
    //四舍五入 
    toFixed(n, s) {
        n = n ?? 0
        s = s ?? 0
        return bn(n).toFixed(s, 1)
    },
    bn,
}

function total(list) {
    let temp = bn(0)
    filter(list).forEach(item => {
        temp = temp.plus(bn(item))
    })
    return temp
}

function filter(list) {
    return list.map(item => {
        return Number(item)
    })
}

function bn(number) {
    number = number ? number : 0
    return new BigNumber(Number(number))
}

export default BN