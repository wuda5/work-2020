/* eslint-disable */
import { awaitToJs } from '@/utils/index';
import { saveAs } from 'file-saver';
// import XLSX from 'xlsx'
import { cloneDeep, merge } from 'lodash';

function generateArray(table) {
  var out = [];
  var rows = table.querySelectorAll('tr');
  var ranges = [];
  for (var R = 0; R < rows.length; ++R) {
    var outRow = [];
    var row = rows[R];
    var columns = row.querySelectorAll('td');
    for (var C = 0; C < columns.length; ++C) {
      var cell = columns[C];
      var colspan = cell.getAttribute('colspan');
      var rowspan = cell.getAttribute('rowspan');
      var cellValue = cell.innerText;
      if (cellValue !== "" && cellValue == +cellValue) cellValue = +cellValue;

      //Skip ranges
      ranges.forEach(function (range) {
        if (R >= range.s.r && R <= range.e.r && outRow.length >= range.s.c && outRow.length <= range.e.c) {
          for (var i = 0; i <= range.e.c - range.s.c; ++i) outRow.push(null);
        }
      });

      //Handle Row Span
      if (rowspan || colspan) {
        rowspan = rowspan || 1;
        colspan = colspan || 1;
        ranges.push({
          s: {
            r: R,
            c: outRow.length
          },
          e: {
            r: R + rowspan - 1,
            c: outRow.length + colspan - 1
          }
        });
      };

      //Handle Value
      outRow.push(cellValue !== "" ? cellValue : null);

      //Handle Colspan
      if (colspan)
        for (var k = 0; k < colspan - 1; ++k) outRow.push(null);
    }
    out.push(outRow);
  }
  return [out, ranges];
};

function datenum(v, date1904) {
  if (date1904) v += 1462;
  var epoch = Date.parse(v);
  return (epoch - new Date(Date.UTC(1899, 11, 30))) / (24 * 60 * 60 * 1000);
}

function sheet_from_array_of_arrays(data, opts) {
  // 判断表格整列正则
  const columnReg = /^([a-z]+)\d+$/i
  const { defaultCellOptions, cellOptions } = opts
  // 需要添加属性的单元格
  const addCells = Object.keys(cellOptions || {})
  var ws = {};
  var range = {
    s: {
      c: 10000000,
      r: 10000000
    },
    e: {
      c: 0,
      r: 0
    }
  };
  for (var R = 0; R != data.length; ++R) {
    for (var C = 0; C != data[R].length; ++C) {
      if (range.s.r > R) range.s.r = R;
      if (range.s.c > C) range.s.c = C;
      if (range.e.r < R) range.e.r = R;
      if (range.e.c < C) range.e.c = C;
      var cell = {
        v: data[R][C]
      };
      if (cell.v == null) continue;
      var cell_ref = XLSX.utils.encode_cell({
        c: C,
        r: R
      });

      if (typeof cell.v === 'number') cell.t = 'n';
      else if (typeof cell.v === 'boolean') cell.t = 'b';
      else if (cell.v instanceof Date) {
        cell.t = 'n';
        cell.z = XLSX.SSF._table[14];
        cell.v = datenum(cell.v);
      } else cell.t = 's';

      // 设置表格单元格默认样式
      cell = merge(cell, setDefaultOptions(), defaultCellOptions)
      let addColumnOption = {}
      if (columnReg.test(cell_ref)) {
        addColumnOption = cellOptions[cell_ref.replace(columnReg, '$1')]
      }
      const addCellOptions = cellOptions[cell_ref]
      if (addColumnOption || addCellOptions) {
        cell = merge(cell, addColumnOption, addCellOptions)
      }

      ws[cell_ref] = cell;
    }
  }
  if (range.s.c < 10000000) ws['!ref'] = XLSX.utils.encode_range(range);
  return ws;
}

function Workbook() {
  if (!(this instanceof Workbook)) return new Workbook();
  this.SheetNames = [];
  this.Sheets = {};
}

function s2ab(s) {
  var buf = new ArrayBuffer(s.length);
  var view = new Uint8Array(buf);
  for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
  return buf;
}

// 重组合并参数数据
function generateMerge(data) {
  let result = null
  if (typeof data === 'string') {
    result = XLSX.utils.decode_range(data)
  } else if (typeof data === 'object') {
    if (data.s && data.e) {
      result = data
    }
  }
  return result
}

// 设置默认单元格统一属性
function setDefaultOptions() {
  return {
    s: {
      alignment: {
        vertical: 'center',
        horizontal: 'center'
      }
    }
  }
}

export function export_table_to_excel(id) {
  var theTable = document.getElementById(id);
  var oo = generateArray(theTable);
  var ranges = oo[1];

  /* original data */
  var data = oo[0];
  var ws_name = "SheetJS";

  var wb = new Workbook(),
    ws = sheet_from_array_of_arrays(data);

  /* add ranges to worksheet */
  // ws['!cols'] = ['apple', 'banan'];
  ws['!merges'] = ranges;

  /* add worksheet to workbook */
  wb.SheetNames.push(ws_name);
  wb.Sheets[ws_name] = ws;

  var wbout = XLSX.write(wb, {
    bookType: 'xlsx',
    bookSST: false,
    type: 'binary'
  });

  saveAs(new Blob([s2ab(wbout)], {
    type: "application/octet-stream"
  }), "test.xlsx")
}

/**
 * 导出json数据
 * @param {*} param0 
 *    @param {Array} header 设置表头，必传属性 ['', 'Title', 'Author', 'Readings', '']
 *    @param {Array} data 数据列表，必传属性 [['Id', 'Title', 'Author', 'Readings', 'Date'], ['Id', 'Title', 'Author', 'Readings', 'Date']]
 *    @param {Array} multiHeader 设置多级表头 [['Id', 'Main Information', '', '', 'Date']]
 *    @param {Array} merges 设置哪些单元格需要合并 ['A1:A2', 'B1:D1', 'E1:E2']
 *    @param {String} filename 设置导出文件名
 *    @param {String} bookType 设置导出文件类型，默认xlsx
 *    @param {Boolean} autoWidth 是否宽度自适应，默认true
 *    @param {Object} defaultCellOptions 设置默认的所有单元格属性
 *    @param {Object} cellOptions 设置单元格属性  设置一列的单元格{ 'A': { v: '' , t: 's', s: { font: { bold: true } }} }, 设置一个单元格{ 'A1': { v: '' , t: 's', s: { font: { bold: true } }} } , 参照https://github.com/protobi/js-xlsx
 *    @param {Function} customExcelOptionsFun 自定义表格样式函数，参数为表格实例化对象ws, 必须返回ws，否则修改的样式不会生效，最好返回promise对象
 */
export async function export_json_to_excel({
  multiHeader = [],
  header,
  data,
  filename,
  merges = [],
  autoWidth = true,
  defaultCellOptions = {}, // 是否默认表格内容居中
  bookType = 'xlsx',
  cellOptions = {}, // 设置单元格的样式
  customExcelOptionsFun
} = {}) {
  try {
    /* original data */
    filename = filename || 'excel-list'
    data = [...data]
    data.unshift(header);
  
    for (let i = multiHeader.length - 1; i > -1; i--) {
      data.unshift(multiHeader[i])
    }
  
    var ws_name = "SheetJS";
    var wb = new Workbook(),
      ws = sheet_from_array_of_arrays(data, { defaultCellOptions, cellOptions });
  
    if (merges.length > 0) {
      if (!ws['!merges']) ws['!merges'] = [];
      merges.forEach(item => {
        const merge = generateMerge(item)
        if (merge) ws['!merges'].push(generateMerge(item))
      })
    }
    
    console.log('ws', ws)
    // console.log('data', data)
    // console.log('multiHeader', multiHeader)
  
    if (autoWidth) {
      /*设置worksheet每列的最大宽度*/
      const colWidth = data.map(row => row.map(val => {
        /*先判断是否为null/undefined*/
        if (val == null) {
          return {
            'wch': 10
          };
        }
        /*再判断是否为中文*/
        else if (val.toString().charCodeAt(0) > 255) {
          return {
            'wch': val.toString().length * 2
          };
        } else {
          return {
            'wch': val.toString().length
          };
        }
      }))
      // console.log('colWidth', colWidth)
      /*以第一行为初始值*/
      let result = colWidth[0];
      for (let i = 1; i < colWidth.length; i++) {
        for (let j = 0; j < colWidth[i].length; j++) {
          if (result[j]['wch'] < colWidth[i][j]['wch']) {
            result[j]['wch'] = colWidth[i][j]['wch'];
          }
        }
      }
      ws['!cols'] = result;
    }

    const deepCloneWs = cloneDeep(ws)
    if (customExcelOptionsFun) {
      const customResult = await awaitToJs(customExcelOptionsFun(deepCloneWs))
      if (!customResult.error && customResult) {
        ws = customResult
      }
    }
  
    /* add worksheet to workbook */
    wb.SheetNames.push(ws_name);
    wb.Sheets[ws_name] = ws;
  
    var wbout = XLSX.write(wb, {
      bookType: bookType,
      bookSST: false,
      type: 'binary'
    });
    saveAs(new Blob([s2ab(wbout)], {
      type: "application/octet-stream"
    }), `${filename}.${bookType}`);
    return Promise.resolve(true)
  } catch (error) {
    console.log(error)
    return Promise.reject(error)
  }
}

/**
 * 格式化导出的json数据
 * @param {*} data 数据源
 * @param {*} fields 数据字段，导出的数据顺序按照该方式排序，如果不传递该参数，则按照原始数据排序字段显示
 */
export function formatJsonData(data, fields) {
  const result = []
  if (!Array.isArray(data) || data.length === 0) {
    return []
  }
  if (Array.isArray(fields) && fields.length > 0) {
    data.forEach((item) => {
      result.push(fields.map((field) => item[field] || ''))
    })
  } else {
    data.forEach((item) => {
      result.push(Object.values(item))
    })
  }
  // console.log('result', result)
  return result
}