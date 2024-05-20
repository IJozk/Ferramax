<!-- src/views/stockView.vue -->
<template>
    <div>
        <SucursalSelector @sucursalSelected="onSucursalSelected" />
        
        <div v-if="selectedSucursal">
            <h2>Productos de {{ selectedSucursal.nombre_sucursal }}</h2>

            <form @submit.prevent="saveStock">
                <h3 v-if="isEdit">Editar Stock</h3>
                <h3 v-else>Agregar Nuevo Stock</h3>
                <div>
                    <label for="cod_producto">Código de Producto:</label>
                    <input type="number" id="cod_producto" v-model="form.cod_producto" required />
                </div>
                <div>
                    <label for="stock_prod">Cantidad en Stock:</label>
                    <input type="number" id="stock_prod" v-model="form.stock_prod" required />
                </div>
                <div>
                    <label for="descuento_tienda">Descuento:</label>
                    <input type="number" id="descuento_tienda" v-model="form.descuento_tienda" required />
                </div>
                <button type="submit">{{ isEdit ? 'Actualizar' : 'Agregar' }}</button>
                <button type="button" @click="clearForm">Cancelar</button>
            </form>

            <ul>
                <li v-for="stock in stockTienda" :key="`${stock.id_sucursal}-${stock.cod_producto}`">
                    Producto {{ stock.cod_producto }}: {{ stock.stock_prod }} unidades (Descuento: {{ stock.descuento_tienda }}%)
                    <button @click="editStock(stock)">Editar</button>
                    <button @click="deleteStock(stock)">Eliminar</button>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import SucursalSelector from './SucursalView.vue';
import { Sucursal } from '../shared/sucursal';
import { StockTienda } from '../shared/stock_tienda';
import { remult } from 'remult';

const stockTiendaRepo = remult.repo(StockTienda)
const selectedSucursal = ref<Sucursal | null>(null);
const stockTienda = ref<StockTienda[]>([]);
const isEdit = ref(false);
const form = ref({
    id_sucursal: 0,
    cod_producto: 0,
    stock_prod: 0,
    descuento_tienda: 0
});


const loadStockTienda = async () => {
    if (selectedSucursal.value) {
        stockTienda.value = await remult.repo(StockTienda).find({ where: { id_sucursal: selectedSucursal.value.id_sucursal } });
    }
};

const onSucursalSelected = (sucursal: Sucursal) => {
    selectedSucursal.value = sucursal;
    form.value.id_sucursal = sucursal.id_sucursal;
    loadStockTienda();
};

const saveStock = async () => {
    try {
        const newStock = {
            id_sucursal: form.value.id_sucursal,
            cod_producto: form.value.cod_producto,
            stock_prod: form.value.stock_prod,
            descuento_tienda: form.value.descuento_tienda
        };

        console.log("Stock a guardar:", newStock);

        if (isEdit.value) {
            const existingStock = await remult.repo(StockTienda).findFirst({
                id_sucursal: form.value.id_sucursal,
                cod_producto: form.value.cod_producto
            });
            if (existingStock) {
                existingStock.stock_prod = form.value.stock_prod;
                existingStock.descuento_tienda = form.value.descuento_tienda;
                await remult.repo(StockTienda).save(existingStock);
            } else {
                console.warn("No se encontró el stock existente, insertando nuevo stock.");
                await remult.repo(StockTienda).insert(newStock);
            }
        } else {
            console.log("Stock a guardar checking:", newStock);
            await remult.repo(StockTienda).insert(newStock);
        }

        clearForm();
        loadStockTienda();
    } catch (error) {
        console.error("Error al guardar el stock:", error);
    }
};

const editStock = (stock: StockTienda) => {
    form.value = { ...stock };
    isEdit.value = true;
};

const deleteStock = async (stock: StockTienda) => {
    try {
        await remult.repo(StockTienda).delete(stock);
        loadStockTienda();
    } catch (error) {
        console.error("Error al eliminar el stock:", error);
    }
};

const clearForm = () => {
    form.value = {
        id_sucursal: selectedSucursal.value ? selectedSucursal.value.id_sucursal : 0,
        cod_producto: 0,
        stock_prod: 0,
        descuento_tienda: 0
    };
    isEdit.value = false;
};
</script>

<style scoped>
form {
    margin-bottom: 1rem;
}
form div {
    margin-bottom: 0.5rem;
}
button {
    margin-right: 0.5rem;
}
</style>
