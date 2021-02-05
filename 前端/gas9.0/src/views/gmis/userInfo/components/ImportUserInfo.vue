<!--导入客户档案信息-->
<template>
  <div class="ImportMeterInfo-container">
    <import api="/bizcenter/archive/userarchive/customer/import" :options="{}" :list-fields-map="listFieldsMap">
    </import>
  </div>
</template>

<script>
import Import from '@/components/QcImport/Index.vue'
import { baseCustomerFormFieldsMap } from '@/lang/zh/modules/customerInfo'

export default {
  name: 'ImportMeterInfo',
  components: {
    Import
  },
  data() {
    return {
      listFieldsMap: {
        ...baseCustomerFormFieldsMap,
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
