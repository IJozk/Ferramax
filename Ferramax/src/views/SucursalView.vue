<!-- src/views/SucursalView.vue -->
<template>
    <div>
        <h2>Seleccionar Sucursal</h2>
        <select v-model="selectedSucursalId" @change="onSelectChange">
            <option disabled value="">Seleccione una sucursal</option>
            <option v-for="sucursal in sucursales" :key="sucursal.id_sucursal" :value="sucursal.id_sucursal">
                {{ sucursal.nombre_sucursal }}
            </option>
        </select>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, defineEmits } from 'vue';
import { Sucursal } from '../shared/sucursal';
import { remult } from 'remult';

const sucursales = ref<Sucursal[]>([]);
const selectedSucursalId = ref<number | null>(null);
const emit = defineEmits(['sucursalSelected']);

const loadSucursales = async () => {
    sucursales.value = await remult.repo(Sucursal).find();
};

const onSelectChange = () => {
    const selectedSucursal = sucursales.value.find(sucursal => sucursal.id_sucursal === selectedSucursalId.value);
    if (selectedSucursal) {
        emit('sucursalSelected', selectedSucursal);
    }
};

onMounted(loadSucursales);
</script>

<style scoped>
select {
    padding: 0.5rem;
    font-size: 1rem;
}
</style>
