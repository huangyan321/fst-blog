<template>
  <div class="sideBox">
    <div
      class="sideBox__mask"
      :class="{ 'sideBox__mask--show': sideBoxOpen }"
      @click="closeSideBox"
    ></div>
    <div class="sideBox__main" :class="{ 'sideBox__main--open': sideBoxOpen }">
      <img src="http://admin.hgyn23.cn/static/img/cat.ea0074ff.jpg" alt="" class="sideBox__img" />
      <p class="sideBox__name">昵称</p>
      <p class="sideBox__autograph">签名</p>
      <ul class="sideBox__iconList">
        <li v-for="(icon, idx) in iconList" :key="idx" class="sideBox__iconItem">
          <a :href="icon.href"><i class="iconfont" :class="'icon-' + icon.name"></i></a>
        </li>
      </ul>
      <ul class="sideBox__tagList">
        <li
          v-for="(tag, idx) in tags"
          :key="idx"
          class="sideBox__tagItem"
          :class="{ 'sideBox__tagItem--active': selectTags.find(e => tag.tag_id === e.tag_id) }"
          @click="triggerSelectTags(tag)"
        >
          <span>{{ tag.name }}</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
export default {
  data() {
    return {
      iconList: [
        {
          name: 'github',
          href: 'https://github.com/huangyan321'
        }
      ]
    }
  },
  watch: {
    sideBoxOpen: {
      handler(v) {
        console.log(v)
      }
    }
  },
  computed: {
    ...mapGetters(['sideBoxOpen', 'tags', 'selectTags'])
  },
  created() {
    this.getAllTags()
  },
  mounted() {},
  methods: {
    ...mapActions('side', {
      getAllTags: 'getAllTags'
    }),
    ...mapMutations('side', {
      closeSideBox: 'CLOSE_SIDE_BOX',
      triggerSelectTags: 'TRIGGER_SELECT_TAGS'
    })
  }
}
</script>
<style lang="stylus" scoped>
@import '../../assets/stylus/_settings.styl'
.sideBox
  width 250px
  float left
  text-align center
  &__img
    width 150px
    border-radius 50%
    box-shadow 0 0 2px black
    margin-top 10px
    cursor pointer
  &__name
    color $grey-dark
    font-size 20px
    margin 5px 0
  &__autograph
    color $grey
    margin-bottom 8px
  &__iconList
    list-style none
    margin-bottom 8px
  &__iconItem
    display inline-block
    margin-bottom 8px
    a
      text-decoration none
      color $grey
      .iconfont
        font-size 28px
        &:hover
          color black
  &__tagList
    list-style none
    margin-bottom 8px
  &__tagItem
    display inline-block
    border 1px solid $grey
    border-radius 4px
    margin 5px
    padding 10px
    color $grey
    cursor pointer
    &:hover
      color $blue
  &__tagItem--active
    color $blue
    border 1px solid $blue
  @media screen and (max-width 850px)
    .sideBox
      position absolute
      top 0
      left 0
      &__main
        position fixed
        left 0px
        top 60px
        z-index 1
        bottom 0
        width 250px
        transform translateX(-250px)
        transition transform 0.3s
        background-color white
        &--open
          box-shadow 0 0 10px rgba(0, 0, 0, 0.2)
          transform translateX(0px)
          transition transform 0.3s
      &__mask
        position fixed
        top 60px
        left 250px
        right 0
        bottom 0
        display block
        z-index 1
        display none
      &__mask--show
        display block
      &__tagItem:hover
        color $grey
      &_tagItem--active:hover
        color $blue
</style>
