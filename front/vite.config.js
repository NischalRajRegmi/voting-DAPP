import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      // process: "process/browser",
      web3: 'web3/dist/web3.min.js',
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  // define: {
  //   'process.env': {},
  //   'global': {}
  // }
})
