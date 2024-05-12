
<script setup lang="ts">
  import { onMounted, onUnmounted, ref } from "vue";
  import { remult } from "remult";
  import { Product } from "./shared/Product";
  import { ProductsController } from "./shared/ProductsController";

const productsRepo = remult.repo(Product);
const products = ref<Product[]>([]);
onMounted(() => productsRepo.find().then(items => (products.value = items)));

const newProductName = ref("")
const newProductPrice = ref()
async function addProduct() {
  try {
    const newProduct = await productsRepo.insert({ prod_name: newProductName.value , current_price: newProductPrice.value })
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

      <div v-for="product in products" v-bind:key="product.id">
        {{ product.prod_name }}
        <input type="numeric" v-model="product.current_price"  @change="saveProduct(product)"/>
        <button @click="saveProduct(product)">Modificar</button>
        <button @click="deleteProduct(product)">Delete</button>
      </div>
    </main>
  </div>
</template>
