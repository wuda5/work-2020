<template>
  <div class="test-page">
    <div>
      <el-form>
        <el-form-item label="数字">
          <el-input-number v-model="num" :controls="false" :max="10" :precision="0" placeholder=""></el-input-number>
        </el-form-item>
        <el-form-item label="租定义数字组件">
          <qc-number-input v-model="num" :max="10" :precision="1"></qc-number-input>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { omit, pick } from 'lodash'
import { download } from '@/api/test'
import commonMixin from '@/mixins/common'
import dayjs from 'dayjs'
import QcNumberInput from '@/components/QcNumberInput/Index.vue'

const date = '2020-12-01'
const dateObj = new Date(date)
console.log(dateObj.setMonth(dateObj.getMonth() + 1))
console.log(dateObj)

// const a = { a: 1, b: '2w', c: 3 }
// const b = { a: 'a', b: 'b', c: 'c' }
// const c = pick(b, Object.keys(a))
// console.log('c', c)
// c.a = 'udopate'
// console.log('c', c)
// console.log('b', b)
console.log('你好\n，世界')
const str = `
console.log(new Date());
console.log('你好\n，世界')`
  console.log('str', str)
  console.log('JSONstr', JSON.stringify(str))
  const newStr = str.replace(/\n/g, '\\n')
  console.log('newStr', newStr)
  console.log('JSONnewStr', JSON.stringify(newStr))
  // console.log('JSONnewStrdddd', JSON.stringify(newStr).replace(/^(")\s\S+(")$/g, function(value, index){
  //   console.log(value, index)
  // } ))
  console.log('JSONnewStrdddd', JSON.stringify(newStr).replaceAll('"', ''))
  // eval(str)
  // eval(JSON.stringify(newStr).replaceAll('"', ''))
// const result = str.replace(/\n/g, function(a, b, c) {
//   console.log('a', a.replace(a, '这是空格'))
//   return a.replace(a, '这是空格')
//   // console.log('b', b)
//   // console.log('c', c)
// })
//   console.log('result', result)

export default {
  name: 'Lilb',
  components: {
    QcNumberInput
  },
  filters: {},
  mixins: [commonMixin],
  props: {

  },
  data() {
    return {
      num: '1.00',
      options: [],
        value: [],
        list: [],
        loading: false,
        states: ['Alabama', 'Alaska', 'Arizona',
        'Arkansas', 'California', 'Colorado',
        'Connecticut', 'Delaware', 'Florida',
        'Georgia', 'Hawaii', 'Idaho', 'Illinois',
        'Indiana', 'Iowa', 'Kansas', 'Kentucky',
        'Louisiana', 'Maine', 'Maryland',
        'Massachusetts', 'Michigan', 'Minnesota',
        'Mississippi', 'Missouri', 'Montana',
        'Nebraska', 'Nevada', 'New Hampshire',
        'New Jersey', 'New Mexico', 'New York',
        'North Carolina', 'North Dakota', 'Ohio',
        'Oklahoma', 'Oregon', 'Pennsylvania',
        'Rhode Island', 'South Carolina',
        'South Dakota', 'Tennessee', 'Texas',
        'Utah', 'Vermont', 'Virginia',
        'Washington', 'West Virginia', 'Wisconsin',
        'Wyoming', 'aidnnds', 'adfniwe', 'dafagads', 'a83h12', 'a12321n3i', 'add', 'dadfa32d', 'adaff', 'dafadsfafdf', 'dfadf', 'a1293213', 'a123131', 'a12313', 'a123123', 'a12321313131', 'a89239h', 'an9823nd', 'admn023h0d', 'adfmj213j', 'a3190j123']
    }
  },
  computed: {

  },
  watch: {

  },
  created() {
    this.initData()
  },
  mounted() {
this.list = this.states.map(item => {
        return { value: `value:${item}`, label: `label:${item}` };
      });
  },
  destroyed() {

  },
  methods: {
    async initData() {
      // download()
    },
    remoteMethod(query) {
        if (query !== '') {
          this.loading = true;
          setTimeout(() => {
            this.loading = false;
            this.options = this.list.filter(item => {
              return item.label.toLowerCase()
                .indexOf(query.toLowerCase()) > -1;
            });
          }, 200);
        } else {
          this.options = [];
        }
    }
  }
}
</script>

<style scoped lang="scss">

</style>
