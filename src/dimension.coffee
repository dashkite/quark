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
      set "width", "-moz-available"
      set "width", "stretch"
  ]
  set "width"
]

height = any [
  lookup
    stretch: pipe [
      set "height", "-webkit-fill-available"
      set "height", "-moz-available"
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
  minWidth "min-content"
  maxWidth "40em"
]

# these will be replaced with row-gap and column-gap
# once they're supported in browsers

rowGap = (size) -> select "> *", [ margin right: size ]

columnGap = (size) -> select "> *", [ margin bottom: size ]

overflow = set "overflow"

textOverflow = set "text-overflow"

float = set "float"

# This is weird stuff, but as of Sept 2020, it's covered by 98% of web using
# only the WebKit prefix. Vulnerable to replacement.
# https://css-tricks.com/line-clampin/#weird-webkit-flexbox-way
lineClamp = (lines, max) ->
  pipe [
    display "-webkit-box"
    set "-webkit-line-clamp", lines
    set "-webkit-box-orient", "vertical"
    overflow "hidden"
    textOverflow "ellipsis"
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
  overflow
  textOverflow
  float
  lineClamp
}
