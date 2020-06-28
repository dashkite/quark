import {pipe} from "@pandastrike/garden"
import {set} from "./core"
import {display} from "./dimension"

rows = display "flex"

columns = pipe [
  display "flex"
  set "flex-direction", "column"
]

wrap = set "flex-wrap", "wrap"

justifyContent = set "justify-content"

alignItems = set "align-items"

flex = set "flex"

stretch = flex 1

export {
  rows
  columns
  wrap
  justifyContent
  alignItems
  flex
  stretch
}
