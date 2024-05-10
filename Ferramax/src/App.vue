<script setup lang="ts">
import { onMounted, ref } from "vue";
import { remult } from "remult";
import { Product } from "./shared/product";

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

      <div v-for="product in products">
        {{ product.prod_name }}
        <input type="numeric" v-model="product.current_price"  @change="saveProduct(product)"/>
        <button @click="saveProduct(product)">Modificar</button>
        <button @click="deleteProduct(product)">Delete</button>
      </div>
    </main>
  </div>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>
