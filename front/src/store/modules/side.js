import { queryAllTags } from '../../api/tags'

const state = {
  sideBoxOpen: false,
  tags: [],
  selectTags: []
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
  //目的是初始化标签
  RESET_SELECT_TAGS(state, tags) {
    state.selectTags = tags
  },
  TRIGGER_SELECT_TAGS(state, { tag_id, name }) {
    if (typeof state.selectTags.find(e => e.tag_id === tag_id) === 'undefined') {
      state.selectTags.push({
        name,
        tag_id
      })
    } else {
      state.selectTags = state.selectTags.filter(e => e.tag_id !== tag_id)
    }
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
