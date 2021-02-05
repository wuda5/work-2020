/**
 * 关于百度地图混入函数
 */

import BaiduMap from 'vue-baidu-map/components/map/Map.vue'

 export default {
  components: {
    BaiduMap
  },
  data() {
    return {
      BMap: null, // BMap 类
      map: null, // map 实例
    }
  },
  computed: {
  },
  methods: {
    //地图加载完毕
    handleMapReady({BMap, map}) {
      this.BMap = BMap
      this.map = map
    },

    // 根据地理位置获取坐标点 address: 地址 city: 城市名
    getPoint(address, city) {
      return new Promise((resolve) => {
        const { BMap } = this
        if (BMap) {
          const mapGeo = new BMap.Geocoder()
          mapGeo.getPoint(address, (point) => {
            // console.log('point', point)
            resolve(point)
          }, city)
        }
      })
    }
  },
 }