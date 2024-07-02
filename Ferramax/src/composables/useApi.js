import { useAuth } from '@/composables/useAuth';

export function useApi() {
  const { apiKey, userId } = useAuth();

  const fetchWithAuth = async (url, options = {}) => {
    const headers = options.headers || {};
    headers['id_usuario'] =  localStorage.getItem("id_usuario"); 
    headers['api_key'] = localStorage.getItem("api_key");

    console.log(headers);

    const response = await fetch(url, {
      ...options,
      headers: {
        ...headers,
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }

    return response.json();
  };

  return {
    fetchWithAuth
  };
}