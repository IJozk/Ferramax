import { ref } from 'vue';

const isAuthenticated = ref(false);
const apiKey = ref('');
const userId = ref('');

export function useAuth() {
  const login = (userApiKey, userIdValue) => {
    isAuthenticated.value = true;
    apiKey.value = userApiKey;
    userId.value = userIdValue;
    // Almacena la api_key y el id_usuario en localStorage
    localStorage.setItem('api_key', userApiKey);
    localStorage.setItem('id_usuario', userIdValue);
  };

  const logout = () => {
    isAuthenticated.value = false;
    apiKey.value = '';
    userId.value = '';
    localStorage.removeItem('api_key');
    localStorage.removeItem('id_usuario');
  };

  return {
    isAuthenticated,
    login,
    logout,
    apiKey,
    userId
  };
}