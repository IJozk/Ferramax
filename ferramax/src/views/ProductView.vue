<template>
  <div>
    <h1>Ferramax</h1>
    <main>

      <!-- Formulario para agregar un nuevo producto -->
      <form @submit.prevent="addProduct">
        <input v-model="newProduct.nombre_producto" placeholder="Nombre del producto" required />
        <input v-model="newProduct.precio_actual" type="number" placeholder="Precio" required />
        <input v-model="newProduct.descripcion_producto" placeholder="Descripción" required />
        <input v-model="newProduct.id_categoria" type="number" placeholder="ID Categoría" required />
        <input v-model="newProduct.marca" placeholder="Marca" required />
        <button type="submit">Añadir</button>
      </form>

      <!-- Componente ProductoLista -->
      <div>
        <ProductoLista/>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import ProductoLista from './ProductoLista.vue';

// Datos del nuevo producto
const newProduct = ref({
  nombre_producto: "",
  precio_actual: 0,
  descripcion_producto: "",
  id_categoria: 0,
  marca: ""
});

// Función para añadir un producto
async function addProduct() {
  try {
    const response = await fetch('/apiProducto/productos/new_product/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ producto: newProduct.value })
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Error al crear el producto: ${response.statusText} - ${errorText}`);
    }

    const data = await response.json();

    // Limpiar formulario
    newProduct.value = {
      nombre_producto: "",
      precio_actual: 0,
      descripcion_producto: "",
      id_categoria: 0,
      marca: ""
    };
  } catch (error) {
    console.error('Error:', error);
    alert(error.message);
  }
}

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
