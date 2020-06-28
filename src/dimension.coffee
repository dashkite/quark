import {pipe} from "@pandastrike/garden"
import {select, set, lookup, any} from "./core"
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

rowGap = (size) ->
  pipe [
    select "> :not(:first-child)", [ margin left: size ]
    select "> *", [ margin left: 0 ]
  ]

columnGap = (size) ->
  pipe [
    select "> :not(:first-child)", [ margin top: size ]
    select "> *", [ margin top: 0 ]
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
  rowGap
  columnGap
}
