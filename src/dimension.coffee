import {pipe} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {first, last, any, getter} from "./helpers"

display = set "display"

margin = set "margin"

padding = set "padding"

width = any [
  lookup
    stretch: pipe [
      set "width", "-webkit-fill-available"
      set "width", "stretch"
  ]
  set "width"
]

height = any [
  lookup
    stretch: pipe [
      set "height", "-webkit-fill-available"
      set "height", "stretch"
  ]
  set "height"
]

minWidth = set "min-width"
maxWidth = set "max-width"
minHeight = set "min-height"
maxHeight = set "max-height"

readable = pipe [
  width "stretch"
  minWidth "20em"
  maxWidth "34em"
]

# these will be replaced with row-gap and column-gap
# once they're supported in browsers

rowGap = (size) -> select "> *", [ margin right: size ]

columnGap = (size) -> select "> *", [ margin bottom: size ]

export {
  display
  margin
  padding
  width
  height
  minWidth
  maxWidth
  minHeight
  maxHeight
  readable
  rowGap
  columnGap
}
