import { merge } from 'lodash'
let files = []
let fieldsMap = {}
try {
  files = require.context('./zh', false, /\.js$/)
  files.keys().forEach((filePath) => {
    const fileContent = files(filePath)
    fieldsMap = merge(fieldsMap, fileContent?.default || {})
  })
} catch (error) {
  console.log(error)
}
// console.log('fieldsMap', fieldsMap)

export default fieldsMap
