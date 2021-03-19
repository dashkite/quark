import {r} from "../registry"
import {set} from "../core"

r["sans"] = set "font-family",
  'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont,
  "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans",
  sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
  "Noto Color Emoji"'

r["serif"] = set "font-family",
  'ui-serif, Georgia, Cambria, "Times New Roman", Times, serif'

r["mono"] = set "font-family",
  'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas,
  "Liberation Mono", "Courier New", monospace'
