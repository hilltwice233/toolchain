import commonjs from "@rollup/plugin-commonjs"
import nodeResolve from "@rollup/plugin-node-resolve"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"

export const pluginJS = [
  commonjs(),
  nodeResolve(),
  terser({compress: true, mangle: true}),
]

export const pluginTS = pluginJS.concat(typescript())
