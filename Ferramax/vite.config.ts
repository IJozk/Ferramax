import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    proxy: {
      "/apiProducto": {
        target: 'https://a664615f-f965-4661-ae43-67e040721d30-00-s66hv8tg1s0d.kirk.replit.dev:3001/',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/apiProducto/, '')
      },
      "/APIconsulta": {
        target: 'https://66bb7737-6cbf-4a5c-ad15-30241155c89c-00-3df4wwz9ec4so.worf.replit.dev:3001/',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/APIconsulta/, '')
      },
      "/api": "http://localhost:3002"
    }
  }
});
