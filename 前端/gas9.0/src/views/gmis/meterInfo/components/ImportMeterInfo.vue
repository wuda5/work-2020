<!--导入表具信息-->
<template>
  <div class="ImportMeterInfo-container">
    <import api="/bizcenter/archive/gasmeterarchive/gasMeter/import" :options="{}" :list-fields-map="listFieldsMap">
    </import>
  </div>
</template>

<script>
import Import from '@/components/QcImport/Index.vue'
import { meterFormFieldsMap } from '@/lang/zh/modules/meterInfo'

export default {
  name: 'ImportMeterInfo',
  components: {
    Import
  },
  data() {
    return {
      form: {
        readTime: null
      },
      listFieldsMap: {
        ...meterFormFieldsMap,
        failValue: '失败原因',
      },
    }
  },
  methods: {
  },
}
</script>
<style lang="scss" scoped>
.ReadMeterImport-container {
  ::v-deep {
    .qc-form {
      padding: 0;
    }
  }
}
</style>
