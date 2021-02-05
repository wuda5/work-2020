<template>
  <div
    class="empty-layout"
    :class="this.$route.name + '-layout'"
  >
    <router-view />
  </div>
</template>

<script>
export default {
  name: 'EmptyLayout'
}
</script>
