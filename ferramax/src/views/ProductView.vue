<script setup lang="ts">
import { onMounted, ref } from "vue";
import { remult } from "remult";
import { Product } from "../shared/product";

const productsRepo = remult.repo(Product);
const products = ref<Product[]>([]);
onMounted(() => productsRepo.find().then(items => (products.value = items)));

const newProductName = ref("")
const newProductPrice = ref()
async function addProduct() {
  try {
    const newProduct = await productsRepo.insert({ nombre_producto: newProductName.value , precio_actual: newProductPrice.value })
    products.value.push(newProduct)
    newProductName.value = ""
    newProductPrice.value = null
  } catch (error: any) {
    alert((error as { message: string }).message)
  }
}

async function saveProduct(product: Product) {
  try {
    await productsRepo.save(product)
  } catch (error: any) {
    alert((error as { message: string }).message)
  }
}

async function deleteProduct(product: Product) {
  try {
    await productsRepo.delete(product)
    products.value = products.value.filter(p => product !== p)
  } catch (error: any) {
    alert((error as { message: string }).message)
  }
}

</script>

<template>
  <div>
    <h1>Ferramax</h1>
    <main>
      <form @submit.prevent="addProduct()">
        <input v-model="newProductName" placeholder="Añade un nuevo producto." />
        <input v-model="newProductPrice" placeholder="Ingresa el precio del producto." />
        <button>Add</button>
      </form>

      <div v-for="product in products">
        {{ product.nombre_producto }}
        <input type="numeric" v-model="product.precio_actual" @change="saveProduct(product)"/>
        <button @click="saveProduct(product)">Modificar</button>
        <button @click="deleteProduct(product)">Delete</button>
      </div>
    </main>
  </div>
</template>

<style scoped>
@charset "utf-8";

body {
  font-family: Arial;
  background-color: whitesmoke;
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
  background-color: white;
  box-sizing: border-box;
  border: 1px solid lightgray;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px #0003, 0 25px 50px #0000001a;
}

main > div,
main > form {
  padding: 0.5rem 1rem;
  border-bottom: 1px solid lightgray;
  display: flex;
  align-items: center;
  gap: 0.25rem;
  justify-content: space-between;
}

main > div:has(input[type="checkbox"]) {
  justify-content: inherit;
}

input {
  font-family: inherit;
  font-size: 100%;
  width: 100%;
  border: 0;
}

input:checked + input {
  text-decoration: line-through;
}

input:placeholder-shown {
  font-style: italic;
}

input[type="checkbox"] {
  width: 36px;
  height: 36px;
  height: 1.5rem;
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

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 500px;
  min-width: 300px;
  margin: auto;
}
</style>