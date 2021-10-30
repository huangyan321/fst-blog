<template>
  <div id="app">
    <div class="wrap">
      <Top></Top>
      <transition name="fade" mode="out-in">
        <router-view> </router-view>
      </transition>
    </div>
  </div>
</template>
<script>
import Top from "./components/common/Top";
export default {
  name: "app",
  components: {
    Top,
  },
};
</script>
<style>
@import "assets/iconfont/iconfont.css";
</style>
<style lang="stylus">
@import 'assets/stylus/main.styl'
@import 'assets/stylus/markdown.styl'
$footer-height = 60px
#app
  width 100%
  height 100%
.fade-enter-active, .fade-leave-active
  transition all 0.2s ease
.fade-enter, .fade-leave-active
  opacity 0
.wrap
  min-height 100%
  margin-bottom -($footer-height)
.wrap:after
  content ''
  display block
  height $footer-height
.footer
  height $footer-height
  text-align center
  color $grey
  text-align center
  line-height 20px
  a
    text-decoration none
    color $blue-link
    &:hover
      text-decoration underline
@media screen and (max-width 850px)
  .fade-enter
    transform translate(30px, 0px)
  .fade-leave-active
    transform translate(-30px, 0px)
</style>
<style lang="stylus" scoped>
#app
  #disqus_thread
    display none
</style>

</style>
