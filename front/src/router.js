import { createRouter, createWebHistory } from "vue-router";
import Home from "./components/Home.vue";
import Admin from "./components/Admin.vue";
import Voter from "./components/Voter.vue";
import Result from "./components/Result.vue";

const routes = [
    { path: '/', component: Home },
    { path: '/admin', component: Admin },
    { path: '/voter', component: Voter },
    { path: '/result', component: Result },
]

export default createRouter({
  history: createWebHistory(),
  routes
})