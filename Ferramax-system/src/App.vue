
<script setup lang="ts">
  import { onMounted, ref } from "vue";
  import { remult } from "remult";
  import { Product } from "./shared/Product";

  const productRepo = remult.repo(Product);
  const products = ref<Product[]>([]);
  onMounted(() => productRepo.find().then((items) => (products.value = items)));
</script>
<template>
  <div>
    <h1>Ferramax</h1>
    <main>
      <div v-for="product in products" v-bind:key="product.id">
        <input type="numeric" v-model="product.current_price" />
        {{ product.prod_name }}
      </div>
    </main>
  </div>
</template>