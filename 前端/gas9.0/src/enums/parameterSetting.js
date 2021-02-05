/**
 * 参数设置枚举
 */

 // 参数设置取值
const SETSUPERFLUID = 'SETSUPERFLUID' // 开/关超流检测
const SETUP_UNUPLOAD_CLOSEVALVEDAY = 'unUploadClose' // 多天未上报权限关阀
const SETUP_VALVECLOSE_NOUPLOAD = 'valveNoUpload' // 多天不上传普通关阀控制参数
const SETUP_VALVECLOSE_NOUSE = 'valveCloseNouse' // 多天不用气关阀控制参数
const SETUP_TIME_INTERVAL = 'timeInterva' // 设置错峰时间间隔
const SETUP_FLOWOVER_ENABLE = 'flowoverEnable' // 过流报警
const SETUP_TIMED_PARAMETER = 'timedParamMeter' // 上传时间设置

// 参数类型字段集合
export const parameterFields = {
  SETSUPERFLUID,
  SETUP_UNUPLOAD_CLOSEVALVEDAY,
  SETUP_VALVECLOSE_NOUPLOAD,
  SETUP_VALVECLOSE_NOUSE,
  SETUP_TIME_INTERVAL,
  SETUP_FLOWOVER_ENABLE,
  SETUP_TIMED_PARAMETER,
}

// 参数类型key-value枚举
export const parameterMap = {
  [SETSUPERFLUID]: '开/关超流检测',
  [SETUP_UNUPLOAD_CLOSEVALVEDAY]: '多天未上报权限关阀',
  [SETUP_VALVECLOSE_NOUPLOAD]: '多天不上传普通关阀',
  [SETUP_VALVECLOSE_NOUSE]: '多天不用气关阀',
  [SETUP_TIME_INTERVAL]: '错峰时间间隔',
  [SETUP_FLOWOVER_ENABLE]: '过流报警',
  [SETUP_TIMED_PARAMETER]: '定时上传参数',
}

// 通用的具体参数字段
const COMMON_FIELD = 'Value' // 通用的参数字段
const CONTROL_CODE = 'controlCode' // 控制码

// 通用的选项值
// 控制码k-v枚举
export const controlCodeMap = {
  '00': '关闭',
  '10': '开启'
}

// 是否禁止和启用
const ENABLE_VALUE = '1' // 禁止
const UNABLE_VALUE = '0' // 开启
export const openCloseMap = {
  [ENABLE_VALUE]: '开启',
  [UNABLE_VALUE]: '关闭'
}

// 参数设置所需表单和选项
export const parameterFormOptions = {
  // [SETSUPERFLUID]: {
  //   // 参数属性选项
  //   options: {
  //     version: ['NB20'], // 该参数设置支持的版号
  //   },
  //   // 该参数设置下的具体参数设置
  //   fields: {
  //     [CONTROL_CODE]: {
  //       type: 'radio', // 输入框类型，
  //       value: null, // v-model绑定值
  //       defaultValue: '01', // 默认值
  //       prependText: '', // 输入框前置内容
  //       appendText: '', // 输入框后置内容
  //       hintText: '', // 输入框提示内容
  //       // element ui表单 Form-Item属性
  //       formItemAttributes: {
  //         label: '控制模式',
  //         rules: (form) => {
  //           return [
  //             { required: true, message: '请选择控制模式。', trigger: 'change' }
  //           ]
  //         },
  //       },
  //       // element ui 输入框属性
  //       attributes: {
  //       },
  //       // 输入框事件
  //       events: {},
  //       options: controlCodeMap, // 可选项
  //     }
  //   }
  // },
  [SETUP_UNUPLOAD_CLOSEVALVEDAY]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      [COMMON_FIELD]: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 5, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '天', // 输入框后置内容
        hintText: '输入范围：0~255，0表示禁用', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '天数',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, max: 255, message: '输入范围：0~255', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '输入范围：0~255',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      }
    }
  },
  [SETUP_VALVECLOSE_NOUPLOAD]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      [COMMON_FIELD]: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 5, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '天', // 输入框后置内容
        hintText: '输入范围：0~255，0表示禁用', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '天数',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, max: 255, message: '输入范围：0~255', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '输入范围：0~255',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      }
    }
  },
  [SETUP_VALVECLOSE_NOUSE]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      [COMMON_FIELD]: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 5, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '天', // 输入框后置内容
        hintText: '输入范围：0~255，0表示禁用', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '天数',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, max: 255, message: '输入范围：0~255', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '输入范围：0~255',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      }
    }
  },
  [SETUP_TIME_INTERVAL]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      [COMMON_FIELD]: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 15, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '秒', // 输入框后置内容
        hintText: '输入范围：15~43', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '错峰时间间隔',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 15, max: 43, message: '输入范围：15~43', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '输入范围：15~43',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      }
    }
  },
  [SETUP_FLOWOVER_ENABLE]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      [COMMON_FIELD]: {
        type: 'radio', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: UNABLE_VALUE, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '', // 输入框后置内容
        hintText: '', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '是否启用',
          rules: (form) => {
            return [
              { required: true, message: '请选择。', trigger: 'change' }
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
        },
        // 输入框事件
        events: {},
        options: openCloseMap, // 可选项
      }
    }
  },
  [SETUP_TIMED_PARAMETER]: {
    // 参数属性选项
    options: {
      version: ['NB21', 'NB22'], // 该参数设置支持的版号
    },
    // 该参数设置下的具体参数设置
    fields: {
      Days: {
        type: 'select', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: '0', // 默认值
        prependText: '', // 输入框前置内容
        appendText: '', // 输入框后置内容
        hintText: '', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '标志',
          rules: (form) => {
            return [
              { required: true, message: '请选择。', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '',
        },
        // 输入框事件
        events: {},
        options: {
          '0': '月',
          '1': '天',
        }, // 可选项
      },
      Cycle: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 1, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '', // 输入框后置内容
        hintText: '如果选择的定时上传时间标志是天,表示隔几天,如果是月,表示每月几号', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '周期',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, message: '周期必须为正整数', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      },
      UploadHours: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 0, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '', // 输入框后置内容
        hintText: '输入范围：0~24', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '小时',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, max: 24, message: '值必须为0~24正整数', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '范围：0~24',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      },
      UploadMinutes: {
        type: 'number', // 输入框类型，
        value: null, // v-model绑定值
        defaultValue: 0, // 默认值
        prependText: '', // 输入框前置内容
        appendText: '', // 输入框后置内容
        hintText: '输入范围：0~60', // 输入框提示内容
        // element ui表单 Form-Item属性
        formItemAttributes: {
          label: '分钟',
          rules: (form) => {
            return [
              { required: true, message: '不能为空', trigger: 'blur' },
              { type: 'integer', min: 0, max: 24, message: '值必须为0~60正整数', trigger: 'blur' },
            ]
          },
        },
        // element ui 输入框属性
        attributes: {
          placeholder: '范围：0~60',
        },
        // 输入框事件
        events: {},
        options: {}, // 可选项
      },
    }
  },
}

// 获取可进行参数设置的版号
export function getParameterSettingVersions() {
  // 预检是否可进行参数设置
  const canParameterSettingVersionsTemp = []
  for (const key in  parameterFormOptions) {
    const versions = parameterFormOptions[key]?.options?.version ?? []
    canParameterSettingVersionsTemp.push(...versions)
  }

  return [...new Set(canParameterSettingVersionsTemp)]
}

// 判断版号是否可进行参数设置
export function checkParameterSetting(checkVersion) {
  return getParameterSettingVersions().find((version) => checkVersion.toUpperCase().trim().includes(version))
}
