<!-- 地址信息 -->
<template>
  <el-card shadow="never" class="counter">
    <div slot="header">
      <span class="card-title">位置信息</span>
      <el-button class="fr" icon="el-icon-location-information" type="primary" plain @click="updateLocation">定位
      </el-button>
    </div>
    <baidu-map
      class="map"
      v-bind="mapOptions"
    >
      <!-- 标记 点 -->
      <bm-marker :position="mapOptions.center" :dragging="true" animation="BMAP_ANIMATION_BOUNCE" title="单独的" />
      <!--<bm-marker :position="mapOptions.center" title="单独的"/>-->
    </baidu-map>
    <div style="display: none">
      <el-tag>东经：{{ mapOptions.center.lng }}</el-tag>
      <el-tag>北纬：{{ mapOptions.center.lat }}</el-tag>
    </div>
  </el-card>
</template>
<script>
// 百度地图组件
import Vue from 'vue'

import { BaiduMap, BmControl, BmView, BmAutoComplete, BmLocalSearch } from 'vue-baidu-map'
import BmMarker from 'vue-baidu-map/components/overlays/Marker.vue'

export default {
  name: 'QcMeterLocation',
  components: {
    BaiduMap,
    BmView,
    BmControl,
    BmAutoComplete,
    BmLocalSearch,
    BmMarker
  },
  data() {
    return {
      mapOptions: {
        // 北纬(north lat) 东经(east lnt)
        center: { lng: 116.403263, lat: 39.924342 }, // 坐标
        ak: 'zHCUdbSZDcAQRHMtk44y6CmbAlKkBN58', // ak
        scrollWheelZoom: true, // 滚动缩放
        zoom: 15 // 地图展示级别
      }
    }
  },
  computed: {},
  methods: {
    updateLocation() {
      this.mapOptions.center = { lng: 104.189589, lat: 30.549658 }
    }
  }
}
</script>
<style lang="scss" scoped>
::v-deep .el-card__body {
  padding: 10px;
}

// 地图区域
.map {
  height: 210px;
  margin-bottom: 10px;
  background: #ddd;
}

::v-deep .BMap_cpyCtrl {
  display: none;
}

::v-deep .anchorBL {
  display: none;
}
</style>
