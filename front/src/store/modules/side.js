import { queryAllTags } from '../../api/tags'

const state = {
  sideBoxOpen: false,
  tags: []
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
