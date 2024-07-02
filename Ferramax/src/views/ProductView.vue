<template>
  <div>
    <h1>Ferramax</h1>
    <main>
      <!-- Formulario para agregar un nuevo producto -->
      <form @submit.prevent="addProduct">
        <input v-model="newProduct.nombre_producto" placeholder="Nombre del producto" required />
        <input v-model="newProduct.precio_actual" type="number" placeholder="Precio" required />
        <input v-model="newProduct.descripcion_producto" placeholder="Descripción" required />
        
        <!-- Input de categoría con opciones cargadas desde la BBDD -->
        <select v-model="newProduct.id_categoria" required>
          <option v-for="categoria in categorias" :key="categoria.id_categoria" :value="categoria.id_categoria">
            {{ categoria.nombre_categoria }}
          </option>
        </select>
        
        <input v-model="newProduct.marca" placeholder="Marca" required />
        <button type="submit">Añadir</button>
      </form>

      <!-- Filtro de categoría -->
      <label for="category">Seleccione una categoría: </label>
      <select id="category" v-model="selectedCategory" @change="fetchProducts">
        <option value="">Todas las categorías</option>
        <option v-for="categoria in categorias" :key="categoria.id_categoria" :value="categoria.id_categoria">
          {{ categoria.nombre_categoria }}
        </option>
      </select>

      <!-- Búsqueda de productos -->
      <div>
        <input v-model="searchId" placeholder="Ingrese código del producto" />
        <button @click="fetchProductById">Buscar Producto</button>

        <div v-if="!productFound && productos.length === 0">No hay productos disponibles</div>
        <div v-if="productFound && productos.length === 0">Producto no encontrado</div>

        <div v-for="producto in filteredProducts" :key="producto.cod_producto">
          <h3>ID: {{ producto.cod_producto }}</h3>
          <h3>Nombre: {{ producto.nombre_producto }} - {{ convertedPrice(producto.precio_actual) }}</h3>
          <p>Desc: {{ producto.descripcion_producto }}</p>
          <p>Marca: {{ producto.marca }}</p>
          <button @click="addToCart(producto)">Añadir al carrito</button>
          <p>-------------------------------------------------------</p>
        </div>
      </div>

      <!-- Carrito de compra -->
      <h2>Carrito de compra</h2>
      <div v-if="cartItems.length === 0">El carrito está vacío</div>
      <div v-else>
        <div v-for="item in cartItems" :key="item.product.cod_producto">
          <h3>{{ item.product.nombre_producto }} - {{ convertedPrice(item.product.precio_actual) }}</h3>
          <p>Cantidad: {{ item.quantity }}</p>
          <p>Precio Total: {{ convertedPrice(item.product.precio_actual * item.quantity) }}</p>
          <p>-------------------------------------------------------</p>
        </div>
        <h3>Total del Carrito: {{ convertedPrice(cartTotal) }}</h3>
      </div>
    </main>
    <footer>
      <div>
        <label for="currency">Seleccione la divisa: </label>
        <select id="currency" v-model="selectedCurrency">
          <option value="clp">Pesos Chilenos (CLP)</option>
          <option value="dolar">Dólar (USD)</option>
          <option value="euro">Euro (EUR)</option>
        </select>
      </div>
      <div>
        <button @click="pago">Pagar</button>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue';
// SDK de Mercado Pago
import { MercadoPagoConfig, Payment } from 'mercadopago';


interface Categoria {
  id_categoria: number;
  nombre_categoria: string;
  id_tipo_empleado: number;
}

interface Producto {
  cod_producto: string;
  nombre_producto: string;
  precio_actual: number;
  descripcion_producto: string;
  marca: string;
  id_categoria: number;
}

interface NewProduct {
  nombre_producto: string;
  precio_actual: number;
  descripcion_producto: string;
  id_categoria: number;
  marca: string;
}

interface ExchangeRates {
  dolar: number;
  euro: number;
  clp: number;
}

interface CartItem {
  product: Producto;
  quantity: number;
}

// Datos reactivos
const productos = ref([]);
const categorias = ref([]);
const searchId = ref('');
const productFound = ref(true);
const selectedCurrency = ref('clp');
const selectedCategory = ref('');
const exchangeRates = reactive({
  dolar: 1,
  euro: 1,
  clp: 1
});
const newProduct = reactive({
  nombre_producto: "",
  precio_actual: 0,
  descripcion_producto: "",
  id_categoria: 0,
  marca: ""
});
const cartItems = reactive([]);

// Inicializar el SDK de Mercado Pago
let mp: any;

onMounted(() => {
  fetchProducts();
  fetchExchangeRates();
  fetchCategorias();

  mp = new MercadoPagoConfig({ accessToken: 'TEST-e8bcfa9a-08fe-445a-9585-4bf37655d3d3'});
});

// Métodos
async function fetchProducts() {
  const apiKey = localStorage.getItem('api_key');
  const userId = localStorage.getItem('id_usuario');
  try {
    const response = await fetch(`/apiProducto/productos/all_prods/`, {
      method: 'GET',
      headers: {
        'id_usuario': String(userId),
        'api_key': String(apiKey),
      }
    });
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.json();
    productos.value = data.productos;
  } catch (error) {
    console.error('Error fetching products:', error);
  }
}

async function fetchProductById() {
  const apiKey = localStorage.getItem('api_key');
  const userId = localStorage.getItem('id_usuario');
  try {
    const response = await fetch(`/apiProducto/productos/producto/${searchId.value}`, {
      method: 'GET',
      headers: {
        'id_usuario': String(userId),
        'api_key': String(apiKey),
      }
    });
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.json();
    productos.value = data.producto ? data.producto : [];
    productFound.value = !!data.producto;
  } catch (error) {
    productos.value = [];
    productFound.value = false;
    console.error('Error fetching product:', error);
  }
}

async function fetchExchangeRates() {
  try {
    const response = await fetch('https://mindicador.cl/api');
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.json();
    exchangeRates.dolar = data.dolar.valor;
    exchangeRates.euro = data.euro.valor;
    exchangeRates.clp = 1; // 1 CLP es igual a 1 CLP
  } catch (error) {
    console.error('Error fetching exchange rates:', error);
  }
}

async function fetchCategorias() {
  try {
    const response = await fetch('/apiProducto/categorias');
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    const data = await response.json();
    categorias.value = data.categorias;
  } catch (error) {
    console.error('Error fetching categories:', error);
  }
}

function convertedPrice(price: number): string {
  if (price == null) {
    return 'N/A';
  }
  const rate = exchangeRates[selectedCurrency.value];
  if (!rate) {
    console.error('Exchange rate not found for currency:', selectedCurrency.value);
    return 'N/A';
  }
  let converted = parseFloat(price.toString());
  if (selectedCurrency.value !== 'clp') {
    converted = converted / rate;
  }
  const currencySymbol = selectedCurrency.value === 'dolar' ? 'USD' : (selectedCurrency.value === 'euro' ? 'EUR' : 'CLP');
  return `${currencySymbol} ${converted.toFixed(2)}`;
}

async function addProduct() {
  try {
    const response = await fetch('/apiProducto/productos/new_product/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ producto: newProduct })
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Error al crear el producto: ${response.statusText} - ${errorText}`);
    }

    const data = await response.json();

    // Añadir el nuevo producto a la lista de productos
    productos.value.push(data.producto);

    // Limpiar formulario
    newProduct.nombre_producto = "";
    newProduct.precio_actual = 0;
    newProduct.descripcion_producto = "";
    newProduct.id_categoria = 0;
    newProduct.marca = "";
  } catch (error) {
    console.error('Error:', error);
    alert(error.message);
  }
}

function addToCart(product: Producto) {
  const existingItem = cartItems.find(item => item.product.cod_producto === product.cod_producto);
  if (existingItem) {
    existingItem.quantity += 1;
  } else {
    cartItems.push({ product, quantity: 1 });
  }
}

async function pago() {
  try {
    const cartTotal = cartItems.reduce((total, item) => total + item.product.precio_actual * item.quantity, 0);

    

    const orderData = {
      transaction_amount: cartTotal,
      description: 'Compra en Ferramax',
      payment_method_id: 'tarjeta_credito', 
      payer: {
        email: 'jozk23@gmail.com' 
      }
    };

    // Crear preferencia de pago
    const response = await fetch('/apimercado', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(orderData)
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`Error al crear la preferencia: ${errorText}`);
    }

    console.log('response');

    const data = await response.json();
    const preferenceId = data.preference_id;

    mp.checkout({
      preference: {
        id: preferenceId
      }
    }).open();
  } catch (error) {
    console.error('Error al procesar el pago:', error);
    alert(error.message);
  }
}

// Computed properties y otras funciones reactivas
const filteredProducts = computed(() => {
  if (selectedCategory.value) {
    return productos.value.filter(producto => producto.id_categoria === parseInt(selectedCategory.value));
  }
  return productos.value;
});

const cartTotal = computed(() => {
  return cartItems.reduce((total, item) => total + item.product.precio_actual * item.quantity, 0);
});
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
