// without this, typescript complains that the UserConfigExport interface
// does not include 'test'
/// <reference types="vitest" />

import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import react from "@vitejs/plugin-react"

export default defineConfig({
  plugins: [
    RubyPlugin(),
    react(),
  ],
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: "./test/setup.ts",
    css: false
  }
})
