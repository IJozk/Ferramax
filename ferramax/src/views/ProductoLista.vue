<template>
  <div>
    <input v-model="searchId" placeholder="Ingrese código del producto" />
    <button @click="fetchProductById">Buscar Producto</button>

    <div v-if="!productFound && productos.length === 0">No hay productos disponibles</div>
    <div v-if="productFound && productos.length === 0">Producto no encontrado</div>

    <div v-for="producto in productos" :key="producto.cod_producto">
      <h3>{{ producto.nombre_producto }} ${{ producto.precio_actual }}</h3>
      <p>{{ producto.descripcion_producto }}</p>
      <p>{{ producto.marca }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      productos: [],
      searchId: '',
      productFound: true
    };
  },
  created() {
    this.fetchProducts();
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
        this.productos = data.producto ? data.producto : [];
        this.productFound = !!data.producto;
      } catch (error) {
        this.productos = [];
        this.productFound = false;
        console.error('Error fetching product:', error);
      }
    }
  }
};
</script>