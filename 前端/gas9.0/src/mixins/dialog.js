export default {
  data() {
    return {}
  },

  methods: {
    // 补卡
    dialogOpen(key) {
      console.log(this[key])
      this[key] = true
    },

    dialogClose(key) {
      this[key] = false
    }
  }
}