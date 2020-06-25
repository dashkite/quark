import {curry, tee,  pipe} from "@pandastrike/garden"
import {speek as peek, log} from "@dashkite/katana"
import {set, lookup, any} from "./core"
import {first, last, getter} from "./helpers"

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
}
