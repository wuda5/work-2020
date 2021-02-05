/**
 * 获取字典数据混入
 */
import { mapState } from 'vuex'
import { arrayColumn } from '@/utils/array'

 export default {
  computed: {
    ...mapState({
      dictionary: state => state.common.dict
    })
  },
  methods: {
    // 获取指定code字典数据
    getDictionaryDataByCode(code) {
      return this.dictionary[code] || []
    },
    // 获取指定字典数据键值对映射
    getDictionaryMapByCode(code, value = 'name', key = 'code') {
      return arrayColumn(this.dictionary[code] || [], value, key)
    }
  },
 }