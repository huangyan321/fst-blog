<template>
  <div class="sideBox">
    <div
      class="sideBox__mask"
      :class="{ 'sideBox__mask--show': sideBoxOpen }"
      @click="closeSideBox"
    ></div>
    <div class="sideBox__main" :class="{ 'sideBox__main--open': sideBoxOpen }">
      <img
        src="https://portrait.gitee.com/uploads/avatars/user/2723/8171994_wping_w_1614679129.png!avatar200"
        alt=""
        class="sideBox__img"
        @click="picClick"
      />
      <p class="sideBox__name">huangyan123</p>
      <p class="sideBox__autograph">此处插入签名</p>
      <ul class="sideBox__iconList">
        <li v-for="(icon, idx) in iconList" :key="idx" class="sideBox__iconItem">
          <a :href="icon.href"><i class="iconfont" :class="'icon-' + icon.name"></i></a>
        </li>
      </ul>
      <ul class="sideBox__tagList" v-if="isInList">
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
      <div v-else-if="!isInList" class="dirBox" :class="{ 'dirBox--fix': false }">
        <p class="dir__title">
          目录
        </p>
        <ul>
          <li v-for="item in articleDir" :key="item.text" :class="'dirBox__' + item.tagName">
            <a :href="item.href">{{ item.text }}</a>
          </li>
        </ul>
      </div>
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
    },
    $route: {
      handler(v) {
        v.params.id ? this.triggerIsInList(false) : this.triggerIsInList(true)
      }
    }
  },
  computed: {
    ...mapGetters(['sideBoxOpen', 'tags', 'selectTags', 'isInList', 'articleDir'])
  },
  created() {
    if (typeof window === 'undefined') {
      return
    }
    if (this.isInList) {
      this.getAllTags()
    } else {
    }
  },
  mounted() {},
  methods: {
    ...mapActions('side', {
      getAllTags: 'getAllTags'
    }),
    ...mapMutations('side', {
      closeSideBox: 'CLOSE_SIDE_BOX',
      triggerSelectTags: 'TRIGGER_SELECT_TAGS',
      triggerIsInList: 'TRIGGER_IS_IN_LIST'
    }),
    picClick() {
      this.closeSideBox()
      this.$router.push('/')
    }
  }
}
</script>
<style lang="stylus" scoped>
@import '../../assets/stylus/_settings.styl'
.sideBox
  width 250px
  float left
  text-align center
  user-select: none
  &__img
    width 150px
    height 150px
    object-fit contain
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
      color black
  &__tagItem--active
    color black
    border 1px solid black
  .dirBox
    padding-left 10px
    padding-right 15px
    will-change transform
    &--fix
      position fixed
      top 350px
      bottom 0
      overflow-y auto
      width 250px
    &__title
      margin-top 15px
      margin-bottom 10px
      font-weight 400
      color #808080
      font-size 18px
    ul
      list-style none
    li
      text-align left
      //list-style-type: square;
      margin-bottom 5px
      padding-left 20px
      word-wrap break-word
      word-break all
      a
        color $grey
        text-decoration none
        margin-left -18px
        word-wrap break-word
        word-break break-all
        &:hover
          color #000000
          text-decoration underline
    &__h1
      margin-left 0
    &__h2
      margin-left 20px
    &__h3
      margin-left 40px
    &__h4
      margin-left 60px
    &__h5
      margin-left 80px
    &__h6
      margin-left 100px
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
      &__tagItem--active:hover
        color $blue
</style>
