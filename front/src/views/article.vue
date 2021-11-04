<template>
  <div class="article">
    <div class="article__loading" v-if="showLoading">
      <Loading :text="loadingMsg"></Loading>
    </div>
    <div class="article__main" v-if="!showLoading">
      <div class="article__title">{{ currentBlog.title }}</div>
      <div class="article__time">{{ currentBlog.update_time }}</div>
      <div
        class="article__content markdown-body"
        v-html="compiledMarkdown(currentBlog.content)"
      ></div>
    </div>
  </div>
</template>
<script>
import Loading from '../components/Loading'
import { mapActions, mapGetters } from 'vuex'
import mark from '../utils/marked'
export default {
  components: {
    Loading
  },
  data() {
    return {
      loadingMsg: '疯狂加载中！奥里给干了！！',
      showLoading: true
    }
  },
  watch: {},
  computed: {
    ...mapGetters(['currentBlog', 'currentlyCompiledBlog'])
  },
  beforeMount() {
    this.getArticle()
  },
  mounted() {},
  methods: {
    async getArticle() {
      let that = this
      this.isLoading = true
      let res = await this.getOneBlog(this.$route.params.id)
      that.showLoading = false
      // res.code === 200 ?
    },
    compiledMarkdown(value) {
      return mark(value)
    },
    ...mapActions('list', {
      getOneBlog: 'getOneBlog'
    })
  }
}
</script>
<style lang="stylus" scoped>
.article
  padding 10px
  max-width 1000px
  margin 0 auto
  &__loading
    position fixed
    top 50%
    left 50%
    width 300px
    height 200px
    margin-left -(@width / 2) + 125
    margin-top -(@height / 2) + 60
  &__main
      margin-left 260px
      min-height 100%
  &__title
      font-size 24px
      word-break break-all
  &__time
      color #7f8c8d
      font-weight 400
      margin-bottom 10px
@media screen and (max-width: 850px)
  .article
    position relative
    &__main
      margin-left 0
    &__loading
      position absolute
      top 200px
      left 50%
      width 300px
      margin-left -(@width/2)
</style>
