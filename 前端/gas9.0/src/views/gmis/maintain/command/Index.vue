<!-- 指令维护 -->
<template>
  <div class="qc-main app-container CommandMaintain-page">
    <el-card shadow="never" class="no-border">
      <template v-slot:header>
        <span class="card-title">{{ $t('maintain.command.title') }}</span>
      </template>
      <command-list></command-list>
    </el-card>
  </div>
</template>

<script>
import CommandList from './components/List.vue'

export default {
  name: 'CommandMaintain',
  components: {
    CommandList
  },
  filters: {
  },
  mixins: [],
  data () {
    return {
    }
  },
  computed: {
  },
  async created () {
  },
  mounted () {
  },
  methods: {
  }
}
</script>
<style lang="scss" scoped>
</style>

