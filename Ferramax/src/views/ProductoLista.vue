<template>
  <div>
    <input v-model="searchId" placeholder="Ingrese código del producto" />
    <button @click="fetchProductById">Buscar Producto</button>

    <div v-if="!productFound && productos.length === 0">No hay productos disponibles</div>
    <div v-if="productFound && productos.length === 0">Producto no encontrado</div>

    <div v-for="producto in productos" :key="producto.cod_producto">
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




<script>
export default {
  data() {
    return {
      productos: [],
      searchId: '',
      productFound: true,
      selectedCurrency: 'clp',
      exchangeRates: {
        dolar: 1,
        euro: 1,
        clp: 1
      }
    };
  },
  created() {
    this.fetchProducts();
    this.fetchExchangeRates();
  },
  methods: {
    async fetchProducts() {
      try {
        const response = await fetch('/apiProducto/productos');
        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }
        const data = await response.json();
        this.productos = data.productos;
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    },
    async fetchProductById() {
      try {
        const response = await fetch(`/apiProducto/productos/producto/${this.searchId}`);
        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }
        const data = await response.json();
        this.productos = data.producto ? [data.producto] : [];
        this.productFound = !!data.producto;
      } catch (error) {
        this.productos = [];
        this.productFound = false;
        console.error('Error fetching product:', error);
      }
    },
    async fetchExchangeRates() {
      try {
        const response = await fetch('https://mindicador.cl/api');
        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }
        const data = await response.json();
        this.exchangeRates.dolar = data.dolar.valor;
        this.exchangeRates.euro = data.euro.valor;
        this.exchangeRates.clp = 1; // 1 CLP es igual a 1 CLP
        console.log('Exchange rates loaded:', this.exchangeRates); // Debugging line
      } catch (error) {
        console.error('Error fetching exchange rates:', error);
      }
    },
    convertedPrice(price) {
      console.log('Converting price:', price, 'Currency:', this.selectedCurrency); // Debugging line
      const rate = this.exchangeRates[this.selectedCurrency];
      if (!rate) {
        console.error('Exchange rate not found for currency:', this.selectedCurrency);
        return 'N/A';
      }
      console.log('Using exchange rate:', rate); // Debugging line
      let converted = parseFloat(price);
      if (this.selectedCurrency !== 'clp') {
        converted = converted / rate;
      }
      console.log('Converted price:', converted); // Debugging line
      const currencySymbol = this.selectedCurrency === 'dolar' ? 'USD' : (this.selectedCurrency === 'euro' ? 'EUR' : 'CLP');
      return `${currencySymbol} ${converted.toFixed(2)}`;
    }
  }
};
</script>