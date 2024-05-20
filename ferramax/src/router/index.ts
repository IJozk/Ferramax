import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import SucursalCrud from '../views/SucursalCrud.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/productos',
      name: 'productos',
      component: () => import('../views/ProductView.vue')
    },
    {
      path: '/consultaView',
      name: 'consultaView',
      component: () => import('../views/ConsultaView.vue')
    },
    {
      path: '/sucursalCrud',
      name: 'SucursalCrud',
      component: SucursalCrud
  },
  ]
})

export default router
