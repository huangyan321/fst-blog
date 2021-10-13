import Vue from 'vue'
import 'normalize.css/normalize.css' // A modern alternative to CSS resets
// import locale from 'element-ui/lib/locale/lang/en' // lang i18n
import '@/styles/index.scss' // global css
import './elementUI'
import 'lib-flexible'
import App from './App'
import lodash from 'lodash'
import store from './store'
import router from './router'
import '@/icons' // icon
import '@/permission' // permission control
import request from '@/utils/request'
import 'default-passive-events'
import {
  getToken
} from '@/utils/auth' // get token from cookie

Vue.prototype.$http = request
// 在页面刷新时将store中的数据保存到sessionStorage中
window.addEventListener("beforeunload", () => {
  const userInfo = {
    ...store.state.user
  }
  window.sessionStorage.setItem("USER_INFO", JSON.stringify(userInfo));
})
Vue.prototype.$_ = lodash
// 在页面刷新后获取sessionStorage中的token
const userInfo = window.sessionStorage.getItem("USER_INFO");
if (userInfo) {
  const user = JSON.parse(userInfo);
  store.commit('user/SET_TOKEN', user.token);
  store.commit('user/SET_NAME', user.name);
}
Vue.config.productionTip = false;
//混入提供upload组件token校验
Vue.mixin({
  methods: {
    getHeaders() {
      return {
        Authorization: getToken()
      }
    }
  }
})
new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
