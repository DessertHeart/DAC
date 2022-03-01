import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const index = () => import('@/views/index/Index.vue')
const dao = () => import('@/views/dao/Dao.vue')

const routes = [
  {
    path:'/index',
    component:index
  },
  {
    path:'/dao',
    component:dao
  },
  {
    path:'/',
    redirect:'/index'
  }
]

const originalPush = VueRouter.prototype.push
   VueRouter.prototype.push = function push(location) {
   return originalPush.call(this, location).catch(err => err)
}

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
