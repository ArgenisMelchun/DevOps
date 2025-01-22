import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";

console.log("API Host:", import.meta.env.VITE_API_HOST);

createApp(App).mount("#app");
