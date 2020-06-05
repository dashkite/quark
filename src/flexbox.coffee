import {pipe} from "@pandastrike/garden"
import {set} from "./core"
import {display} from "./dimension"

rows = display "flex"

columns = pipe [
  display "flex"
  set "flex-direction", "column"
]

wrap = set "flex-wrap", "wrap"

export {
  rows
  columns
  wrap
}
