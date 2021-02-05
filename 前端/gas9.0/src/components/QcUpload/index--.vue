<!-- 上传 -->
<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="身份证" name="1">
        <gao-pai
          img-id="photo"
        />
      </el-tab-pane>
      <el-tab-pane label="合同资料" name="2">
        <!--        <gao-pai-->
        <!--          imgId="photo1"-->
        <!--        />-->
      </el-tab-pane>
      <el-tab-pane label="其他资料" name="3">角色管理</el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>

import imgItem from './imgItem'
import GaoPai from './pai'

export default {
  name: 'QcUpload',
  components: {
    imgItem,
    GaoPai
  },
  data() {
    return {
      activeName: '1'
    }
  },
  computed: {},
  beforeDestroy() {
  },
  mounted() {
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event)
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
