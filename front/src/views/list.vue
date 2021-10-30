<template>
  <div class="list">
    <Side></Side>
    <div class="list__loading" v-if="showLoading">
      <Loading :text="loadingMsg"></Loading>
    </div>
  </div>
</template>
<script>
import Side from "../components/common/Side.vue";
import Loading from "../components/Loading.vue";
export default {
  components: {
    Side,
    Loading,
  },
  data() {
    return {
      loadingMsg: "疯狂加载中！奥里给干了！！",
      showLoading: true,
    };
  },
  mounted() {},
  methods: {},
};
</script>
<style lang="stylus" scoped>
.list
  padding 10px
  max-width 1000px
  margin 0 auto
  padding-top 85px
  &__loading
    position fixed
    top 50%
    left 50%
    width 300px
    height 200px
    margin-left -(@width / 2) + 125
    margin-top -(@height / 2) + 60
@media screen and (max-width 850px)
  .list
    position relative
    padding-top 85px
    &__loading
      position absolute
      top 250px
      left 50%
      z-index 0
      width 300px
      margin-left -(@width / 2)
</style>