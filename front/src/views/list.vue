<template>
  <div class="list">
    <Side></Side>
    <div class="list__loading" v-if="showLoading">
      <Loading :text="loadingMsg"></Loading>
    </div>
    <ul class="list__article">
      <li class="list__article__filter">
        筛选
        <span>vue</span>
        分类
      </li>
      <template>
        <li class="list__article__item" v-for="item in 3">
          <h1 class="list__article__item__title">标题</h1>
          <div class="list__article__item__info">
            <p class="list__article__item__time">时间</p>
            <div class="list__article__item__abstract markdown-body">内容</div>
            <p>
              <router-link to="" class="continue-reading">继续阅读...</router-link>
            </p>
          </div>
        </li>
      </template>
      <div class="msg-box">暂时没有相关内容</div>
    </ul>
  </div>
</template>
<script>
import Side from '../components/common/Side'
import Loading from '../components/Loading'
export default {
  components: {
    Side,
    Loading
  },
  data() {
    return {
      loadingMsg: '疯狂加载中！奥里给干了！！',
      showLoading: false
    }
  },
  mounted() {},
  methods: {}
}
</script>
<style lang="stylus" scoped>
.list
  padding 10px
  max-width 1000px
  margin 0 auto
  padding-top 85px
  .continue-reading {
    text-decoration none
    color #0366d6
  }
  &__article
    list-style none
    margin-left 260px
    &__item
      margin 0 auto
      padding 0 10px 10px 10px
      margin-bottom 15px
      &__abstract
        margin-bottom 5px
      &__title
        font-size 24px
      &__time
        color #7f8c8d
        font-weight 400
        margin-bottom 10px
        margin-top 2px
    &__filter
      font-size 20px
      text-align center
      margin-bottom 20px
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
    &__article
      list-style none
      margin-left 0
      &__item
        margin 0 auto
        padding 0 10px 10px 10px
        margin-bottom 15px
      &__abstract
        margin-bottom 5px
      &__title
        font-size 24px
      &__time
        color #7f8c8d
        font-weight 400
        margin-bottom 10px
        margin-top 2px
    &__filter
      font-size 20px
      text-align center
      margin-bottom 20px
    &__loading
      position absolute
      top 250px
      left 50%
      z-index 0
      width 300px
      margin-left -(@width / 2)
</style>
