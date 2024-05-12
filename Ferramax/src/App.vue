
<script setup lang="ts">
  import { onMounted, onUnmounted, ref } from "vue";
  import { remult } from "remult";
  import { Product } from "./shared/Product";
  import { ProductsController } from "./shared/ProductsController";

  const productRepo = remult.repo(Product);
  const products = ref<Product[]>([]);
  //onMounted(() => productRepo.find().then((items) => (products.value = items)));
  onMounted(() => 
    onUnmounted(
      productRepo
        .liveQuery({
          limit: 20,
          orderBy: { createdAt: "asc" }
        })
        .subscribe(info => (products.value = info.applyChanges(products.value)))
    ))
  
  // valores de referencia para página
  const newProductName = ref("")
  const newProductPrice = ref()

  // añade producto
  async function addProduct() {
    try {
      const newTask = await productRepo.insert({prod_name: newProductName.value, current_price: newProductPrice.value })
      //products.value.push(newTask)
      newProductName.value = ""
    } catch (error: any) {
      alert((error as { message: string }).message)
    }
  }

  // guarda producto modificado
  async function saveProduct(product: Product) {
    try {
      await productRepo.save(product)
    } catch (error: any) {
      alert((error as { message: string }).message)
    }
  } 

  // elimina producto
  async function deleteProduct(product: Product) { 
    try{
      await productRepo.delete(product)
      //products.value = products.value.filter(t => product !== t)
    } catch (error: any) {
      alert((error as { message: string }).message)
    }
  }
  
  // settear todos los valores a 2000
  async function setTo2000(current_price: number){
    await ProductsController.setTo2000(current_price)
  }
</script>

<template>
  <div>
    <h1>Ferramax</h1>
    <main>
      <!-- Ingresar producto -->
      <form
      v-if="productRepo.metadata.apiInsertAllowed()"
      @submit.prevent="addProduct()"
      >
        <input v-model="newProductName" placeholder="Qué titulo deseas insertar?" />
        <input type="numeric" v-model="newProductPrice" placeholder="Valor" />
        <button>Guardar</button>
      </form>

      <!-- Modificar producto -->
      <div v-for="product in products" v-bind:key="product.id">
        <input type="numeric" v-model="product.current_price" @change="saveProduct(product)" />
        <input v-model="product.prod_name" />
        <button @click="saveProduct(product)">Guardar</button>
        <button 
        v-if="productRepo.metadata.apiDeleteAllowed(product)"
        @click="deleteProduct(product)"
        >Borrar</button>
      </div>
      <div>
        <button @click="setTo2000(2000)">Set to 2000</button>
      </div>
    </main>
  </div>
</template>
