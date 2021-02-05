module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
    es6: true
  },
  'extends': [
    'plugin:vue/essential', 'plugin:vue/recommended', 'eslint:recommended'
  ],
  rules: {
    // 还可以写表达式，厉害了~
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',

    // add
    // 单引号
    'quotes': [1, 'single', {
      'avoidEscape': true,
      'allowTemplateLiterals': true
    }],

    // 最大空行数
    'no-multiple-empty-lines': [2, {
      'max': 1
    }],

    "vue/singleline-html-element-content-newline": "off",
    "vue/multiline-html-element-content-newline": "off",
    'vue/max-attributes-per-line': 'off',
    'vue/html-indent': 'off',
    'vue/no-unused-components': 0,
    // 未使用变量不提示
    'vue/no-unused-vars': 'off',
    "no-unused-vars": 'off',

    // 标签闭合
    'vue/html-self-closing': 0,
    // props 默认值不必须
    'vue/require-default-prop': 0,
    // v-html不警告
    'vue/no-v-html': 0,
    // 组件名禁止首字符大写
   'vue/name-property-casing': 0,
   
  },
  parserOptions: {
    parser: 'babel-eslint'
  }
}
