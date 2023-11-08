import commonjs from "@rollup/plugin-commonjs"
import nodeResolve from "@rollup/plugin-node-resolve"
import replace from "@rollup/plugin-replace"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import {readFileSync} from "node:fs"
import {join} from "node:path"
import {cwd} from "node:process"
import {defineConfig} from "rollup"

export const plugins = [
  typescript(),
  commonjs(),
  nodeResolve(),
  terser({compress: true, mangle: true}),
  replace({"import.meta.vitest": "undefined", preventAssignment: true}),
]

/** Parse format (commonjs/esm) from manifest (package.json file). */
function parseFormat() {
  const raw = readFileSync(join(cwd(), "package.json"))
  const manifest = JSON.parse(raw.toString())
  return manifest["type"] === "module" ? "esm" : "commonjs"
}

export const bin = defineConfig({
  plugins,
  input: "main.ts",
  output: {file: "main.js", format: parseFormat()},
})

export const lib = defineConfig({
  plugins,
  input: "index.ts",
  output: {file: "index.js", format: parseFormat()},
})

export const both = defineConfig([lib, bin])
