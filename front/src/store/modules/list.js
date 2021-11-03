import { queryAllBlogs, queryOneBlog } from '../../api/article'
import markdownCompile from '../../utils/marked'
const state = {
  blogs: [],
  pageNum: 1,
  pageSize: 4,
  type: 0,
  total: 0,
  currentBlog: {
    id: '',
    content: ''
  },
  currentlyCompiledBlog: ''
}
const mutations = {
  GET_ALL_BLOGS(state, res) {
    state.blogs = res.data
    state.total = res.total
  },
  GET_ONE_BLOGS(state, blog) {
    state.currentBlog = blog
    state.currentlyCompiledBlog = markdownCompile(blog.content)
  },
  TRIGGER_PAGE(state, page) {
    page.pageNum ? (state.pageNum = page.pageNum) : ''
    page.pageSize ? (state.pageSize = page.pageSize) : ''
  }
}
const actions = {
  getAllBlogs({ commit, state }) {
    return queryAllBlogs({
      pageNum: state.pageNum,
      pageSize: state.pageSize,
      type: state.type
    }).then(res => {
      if (res.code === 200) {
        commit('GET_ALL_BLOGS', res)
        return new Promise((resolve, reject) => {
          resolve(res)
        })
      }
    })
  },
  getOneBlog({ commit, state }, blog_id) {
    return queryOneBlog(blog_id).then(res => {
      commit('GET_ONE_BLOGS', res.data)
      return new Promise((resolve, reject) => {
        resolve(res)
      })
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
