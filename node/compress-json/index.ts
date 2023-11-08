if (import.meta.vitest) {
  const {it, expect} = import.meta.vitest
  it("add", () => {
    expect(1 + 1).toEqual(2)
  })
}
