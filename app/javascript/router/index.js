import { createWebHistory, createRouter } from "vue-router";
import Patient from "../components/patient.vue";
import VisitNote from "../components/visit_note.vue";

const routes = [
  {
    path: "/",
    name: "VisitNote",
    component: VisitNote,
  },
  {
    path: "/patient",
    name: "Patient",
    component: Patient,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;