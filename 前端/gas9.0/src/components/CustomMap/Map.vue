<!--
 * @Description: baidu 地图组件
 * @Author: lingw
 * @Date: 2020-10-19 13:49:54
 * @LastEditors: lingw
 * @LastEditTime: 2020-10-21 10:22:36
-->
<!-- 地址信息 -->
<template>
  <baidu-map
    class="map"
    v-bind="mapOptions"
    :style="{width: `${width}px`, height: `${height}px`}"
    :scroll-wheel-zoom="true"
    auto-resize
  >
    <!-- 点聚合块 -->
    <bml-marker-clusterer :average-center="true">
      <!-- 标记 点 -->
      <bm-marker v-for="marker in markers" :key="marker.code" :title="marker.name" :position="{lng: marker.lng, lat: marker.lat}" @click="lookDetail(marker)"></bm-marker>
    </bml-marker-clusterer>
    <!--信息窗体-->
    <bm-info-window :position="{lng: infoWindow.info.lng, lat: infoWindow.info.lat}" :title="infoWindow.info.name" :show="infoWindow.show" @close="infoWindowClose" @open="infoWindowOpen">
      <span>hello I'm here</span>
    </bm-info-window>
  </baidu-map>
</template>
<script>

// 百度地图组件
import { BaiduMap, BmlMarkerClusterer } from 'vue-baidu-map'
import BmMarker from 'vue-baidu-map/components/overlays/Marker.vue'
import BmInfoWindow from 'vue-baidu-map/components/overlays/InfoWindow'

export default {
  name: 'QcMeterLocation',
  components: {
    BaiduMap,
    BmMarker,
    BmlMarkerClusterer,
    BmInfoWindow
  },
  data() {
    return {
      mapOptions: {
        // 北纬(north lat) 东经(east lnt)
        center: '四川省成都市', // 坐标
        ak: 'zHCUdbSZDcAQRHMtk44y6CmbAlKkBN58', // ak
        scrollWheelZoom: true, // 滚动缩放
        zoom: 10 // 地图展示级别
      },
      markers: [], // 地图上的聚合点数组
      // 弹框信息
      infoWindow: {
        lng: 0,
        lat: 0,
        show: false,
        info: {
          air: 0,
          area: 12313,
          areaEnergy: 0.64,
          code: '440300A055',
          energy: 7922.66,
          lat: '32.043433',
          lng: '118.784107',
          name: '市人民检察院',
          water: 0
        }
      },
      // 当前选中的节点
      activeName: ''
    }
  },
  computed: {
    width() {
      return document.body.clientWidth
    },
    height() {
      return document.body.clientHeight - 80
    }
  },
  mounted() {
    for (let i = 0; i < 20; i++) {
      const position = { lng: Math.random() + 104, lat: Math.random() + 30 }
      this.markers.push(position)
    }
  },
  methods: {
    updateLocation() {
      this.mapOptions.center = { lng: 104.189589, lat: 30.549658 }
    },
    infoWindowClose (e) {
      this.infoWindow.show = false
    },
    infoWindowOpen (e) {
      this.infoWindow.show = true
    },
    // 查看详情
    lookDetail(data, target) {
      this.infoWindow.show = true
      this.infoWindow.info = data
      this.activeName = data.name
    },
    // 设置marker
    setMarker(record) {
      this.marker = record
      this.mapOptions.center = record
    }
  }
}
</script>
<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}

::v-deep .BMap_cpyCtrl {
  display: none;
}

::v-deep .anchorBL {
  display: none;
}
</style>
