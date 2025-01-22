<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import HelloWorld from './components/HelloWorld.vue'

// Define una variable reactiva para almacenar los datos del clima
const weatherData = ref([])

// Obtén la URL del servidor desde la variable de entorno
const API_HOST = import.meta.env.VITE_API_HOST

// Función para obtener los datos del servidor
const fetchWeatherData = async () => {
  try {
    const response = await axios.get(`${API_HOST}/WeatherForecast`)
    weatherData.value = response.data
  } catch (error) {
    console.error('Error fetching weather data:', error)
  }
}

// Llama a la función al montar el componente
onMounted(() => {
  fetchWeatherData()
})
</script>

<template>
  <div>
    <a href="https://vite.dev" target="_blank">
      <img src="/vite.svg" class="logo" alt="Vite logo" />
    </a>
    <a href="https://vuejs.org/" target="_blank">
      <img src="./assets/vue.svg" class="logo vue" alt="Vue logo" />
    </a>
  </div>
  <HelloWorld msg="Vite + Vue" />
  
  <!-- Nueva sección para mostrar los datos del clima -->
  <div>
    <h2>Weather Forecast</h2>
    <ul>
      <li v-for="(forecast, index) in weatherData" :key="index">
        <strong>{{ forecast.date }}</strong>: 
        {{ forecast.temperatureC }}°C - {{ forecast.summary }}
      </li>
    </ul>
  </div>
</template>

<style scoped>
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
