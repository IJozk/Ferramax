import './assets/main.css'
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import Auth from "./Auth.vue"

const app = createApp(Auth)

app.use(router)

app.mount("#app")
