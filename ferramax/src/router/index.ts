import { createRouter, createWebHistory } from 'vue-router'
import RespuestaView from '../views/RespuestaView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [

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
      path: '/stockView',
      name: 'stockView',
      component: () => import('../views/stockView.vue')
    },
    {
      path: '/respuesta/:rut_empleado',
      name: 'respuesta',
      component: RespuestaView,
      props: true
    }
  ]
})

export default router
