import { queryAllBlogs, queryOneBlog } from '../../api/article'
import markdownCompile from '../../utils/marked'
const state = {
  blogs: [],
  pageNum: 0,
  pageSize: 0,
  currentBlog: {
    id: '',
    content: ''
  },
  currentlyCompiledBlog: ''
}
const mutations = {
  GET_ALL_BLOGS(state, blogs) {
    state.blogs = blogs
  },
  GET_ONE_BLOGS(state, blog) {
    state.currentBlog = blog
    state.currentlyCompiledBlog = markdownCompile(blog.content)
  }
}
const actions = {
  getAllBlogs({ commit, state }, listQuery) {
    return queryAllBlogs(listQuery).then(res => {
      if (res.code === 200) {
        commit('GET_ALL_BLOGS', res.data)
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
