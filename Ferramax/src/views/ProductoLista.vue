<template>
  <div>
    <input v-model="searchId" placeholder="Ingrese código del producto" />
    <button @click="fetchProductById">Buscar Producto</button>
    
    <label for="category">Seleccione una categoría: </label>
    <select id="category" v-model="selectedCategory" @change="fetchProducts">
      <option value="">Todas las categorías</option>
      <option v-for="categoria in categorias" :key="categoria" :value="categoria">{{ categoria }}</option>
    </select>

    <div v-if="!productFound && productos.length === 0">No hay productos disponibles</div>
    <div v-if="productFound && productos.length === 0">Producto no encontrado</div>

    <div v-for="producto in filteredProducts" :key="producto.cod_producto">
      <h3>ID: {{ producto.cod_producto }}</h3>
      <h3>Nombre: {{ producto.nombre_producto }} - {{ convertedPrice(producto.precio_actual) }}</h3>
      <p>Desc: {{ producto.descripcion_producto }}</p>
      <p>Marca: {{ producto.marca }}</p>
      <p>-------------------------------------------------------</p>
    </div>
  </div>
  <footer>
    <div>
      <label for="currency">Seleccione la divisa: </label>
      <select id="currency" v-model="selectedCurrency">
        <option value="clp">Pesos Chilenos (CLP)</option>
        <option value="dolar">Dólar (USD)</option>
        <option value="euro">Euro (EUR)</option>
      </select>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const searchId = ref('');
const productos = ref([]);
const categorias = ref([]);
const productFound = ref(true);
const selectedCurrency = ref('clp');
const selectedCategory = ref('');
const exchangeRates = ref({
  dolar: 1,
  euro: 1,
  clp: 1
});

const router = useRouter();

const fetchProducts = async () => {
  const apiKey = localStorage.getItem('api_key');
  const userId = localStorage.getItem('id_usuario');

  if (!apiKey || !userId) {
    console.error('API key or User ID not found in localStorage');
    return;
  }

  try {
    const response = await fetch('/apiProducto/productos/all_prods/', {
      method: 'GET',
      headers: {
        'id_usuario': userId,
        'api_key': apiKey,
      }
    });
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    productos.value = data.productos;
    categorias.value = [...new Set(productos.value.map(producto => producto.categoria))];
  } catch (error) {
    console.error('Error fetching products:', error);
  }
};

const fetchProductById = async () => {
  const apiKey = localStorage.getItem('api_key');
  const userId = localStorage.getItem('id_usuario');

  if (!apiKey || !userId) {
    console.error('API key or User ID not found in localStorage');
    return;
  }

  try {
    const response = await fetch(`/apiProducto/productos/producto/${searchId.value}`, {
      method: 'GET',
      headers: {
        'id_usuario': userId,
        'api_key': apiKey
      }
    });
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    productos.value = data.producto ? [data.producto] : [];
    productFound.value = !!data.producto;
  } catch (error) {
    productos.value = [];
    productFound.value = false;
    console.error('Error fetching product:', error);
  }
};

const fetchExchangeRates = async () => {
  try {
    const response = await fetch('https://mindicador.cl/api');
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.json();
    exchangeRates.value.dolar = data.dolar.valor;
    exchangeRates.value.euro = data.euro.valor;
    exchangeRates.value.clp = 1; // 1 CLP es igual a 1 CLP
  } catch (error) {
    console.error('Error fetching exchange rates:', error);
  }
};

const convertedPrice = (price) => {
  const rate = exchangeRates.value[selectedCurrency.value];
  if (!rate) {
    return 'N/A';
  }
  let converted = parseFloat(price);
  if (selectedCurrency.value !== 'clp') {
    converted = converted / rate;
  }
  const currencySymbol = selectedCurrency.value === 'dolar' ? 'USD' : (selectedCurrency.value === 'euro' ? 'EUR' : 'CLP');
  return `${currencySymbol} ${converted.toFixed(2)}`;
};

const filteredProducts = computed(() => {
  if (selectedCategory.value) {
    return productos.value.filter(producto => producto.categoria === selectedCategory.value);
  }
  return productos.value;
});

onMounted(() => {
  fetchProducts();
  fetchExchangeRates();
});
</script>

<style scoped>
.login {
  max-width: 300px;
  margin: auto;
}

.error {
  color: red;
}
</style>