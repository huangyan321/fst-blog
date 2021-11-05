import { queryAllBlogs, queryOneBlog } from '../../api/article'
import { queryBlogsBySelectTags } from '../../api/list'
import markdownCompile from '../../utils/marked'
const state = {
  blogs: [],
  pageNum: 1,
  pageSize: 5,
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
  getAllBlogs({ dispatch, commit, state, rootGetters }) {
    if (!rootGetters.selectTagsId.length) {
      return queryAllBlogs({
        pageNum: state.pageNum,
        pageSize: state.pageSize,
        type: 0
      }).then(res => {
        if (res.code === 200) {
          commit('GET_ALL_BLOGS', res)
          return new Promise((resolve, reject) => {
            resolve(res)
          })
        }
      })
    } else {
      return dispatch('getBlogsBySelectTags')
    }
  },
  getOneBlog({ commit, state }, blog_id) {
    return queryOneBlog(blog_id).then(res => {
      commit('GET_ONE_BLOGS', res.data)
      return new Promise((resolve, reject) => {
        resolve(res)
      })
    })
  },
  getBlogsBySelectTags({ dispatch, commit, state, rootGetters }) {
    if (rootGetters.selectTagsId.length) {
      return queryBlogsBySelectTags({
        pageNum: state.pageNum,
        pageSize: state.pageSize,
        tag_id: rootGetters.selectTagsId.join(','),
        type: 1
      }).then(res => {
        if (res.code === 200) {
          commit('GET_ALL_BLOGS', res)
          return new Promise((resolve, reject) => {
            resolve(res)
          })
        }
      })
    } else {
      return dispatch('getAllBlogs')
    }
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
