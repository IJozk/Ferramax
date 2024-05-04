
<script setup lang="ts">
  import { onMounted, ref } from "vue";
  import { remult } from "remult";
  import { Product } from "./shared/Product";

  const productRepo = remult.repo(Product);
  const products = ref<Product[]>([]);
  onMounted(() => productRepo.find().then((items) => (products.value = items)));

  const newProductName = ref("")
  const newProductPrice = ref()
  async function addProduct() {
    try {
      const newTask = await productRepo.insert({prod_name: newProductName.value, current_price: newProductPrice.value })
      products.value.push(newTask)
      newProductName.value = ""
    } catch (error: any) {
      alert((error as { message: string }).message)
    }
  }

  async function saveProduct(product: Product) {
  try {
    await productRepo.save(product)
  } catch (error: any) {
    alert((error as { message: string }).message)
  }
}
  
</script>

<template>
  <div>
    <h1>Ferramax</h1>
    <main>
      <!-- Ingresar producto -->
      <form @submit.prevent="addProduct()">
        <input v-model="newProductName" placeholder="Qué titulo deseas insertar?" />
        <input type="numeric" v-model="newProductPrice" placeholder="Valor" />
        <button>Guardar</button>
      </form>

      <!-- Modificar producto -->

      <div v-for="product in products" v-bind:key="product.id">
        <input type="numeric" v-model="product.current_price" @change="saveProduct(product)" />
        <input v-model="product.prod_name" />
        <button @click="saveProduct(product)">Guardar</button>
      </div>
    </main>
  </div>
</template>