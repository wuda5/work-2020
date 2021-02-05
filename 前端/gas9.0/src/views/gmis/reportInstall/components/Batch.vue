<!--
 * @Description: 批量报装
 * @Author: lingw
 * @Date: 2020-11-09 14:20:48
 * @LastEditors: lingw
 * @LastEditTime: 2020-11-17 10:05:28
-->
<template>
  <el-form label-position="top" class="jh-text">
    <el-form-item label="报装类型" prop="installTypeName">
        <el-select v-model="form.installTypeName">
          <el-option v-for="({ value, label, id }) in reportTypes" :key="id" :value="value" :label="label">
          </el-option>
        </el-select>
      </el-form-item>
    <el-form-item label="街道" prop="street">
        <el-select v-model="form.street" value-key="streetId" @change="handleStreet">
          <el-option v-for="street in streetList" :key="street.streetId" :value="street" :label="street.streetName">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item ref="community" label="小区" prop="community">
        <el-select v-model="form.community" value-key="communityId" @change="handleCommunity">
          <el-option v-for="community in communityList" :key="community.communityId" :value="community" :label="community.communityName">
          </el-option>
        </el-select>
      </el-form-item>
    <el-form-item label="栋">
      <el-input v-model.number="form.build"></el-input>
    </el-form-item>
    <el-form-item label="单元">
      <el-input v-model.number="form.unit"></el-input>
    </el-form-item>
    <el-form-item label="楼层">
      <el-input v-model.number="form.floor"></el-input>
    </el-form-item>
    <el-form-item label="每层户数">
      <el-input v-model.number="form.count"></el-input>
    </el-form-item>
    <el-form-item></el-form-item>
    <el-form-item>
      <el-button type="primary" style="margin-top: 28px" @click="handleBatch">
        批量受理
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script>
export default {
  name: 'BatchReport',
  props: {
    reportTypes: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    streetList: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
    communityList: {
      required: true,
      type: Array,
      default: () => {
        return []
      }
    },
  },
  data () {
    return {
      form: {
        installTypeName: '',
        street: '',
        community: '',
        build: '',
        unit: '',
        floor: '',
        count: ''
      }
    }
  },
  mounted () {

  },
  methods: {
    // 批量受理 
    handleBatch() {

    },
    // 街道选中
    handleStreet(street) {
      this.$refs['community'].resetField()
      this.$emit('fetchCommunity', street.streetId)
    },
  }
}
</script>

<style lang='scss' scoped>
  .jh-text {
    .el-form-item {
      width: calc(100% / 3)
    }
  }
</style>
