<template>
    <div>
      <h1>Consultas del Empleado</h1>
      <main>
        <div v-for="consulta in consultas" :key="consulta.id_consulta">
          <p><strong>Fecha:</strong> {{ consulta.fecha_creacion }}</p>
          <p><strong>Consulta:</strong> {{ consulta.consulta }}</p>
          <p><strong>Respuesta:</strong> {{ consulta.respuesta }}</p>
          <p><strong>RUT Cliente:</strong> {{ consulta.rut_cliente }}</p>
  
          <form @submit.prevent="updateRespuesta(consulta.id_consulta)">
            <input v-model="consulta.respuesta" placeholder="Nueva Respuesta" required />
            <button type="submit">Actualizar Respuesta</button>
          </form>
        </div>
      </main>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted } from 'vue';
  import { useRoute } from 'vue-router';
  
  const route = useRoute();
  const consultas = ref([]);
  
  async function fetchConsultas() {
    try {
      const rut_empleado = route.params.rut_empleado;
      if (!rut_empleado) {
        throw new Error('RUT Empleado no proporcionado');
      }
      
      const response = await fetch(`/APIconsulta/consultas/empleado/${rut_empleado}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      });
  
      if (!response.ok) {
        throw new Error(`Error al obtener consultas: ${response.statusText}`);
      }
  
      const data = await response.json();
      consultas.value = data.consulta;  // Asegúrate de que el endpoint devuelve 'consulta' en singular
    } catch (error) {
      console.error('Error:', error);
      alert(error.message);
    }
  }
  
  async function updateRespuesta(id_consulta) {
  const consulta = consultas.value.find(c => c.id_consulta === id_consulta);
  try {
    const response = await fetch(`/APIconsulta/consultas/update_respuesta/${id_consulta}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ consulta: { respuesta: consulta.respuesta } }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Error al actualizar la respuesta: ${response.statusText} - ${errorText}`);
    }

    const data = await response.json();
    const index = consultas.value.findIndex(c => c.id_consulta === id_consulta);
    consultas.value[index] = { ...consultas.value[index], ...data.consulta };
  } catch (error) {
    console.error('Error:', error);
    alert(error.message);
  }
}

  
  onMounted(fetchConsultas);
  </script>
  
  <style scoped>
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
  
  main > div {
    padding: 0.5rem 1rem;
    border-bottom: 1px solid lightgray;
  }
  
  input {
    font-family: inherit;
    font-size: 100%;
    width: 100%;
    border: 0;
    margin-bottom: 1rem;
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
  