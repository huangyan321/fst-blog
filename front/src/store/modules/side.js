import { queryAllTags } from '../../api/tags'

const state = {
  sideBoxOpen: false,
  tags: [],
  selectTags: [],
  selectTagsId: [],
  isInList: true,
  articleDir: []
}
const mutations = {
  TOGGLE_SIDE_BOX(state) {
    console.log('触发')
    state.sideBoxOpen = !state.sideBoxOpen
  },
  CLOSE_SIDE_BOX(state) {
    state.sideBoxOpen = false
  },
  GET_ALL_TAGS(state, tags) {
    state.tags = tags
  },
  TRIGGER_IS_IN_LIST(state, status) {
    state.isInList = status
  },
  //目的是初始化标签
  RESET_SELECT_TAGS(state, tags) {
    state.selectTags = tags
  },
  TRIGGER_SELECT_TAGS(state, { tag_id, name }) {
    if (typeof state.selectTags.find(e => e.tag_id === tag_id) === 'undefined') {
      state.selectTags.push({
        name,
        tag_id
      }),
        state.selectTagsId.push(tag_id)
    } else {
      state.selectTags = state.selectTags.filter(e => e.tag_id !== tag_id)
      state.selectTagsId = state.selectTagsId.filter(e => e !== tag_id)
    }
  },
  TRIGGER_DIR(state, dir) {
    state.articleDir = dir
  }
}
const actions = {
  getAllTags({ commit, state }) {
    return queryAllTags().then(res => {
      if (res.code === 200) {
        commit('GET_ALL_TAGS', res.data)
        return new Promise((resolve, reject) => {
          resolve(res)
        })
      }
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
