import commonApi from '@/api/Common'
import dictionaryItemApi from '@/api/DictionaryItem'
import { deleteStatusField } from '@/enums/common'
import { merge } from 'lodash'
import dayjs from 'dayjs';

export const loadEnums = (codes, enums = {}) => {
  if (typeof (codes) === 'string') {
    codes = [codes]
  }

  if (codes && codes.length > 0) {
    commonApi.enums({codes: codes}).then(response => {
      const res = response.data
      for (const code of codes) {
        enums[code] = res.data[code]
      }
    })
  }
}

/**
 * 初始化权限服务枚举
 * @param codes
 * @param enums
 */
export const initEnums = (codes, enums = {}) => {
  loadEnums(codes, enums)
}
/**
 * 初始化文件服务枚举
 * @param codes
 * @param enums
 */
export const initFileEnums = (codes, enums = {}) => {
  loadEnums(codes, enums)
}
/**
 * 初始化消息服务枚举
 * @param codes
 * @param enums
 */
export const initMsgsEnums = (codes, enums = {}) => {
  loadEnums(codes, enums)
}

/**
 * 初始化字典
 * @param codes
 * @param dicts
 */
export const initDicts = (codes, dicts = {}) => {
  if (typeof (codes) === 'string') {
    codes = [codes]
  }

  if (codes && codes.length > 0) {
    dictionaryItemApi.list({codes: codes}).then(response => {
      const res = response.data
      for (const code of codes) {
        dicts[code] = res.data[code]
      }
    })
  }
}

/**
 * 下载方法
 * @param response
 */
export const downloadFile = (response) => {
  const res = response.data;
  const type = res.type;
  if (type.includes('application/json')) {
    let reader = new FileReader();
    reader.onload = e => {
      if (e.target.readyState === 2) {
        let data = JSON.parse(e.target.result);
        this.$message({
          message: data.msg,
          type: 'warning'
        });
      }
    };
    reader.readAsText(res);
  } else {
    let disposition = response.headers['content-disposition'];
    let fileName = '下载文件.zip';
    if (disposition) {
      let respcds = disposition.split(';');
      for (let i = 0; i < respcds.length; i++) {
        let header = respcds[i];
        if (header !== null && header !== '') {
          let headerValue = header.split('=');
          if (headerValue !== null && headerValue.length > 0) {
            if (headerValue[0].trim().toLowerCase() === 'filename') {
              fileName = decodeURI(headerValue[1]);
              break;
            }
          }
        }
      }
    }
    //处理引号
    if ((fileName.startsWith("'") || fileName.startsWith('"')) && (fileName.endsWith("'") || fileName.endsWith('"'))) {
      fileName = fileName.substring(1, fileName.length - 1)
    }

    let blob = new Blob([res]);
    let link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = fileName;
    link.click();
    window.URL.revokeObjectURL(link.href);
  }
}

// 初始化查询参数
export const initQueryParams = (params = {}, deepMerge = true) => {
  const defParams = {
    size: 10,
    current: 1,
    sort: 'id',
    order: 'descending',
    model: {
      dataStatus: null,
      deleteStatus: deleteStatusField.DELETE_INVALID
    },
    map: {},
    timeRange: null
  }
  if (deepMerge) {
    return merge(defParams, params)
  } else {
    return params ? { ...defParams, ...params } : defParams;
  }
}

/**
 * 设置默认的列表信息存放字段数据
 * @param {Object} customData 自定义列表数据
 * @param {Boolean} deepMerge 是否数据深度合并 
 */
export const initListData = (customData = {}, deepMerge = true) => {
  const defaultListData = {
    listRef: 'listRef',
    list: [], // 列表数据存放
    total: 0,
    listLoading: false, // 表格数据loading
    queryParams: initQueryParams(),
    multipleSelection: [], // 选中的行的数据信息
    currentRow: null, // 当前正在操作的行
    isRowClick: false, // 是否单击表格行了
    // 列表筛选表单ref
    searchFormRef: 'SearchFormRef',
    // 列表筛选表单
    searchForm: {
    },
    // 列表筛选表单规则
    searchFormRules: {
    },
    formDialogVisible: false, // 表单弹框显示标志
  }
  if (deepMerge) {
    return merge(defaultListData, customData)
  } else {
    return { ...defaultListData, ...customData }
  }
}

/**
 * @name: 时间转字符串
 * @param {Date} date时间 
 * @return {String} 字符串时间格式 
 */
export const parseDate2Str = (date, format = 'YYYY-MM-DD') => dayjs(date).format(format)

/**
 * @name: 手机校验
 * @param {String} 手机号码字符串
 * @return {Number} 校验结果 1 正确 0 错误
 */
export const checkPhone = field => {
  const reg = /^[1]([3-9])[0-9]{9}$/;
  if (reg.test(field)) {
    return 1;
  }
  return 0;
};

// 千分位格式化
export const formatNumber2Thousand = num => {
  if (num == null || num === '--') {
    return '--';
  }
  return num
    .toString()
    .replace(/(\d)(?=(\d{3})+(?!\d))/g, `$1,`);
}