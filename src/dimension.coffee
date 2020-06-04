import {curry, tee,  pipe} from "@pandastrike/garden"
import {speek as peek, log} from "@dashkite/katana"
import {set, setWith, lookup} from "./core"
import {first, last, getter} from "./helpers"

prefixed =
  stretch: pipe [
    set "width", "-webkit-fill-available"
    set "width", "stretch"
  ]

width = (value) -> prefixed[value] ? set "width", value
height = (value) -> prefixed[value] ? set "height", value

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
