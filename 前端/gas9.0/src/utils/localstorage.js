const db = {
  save (key, value, prefix = true) {
    // if (value) {
    if (prefix) {
      let projectName = process.env.VUE_APP_PROJECT_NAME
      localStorage.setItem(projectName + '_' + key, JSON.stringify(value))
    } else {
      localStorage.setItem(key, JSON.stringify(value))
    }
    // } else {
    //   console.log("set 出错： key=" + key + ',value=' + value)
    // }

  },
  get (key, defaultValue = {}, prefix = true) {
    let projectName = process.env.VUE_APP_PROJECT_NAME
    try {
      if (prefix) {
        return JSON.parse(localStorage.getItem(projectName + '_' + key)) || defaultValue
      } else {
        return JSON.parse(localStorage.getItem(key)) || defaultValue
      }
    } catch (err) {
      return defaultValue
    }
  },
  remove (key, prefix = true) {
    if (prefix) {
      let projectName = process.env.VUE_APP_PROJECT_NAME
      localStorage.removeItem(projectName + '_' + key)
    } else {
      localStorage.removeItem(key)
    }
  },
  clear (prefix = true) {
    // localStorage.clear()

    // 为了使 gmis-admin-ui 和 gmis-ui 能在同一个域下 独立使用， 清除缓存时，需要区分来

    let projectName = process.env.VUE_APP_PROJECT_NAME
    for (const key in localStorage) {
      if (prefix) {
        if (key.indexOf(projectName) !== -1) {
          console.log(key)
          localStorage.removeItem(key)
        }
      } else {
        localStorage.removeItem(key)
      }
    }
  }
}

export default db
