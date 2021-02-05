/**
 * 项目公用混入
 */

 export default {
   data() {
     return {
      result: '', // 存放从后端获取的最原始数据
      data: '', // 统一数据存放
      loading: false, // 全局页面加载loading
      btnLoading: false, // 全局按钮加载loading
     }
   }
 }
