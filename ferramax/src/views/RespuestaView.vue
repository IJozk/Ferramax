<template>
    <div>
      <h1>Consultas del Empleado</h1>
      <main>
        <!-- Lista de consultas asociadas a un empleado -->
        
          <p><strong>Fecha:</strong> {{ consulta.fecha_creacion }}</p>
          <p><strong>Consulta:</strong> {{ consulta.consulta }}</p>
          <p><strong>Respuesta:</strong> {{ consulta.respuesta }}</p>
          <p><strong>RUT Cliente:</strong> {{ consulta.rut_cliente }}</p>
  
          <!-- Formulario para actualizar la respuesta -->
          
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
  
  
  
  
  // Obtener consultas al montar el componente
  
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
  