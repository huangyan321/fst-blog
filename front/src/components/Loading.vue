<template>
  <div
    v-loading="loading"
    :element-loading-text="text"
    element-loading-spinner="el-icon-loading"
  ></div>
</template>

<script>
export default {
  props: {
    text: {
      type: String,
      default: () => "",
    },
  },
  data() {
    return {
      loading: true,
    };
  },
};
</script>

<style lang="stylus">
.el-icon-loading:before
  content '\e6cf'
  font-size 40px !important
</style>