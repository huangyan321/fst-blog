<template>
  <div class="list">
    你好这是我的blog
    <Side></Side>
  </div>
</template>
<script>
import Side from "../components/common/Side.vue";
export default {
  components: {
    Side,
  },
  data() {
    return {};
  },
  mounted() {},
  methods: {},
};
</script>
<style lang="stylus" scoped>
.list {
  padding: 10px;
  max-width: 1000px;
  margin: 0 auto;
  padding-top: 85px;
}
</style>