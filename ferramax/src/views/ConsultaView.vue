<template>
  <div>
    <h1>Consultas</h1>
    <main>
      <!-- Formulario para agregar una nueva consulta -->
      <form @submit.prevent="addConsulta">
        <input v-model="newConsulta.fecha_creacion" type="date" placeholder="Fecha de creación" required />
        <input v-model="newConsulta.consulta" placeholder="Consulta" required />
        <input v-model="newConsulta.respuesta" placeholder="Respuesta" />
        <input v-model="newConsulta.rut_cliente" placeholder="RUT Cliente" required />        <button type="submit">Añadir</button>
      </form>

      <!-- Lista de consultas -->
      <div v-for="consulta in consultas" :key="consulta.id_consulta">
        <p><strong>Fecha:</strong> {{ consulta.fecha_creacion }}</p>
        <p><strong>Consulta:</strong> {{ consulta.consulta }}</p>
        <p><strong>Respuesta:</strong> {{ consulta.respuesta }}</p>
        <p><strong>RUT Cliente:</strong> {{ consulta.rut_cliente }}</p>
        <p><strong>RUT Empleado:</strong> {{ consulta.rut_empleado }}</p>

        <!-- Enlace para ver las consultas del empleado -->
        <router-link :to="{ name: 'respuesta', params: { rut_empleado: consulta.rut_empleado } }">Ver Consultas del Empleado</router-link>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

// Datos de la nueva consulta
const newConsulta = ref({
  fecha_creacion: '',
  consulta: '',
  respuesta: '',
  rut_cliente: '',
  rut_empleado: ''
});

// Lista de consultas
const consultas = ref([]);

// Función para obtener todas las consultas
async function fetchConsultas() {
  try {
    const response = await fetch('/APIconsulta/consultas', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`Error al obtener consultas: ${response.statusText}`);
    }

    const data = await response.json();
    consultas.value = data.consultas;
  } catch (error) {
    console.error('Error:', error);
    alert(error.message);
  }
}

// Función para añadir una consulta
async function addConsulta() {
  try {
    const response = await fetch('/APIconsulta/consultas/nueva_consulta/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(newConsulta.value)
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Error al crear la consulta: ${response.statusText} - ${errorText}`);
    }

    const data = await response.json();
    consultas.value.push(data.consulta);

    // Limpiar formulario
    newConsulta.value = {
      fecha_creacion: '',
      consulta: '',
      respuesta: '',
      rut_cliente: '',
      rut_empleado: ''
    };
  } catch (error) {
    console.error('Error:', error);
    alert(error.message);
  }
}

// Obtener consultas al montar el componente
onMounted(fetchConsultas);
</script>

  <style scoped>
  @charset "utf-8";
  
  body {
    font-family: Arial;
    background-color: rgb(46, 46, 46);
    justify-content: center;
    margin: 0;
  }
  
  h1 {
    color: #ef4444;
    font-style: italic;
    font-size: 3.75rem;
    font-weight: inherit;
    text-align: center;
  }
  
  main {
    max-width: 500px;
    min-width: 300px;
    margin: auto;
    background-color: rgb(41, 41, 41);
    box-sizing: border-box;
    border: 1px solid rgb(48, 47, 47);
    border-radius: 0.5rem;
    box-shadow: 0 2px 4px #0003, 0 25px 50px #0000001a;
  }
  
  main > form {
    padding: 0.5rem 1rem;
    border-bottom: 1px solid lightgray;
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }
  
  main > div {
    padding: 0.5rem 1rem;
    border-bottom: 1px solid lightgray;
  }
  
  input {
    font-family: inherit;
    font-size: 100%;
    width: 100%;
    border: 0;
  }
  
  input:placeholder-shown {
    font-style: italic;
  }
  
  button {
    cursor: pointer;
    padding: 0.5rem 0.5rem;
    background-color: white;
    font-family: inherit;
    font-size: 85%;
    line-height: inherit;
    border: 2px solid #0000001a;
    border-radius: 0.5rem;
    white-space: nowrap;
  }
  </style>
  