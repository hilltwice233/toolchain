import commonjs from "@rollup/plugin-commonjs"
import nodeResolve from "@rollup/plugin-node-resolve"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import {defineConfig} from "rollup"

export const plugins = [
  typescript(),
  commonjs(),
  nodeResolve(),
  terser({compress: true, mangle: true}),
]

export const bin = defineConfig({
  plugins,
  input: "main.ts",
  output: {file: "main.js", format: "esm"},
})
