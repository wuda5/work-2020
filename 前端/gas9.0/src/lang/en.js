import { merge } from 'lodash'
let files = []
let fieldsMap = {}
try {
  files = require.context('./en', true, /\.js$/)
  files.keys().forEach((filePath) => {
    const fileContent = files(filePath)
    fieldsMap = merge(fieldsMap, fileContent?.default || {})
  })
} catch (error) {
  console.log(error)
}
// console.log('fieldsMap', fieldsMap)

export default fieldsMap
