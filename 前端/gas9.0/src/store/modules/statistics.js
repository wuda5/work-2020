import db from '@/utils/localstorage'

export default {
  namespaced: true,
  state: {
    curTabName: '',
    org: ''
  },
  mutations: {
    changeTabName(state, value) {
      // console.log(value)
      state.curTabName = value
    },
    changeOrg(state, value) {
      // console.log(value)
      state.org = value
    },
  },
}
