// store/permission.js
import {
  asyncRouterMap,
  constantRouterMap
} from '@/router/index';

function hasPermission(type, route) {
  if (route.meta && route.meta.type) {
    return type.some(item => route.meta.type.indexOf(item) >= 0)
  } else {
    return true
  }
}

const state = {
  routers: [],
  addRouters: []
}
const mutations = {
  SET_ROUTERS: (state, routers) => {
    state.addRouters = routers;
    state.routers = constantRouterMap.concat(routers);
  }
}
const actions = {
  GenerateRoutes({
    commit
  }, data) {
    return new Promise(resolve => {
      const {
        type
      } = data;
      const accessedRouters = asyncRouterMap.filter(v => {
        // if (type.indexOf(1) >= 0) return true;
        if (hasPermission(type, v)) {
          if (v.children && v.children.length > 0) {
            v.children = v.children.filter(child => {
              if (hasPermission(type, child)) {
                return child
              }
              return false;
            });
            return v
          } else {
            return v
          }
        }
        return false;
      });
      commit('SET_ROUTERS', accessedRouters);
      resolve();
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
