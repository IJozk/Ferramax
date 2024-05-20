<template>
    <div class="product-management">
      <h1>Gestión de Productos</h1>
      <div v-for="product in products" :key="product.cod_producto" class="product">
        <p>{{ product.nombre_producto }}</p>
        <select v-model="product.id_categoria" @change="updateCategory(product)">
          <option v-for="category in categories" :key="category.id_categoria" :value="category.id_categoria">
            {{ category.nombre_categoria }}
          </option>
        </select>
        <button @click="togglePromotion(product)">
          {{ product.inPromotion ? "Quitar de promoción" : "Poner en promoción" }}
        </button>
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        products: [],
        categories: []
      };
    },
    methods: {
      fetchProducts() {
        axios.get('/apiProducto/productos')
          .then(response => {
            this.products = response.data.productos;
          })
          .catch(error => {
            console.error("Hubo un error al obtener los productos:", error);
          });
      },
      fetchCategories() {
        axios.get('/apiProducto/categorias/')
          .then(response => {
            this.categories = response.data.categorias;
          })
          .catch(error => {
            console.error("Hubo un error al obtener las categorías:", error);
          });
      },
      updateCategory(product) {
        axios.post(`/apiProducto/update_producto/${product.cod_producto}/`, {
          producto: {
            id_categoria: product.id_categoria
          }
        })
          .then(response => {
            console.log("Categoría actualizada:", response.data);
          })
          .catch(error => {
            console.error("Hubo un error al actualizar la categoría:", error);
          });
      },
      togglePromotion(product) {
        product.inPromotion = !product.inPromotion;
        axios.post(`/apiProducto/update_producto/${product.cod_producto}/`, {
          producto: {
            inPromotion: product.inPromotion
          }
        })
          .then(response => {
            console.log("Estado de promoción actualizado:", response.data);
          })
          .catch(error => {
            console.error("Hubo un error al actualizar el estado de promoción:", error);
          });
      }
    },
    mounted() {
      this.fetchProducts();
      this.fetchCategories();
    }
  };
  </script>
  
  <style scoped>
  .product-management {
    margin: 20px;
  }
  .product {
    border: 1px solid #ccc;
    padding: 10px;
    margin-bottom: 10px;
  }
  </style>
  