/**
 *  系统公用数组操作
 */
import { deepClone } from './index'

/**
 * 数组去重
 * @param {*} a
 */
export function unique(a) {
  return Array.from(new Set(a))
}

/**
 * 数组去重
 * @param {*} a
 */
export function arrayUnique(a) {
  return Array.from(new Set(a))
}

/**
 * 对两个数组取并集
 * @param {array} a
 * @param {array} b
 */
export function union(a, b) {
  return Array.from(new Set(a.concat(b)))
}

/**
 * 对两个数组取并集
 * @param {array} a
 * @param {array} b
 */
export function arrayUnion(a, b) {
  return Array.from(new Set(a.concat(b)))
}

/**
 * 对两个数组取交集
 * @param {array} a
 * @param {array} b
 */
export function intersection(a, b) {
//   const aSet = new Set(a)
  const bSet = new Set(b)
  return Array.from(new Set(a.filter((v) => bSet.has(v))))
}

/**
 * 对两个数组取交集
 * @param {array} a
 * @param {array} b
 */
export function arrayIntersection(a, b) {
//   const aSet = new Set(a)
  const bSet = new Set(b)
  return Array.from(new Set(a.filter((v) => bSet.has(v))))
}

/**
 * 对两个数组取差集
 * @param {array} a
 * @param {array} b
 */
export function difference(a, b) {
  const aSet = new Set(a)
  const bSet = new Set(b)
  return Array.from(new Set(a.concat(b).filter((v) => !aSet.has(v) || !bSet.has(v))))
}

/**
 * 对两个数组取差集
 * @param {array} a
 * @param {array} b
 */
export function arrayDifference(a, b) {
  const aSet = new Set(a)
  const bSet = new Set(b)
  return Array.from(new Set(a.concat(b).filter((v) => !aSet.has(v) || !bSet.has(v))))
}

/**
 * 获取对象数组的某一列, 如果存在key参数，则返回的是键值对json对象
 * @param {*} data 数据源
 * @param {*} field 需要获取的字段
 * @param {string} key 返回json对象的键
 */
export function arrayColumn(data = [], field = 'id', key = null) {
  if (!Array.isArray(data)) {
    data = Array.from(data)
  }
  if (!key) {
    return data.map((v) => v[field] || null)
  } else {
    const result = {}
    data.forEach((item) => {
      if (item[key]) {
        result[item[key]] = item[field] || ''
      }
    })
    return result
  }
}

/**
 * 合并两个数组成对象
 * @param {array} keys 键名数组
 * @param {array} values 键值数组
 */
export function arrayCombine(keys, values) {
  if (!Array.isArray(keys)) {
    console.error('keys应该是一个数组!')
    return []
  }
  if (!values) {
    values = keys
  } else {
    if (!Array.isArray(values)) {
      console.warn('values应该是一个数组!')
      return []
    }
  }
  const result = {}
  keys.forEach((key, index) => {
    const value = values[index]
    if (value !== undefined) {
      result[key] = value
    }
  })
  return result
}

/**
 * 将树形结构数据转换成一维数组
 * @param {Array} data 数据源
 * @param {object} param1 默认参数配置
 * @returns {array} result
 */
export function nestToFlat(data, { idField = 'id', childrenField = 'children', parentIdField = 'parentId', defaultParentIdValue = 0 } = {}) {
  const result = []
  let incrementId = 0
  const rebuildData = deepClone(data)

  // 增加结果数组
  function addData(item, parentId = defaultParentIdValue) {
    const childrenArr = item[childrenField] || []
    let id = item[idField]
    if (!id) {
      incrementId++
      id = incrementId
    }
    result.push(Object.assign({}, item, { [idField]: id, [parentIdField]: parentId, [childrenField]: [] }))
    if (childrenArr && childrenArr.length > 0) {
      childrenArr.forEach((childrenItem) => {
        addData(childrenItem, id)
      })
    }
  }

  rebuildData.forEach((item) => {
    addData(item, defaultParentIdValue)
  })

  return result
}

/**
 * 将一维数组转换成数据结构的多维数组
 * @param {array} data 数据源
 * @param {object} param1 默认字段和参数设置
 * @param {boolean} showAll 是否显示所有数据，包括不在树形数组范围之内的数据
 * @description
 *  labelField：数据名称字段
 *  idField：数据id字段
 *  childrenField：子数据字段
 *  parentIdField：父级数据id字段
 *  defaultParentIdValue：默认的顶级数据的父级id值
 * @returns {array} 返回结果数组
 */
export function flatToNest(data, { labelField = 'name', idField = 'id', childrenField = 'children', parentIdField = 'parentId', defaultParentIdValue = 0 } = {}, showAll = true) {
  const rebuildData = deepClone(data)
  const mapData = {}
  const result = []
  rebuildData.forEach((item) => {
    mapData[item[idField]] = item
    if (!item[labelField]) {
      item[labelField] = ''
    }
    if (!item[parentIdField]) {
      item[parentIdField] = defaultParentIdValue
    }
    // 如果存在子数据，先删除掉
    if (item[childrenField]) {
      delete item[childrenField]
    }
  })
  // console.log('mapData', mapData)
  rebuildData.forEach((item) => {
    const parentIdValue = item[parentIdField]
    const id = item[idField]
    if (id === defaultParentIdValue) {
      result.push(item)
    } else {
      const parent = mapData[parentIdValue]
      if (parent) {
        if (parent[childrenField]) {
          parent[childrenField].push(item)
        } else {
          parent[childrenField] = [item]
        }
      } else {
        showAll && result.push(item)
      }
    }
  })
  // console.log('result', result)
  return result
}

/**
 * 获取有效的一维数组（数据源是可组成树形结构的数组）
 * @param {*} data 数据源
 * @param {*} param1 默认字段和参数设置
 * @description
 *  idField：数据id字段
 *  parentIdField：父级数据id字段
 *  defaultParentIdValue：默认的顶级数据的父级id值
 */
export function getValidFlatData(data, { idField = 'id', parentIdField = 'parentId', defaultParentIdValue = 0 } = {}) {
  const deepCloneData = deepClone(data)
  const result = []
  deepCloneData.forEach((item) => {
    if (item[parentIdField] === defaultParentIdValue) {
      result.push(item)
    } else {
      if (deepCloneData.findIndex((findItem) => findItem[idField] === item[parentIdField]) !== -1) {
        result.push(item)
      }
    }
  })

  return result
}

/**
 * 获取级联的一维数组最后一级数据
 * @param {array} data 数据源
 * @param {object} param1 默认字段和参数设置
 * @description
 *  labelField：数据名称字段
 *  idField：数据id字段
 *  childrenField：子数据字段
 *  parentIdField：父级数据id字段
 *  defaultParentIdValue：默认的顶级数据的父级id值
 * @returns {array} 返回结果数组
 */
export function getLastChildrenData(data, { idField = 'id', parentIdField = 'parentId' } = {}) {
  return data.filter((item) => data.findIndex((v) => v[parentIdField] === item[idField]) === -1)
}

/**
 * 删除一维数组中的数据
 * @param {array} data 数据源
 * @param {string | int | array} id 需要删除的id
 * @param {object} param1 默认参数设置
 * @description
 *  byField: 根据删除的字段
 *  isCascade：是否级联删除
 * @returns {array} 返回结果数组
 */
export function removeData(data, ids, { isCascade = true, idField = 'id', parentIdField = 'parentId' } = {}) {
  if (typeof ids === 'object') {
    if (!Array.isArray(ids)) {
      ids = ids.values()
    }
  } else {
    ids = [ids]
  }
  if (ids.length === 0) {
    return []
  }

  const deepCloneData = deepClone(data)
  const readOnlyData = deepClone(data)
  function removeChildrenData(parentId) {
    readOnlyData.forEach((item) => {
      // 如果该元素有所对应的父级id，则需要删除
      if (item[parentIdField] === parentId) {
        // 如果该元素存在子元素，则需要嵌套循环
        const index = deepCloneData.findIndex((v) => v[idField] === item[idField])
        if (index !== -1) {
          deepCloneData.splice(index, 1)
          if (deepCloneData.some((chirlItem) => chirlItem[parentIdField] === item[idField])) {
            removeChildrenData(item[idField])
          }
        }
      }
    })
  }

  readOnlyData.forEach((item) => {
    const id = item[idField]
    if (ids.includes(id)) {
      const index = deepCloneData.findIndex((v) => v[idField] === id)
      if (index !== -1) {
        deepCloneData.splice(index, 1)
        if (isCascade) {
          removeChildrenData(id)
        }
      }
    }
  })

  return deepCloneData
}
