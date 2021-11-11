import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)
// 解决重复点击路由报错的BUG
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}
const routes = [
  {
    path: '/',
    component: () => import(/* webpackChunkName: "list" */ '../views/list.vue')
  },
  {
    path: '/article/:id',
    component: () => import(/* webpackChunkName: "article" */ '../views/article.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
