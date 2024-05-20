<template>
  <div v-if="productos.length === 0">No hay productos disponibles</div>
  <div v-for="producto in productos" :key="producto.cod_producto">
    <br>
    <h3> ID: {{ producto.cod_producto }} </h3>
    <h3> Nombre: {{ producto.nombre_producto }} - ${{ producto.precio_actual }}</h3>
    <p> Desc: {{ producto.descripcion_producto }}</p>
    <p> Marca: {{ producto.marca }}</p>
    <br>
    <hr>
  </div>
</template>

<script>
export default {
  data() {
    return {
      productos: []
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
        console.log(this.productos, data);
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    }
  }
};
</script>
