import {readFileSync} from "node:fs"

export function removeJsonComments(raw: string): string {
  return raw.replaceAll(/(\/\/.*\n)|(\/\*(.|[\r\n])*\*\/)/g, "")
}

export function parseJsonc(raw: string) {
  return JSON.parse(removeJsonComments(raw))
}

export function parseJsoncFile(path: string) {
  return parseJsonc(readFileSync(path).toString())
}

if (import.meta.vitest) {
  const {it, expect} = import.meta.vitest
  it("remove json comments", () => {
    const raw = `{
      // inline comment
      "name": "hilltwice",
      /* inline block comment */
      /*
       * multi-line comment
       */
      "age": 22,
      "has-y-chromosome": true
    }`
    const resolved = removeJsonComments(raw)
    console.log(resolved)
    const person = JSON.parse(resolved)
    expect(person["name"]).toBe("hilltwice")
    expect(person["age"]).toBe(22)
    expect(person["has-y-chromosome"]).toBe(true)
  })
}
