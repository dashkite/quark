import {pipe} from "@dashkite/joy/function"
import {set} from "./core"
import {display} from "./dimension"
import {pct} from "./units"

rows = display "flex"

columns = pipe [
  display "flex"
  set "flex-direction", "column"
]

wrap = set "flex-wrap", "wrap"

justifyContent = set "justify-content"

alignItems = set "align-items"

flex = set "flex"

stretch = flex grow: 1, basis: pct 100

export {
  rows
  columns
  wrap
  justifyContent
  alignItems
  flex
  stretch
}
