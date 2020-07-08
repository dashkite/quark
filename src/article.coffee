import {tee, pipe, pipeWith} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {select, set, lookup} from "./core"
import {type} from "./typography"
import {hrem, em} from "./units"
import {readable, margin} from "./dimension"
import {reset} from "./reset"

block = (tag, fx = []) ->
  gx = [
    select "& #{tag}", [
      reset [ "block" ]
      margin bottom: hrem 1
      pipe fx
    ]
  ]
  if tag[0] == 'h'
    gx.push select "& > * + #{tag}", [ margin top: hrem 3 ]

  pipe gx

h1 = block "h1", [ type "extra large heading" ]
h2 = block "h2", [ type "large heading" ]
h3 = block "h3", [ type "heading" ]
h4 = block "h4", [ type "small heading" ]
h5 = block "h5", [ type "extra small heading" ]
p = block "p"
ul = block "ul", [ margin left: em 1 ]
li = block "li", [ set "list-style", "disc outside" ]

all = pipe [readable, h1, h2, h3, h4, h5, p, ul ]

article = lookup {readable, h1, h2, h3, h4, h5, p, ul, li, all}

export {article}
