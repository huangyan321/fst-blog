<template>
  <div class="list">
    <Side></Side>
    <div class="list__loading" v-if="showLoading">
      <Loading :text="loadingMsg"></Loading>
    </div>
    <ul class="list__article">
      <transition name="slide-fade">
        <li class="list__article__filter" v-if="selectTags.length !== 0">
          筛选
          <span>{{ filterMsg }}</span>
          分类
        </li>
      </transition>
      <template v-if="blogs.length !== 0 && showLoading == false">
        <li class="list__article__item" v-for="blog in blogs" :key="blog.blog_id">
          <h1 class="list__article__item__title">
            <router-link :to="'article/' + blog.blog_id">{{ blog.title }}</router-link>
          </h1>
          <div class="list__article__item__info">
            <p class="list__article__item__time">{{ blog.update_time }}</p>
            <div
              class="list__article__item__abstract markdown-body"
              v-html="compiledMarkdown(blog.brief)"
            >
              {{ blog.brief }}
            </div>
            <p>
              <router-link :to="'article/' + blog.blog_id" class="continue-reading"
                >继续阅读...</router-link
              >
            </p>
          </div>
        </li>
      </template>
      <div class="msg-box" v-if="blogs.length === 0">暂时没有相关内容</div>
    </ul>
  </div>
</template>
<script>
import Side from '../components/common/Side'
import Loading from '../components/Loading'
import { mapGetters, mapActions } from 'vuex'
import mark from '../utils/marked'
export default {
  components: {
    Side,
    Loading
  },
  data() {
    return {
      listQuery: {
        pageNum: 1,
        pageSize: 5,
        type: 0
      },
      loadingMsg: '疯狂加载中！奥里给干了！！',
      showLoading: false
    }
  },
  computed: {
    ...mapGetters(['selectTags', 'blogs']),
    filterMsg() {
      let msg = ''
      this.selectTags.forEach((item, index) => {
        msg += item.name + '、'
      })
      return msg.replace(/、$/, '')
    }
  },
  beforeMount() {
    let that = this
    this.showLoading = true
    let res = this.getAllBlogs(this.listQuery)
    setTimeout(() => {
      that.showLoading = false
    }, 200)
  },
  mounted() {},
  methods: {
    compiledMarkdown(value) {
      return mark(value)
    },
    ...mapActions('list', {
      getAllBlogs: 'getAllBlogs'
    })
  }
}
</script>
<style lang="stylus" scoped>
/* 可以设置不同的进入和离开动画 */
/* 设置持续时间和动画函数 */
.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .2s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active for below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
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
        font-size 20px
        a
          text-decoration none
          color black
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
