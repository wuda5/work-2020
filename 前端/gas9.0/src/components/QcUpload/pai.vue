<!-- 上传 -->
<template>
  <div>
    <div class="el-upload-list">
      <!--<img v-for="(img,index) in imgList" :key="index" :src="img" alt="">-->
      <img-item v-for="(img,index) in imgList" :key="index" :src="img" @deleteImg="delImg(index)" />
    </div>

    <div class="mainRight fr">
      <div class="viewImg">
        <!--<el-alert
          title="设备连接成功!"
          type="success"
          :closable="false"
        />-->
        <div class="viewImgArea">

          <div class="bgText">等待设备连接！</div>
          <img
            :id="imgId"
            src=""
          >
        </div>
      </div>
      <div>
        <el-select v-model="resolutionImage" placeholder="请选择" @change="setResolution">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          >
          </el-option>
        </el-select>
        <div class="fr">
          <el-button type="primary" @click="gpStart">开启设备</el-button>
          <el-button type="primary" @click="gpStop">关闭设备</el-button>
          <el-button type="primary" @click="rotateLeft">左旋转</el-button>
          <el-button type="primary" @click="rotateRight">右旋转</el-button>
          <el-button type="primary" @click="saveImg">拍照</el-button>
        </div>
      </div>
      <el-upload
        class="dragUpload"
        drag
        action=""
        :auto-upload="false"
        :on-change="getFile"
        :multiple="true"
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text" style="line-height: 26px !important; margin-bottom: 10px">
          将文件拖到此处，或<em>点击上传</em>
          <!-- <small style="color: #cdcccc">只能上传jpg/png文件，且不超过500kb</small>-->
        </div>
        <!-- <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>-->
      </el-upload>
      <el-button type="primary" class="fr">上传资料</el-button>
    </div>
  </div>

</template>

<script>
var webSocket = new WebSocket('ws://localhost:1818')
window.onbeforeunload = function () {
  webSocket.send('bStopPlay()')
  webSocket.send('bStopPlay4()')
}
webSocket.onerror = function (event) {
  onError(event)
}

webSocket.onopen = function (event) {
  onOpen(event)
}

webSocket.onclose = function (event) {
  onClose(event)
  webSocket.send('bStopPlay()')
  webSocket.send('bStopPlay4()')
}

var begin_data = 'data:image/jpeg;base64,'

function onError(event) {
}

function onClose(event) {
  webSocket.send('bStopPlay()')
  webSocket.send('bStopPlay4()')
}

function onOpen(event) {
}

import imgItem from './imgItem'

export default {
  name: 'GaoPai',
  components: {
    imgItem
  },
  props: {
    imgId: {
      type: String
    }
  },
  data() {
    return {
      activeName: '1',
      options: [
        /* 1—320*240
        2—640*480
        3—800*600
        4—1024*768
        5—1600*1200
        6—2048*1536
        7—2592*1944 */
        {
          value: '6',
          label: '2048*1536'
        },
        {
          value: '7',
          label: '2592*1944'
        },
        {
          value: '0',
          label: '设备默认'
        }
      ],
      resolutionImage: '6', // 图片分辨率
      imgList: [], // 图片列表,
      angle: 0 // 图片旋转角度
    }
  },
  computed: {},
  beforeDestroy() {
    this.gpStop()
  },
  mounted() {
    webSocket.onmessage = (event) => {
      this.onMessage(event)
    }
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event)
    },
    // 开启高拍仪
    gpStart() {
      webSocket.send(`vSetResolution(${this.resolutionImage})`)
      this.gpStop()
      webSocket.send('bStartPlay')
      webSocket.send('bSetMode(3)')
    },

    // 关闭高拍仪
    gpStop() {
      webSocket.send('bStopPlay')
    },

    // 旋转图片处理角度
    handleAngle() {
      if (this.angle >= 360) {
        this.angle -= 360
      } else if (this.angle < 0) {
        this.angle += 360
      }
      webSocket.send(`bStartPlayRotate(${this.angle})`)
      webSocket.send('bSetMode(3)')
    },

    // 左旋转
    rotateLeft() {
      this.angle += 90
      this.handleAngle()
    },
    // 右旋转
    rotateRight() {
      this.angle -= 90
      this.handleAngle()
    },
    // 拍照
    saveImg() {
      // webSocket.send(`bSaveJPG(D:\\\\,Photo-${Date.now()})`)
      webSocket.send(`bSaveJPGEx`)
    },
    // 设置分辨率
    setResolution() {
      webSocket.send(`vSetResolution(${this.resolutionImage})`)
      this.gpStop()
      this.gpStart()
    },

    // 处理上传图片
    getFile(file, fileList) {
      // console.log(file.raw)
      this.getBase64(file.raw).then(res => {
        this.imgList.unshift(res)
        // console.log(res)
      })
    },

    // 将上传图片转换成base64
    getBase64(file) {
      return new Promise(function (resolve, reject) {
        const reader = new FileReader()
        let imgResult = ''
        reader.readAsDataURL(file)
        reader.onload = function () {
          imgResult = reader.result
        }
        reader.onerror = function (error) {
          reject(error)
        }
        reader.onloadend = function () {
          resolve(imgResult)
        }
      })
    },

    // 删除图片
    delImg(index) {
      // console.log(index)
      this.imgList.splice(index, 1)
    },

    // 处理websocket onmessage 消息
    onMessage(event) {
      if (event.data.indexOf('BeginBase64') >= 0) {
        const base64 = begin_data + event.data.replace('BeginBase64', '').replace('EndBase64', '')
        this.imgList.unshift(base64)
      } else if (event.data.indexOf('BeginbSaveJPGEx') >= 0) {
        const base64 = begin_data + event.data.replace('BeginbSaveJPGEx', '').replace('EndbSaveJPGEx', '')
        this.imgList.unshift(base64)
        // alert(event.data.replace('BeginbSaveJPGEx', '').replace('EndbSaveJPGEx', ''))
      } else {
        document.getElementById(this.imgId).src = begin_data + event.data
      }
    }

  }
}
</script>

<style lang="scss">
.el-tabs__content {
  height: 680px;
}

.el-upload-list {
  position: absolute;
  padding: 5px;
  left: 0;
  top: 0;
  width: 150px;
  height: 628px;
  overflow-y: scroll;
  border: 1px solid #eee;

  img {
    width: 100%;
  }
}

.mainRight {
  width: 620px;
  height: 680px;

  .viewImg {
    border: 1px solid #eee;
    margin-bottom: 15px;

    .viewImgArea {
      height: 460px;
      overflow-y: scroll;
      position: relative;

      // 等待连接样式
      .bgText {
        text-align: center;
        position: absolute;
        letter-spacing: 5px;
        top: 50%;
        font-size: 30px;
        color: #666;
        opacity: 0.3;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 0;
      }

      img {
        width: 100%;
        z-index: 10;
        position: relative;
      }
    }
  }

  // 拖拽上传
  .dragUpload {
    margin: 15px 0;

    .el-upload-list {
      display: none;
    }

    .el-upload-dragger {
      height: 100%;
      /*border: none;*/
    }

    .el-upload--picture-card {
      border: none;
      line-height: 20px !important;
    }

    .el-upload-dragger .el-icon-upload {
      font-size: 60px;
      margin: 10px auto;
    }

    .el-upload {
      width: 100%;

      .el-upload-dragger {
        width: 100%;
      }
    }
  }
}
</style>
