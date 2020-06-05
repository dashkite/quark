import {curry, tee,  pipe} from "@pandastrike/garden"
import {speek as peek, log} from "@dashkite/katana"
import {set, lookup, any} from "./core"
import {first, last, getter} from "./helpers"

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

# TODO this technique will not worked with prefixed values
#      since it relies on grabbing the last property
prefix = curry (text, p) -> p.name = "#{text}-#{p.name}"
children = pipe [ first, getter "children" ]
min = (f) -> tee pipe [ f, children, last, prefix "min" ]
max = (f) -> tee pipe [ f, children, last, prefix "max" ]

readable = pipe [
  width "stretch"
  min width "20em"
  max width "34em"
]

export {width, height, min, max, readable}
