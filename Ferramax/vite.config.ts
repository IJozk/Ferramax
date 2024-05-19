import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: { proxy: { "/api": {
    target: 'https://a664615f-f965-4661-ae43-67e040721d30-00-s66hv8tg1s0d.kirk.replit.dev:3001',
    changeOrigin: true,
    rewrite: (path) => path.replace(/^\/api/, '')
  } } },
})
