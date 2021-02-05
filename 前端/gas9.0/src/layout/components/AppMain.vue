<template>
  <section class="app-main">
    <transition name="fade-transform" mode="out-in">
      <router-view v-if="isDevelopment" :key="key" />
      <keep-alive v-else>
        <router-view :key="key" />
      </keep-alive>
    </transition>
  </section>
</template>

<script>
import { isDevelopment } from '@/utils/env'

export default {
  name: 'AppMain',
  data() {
    return {
      isDevelopment: isDevelopment()
    }
  },
  computed: {
    key() {
      return this.$route.path
    }
  },
  created() {
  }
}
</script>

<style lang="scss" scoped>
.app-main {
  /* 50= navbar  50  */
  min-height: calc(100vh - 50px);
  width: 100%;
  position: relative;
  overflow: hidden;
  background: #f8f8f8;
  font-size: .9rem;
}

.fixed-header+.app-main {
  padding-top: 50px;
  height: 100vh;
  overflow: auto;
}

.hasTagsView {
  .app-main {
    /* 84 = navbar + tags-view = 50 + 34 */
    min-height: calc(100vh - 84px);
  }

  .fixed-header+.app-main {
    padding-top: 84px;
    overflow-x: hidden;
  }
}
</style>

<style lang="scss">
// fix css style bug in open el-dialog
.el-popup-parent--hidden {
  .fixed-header {
    padding-right: 15px;
  }
}
</style>
