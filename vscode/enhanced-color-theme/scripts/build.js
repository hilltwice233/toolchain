import {buildManifest} from "./processor.js"

buildManifest("package.json", "extension/package.json", [
  {
    label: "Enhanced Light Theme",
    id: "enhanced.light",
    uiTheme: "vs",
    path: "light.json",
  },
  {
    label: "Enhanced Dark Theme",
    id: "enhanced.dark",
    uiTheme: "vs-dark",
    path: "dark.json",
  },
])
