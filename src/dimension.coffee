import {curry, tee,  pipe} from "@pandastrike/garden"
import {speek as peek, log} from "@dashkite/katana"
import {set} from "./core"
import {first, last, getter} from "./helpers"

prefixed =
  stretch: [ "-webkit-fill-available" ]

dimension = curry (name, value) ->
  actions = [ set name, value ]
  if prefixed[value]?
    actions.push set name, prefixed[value]
  pipe actions

width = dimension "width"
height = dimension "height"

prefix = curry (name, p) -> p.key = "#{name}-#{p.key}"
children = pipe [ first, getter "children" ]
min = (f) -> tee pipe [ f, children, last, prefix "min" ]
max = (f) -> tee pipe [ f, children, last, prefix "max" ]

readable = pipe [
  width "stretch"
  min width "20em"
  max width "34em"
]

export {width, height, min, max, readable}
