const state = {
  sideBoxOpen: false,
};
const mutations = {
  TOGGLE_SIDE_BOX() {
    console.log('触发');
    state.sideBoxOpen = !state.sideBoxOpen
  }
};
const actions={
  
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}