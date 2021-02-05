module.exports = {
  printWidth: 100, //每行最多多少个字符换行
  singleQuote: true, // 使用单引号, 默认false(在jsx中配置无效, 默认都是双引号)
  trailingComma: 'es5', // 对象属性最后有 ","
  semi: false, //是否需要分号
  tabWidth: 2, // tab缩进大小,默认为2
  useTabs: false, // 使用tab缩进，默认false

  // 行尾逗号,默认none,可选 none|es5|all
  // es5 包括es5中的数组、对象
  // all 包括函数对象等所有可选
  TrailingCooma: 'all',

  // 对象中的空格 默认true
  // true: { foo: bar }
  // false: {foo: bar}
  bracketSpacing: true,

  // JSX标签闭合位置 默认false
  // false: <div
  //          className=""
  //          style={{}}
  //       >
  // true: <div
  //          className=""
  //          style={{}} >
  jsxBracketSameLine: false,

  // 箭头函数参数括号 默认avoid 可选 avoid| always
  // avoid 能省略括号的时候就省略 例如x => x
  // always 总是有括号
  arrowParens: 'avoid',

  // 对象属性的引号使用
  // as-needed 仅在需要的时候使用
  // consistent 有一个属性需要引号，就都需要引号
  // preserve 保留用户输入的情况
  quoteProps: 'as-needed',

  // 行末尾标识
  // “auto” - 默认使用Maintain existing line endings (mixed values within one file are normalised by looking at what’s used after the first line)
  // “lf” – Line Feed only (\n), common on Linux and macOS as well as inside git repos
  // “crlf” - Carriage Return + Line Feed characters (\r\n), common on Windows
  // “cr” - Carriage Return character only (\r), used very rarely

  endOfLine: 'auto',
}
