import { createApp } from 'vue'
import App from '../app.vue'
import VueToast from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-sugar.css';
import TurbolinksAdapter from 'vue-turbolinks'
import Router from '../router'

export default () => {
  document.addEventListener('turbolinks:load', () => {
    const app = createApp(App)
    app.use(TurbolinksAdapter)
    app.use(VueToast)
    app.use(Router)
    app.mount('#root')
  })
}
