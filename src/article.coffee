import {tee, pipe, pipeWith} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {select, set, lookup} from "./core"
import {type} from "./typography"
import {hrem, qrem, em} from "./units"
import {readable, margin, padding} from "./dimension"
import {borders} from "./borders"
import {reset} from "./reset"
import {normalize} from "./normalize"

block = pipe [
  reset [ "block" ]
  select "&:not(:last-child)", [
    margin bottom: hrem 3
  ]
]

header = pipe [
  select "header", [
    margin bottom: hrem 5
  ]
]

h1 = pipe [
  select "h1", [
    block
    type "extra large heading"
  ]
]

h2 = pipe [
  select "h2", [
    block
    type "large heading"
    select "&:not(:first-child)", [
      margin top: hrem 5
    ]
    padding bottom: qrem 1
    borders [ "bottom" ]
  ]
]

h3 = pipe [
  select "h3", [
    block
    type "heading"
  ]
]

h4 = pipe [
  select "h4", [
    block
    type "small heading"
  ]
]

h5 = pipe [
  select "h5", [
    block
    type "extra small heading"
  ]
]

p = pipe [
  select "p", [
    block
    type "copy"
  ]
]

ul = pipe [
  select "ul", [
    block
    type "copy"
    margin left: em 1
  ]
]

li = pipe [
  select "li", [
    block
    type "copy"
    set "list-style", "disc outside"
  ]
]

all = pipe [
  readable
  header
  h1, h2, h3, h4, h5, p, ul, li
  normalize [ "links", "focus" ]
]

article = lookup {readable, h1, h2, h3, h4, h5, p, ul, li, all}

export {article}
