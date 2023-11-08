import {parseJsoncFile} from "@toolchain/jsonc"
import {writeFileSync} from "node:fs"

/**
 * Build and process the manifest file (package.json).
 * @param {string} src source path of the manifest file.
 * @param {string} dist dist path of the manifest file.
 * @param {{}[]} themes updated themes options.
 */
export function buildManifest(src, dist, themes) {
  const raw = parseJsoncFile(src)
  raw["scripts"] = undefined
  raw["dependencies"] = undefined
  raw["devDependencies"] = undefined
  if (raw["contributes"]) raw["contributes"]["themes"] = themes
  writeFileSync(dist, JSON.stringify(raw))
}
