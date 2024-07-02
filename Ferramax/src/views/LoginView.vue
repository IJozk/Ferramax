<template>
  <div class="login">
    <h2>Iniciar Sesión</h2>
    <form @submit.prevent="handleLogin">
      <div>
        <label for="email">Correo Electrónico</label>
        <input type="email" id="email" v-model="email" required />
      </div>
      <div>
        <label for="password">Contraseña</label>
        <input type="password" id="password" v-model="password" required />
      </div>
      <button type="submit">Iniciar Sesión</button>
    </form>
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuth } from '@/composables/useAuth';

const email = ref('');
const password = ref('');
const error = ref('');

const router = useRouter();
const { login } = useAuth();

const handleLogin = async () => {
  try {
    const response = await fetch('/apiProducto/usuarios/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        correo: email.value,
        clave: password.value
      })
    });

    console.log(response); // Verifica el objeto de respuesta
    if (!response.ok) {
      throw new Error('Error al iniciar sesión');
    }

    const data = await response.json();
    console.log(data.usuario_out.usuario.id_usuario); // Verifica los datos de respuesta
    if (data.usuario_out.usuario.api_key) {
      login(data.usuario_out.usuario.api_key, data.usuario_out.usuario.id_usuario); // Guarda la api_key en algún lugar (por ejemplo, en el estado de autenticación)
      router.push('/'); // Redirige a la página principal
    } else {
      throw new Error('La respuesta del servidor no contiene api_key');
    }
  } catch (err) {
    error.value = err.message;
  }
};
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