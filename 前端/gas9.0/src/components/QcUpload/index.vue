<!-- 上传 -->
<template>
  <div>
    <div v-if="meterNumber && customerCode && gasMeterCode " class="uploadBox">
      <el-button :type="activeName === 'ID' ? 'primary' : null" @click="activeName = 'ID'">身份证</el-button>
      <el-button :type="activeName === 'contract' ? 'primary' : null" @click="activeName = 'contract'">合同资料</el-button>
      <el-button :type="activeName === 'other' ? 'primary' : null" @click="activeName = 'other'">其他资料</el-button>
      <el-divider></el-divider>

      <div class="el-upload-list">
        <img-item
          v-for="(img, index) in categoryImages"
          :key="index"
          :src="img.url"
          @deleteImg="delImg(img,index)"
          @viewImg="viewImg(img,index)"
        />
      </div>

      <div class="mainRight">
        <div class="viewImg">
          <div class="viewImgArea">
            <div class="bgText">等待设备连接！</div>
            <img id="photo" ref="photo" src="" alt=""/>
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
            <el-button type="primary" :disabled="!isClosed" @click="gpStart">开启设备</el-button>
            <el-button type="primary" :disabled="isClosed" @click="gpStop">关闭设备</el-button>
            <el-button type="primary" :disabled="isClosed" @click="rotateLeft">左旋转</el-button>
            <el-button type="primary" :disabled="isClosed" @click="rotateRight">右旋转</el-button>
            <el-button type="primary" :disabled="isClosed" @click="saveImg">拍照</el-button>
          </div>
        </div>
        <el-upload
          class="dragUpload"
          drag
          action=""
          :auto-upload="false"
          :on-change="getFile"
          :multiple="true"
          accept="image/jpeg,image/png"
        >
          <i class="el-icon-upload"></i>
          <div class="el-upload__text" style="line-height: 26px !important; margin-bottom: 10px">
            将文件拖到此处，或<em>点击上传</em>
            <!-- <small style="color: #cdcccc">只能上传jpg/png文件，且不超过500kb</small>-->
          </div>
          <!-- <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>-->
        </el-upload>
        <el-button type="primary" class="fr" @click="submitImg()">提交资料</el-button>
      </div>
    </div>
    <NoSelect v-else tips="资料信息不全"></NoSelect>
  </div>
</template>

<script>

import fileApi from '@/api/Attachment';

let webSocket
import imgItem from './imgItem'
import NoSelect from '@/components/QcNoSelect/index.vue'

export default {
  name: 'QcUpload',
  components: {
    imgItem,
    NoSelect
  },
  props: {
    meterNumber: String,
    customerCode: String,
    gasMeterCode: String
  },
  data() {
    return {
      webSocket,
      isClosed: true,
      wsUrl: 'ws://localhost:1818', // 高拍仪 websocket地址
      begin_data: 'data:image/jpeg;base64,', // base64前缀
      activeName: 'ID',
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
          label: '2048*1536',
        },
        {
          value: '7',
          label: '2592*1944',
        },
        {
          value: '0',
          label: '设备默认',
        },
      ],
      resolutionImage: '6', // 图片分辨率
      angle: 0, // 图片旋转角度
      /*
      * ID: 身份证
        contract:合同
        other:其他资料
        * */
      imgList: []

    }
  },
  computed: {
    // 当前分类下的图片
    categoryImages() {
      return this.imgList.filter((item) => {
        return item.type === this.activeName
      })
    }
  },
  created() {

    webSocket = new WebSocket(this.wsUrl)
    webSocket.onerror = event => {
      this.onError(event)
    }
    webSocket.onopen = event => {
      this.onOpen(event)
    }
    webSocket.onclose = event => {
      this.onClose(event)
    }
    webSocket.onmessage = event => {
      this.onMessage(event)
    }

    this.getMeterImg()
  },
  beforeDestroy() {
    this.gpStop()
    // 如果是开启才关闭
    if (webSocket.readyState === 1) {
      webSocket.close()
    }
  },
  methods: {
    // 高拍仪处理函数
    onError(event) {
      this.isClosed = true
    },
    onClose() {
      webSocket.send('bStopPlay()')
      console.log('WS已关闭!')
    },
    onOpen() {
      console.log('WS已连接!')
    },

    handleClick(tab, event) {
      console.log(tab, event)
    },

    // 开启高拍仪
    gpStart() {
      webSocket.send(`vSetResolution(${this.resolutionImage})`)
      this.gpStop()
      webSocket.send('bStartPlay')
      webSocket.send('bSetMode(3)')
      this.isClosed = false
    },

    // 关闭高拍仪
    gpStop() {
      webSocket.send('bStopPlay')
      this.isClosed = true
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

    // 处理本地上传图片
    getFile(file, fileList) {
      // console.log(file.raw)
      this.getBase64(file.raw).then(res => {
        let img = this.createImg(res)
        this.imgList.unshift(img)
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
    delImg(img, index) {
      // console.log(index)
      let params = [img.id]
      fileApi.deleteMaterial(params).then(res=>{
        const {isSuccess} = res.data
        if(isSuccess){
          this.msg('删除成功')
          this.imgList.splice(index, 1)
        }
      })
    },

    viewImg(img, index) {
      console.log(img, index)
    },

    // 处理websocket onmessage 消息
    onMessage(event) {
      if (event.data.indexOf('BeginBase64') >= 0) {
        const base64 =
          this.begin_data + event.data.replace('BeginBase64', '').replace('EndBase64', '')
        const img = this.createImg(base64)
        this.imgList.unshift(img)
      } else if (event.data.indexOf('BeginbSaveJPGEx') >= 0) {
        const base64 =
          this.begin_data + event.data.replace('BeginbSaveJPGEx', '').replace('EndbSaveJPGEx', '')
        const img = this.createImg(base64)
        this.imgList.unshift(img)
        // alert(event.data.replace('BeginbSaveJPGEx', '').replace('EndbSaveJPGEx', ''))
      } else {
        document.getElementById('photo').src = this.begin_data + event.data
      }
    },

    // 生成图片对象
    createImg(base64) {
      return {
        id: '',
        url: base64,
        type: this.activeName
      }
    },

    // 获取当前表具图片
    getMeterImg() {
      let params = {
        customerCode: this.customerCode,
        meterNumber: this.meterNumber,
        gasMeterCode: this.gasMeterCode,
      }
      fileApi.queryMaterial(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          console.log(data)
          this.imgList = data;
        }
      })
    },

    // 上传图片
    submitImg() {
      this.gpStop()
      let params = {
        customerCode: this.customerCode,
        meterNumber: this.meterNumber,
        gasMeterCode: this.gasMeterCode,
        imgList: this.imgList
      }
      fileApi.uploadMaterial(params).then(res => {
        const {isSuccess, data} = res.data
        if (isSuccess) {
          this.msg('保存成功')
          this.imgList = data
        }

      })
    },
  },
}
</script>

<style lang="scss">
.uploadBox {
  height: 715px;
  position: relative;
  overflow: hidden;

  .el-divider {
    margin: 5px 0;
  }

  // left imgList
  .el-upload-list {
    padding: 5px;
    float: left;
    width: 140px;
    height: 658px;
    overflow-y: scroll;
    border: 1px solid #eee;

    img {
      width: 100%;
    }
  }

  // right
  .mainRight {
    width: 620px;
    height: 680px;
    float: right;

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
}
</style>
