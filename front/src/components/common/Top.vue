<template>
  <div>
    <header class="top-header">
      <img
        src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAACYktHRAD/h4/MvwAAAAlwSFlzAAALEwAACxMBAJqcGAAAADlJREFUWMPt08ERACAIBDEomvqxBh18EQogn9us+HsJAAAAt0BPfQU8A2YKULKSdQAQmpIBAMBm4AAtdCIhmRB8RAAAAABJRU5ErkJggg=="
        alt=""
        class="top-header__menu-button"
        @click="toggleSidebox"
      />
      <router-link to="/" class="top-header__main-icon">lan bi tou</router-link>
      <ul class="top-header__menu">
        <li class="top-header__menu__item"><a href="">归档</a></li>
        <li class="top-header__menu__item"><a href="">分类</a></li>
        <li class="top-header__menu__item"><a href="">关于</a></li>
      </ul>
    </header>
  </div>
</template>
<script>
import { mapMutations } from 'vuex'
export default {
  data() {
    return {}
  },
  computed: {},
  mounted() {},
  methods: {
    //将模块的空间名称字符串作为第一个参数传递
    ...mapMutations('side', {
      toggleSidebox: 'TOGGLE_SIDE_BOX'
    })
  }
}
</script>
<style lang="stylus" scoped>
@import '../../assets/stylus/_settings.styl';

.top-header
  position: fixed;
  top: 0;
  height: 60px;
  line-height: @height;
  width: 100%;
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.25);
  padding: 0 40px;
  background: white;
  z-index: 3;

  &__main-icon
    text-decoration: none;
    color $grey-dark;
    font-weight: 600;
    font-size: 20px;


  &__menu-button
    position: absolute;
    left: 10px;
    top: 50%;
    width: 32px;
    height: 32px;
    margin-top: -(@height / 2);
    display: none;

  &__menu
    float right
    list-style none
    margin-right: 30px
    &__item
      display: inline-block
      line-height: 0
      a
        text-decoration: none
        color: #808080
        padding: 20px
        &:hover
          color: black


// 屏幕宽度小于850px时 字体居中
@media screen and (max-width: 850px)
  .top-header
    text-align: center;
    padding: 0;
    &__menu
      display: none
    &__menu-button
      display: block;
</style>
