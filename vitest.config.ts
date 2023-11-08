import {defineConfig} from "vitest/config"

export default defineConfig({
  test: {
    includeSource: ["{node,vscode}/**/*.{js,ts}"],
  },
})
