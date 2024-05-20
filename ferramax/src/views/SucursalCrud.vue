<!-- src/views/SucursalView.vue -->
<template>
    <div>
        <h1>Lista de Sucursales</h1>
        <ul>
            <li v-for="sucursal in sucursales" :key="sucursal.id_sucursal">
                {{ sucursal.nombre_sucursal }}
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Sucursal } from '../shared/sucursal';
import { remult } from 'remult';

const sucursales = ref<Sucursal[]>([]);

const loadSucursales = async () => {
    sucursales.value = await remult.repo(Sucursal).find();
    console.log("Sucursales cargadas:", sucursales.value); // Para depuración
};

onMounted(loadSucursales);
</script>

<style scoped>
ul {
    list-style-type: none;
    padding: 0;
}
li {
    margin-bottom: 0.5rem;
}
</style>
